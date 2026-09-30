package com.example.health;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Map;
import org.junit.jupiter.api.Test;

class HealthControllerTest {

    @Test
    void ac2_healthReturnsStatusOk() {
        assertThat(new HealthController().health()).containsExactlyEntriesOf(Map.of("status", "OK"));
    }
}
