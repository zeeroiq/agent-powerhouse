---
name: api-design
description: REST API design patterns including resource naming, status codes, pagination, filtering, error responses, versioning, and rate limiting for production APIs.
metadata:
  origin: AgentPowerHouse - APH
---


# API Design Patterns

Conventions and best practices for designing consistent, developer-friendly REST APIs using Spring Boot on the backend and React on the frontend.

---

## When to Activate

- Designing new API endpoints
- Reviewing existing API contracts
- Adding pagination, filtering, or sorting
- Implementing error handling for APIs
- Planning API versioning strategy
- Building public or partner-facing APIs

---

## Resource Design

### URL Structure

```
# Resources are nouns, plural, lowercase, kebab-case
GET    /api/v1/users
GET    /api/v1/users/{id}
POST   /api/v1/users
PUT    /api/v1/users/{id}
PATCH  /api/v1/users/{id}
DELETE /api/v1/users/{id}

# Sub-resources for relationships
GET    /api/v1/users/{id}/orders
POST   /api/v1/users/{id}/orders

# Actions that don't map to CRUD (use verbs sparingly)
POST   /api/v1/orders/{id}/cancel
POST   /api/v1/auth/login
POST   /api/v1/auth/refresh
```

### Naming Rules

```
# GOOD
/api/v1/team-members          # kebab-case for multi-word resources
/api/v1/orders?status=active  # query params for filtering
/api/v1/users/123/orders      # nested resources for ownership

# BAD
/api/v1/getUsers              # verb in URL
/api/v1/user                  # singular (use plural)
/api/v1/team_members          # snake_case in URLs
/api/v1/users/123/getOrders   # verb in nested resource
```

---

## HTTP Methods and Status Codes

### Method Semantics

| Method | Idempotent | Safe | Use For |
|--------|-----------|------|---------|
| GET | Yes | Yes | Retrieve resources |
| POST | No | No | Create resources, trigger actions |
| PUT | Yes | No | Full replacement of a resource |
| PATCH | No* | No | Partial update of a resource |
| DELETE | Yes | No | Remove a resource |

*PATCH can be made idempotent with proper implementation

### Status Code Reference

```
# Success
200 OK                    — GET, PUT, PATCH (with response body)
201 Created               — POST (include Location header)
204 No Content            — DELETE, PUT (no response body)

# Client Errors
400 Bad Request           — Validation failure, malformed JSON
401 Unauthorized          — Missing or invalid authentication
403 Forbidden             — Authenticated but not authorized
404 Not Found             — Resource doesn't exist
409 Conflict              — Duplicate entry, state conflict
422 Unprocessable Entity  — Semantically invalid (valid JSON, bad data)
429 Too Many Requests     — Rate limit exceeded

# Server Errors
500 Internal Server Error — Unexpected failure (never expose details)
502 Bad Gateway           — Upstream service failed
503 Service Unavailable   — Temporary overload, include Retry-After
```

### Common Mistakes

```
# BAD: 200 for everything
{ "status": 200, "success": false, "error": "Not found" }

# GOOD: Use HTTP status codes semantically
HTTP/1.1 404 Not Found
{ "error": { "code": "not_found", "message": "User not found" } }

# BAD: 500 for validation errors
# GOOD: 400 or 422 with field-level details

# BAD: 200 for created resources
# GOOD: 201 with Location header
HTTP/1.1 201 Created
Location: /api/v1/users/abc-123
```

---

## Response Format

### Success Response

```json
{
  "data": {
    "id": "abc-123",
    "email": "alice@example.com",
    "name": "Alice",
    "createdAt": "2025-01-15T10:30:00Z"
  }
}
```

> **Note:** Spring Boot uses `camelCase` field names by default via Jackson. Stick with `camelCase` in JSON responses to stay consistent with the framework default; only switch to `snake_case` if you configure `PropertyNamingStrategies.SNAKE_CASE` globally.

### Collection Response (with Pagination)

```json
{
  "data": [
    { "id": "abc-123", "name": "Alice" },
    { "id": "def-456", "name": "Bob" }
  ],
  "meta": {
    "total": 142,
    "page": 1,
    "perPage": 20,
    "totalPages": 8
  },
  "links": {
    "self": "/api/v1/users?page=0&size=20",
    "next": "/api/v1/users?page=1&size=20",
    "last": "/api/v1/users?page=7&size=20"
  }
}
```

### Error Response

```json
{
  "error": {
    "code": "validation_error",
    "message": "Request validation failed",
    "details": [
      {
        "field": "email",
        "message": "Must be a valid email address",
        "code": "invalid_format"
      },
      {
        "field": "age",
        "message": "Must be between 0 and 150",
        "code": "out_of_range"
      }
    ]
  }
}
```

---

## Pagination

### Offset-Based with Spring Data (Simple)

Spring Data's `Pageable` maps directly to `?page=0&size=20&sort=createdAt,desc`.

```java
// Repository
public interface UserRepository extends JpaRepository<User, UUID> {
    Page<User> findAllByStatus(String status, Pageable pageable);
}

// Controller
@GetMapping("/users")
public ResponseEntity<ApiResponse<List<UserDto>>> listUsers(
        @RequestParam(defaultValue = "active") String status,
        Pageable pageable) {

    Page<User> page = userRepository.findAllByStatus(status, pageable);

    PagedResponse<UserDto> body = PagedResponse.<UserDto>builder()
            .data(page.getContent().stream().map(userMapper::toDto).toList())
            .meta(PaginationMeta.from(page))
            .build();

    return ResponseEntity.ok(body);
}
```

```java
// PaginationMeta helper
public record PaginationMeta(long total, int page, int perPage, int totalPages) {
    public static PaginationMeta from(Page<?> page) {
        return new PaginationMeta(
            page.getTotalElements(),
            page.getNumber() + 1,   // convert 0-based Spring to 1-based API
            page.getSize(),
            page.getTotalPages()
        );
    }
}
```

**Pros:** Easy to implement, supports "jump to page N"
**Cons:** Slow on large offsets, inconsistent with concurrent inserts

### Cursor-Based (Scalable)

```java
// Repository — keyset pagination
@Query("SELECT u FROM User u WHERE u.id > :cursor ORDER BY u.id ASC LIMIT :limit")
List<User> findAfterCursor(@Param("cursor") UUID cursor, @Param("limit") int limit);

// Controller
@GetMapping("/users")
public ResponseEntity<?> listUsers(
        @RequestParam(required = false) String cursor,
        @RequestParam(defaultValue = "20") int limit) {

    UUID cursorId = cursor != null ? UUID.fromString(decode(cursor)) : null;
    List<User> rows = userRepository.findAfterCursor(cursorId, limit + 1);

    boolean hasNext = rows.size() > limit;
    List<UserDto> data = rows.stream().limit(limit).map(userMapper::toDto).toList();
    String nextCursor = hasNext ? encode(rows.get(limit - 1).getId().toString()) : null;

    return ResponseEntity.ok(Map.of(
        "data", data,
        "meta", Map.of("hasNext", hasNext, "nextCursor", nextCursor)
    ));
}
```

**Pros:** Consistent performance regardless of position, stable with concurrent inserts
**Cons:** Cannot jump to arbitrary page, cursor is opaque

### When to Use Which

| Use Case | Pagination Type |
|----------|----------------|
| Admin dashboards, small datasets (<10K) | Offset (Spring `Pageable`) |
| Infinite scroll, feeds, large datasets | Cursor |
| Public APIs | Cursor (default) with offset (optional) |
| Search results | Offset (users expect page numbers) |

---

## Filtering, Sorting, and Search

### Filtering with Spring Data Specifications

```java
// Specification builder
public class UserSpec {
    public static Specification<User> hasStatus(String status) {
        return (root, query, cb) -> status == null
            ? cb.conjunction()
            : cb.equal(root.get("status"), status);
    }

    public static Specification<User> createdAfter(LocalDate date) {
        return (root, query, cb) -> date == null
            ? cb.conjunction()
            : cb.greaterThanOrEqualTo(root.get("createdAt"), date.atStartOfDay());
    }
}

// Controller
@GetMapping("/users")
public Page<UserDto> list(
        @RequestParam(required = false) String status,
        @RequestParam(required = false) @DateTimeFormat(iso = ISO.DATE) LocalDate createdAfter,
        Pageable pageable) {

    Specification<User> spec = Specification
        .where(UserSpec.hasStatus(status))
        .and(UserSpec.createdAfter(createdAfter));

    return userRepository.findAll(spec, pageable).map(userMapper::toDto);
}
```

### Sorting

```
# Single field (Spring Pageable format)
GET /api/v1/products?sort=createdAt,desc

# Multiple fields
GET /api/v1/products?sort=featured,desc&sort=price,asc
```

```java
// Spring automatically binds sort params via Pageable
// Whitelist sortable fields to prevent SQL injection
@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
        SortHandlerMethodArgumentResolver resolver = new SortHandlerMethodArgumentResolver();
        resolver.setPropertyDelimiter(",");
        resolvers.add(new PageableHandlerMethodArgumentResolver(resolver));
    }
}
```

### Full-Text Search with JPA

```java
@Query("SELECT u FROM User u WHERE " +
       "LOWER(u.name) LIKE LOWER(CONCAT('%', :q, '%')) OR " +
       "LOWER(u.email) LIKE LOWER(CONCAT('%', :q, '%'))")
Page<User> search(@Param("q") String query, Pageable pageable);
```

---

## Implementation: Spring Boot

### Project Setup (pom.xml)

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-validation</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
</dependencies>
```

### Request/Response DTOs

```java
// Request DTO with Bean Validation
public record CreateUserRequest(
    @NotBlank @Email
    String email,

    @NotBlank @Size(min = 1, max = 100)
    String name,

    @Min(0) @Max(150)
    Integer age
) {}

// Response DTO
public record UserDto(
    UUID id,
    String email,
    String name,
    LocalDateTime createdAt
) {}
```

### Controller

```java
@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping
    public ResponseEntity<PagedResponse<UserDto>> list(
            @RequestParam(required = false) String status,
            Pageable pageable) {

        Page<UserDto> page = userService.findAll(status, pageable);
        return ResponseEntity.ok(PagedResponse.of(page));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<UserDto>> getById(@PathVariable UUID id) {
        UserDto user = userService.findById(id);
        return ResponseEntity.ok(ApiResponse.of(user));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<UserDto>> create(
            @Valid @RequestBody CreateUserRequest request) {

        UserDto created = userService.create(request);
        URI location = URI.create("/api/v1/users/" + created.id());

        return ResponseEntity
            .created(location)
            .body(ApiResponse.of(created));
    }

    @PatchMapping("/{id}")
    public ResponseEntity<ApiResponse<UserDto>> update(
            @PathVariable UUID id,
            @Valid @RequestBody UpdateUserRequest request) {

        UserDto updated = userService.update(id, request);
        return ResponseEntity.ok(ApiResponse.of(updated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        userService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
```

### Global Exception Handler

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    // Bean Validation failures (@Valid)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(
            MethodArgumentNotValidException ex) {

        List<FieldError> details = ex.getBindingResult().getFieldErrors().stream()
            .map(e -> new FieldError(e.getField(), e.getDefaultMessage(), "invalid_value"))
            .toList();

        return ResponseEntity
            .unprocessableEntity()
            .body(ErrorResponse.of("validation_error", "Request validation failed", details));
    }

    // Deserialization failures (malformed JSON, wrong types)
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ErrorResponse> handleMalformedJson(
            HttpMessageNotReadableException ex) {

        return ResponseEntity
            .badRequest()
            .body(ErrorResponse.of("invalid_json", "Malformed request body"));
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFound(ResourceNotFoundException ex) {
        return ResponseEntity
            .status(HttpStatus.NOT_FOUND)
            .body(ErrorResponse.of("not_found", ex.getMessage()));
    }

    @ExceptionHandler(DuplicateResourceException.class)
    public ResponseEntity<ErrorResponse> handleConflict(DuplicateResourceException ex) {
        return ResponseEntity
            .status(HttpStatus.CONFLICT)
            .body(ErrorResponse.of("conflict", ex.getMessage()));
    }

    // Catch-all: never expose internal details
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleUnexpected(Exception ex) {
        log.error("Unexpected error", ex);
        return ResponseEntity
            .internalServerError()
            .body(ErrorResponse.of("internal_error", "An unexpected error occurred"));
    }
}
```

### Shared Response Wrappers

```java
public record ApiResponse<T>(T data) {
    public static <T> ApiResponse<T> of(T data) { return new ApiResponse<>(data); }
}

public record PagedResponse<T>(
    List<T> data,
    PaginationMeta meta,
    PaginationLinks links
) {
    public static <T> PagedResponse<T> of(Page<T> page) { /* ... */ }
}

public record ErrorResponse(ErrorBody error) {
    public record ErrorBody(String code, String message, List<FieldError> details) {}

    public static ErrorResponse of(String code, String message) {
        return new ErrorResponse(new ErrorBody(code, message, null));
    }
    public static ErrorResponse of(String code, String message, List<FieldError> details) {
        return new ErrorResponse(new ErrorBody(code, message, details));
    }
}

public record FieldError(String field, String message, String code) {}
```

### Authentication with Spring Security + JWT

```java
@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtAuthFilter jwtAuthFilter;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        return http
            .csrf(AbstractHttpConfigurer::disable)
            .sessionManagement(sm -> sm.sessionCreationPolicy(STATELESS))
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/v1/auth/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/api/v1/products/**").permitAll()
                .anyRequest().authenticated()
            )
            .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class)
            .build();
    }
}

// In a controller: access authenticated user
@GetMapping("/me")
public ResponseEntity<ApiResponse<UserDto>> me(
        @AuthenticationPrincipal UserDetails userDetails) {
    UserDto user = userService.findByEmail(userDetails.getUsername());
    return ResponseEntity.ok(ApiResponse.of(user));
}

// Role-based access
@DeleteMapping("/{id}")
@PreAuthorize("hasRole('ADMIN')")
public ResponseEntity<Void> delete(@PathVariable UUID id) {
    userService.delete(id);
    return ResponseEntity.noContent().build();
}
```

### Rate Limiting with Bucket4j

```java
@Component
@RequiredArgsConstructor
public class RateLimitFilter extends OncePerRequestFilter {

    private final Map<String, Bucket> buckets = new ConcurrentHashMap<>();

    private Bucket resolveBucket(String key) {
        return buckets.computeIfAbsent(key, k -> Bucket.builder()
            .addLimit(Bandwidth.classic(100, Refill.intervally(100, Duration.ofMinutes(1))))
            .build());
    }

    @Override
    protected void doFilterInternal(HttpServletRequest req,
            HttpServletResponse res, FilterChain chain) throws IOException, ServletException {

        String key = Optional.ofNullable(req.getHeader("X-API-Key"))
            .orElse(req.getRemoteAddr());

        Bucket bucket = resolveBucket(key);
        ConsumptionProbe probe = bucket.tryConsumeAndReturnRemaining(1);

        res.addHeader("X-RateLimit-Limit", "100");
        res.addHeader("X-RateLimit-Remaining", String.valueOf(probe.getRemainingTokens()));

        if (!probe.isConsumed()) {
            res.setStatus(429);
            res.addHeader("Retry-After", "60");
            res.getWriter().write("""
                {"error":{"code":"rate_limit_exceeded",
                "message":"Rate limit exceeded. Try again in 60 seconds."}}
            """);
            return;
        }
        chain.doFilter(req, res);
    }
}
```

---

## Implementation: React

### API Client (axios + interceptors)

```typescript
// src/lib/apiClient.ts
import axios, { AxiosError } from "axios";

export const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL ?? "/api/v1",
  headers: { "Content-Type": "application/json" },
});

// Attach JWT on every request
apiClient.interceptors.request.use((config) => {
  const token = localStorage.getItem("token");
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

// Handle 401 globally — redirect to login
apiClient.interceptors.response.use(
  (res) => res,
  (error: AxiosError) => {
    if (error.response?.status === 401) {
      localStorage.removeItem("token");
      window.location.href = "/login";
    }
    return Promise.reject(error);
  }
);
```

### Typed API Functions

```typescript
// src/api/users.ts
import { apiClient } from "@/lib/apiClient";

export interface User {
  id: string;
  email: string;
  name: string;
  createdAt: string;
}

export interface PagedResponse<T> {
  data: T[];
  meta: { total: number; page: number; perPage: number; totalPages: number };
  links: { self: string; next?: string; last?: string };
}

export interface ApiError {
  error: {
    code: string;
    message: string;
    details?: { field: string; message: string; code: string }[];
  };
}

export const usersApi = {
  list: (params?: { status?: string; page?: number; size?: number }) =>
    apiClient.get<PagedResponse<User>>("/users", { params }).then((r) => r.data),

  getById: (id: string) =>
    apiClient.get<{ data: User }>(`/users/${id}`).then((r) => r.data.data),

  create: (payload: { email: string; name: string }) =>
    apiClient.post<{ data: User }>("/users", payload).then((r) => r.data.data),

  update: (id: string, payload: Partial<User>) =>
    apiClient.patch<{ data: User }>(`/users/${id}`, payload).then((r) => r.data.data),

  delete: (id: string) =>
    apiClient.delete(`/users/${id}`),
};
```

### Data Fetching with TanStack Query

```typescript
// src/hooks/useUsers.ts
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { usersApi, ApiError } from "@/api/users";
import { AxiosError } from "axios";

export const userKeys = {
  all: ["users"] as const,
  list: (params?: object) => [...userKeys.all, "list", params] as const,
  detail: (id: string) => [...userKeys.all, "detail", id] as const,
};

export function useUsers(params?: { status?: string; page?: number; size?: number }) {
  return useQuery({
    queryKey: userKeys.list(params),
    queryFn: () => usersApi.list(params),
    staleTime: 30_000,
  });
}

export function useUser(id: string) {
  return useQuery({
    queryKey: userKeys.detail(id),
    queryFn: () => usersApi.getById(id),
    enabled: !!id,
  });
}

export function useCreateUser() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: usersApi.create,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: userKeys.all }),
  });
}

export function useDeleteUser() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: usersApi.delete,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: userKeys.all }),
  });
}
```

### API Error Handling in Components

```typescript
// src/utils/apiError.ts
import { AxiosError } from "axios";
import { ApiError } from "@/api/users";

export function extractApiError(error: unknown): string {
  if (error instanceof AxiosError) {
    const data = error.response?.data as ApiError | undefined;
    return data?.error?.message ?? "An unexpected error occurred";
  }
  return "An unexpected error occurred";
}

export function extractFieldErrors(
  error: unknown
): Record<string, string> {
  if (error instanceof AxiosError) {
    const data = error.response?.data as ApiError | undefined;
    return Object.fromEntries(
      (data?.error?.details ?? []).map((d) => [d.field, d.message])
    );
  }
  return {};
}
```

```tsx
// src/components/CreateUserForm.tsx
import { useState } from "react";
import { useCreateUser } from "@/hooks/useUsers";
import { extractApiError, extractFieldErrors } from "@/utils/apiError";

export function CreateUserForm() {
  const { mutate, isPending, error } = useCreateUser();
  const fieldErrors = extractFieldErrors(error);
  const globalError = error ? extractApiError(error) : null;

  const [form, setForm] = useState({ email: "", name: "" });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    mutate(form);
  };

  return (
    <form onSubmit={handleSubmit}>
      {globalError && <p role="alert" className="text-red-600">{globalError}</p>}

      <label>
        Email
        <input
          type="email"
          value={form.email}
          onChange={(e) => setForm((f) => ({ ...f, email: e.target.value }))}
          aria-invalid={!!fieldErrors.email}
        />
        {fieldErrors.email && <span className="text-red-500">{fieldErrors.email}</span>}
      </label>

      <label>
        Name
        <input
          value={form.name}
          onChange={(e) => setForm((f) => ({ ...f, name: e.target.value }))}
          aria-invalid={!!fieldErrors.name}
        />
        {fieldErrors.name && <span className="text-red-500">{fieldErrors.name}</span>}
      </label>

      <button type="submit" disabled={isPending}>
        {isPending ? "Creating…" : "Create User"}
      </button>
    </form>
  );
}
```

### Paginated List Component

```tsx
// src/components/UserList.tsx
import { useState } from "react";
import { useUsers } from "@/hooks/useUsers";

export function UserList() {
  const [page, setPage] = useState(1);
  const { data, isLoading, isError } = useUsers({ page, size: 20 });

  if (isLoading) return <p>Loading…</p>;
  if (isError)   return <p role="alert">Failed to load users.</p>;

  return (
    <>
      <ul>
        {data?.data.map((user) => (
          <li key={user.id}>{user.name} — {user.email}</li>
        ))}
      </ul>

      <nav aria-label="Pagination">
        <button onClick={() => setPage((p) => p - 1)} disabled={page === 1}>
          Previous
        </button>
        <span>Page {data?.meta.page} of {data?.meta.totalPages}</span>
        <button
          onClick={() => setPage((p) => p + 1)}
          disabled={page === data?.meta.totalPages}
        >
          Next
        </button>
      </nav>
    </>
  );
}
```

---

## Versioning

### URL Path Versioning (Recommended)

```
/api/v1/users
/api/v2/users
```

```java
// Spring Boot: version via RequestMapping prefix
@RestController
@RequestMapping("/api/v1/users")
public class UserV1Controller { /* ... */ }

@RestController
@RequestMapping("/api/v2/users")
public class UserV2Controller { /* ... */ }

// Or via a single controller with path differentiation
@GetMapping({"/api/v1/users", "/api/v2/users"})
```

### Versioning Strategy

```
1. Start with /api/v1/ — don't version until you need to
2. Maintain at most 2 active versions (current + previous)
3. Deprecation timeline:
   - Announce deprecation (6 months notice for public APIs)
   - Add Sunset header: Sunset: Sat, 01 Jan 2026 00:00:00 GMT
   - Return 410 Gone after sunset date
4. Non-breaking changes don't need a new version:
   - Adding new fields to responses
   - Adding new optional query parameters
   - Adding new endpoints
5. Breaking changes require a new version:
   - Removing or renaming fields
   - Changing field types
   - Changing URL structure
   - Changing authentication method
```

---

## application.yml: Key Settings

```yaml
spring:
  jackson:
    default-property-inclusion: non_null          # omit null fields
    serialization:
      write-dates-as-timestamps: false            # ISO-8601 dates
    deserialization:
      fail-on-unknown-properties: false           # tolerate extra fields

  data:
    web:
      pageable:
        default-page-size: 20
        max-page-size: 100
        one-indexed-parameters: true              # page=1 instead of page=0

server:
  error:
    include-message: never                        # hide Spring's default error messages
    include-stacktrace: never
```

---

## API Design Checklist

Before shipping a new endpoint:

- [ ] Resource URL follows naming conventions (plural, kebab-case, no verbs)
- [ ] Correct HTTP method used (GET for reads, POST for creates, etc.)
- [ ] Appropriate status codes returned (not 200 for everything)
- [ ] Input validated with `@Valid` + Bean Validation annotations
- [ ] `@RestControllerAdvice` handles all exception types consistently
- [ ] Pagination implemented for list endpoints (`Pageable` or cursor)
- [ ] Authentication required (Spring Security) or explicitly permitted
- [ ] Authorization checked (`@PreAuthorize`, ownership check in service)
- [ ] Rate limiting configured (Bucket4j filter)
- [ ] Response never leaks internal details (stack traces, SQL errors)
- [ ] Consistent `camelCase` naming across all responses
- [ ] React API layer uses typed functions + TanStack Query
- [ ] Field-level errors surfaced in forms via `details[]` array
- [ ] OpenAPI/Swagger spec updated (`springdoc-openapi`)