# Spec: Health endpoint (sample)

> **Example only.** This file shows what a correctly filled Draft looks like. It is not a work request
> and will never be approved. Write a new `specs/<name>.md` for every real request.

## Status

Status: Draft

## Problem

Operators have no way to check whether the service is running. The request asks for an endpoint that returns HTTP 200 with status OK.

## Scope

- One read-only HTTP endpoint that reports that the service is up.

## Out of Scope

- Dependency checks (database, downstream services), metrics, readiness or liveness split, and authentication.

## Requirements

- REQ-1: The service must expose a health endpoint over HTTP.
- REQ-2: A successful health request must return HTTP status 200.
- REQ-3: The response body must report the status as `OK`.

## Acceptance criteria

- AC-1 (REQ-1, REQ-2): Given the service is running, When a client sends a request to the health endpoint, Then the response status is 200.
- AC-2 (REQ-3): Given the service is running, When a client sends a request to the health endpoint, Then the response body reports status `OK` in the agreed format (Q-4).

## Security

The endpoint returns no data beyond the status. Whether it needs authentication is unknown (Q-5).

## Dependencies

None requested. The language, framework, and test tool are not chosen (Q-1, Q-6).

## Open Questions

- Q-1: What language and runtime should the service use? Answer: <pending>
- Q-2: What is the route and HTTP method, for example `GET /health`? Answer: <pending>
- Q-3: Which port or host should the service listen on, and how is it configured? Answer: <pending>
- Q-4: What is the exact response body, for example plain text `OK` or JSON `{"status":"OK"}`? Answer: <pending>
- Q-5: Must the endpoint be public (no auth)? Answer: <pending>
- Q-6: Which test tool may we use? Is the standard library alone acceptable? Answer: <pending>

## Human approval

Approved by: <name>
Date: <YYYY-MM-DD>
