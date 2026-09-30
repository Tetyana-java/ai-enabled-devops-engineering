# Spec: Health endpoint

## Status

Status: Approved

## Problem

There is no way to check whether the service is running. The request asks for a health endpoint that returns HTTP 200 with status OK.

## Scope

- Java 17, Spring Boot 2.7.18, Maven 3.9.8, standard Maven layout (src/main/java, src/test/java)
- Maven coordinates com.example:health-service, package com.example.health
- Public endpoint, GET api/health, return HTTP 200 and {"status":"OK"}
- unit tests for the endpoint,  Web slice test (@WebMvcTest / MockMvc), full integration test (@SpringBootTest)

## Out of Scope
- Authentication or authorization.
- Dependency checks (database, downstream services), metrics, readiness or liveness split, version info, and authentication.
- Any other endpoint or application feature.

## Requirements

- REQ-1: GET api/health returns HTTP 200 {"status":"OK"}` with content type `application/json'
- REQ-2: `GET api/health` is reachable without authentication.
- REQ-3: mvn test runs tests and no test failures

## Acceptance criteria

- AC-1 (REQ-1, REQ-2): Given the service is running, when a client sends `GET api/health`, then the response status is 200.
- AC-2 (REQ-1): Given the service is running, when a client sends `GET api/health`, then the response body is `{"status":"OK"}`
  with content type `application/json`.
- AC-3 (REQ-2): Given the service is running, when a client sends `GET api/health` without credentials, then the request is not
  rejected for authentication reasons.
- AC-4 (REQ-3): Given the source tree, when `mvn test` is run, then all tests pass with no failures.

## Security

The endpoint is public (no authentication). No sensitive information is exposed.

## Dependencies

- JUnit 5 (Jupiter) — test engine
- Spring Test + spring-boot-test — @SpringBootTest, @WebMvcTest, MockMvc
- AssertJ — assertions (including exact JSON body checks via jsonPath)
- JSONPath (json-path) — the jsonPath("$.status") matcher for asserting {"status":"OK"}
- Mockito — mocking (not strictly needed here, but included)

## Open Questions

- Q-1: What language and runtime should the service use? Answer: Java 17, Spring boot 2.7.18, mmaven 3.9.8
- Q-2: What is the route and HTTP method, for example `GET /health`? Answer: api/health
- Q-3: Which host and port should the service listen on, and how are they configured (for example an environment variable)? Answer: port 8080
- Q-4: What is the exact response body and content type, for example plain text `OK` or JSON `{"status":"OK"}`? Answer: `{"status":"OK"}`
- Q-5: Must the endpoint be public (no auth)? Answer: yes
- Q-6: Which test tool may we use? Is the standard library alone acceptable? Answer: JUnit 5, MockMvc or sth similar for testing REST
- Q-7: May we use a web framework or other dependency, or only the standard library HTTP server? Answer:  Yes, Spring Boot 2.7 (spring-boot-starter-web).

## Human approval

Approved by: Tetyana Petrenko
Date: 2026-09-30
