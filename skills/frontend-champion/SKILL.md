---
name: frontend-champion
description: Mandatory first step for any frontend, UI, or UX work, no matter how small. Covers building or editing a component, page, screen, dashboard, form, landing page, nav, modal, chart, table, or layout; fixing styling, spacing, color, animation, or responsiveness; reviewing or critiquing an existing interface; or converting a design or mockup into code, in React, Vue, Svelte, plain HTML and CSS, Tailwind, or mobile UI. Use this even for requests that look trivial, like a single button or a one-line color change, and even when the user does not explicitly say UI or frontend. If the task touches anything a person will look at or click on, read this in full before writing or editing any code or discussing visual design. Skipping this step is what produces generic, unverified, first-draft output.
compatibility: Works standalone. Most effective with a Figma MCP connected, a component-registry MCP (shadcn MCP / 21st.dev Magic MCP), a current-docs MCP (Context7 or similar), and a browser/screenshot MCP (Playwright MCP / Chrome DevTools MCP). Degrades gracefully, and says so, when any of these are missing.
---

# Frontend Champion

Left alone, a coding model's default frontend output is a generic first draft: invented markup instead of real components, whatever colors and spacing come to mind instead of a real design system, APIs it half-remembers instead of what's current, and no check that any of it actually renders. This skill closes those gaps. It's a gate, not a suggestion — work through it before producing UI code, every time it applies.

For the duration of the task, act like the senior frontend engineer on the team: the one who checks the design file instead of guessing, reaches for the real component library instead of typing markup from memory, and looks at the rendered page before saying it's done.

## 0. Scale, don't skip

A new page or feature gets the full workflow below. A one-line copy fix or a color swap can skip Step 3's design-system exercise — but never skip Steps 1, 4, and 6. They're cheap, and they're exactly where generic AI output gets caught.

## 1. Check what tools you actually have

Look at the available tools/MCP servers before starting anything. Relevant ones, if connected:

- **Figma MCP** (or similar design-file connector) — pulls real tokens, hierarchy, and component references from an actual design file instead of guessing spacing and colors from a description.
- **shadcn MCP / Magic MCP / a component-registry MCP** — real, working component source to pull in, instead of hand-typed markup from memory.
- **Context7** (or another current-docs MCP) — up-to-date, version-pinned framework and library docs, so you don't reach for a deprecated API or a Tailwind v3 class in a v4 project.
- **Playwright MCP / Chrome DevTools MCP** (or any browser/screenshot tool) — lets you render what you just built and actually look at it.

If a relevant one isn't connected, say so plainly in your response and name what would help ("I don't have a way to render this — connecting Playwright MCP or Chrome DevTools MCP would let me check it visually before calling it done"). Don't quietly fall back to guessing and imply nothing was missing.

## 2. Pull real context before inventing anything

- If a design file exists and there's a way to read it, pull the actual tokens and hierarchy — don't estimate them.
- If working in an existing codebase, read what's already there first — existing components, the Tailwind config, the theme file — before adding new ones. Match it. Don't introduce a second, competing visual language next to the first.
- If the framework or library's API might have moved since training data (Next.js, React, Tailwind, any fast-moving library) and a docs tool is available, check current docs rather than trusting memory for anything version-sensitive.

## 3. Lock a point of view before writing code

Before the first component, write down a few lines — not a brand deck:

- **Who is this for, and what's the one job of this screen?** A pricing page, an internal admin table, and a marketing landing page shouldn't default to the same layout.
- **A small, named token set** — four to six colors with a role each (not just hex codes: "primary action," "danger," "muted text"), one or two typefaces, a spacing or layout idea.
- If a design system already exists in the repo, or was established earlier in this project, reuse it. Don't relitigate it component by component.

## 4. Self-check against generic-AI tells

Before finalizing the plan, check it against the patterns that make AI-generated UI recognizable as such. If more than one or two of these are true by default rather than by deliberate choice, change the plan:

- The same "safe" neutral background plus one bright accent color, regardless of what the product actually is.
- Every content block is an identical rounded card with the same soft drop shadow, no matter its importance.
- Tracked-out ALL-CAPS micro-labels above every section.
- An arrow tacked onto every link or button, every time ("Learn more →", "Get started →").
- Numbered 01 / 02 / 03 markers on content that isn't actually sequential.
- The same fade-and-slide-up entrance on every section, hover-lift on every card.
- Placeholder-grade copy — generic marketing filler — standing in for real, specific content.
- Uniform border-radius and shadow values applied everywhere, with no hierarchy.

None of these are wrong in isolation. They're a problem when they're the reflexive default instead of a deliberate choice for this product.

## 5. Build with real material, not memory

- Prefer pulling actual component source (via a component-registry MCP, or the project's own existing component library) over hand-typing markup recalled from memory.
- Match the repo's existing conventions — naming, folder structure, styling approach — instead of introducing a new pattern alongside the old one.
- No placeholders or silent stubs. If something genuinely can't be finished, say so explicitly rather than shipping a `TODO` and implying it's done.
- Handle the states a real UI actually has — empty, loading, error, long or overflowing content — not just the happy path with ideal sample data.

## 6. Look at what you built before calling it done

- If a browser/screenshot tool is available, render the result. Check it at a narrow (mobile) and a wide (desktop) width. Check the console for errors. Fix what's visibly broken before returning.
- If that tool isn't available, say so plainly, and say what wasn't verified — don't imply it was checked when it wasn't.
- Minimum bar regardless of tooling: visible keyboard-focus states, reasonable color contrast, no layout that breaks at narrow widths, no unstyled orphaned elements.

## 7. Report honestly

Close with a short, specific account:

- What was built.
- Which tools from Step 1 were actually used — and which relevant ones weren't available.
- What was verified, and how. "Looks good" is not a verification step; name the actual check performed.
- Anything that couldn't be finished or verified, and why. Don't paper over it.

## Reference: tools worth adding if missing

Name these explicitly if they're not connected and would help, rather than quietly working around their absence:

- **Figma Dev Mode MCP** — Figma's official remote MCP server; exposes real design tokens and hierarchy from a Figma file.
- **shadcn MCP / 21st.dev Magic MCP** — real component source and natural-language component generation, instead of hand-rolled markup.
- **Context7** — current, version-pinned framework and library docs, to stop deprecated-API guesses.
- **Playwright MCP / Chrome DevTools MCP** — render-and-inspect: screenshots, console errors, responsive checks, before declaring the work done.