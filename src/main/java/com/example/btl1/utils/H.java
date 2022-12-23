package com.example.btl1.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;

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

    public static Date str2date(String dateStr, String format){
        SimpleDateFormat sdf = new SimpleDateFormat(format);//"yyyy-MM-dd HH:mm"
        Date date = null;
        try {
            if(isTrue(dateStr))
                date = sdf.parse(dateStr);
        } catch (Exception e) {

        }
        return date;
    }

    public static String date2str(Date input, String oFormat) {
        String result = "";
        if (input != null) {
            try {
                DateFormat df = new SimpleDateFormat(oFormat);
                result = df.format(input);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }

    public static String convertMoney(Long total) {
        //convert to 1.000.000
        String result = "";
        if (total != null) {
            String str = total.toString();
            int count = 0;
            for (int i = str.length() - 1; i >= 0; i--) {
                result = str.charAt(i) + result;
                count++;
                if (count == 3 && i != 0) {
                    result = "." + result;
                    count = 0;
                }
            }
        }
        return result;
    }
}
