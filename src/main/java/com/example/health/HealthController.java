package com.example.health;

import java.util.Map;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/** Public health endpoint (specs/health-endpoint.md, REQ-1 and REQ-2). */
@RestController
public class HealthController {

    @GetMapping(path = "/api/health", produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, String> health() {
        return Map.of("status", "OK");
    }
}
