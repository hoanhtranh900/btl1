package com.example.btl1.utils;

import java.util.Collection;

public class H {
    public static Boolean isTrue(Object value) {

        if (value == null) return false;

        if (value instanceof String) return !((String) value).trim().isEmpty();

        if (value instanceof Number) return !((Number) value).equals(Long.valueOf(0));

        if (value instanceof Boolean) return (Boolean) value;

        if (value instanceof Collection) return !((Collection) value).isEmpty();

        if (value instanceof Object[]) return ((Object[]) value).length > 0;

        return true;
    }

    public static String getFileExtension(String originalFilename) {
        if (originalFilename == null) return null;
        int index = originalFilename.lastIndexOf(".");
        if (index == -1) return null;
        return originalFilename.substring(index + 1);
    }
}
