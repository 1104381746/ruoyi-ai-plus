package org.ruoyi.service;

import org.springframework.stereotype.Component;

import java.util.concurrent.ConcurrentHashMap;

@Component
public class GenerationCancelManager {

    private final ConcurrentHashMap<String, Boolean> flags = new ConcurrentHashMap<>();

    public void cancel(String sessionId) {
        flags.put(sessionId, true);
    }

    public boolean isCancelled(String sessionId) {
        return sessionId != null && flags.getOrDefault(sessionId, false);
    }

    public void clear(String sessionId) {
        flags.remove(sessionId);
    }
}
