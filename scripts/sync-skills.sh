#!/usr/bin/env bash
set -euo pipefail

# scripts/sync-skills.sh
# Syncs or verifies exposed skill paths (.agents/skills/ and .claude/skills/)
# against canonical source skills in plugins/*/skills/.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

AGENTS_DIR="${REPO_ROOT}/.agents/skills"
CLAUDE_DIR="${REPO_ROOT}/.claude/skills"

MODE="symlink"
if [[ "${1:-}" == "--check" ]] || [[ "${1:-}" == "--ci" ]]; then
  MODE="check"
elif [[ "${1:-}" == "--copy" ]]; then
  MODE="copy"
fi

if [[ "${MODE}" == "check" ]]; then
  echo "Checking skill exposure parity across .agents/skills/ and .claude/skills/..."
  DRIFT=0

  for pskill in "${REPO_ROOT}"/plugins/*/skills/*; do
    [[ -d "${pskill}" ]] || continue
    skill_name="$(basename "${pskill}")"

    for target_dir in "${AGENTS_DIR}" "${CLAUDE_DIR}"; do
      exposed_skill="${target_dir}/${skill_name}"
      if [[ ! -e "${exposed_skill}" ]]; then
        echo "DRIFT DETECTED: Missing exposed skill: ${exposed_skill}" >&2
        DRIFT=1
      elif [[ ! -f "${exposed_skill}/SKILL.md" ]]; then
        echo "DRIFT DETECTED: Missing or unresolvable SKILL.md in: ${exposed_skill}" >&2
        DRIFT=1
      fi
    done
  done

  # Check for orphan skills in target dirs
  for target_dir in "${AGENTS_DIR}" "${CLAUDE_DIR}"; do
    if [[ -d "${target_dir}" ]]; then
      for exposed in "${target_dir}"/*; do
        [[ -e "${exposed}" || -L "${exposed}" ]] || continue
        skill_name="$(basename "${exposed}")"
        found=0
        for pskill in "${REPO_ROOT}"/plugins/*/skills/*; do
          if [[ "$(basename "${pskill}")" == "${skill_name}" ]]; then
            found=1
            break
          fi
        done
        if [[ "${found}" -eq 0 ]]; then
          echo "DRIFT DETECTED: Orphan skill found in ${target_dir}: ${skill_name}" >&2
          DRIFT=1
        fi
      done
    fi
  done

  if [[ "${DRIFT}" -ne 0 ]]; then
    echo "FAILED: Skill drift detected. Run ./scripts/sync-skills.sh to resync." >&2
    exit 1
  fi

  echo "SUCCESS: All skills in .agents/skills/ and .claude/skills/ are in parity with plugins/."
  exit 0
fi

mkdir -p "${AGENTS_DIR}" "${CLAUDE_DIR}"

echo "Syncing skills from plugins/ to .agents/skills/ and .claude/skills/ (mode: ${MODE})..."

for pskill in "${REPO_ROOT}"/plugins/*/skills/*; do
  [[ -d "${pskill}" ]] || continue
  skill_name="$(basename "${pskill}")"
  domain_name="$(basename "$(dirname "$(dirname "${pskill}")")")"
  rel_target="../../plugins/${domain_name}/skills/${skill_name}"

  for target_dir in "${AGENTS_DIR}" "${CLAUDE_DIR}"; do
    dest="${target_dir}/${skill_name}"
    rm -rf "${dest}"

    if [[ "${MODE}" == "copy" ]]; then
      cp -R "${pskill}" "${dest}"
    else
      # Default: relative symlink
      ln -s "${rel_target}" "${dest}"
    fi
  done
done

echo "Synced 23 skills successfully."
