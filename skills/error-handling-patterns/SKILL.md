---
name: implementing-error-handling
description: Master error handling patterns across languages including exceptions, Result types, error propagation, and graceful degradation to build resilient applications. Use when adding try/catch blocks, handling async errors, fixing silent failures, or designing fallback strategies. Triggers on: unhandled exception, error boundary, async error, retry logic, fallback, graceful degradation, API error response, catch block, error state.
---

# Error Handling Patterns

Build resilient applications with robust error handling strategies that gracefully handle failures and provide excellent debugging experiences.

## When to use this skill
- Implementing error handling in new features.
- Designing error-resilient APIs.
- Debugging production issues.
- Improving application reliability.
- Creating better error messages for users and developers.
- Implementing retry and circuit breaker patterns.

## Workflow
1.  **Identify Error Category**: Determine if the error is recoverable (timeouts, invalid input) or unrecoverable (OOM, bugs).
2.  **Select Philosophy**: Choose between Exceptions, Result Types, or Error Codes based on the language and context.
3.  **Apply Patterns**: Implement the appropriate pattern (Circuit Breaker, Aggregation, Graceful Degradation).
4.  **Validate Implementation**: Ensure resources are cleaned up (try-finally) and context is preserved.

## Instructions

### Language-Specific Patterns

#### Python
- Use custom exception hierarchies for domain errors.
- Implement retries with exponential backoff for network operations.
- Use context managers (`@contextmanager`) for resource cleanup.

#### TypeScript/JavaScript
- Use custom classes extending `Error` for typed errors.
- Use the **Result Type Pattern** (`{ ok: true, value: T } | { ok: false, error: E }`) for explicit handling.
- Always handle async errors (try-catch in async/await).

#### Go/Rust
- Follow idiomatic patterns (explicit error returns in Go, `Result`/`Option` in Rust).

### Universal Patterns
- **Circuit Breaker**: Prevent cascading failures.
- **Error Aggregation**: Collect multiple errors before failing.
- **Graceful Degradation**: Provide fallbacks for non-critical failures.

## Resources
- `references/exception-hierarchy-design.md`
- `references/error-recovery-strategies.md`
- `references/async-error-handling.md`
