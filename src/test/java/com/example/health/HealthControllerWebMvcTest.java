package com.example.health;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

@WebMvcTest(HealthController.class)
class HealthControllerWebMvcTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void ac1_getHealthReturns200() throws Exception {
        mockMvc.perform(get("/api/health")).andExpect(status().isOk());
    }

    @Test
    void ac2_getHealthReturnsJsonStatusOk() throws Exception {
        mockMvc.perform(get("/api/health"))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.status").value("OK"))
                .andExpect(content().json("{\"status\":\"OK\"}", true));
    }

    @Test
    void ac3_getHealthWithoutCredentialsIsNotRejected() throws Exception {
        mockMvc.perform(get("/api/health")).andExpect(status().isOk());
    }
}
