package org.ruoyi.service;

import org.springframework.stereotype.Component;

import java.util.concurrent.ConcurrentHashMap;

@Component
public class GenerationCancelManager {

    private final ConcurrentHashMap<String, Boolean> flags = new ConcurrentHashMap<>();
    private final ThreadLocal<String> currentSessionId = new ThreadLocal<>();

    public void setCurrent(String sessionId) {
        currentSessionId.set(sessionId);
    }

    public void clearCurrent() {
        currentSessionId.remove();
    }

    public void cancel(String sessionId) {
        flags.put(sessionId, true);
    }

    public boolean isCancelled() {
        String sid = currentSessionId.get();
        return sid != null && flags.getOrDefault(sid, false);
    }

    public void clear(String sessionId) {
        flags.remove(sessionId);
    }
}
