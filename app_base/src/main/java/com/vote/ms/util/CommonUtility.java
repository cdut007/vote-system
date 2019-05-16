package com.bank.guarantee.ms.util;

import org.apache.commons.codec.digest.DigestUtils;

import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.*;
import java.security.spec.AlgorithmParameterSpec;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

/**
 * @author dengjiepeng:
 * @areate Date:2012-3-13
 */
public class CommonUtility {
    /**
     * Logger for this class
     */
    private static final String EMAIL_PATTERN = "^((([a-z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+(\\.([a-z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+)*)|((\\x22)((((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(([\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x7f]|\\x21|[\\x23-\\x5b]|[\\x5d-\\x7e]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(\\\\([\\x01-\\x09\\x0b\\x0c\\x0d-\\x7f]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF]))))*(((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(\\x22)))@((([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.)+(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.?$";
    private static final String NUMBER_PATTERN = "^([0-9]+)$";

    /**
     * 字符串是否非空
     *
     * @param str
     * @return
     */
    public static boolean isNonEmpty(String str) {
        boolean result = false;
        if (str != null && !"".trim().equals(str)) {
            result = true;
        }
        return result;
    }

    /**
     * * 通配符比较
     */
    public static boolean simpleWildcardMatch(String pattern, String str) {
        return wildcardMatch(pattern, str, "*");
    }

    /**
     * 通配符比较
     *
     * @param pattern  正则表达式匹配规则,
     * @param str      待匹配字符串
     * @param wildcard 通配符
     * @return
     */
    public static boolean wildcardMatch(String pattern, String str,
                                        String wildcard) {
        if (!isNonEmpty(pattern) || !isNonEmpty(str)) {
            return false;
        }
        /*
         * final boolean startWith = pattern.startsWith(wildcard); final boolean
		 * endWith = pattern.endsWith(wildcard); String[] array =
		 * StringUtils.split(pattern, wildcard); int currentIndex = -1; int
		 * lastIndex = -1 ; switch (array.length) { case 0: return true ; case
		 * 1: currentIndex = str.indexOf(array[0]); if (startWith && endWith) {
		 * return currentIndex >= 0 ; } if (startWith) { return currentIndex +
		 * array[0].length() == str.length(); } if (endWith) { return
		 * currentIndex == 0 ; } return str.equals(pattern) ; default: for
		 * (String part : array) { currentIndex = str.indexOf(part); //
		 * System.out.println("part:"+part); //
		 * System.out.println("currentIndex:"+currentIndex); //
		 * System.out.println("lastIndex:"+lastIndex); if (currentIndex >=
		 * lastIndex) { lastIndex = currentIndex; continue; } return false; }
		 * return true; }
		 */

        pattern = pattern.replace("*", ".*");
        return Pattern.matches(pattern, str);

    }

    /**
     * 替换占位符
     * 占位符标识为{?},其中问号下标从0开始
     * 例如：{0}会被replaceArray[0]所替换
     *
     * @param from         包含占位符的字符串
     * @param replaceArray 替换的字符数组
     * @return
     */
    public static String replacePlaceholders(String from, String[] replaceArray) {
        if (!isNonEmpty(from)) {
            return null;
        }

        if (replaceArray == null) {
            return null;
        }

        for (int i = 0; i < replaceArray.length; i++) {
            from = from.replace("{" + (i) + "}", replaceArray[i]);
        }
        return from;
    }

    /**
     * 获取资源配置文件
     *
     * @param key
     * @return
     */
    public static String getProperty(String key) {
        try {
            Properties prop = new Properties();
            InputStream in = CommonUtility.class.getClassLoader()
                    .getResourceAsStream("httpClientPath.properties");
            prop.load(in);
            return prop.getProperty(key).trim();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    public static Properties getPropertyFile(String fileName) {
        try {
            Properties prop = new Properties();
            InputStream in = CommonUtility.class.getClassLoader()
                    .getResourceAsStream(fileName);
            prop.load(in);
            return prop;
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }


    public static String removePlus(String prefix) {
        if (isNonEmpty(prefix)) {
            if (prefix.contains("+")) {
                prefix = prefix.substring(prefix.indexOf("+") + 1,
                        prefix.length());
            }
        } else {
            prefix = "";
        }
        return prefix.trim();
    }

    /**
     * md5
     *
     * @param str
     * @return
     */
    public static String MD5Digest(String str) {
        // use md5
        String value = null;
        if (isNonEmpty(str)) {
            value = DigestUtils.md5Hex(str);
        }
        return value;
    }

    /**
     * make md5 with disturb string.
     *
     * @param disturbStr
     * @param str
     * @return
     */
    public static String MD5Digest(String disturbStr, String str) {
        // use md5
        if (!isNonEmpty(disturbStr)) {
            disturbStr = "gnum.com:";
        }
        String value = null;
        if (isNonEmpty(str)) {
            str = disturbStr + str;
            value = DigestUtils.md5Hex(str);
        }
        return value;
    }

    /**
     * 将二进制转换成16进制
     *
     * @param buf
     * @return
     */
    public static String parseByte2HexStr(byte buf[]) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < buf.length; i++) {
            String hex = Integer.toHexString(buf[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            sb.append(hex.toUpperCase());
        }
        return sb.toString();
    }

    /**
     * 将16进制转换为二进制
     *
     * @param hexStr
     * @return
     */
    public static byte[] parseHexStr2Byte(String hexStr) {
        if (hexStr.length() < 1)
            return null;
        byte[] result = new byte[hexStr.length() / 2];
        for (int i = 0; i < hexStr.length() / 2; i++) {
            int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
            int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
            result[i] = (byte) (high * 16 + low);
        }
        return result;
    }

    /**
     * AES 加密
     *
     * @param content
     * @param key
     * @return
     */
    public static String AESEncrypt(String content, String key) {
        try {
            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            kgen.init(128, new SecureRandom(key.getBytes()));

            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(kgen.generateKey().getEncoded(), "AES"));
            return parseByte2HexStr(cipher.doFinal(content.getBytes("utf-8")));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * AES 解密
     *
     * @param content
     * @param key
     * @return
     */
    public static String AESDecrypt(String content, String key) {
        try {
            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            kgen.init(128, new SecureRandom(key.getBytes()));

            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(kgen.generateKey().getEncoded(), "AES"));
            byte[] decryptBytes = cipher.doFinal(parseHexStr2Byte(content));
            return new String(decryptBytes);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * AES 解密
     * 更深度的加密方法
     *
     * @param message   被解密字符串
     * @param secretKey 加密串
     * @return
     */
    public static String AESEncryptHit(String message, String secretKey) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidAlgorithmParameterException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
        String str = "";
        byte[] key = parseHexStr2Byte(secretKey.substring(0, 32));
        byte[] iv = parseHexStr2Byte(secretKey.substring(32));
        SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");
        AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv);
        Cipher ecipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        ecipher.init(Cipher.ENCRYPT_MODE, skeySpec, paramSpec);
        str = parseByte2HexStr(ecipher.doFinal(message.getBytes()));
        return str;
    }

    public static String SHA1(String decript) {
        try {
            MessageDigest digest = MessageDigest
                    .getInstance("SHA-1");
            digest.update(decript.getBytes());
            byte messageDigest[] = digest.digest();
            // Create Hex String
            StringBuffer hexString = new StringBuffer();
            // 字节数组转换为 十六进制 数
            for (int i = 0; i < messageDigest.length; i++) {
                String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
                if (shaHex.length() < 2) {
                    hexString.append(0);
                }
                hexString.append(shaHex);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * AES解密
     * 更深度的解密
     *
     * @param message   被解密字符串
     * @param secretKey 加密串
     * @return
     */
    public static String AESDecryptHit(String message, String secretKey) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidAlgorithmParameterException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
        byte[] key = parseHexStr2Byte(secretKey.substring(0, 32));
        byte[] iv = parseHexStr2Byte(secretKey.substring(32));
        SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");
        AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv);
        Cipher dcipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        dcipher.init(Cipher.DECRYPT_MODE, skeySpec, paramSpec);
        return new String(dcipher.doFinal(parseHexStr2Byte(message)));
    }

    /**
     * convert GMT
     *
     * @param GMT
     * @return
     * @throws ParseException
     */
    public static long convertCalendarToTimestamp(String calendar,
                                                  TimeZone timezone) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        format.setTimeZone(timezone);
        // log.info("timezone:"+timezone.getID());
        long time = format.parse(calendar).getTime();
        return time;
    }

    public static String convertCurrentTimestampToCalendar(TimeZone timezone) {
        return convertTimestampToCalendar(0, timezone);
    }

    public static String convertTimestampToCalendar(long timestamp, TimeZone timezone) {
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            format.setTimeZone(timezone);
            Date date = new Date();
            if (timestamp != 0) {
                date = new Date(timestamp);
            }
            String calendarStr = format.format(date);
            return calendarStr;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 去除字符串中的所有空格
     *
     * @param str
     * @return
     */
    public static String removeBlank(String str) {
        str = deleteBlock(str, "");
        return str;
    }

    public static String removeBlank(String str, String replace) {
        str = deleteBlock(str, replace);
        return str;
    }

    private static String deleteBlock(String str, String replace) {
        StringBuffer sb = new StringBuffer();
        if (isNonEmpty(str)) {
            int length = str.length();
            for (int i = 0; i < length; i++) {
                char s = str.charAt(i);
                if (0 == s || 32 == s) {
                    if (isNonEmpty(replace)) sb.append(replace);
                    continue;
                } else {
                    sb.append(s);
                }
            }
            str = sb.toString();
        }
        return str;
    }

    public static String formatTime(String seconds) {
        int time = Integer.parseInt(seconds);
        DecimalFormat df = new DecimalFormat("00");
        int sec = time % 60;
        int min = (time % 3600) / 60;
        int hour = time / 3600;

        String sec_str = df.format(sec);
        String min_str = df.format(min);
        String hour_str = df.format(hour);

        String time_str = "";
        if (hour == 0) {
            if (min == 0) {
                time_str = sec_str + " secs";
            } else {
                time_str = min_str + " mins " + sec_str + " secs";
            }
        } else {
            time_str = hour_str + " hous " + min_str + " mins " + sec_str + " secs";
        }
        //01 hous 00 mins 00 secs
        return time_str;
    }

    /**
     * 保留小数点后指定位数
     *
     * @param from   要保留的原始数据
     * @param length 要保留个数
     * @return
     */
    public static double decimalLeft(double from, int length) {
        String pattern = "#0.";
        for (int i = 0; i < length; i++) {
            pattern += "0";
        }
        DecimalFormat df = new DecimalFormat(pattern);

        return Double.valueOf(df.format(from));
    }

    public static String getYear(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        String year = String.valueOf(calendar.get(Calendar.YEAR));
        return year;
    }

    public static String getMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
        return month;
    }

    public static String getDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        String day = String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
        return day;
    }

    public static String getHour(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        String hour = String.valueOf(calendar.get(Calendar.HOUR_OF_DAY));
        return hour;
    }

    public static String getMinute(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        String minute = String.valueOf(calendar.get(Calendar.MINUTE));
        return minute;
    }

    public static String getSecond(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        String second = String.valueOf(calendar.get(Calendar.SECOND));
        return second;
    }

    public static boolean isDateFormate(String timeStr) throws ParseException {
        boolean result = true;
        SimpleDateFormat df = new SimpleDateFormat("yyyy-DD-mm");
        df.parse(timeStr);
        return result;
    }

    public static boolean isMobileNumber(String mobileNo) {
        boolean result = false;
        if (isNonEmpty(mobileNo)) {
            String regex = "^(\\+)*([0-9])+$";
            result = Pattern.compile(regex).matcher(mobileNo).matches();
        }
        return result;
    }

    public static boolean isNumber(String number) {
        Pattern numberPattern = Pattern.compile(NUMBER_PATTERN);
        if (isNonEmpty(number) && numberPattern.matcher(number).matches()) {
            return true;
        } else {
            return false;
        }

    }

    public static boolean isEmail(String email) {
        Pattern emailPattern = Pattern.compile(EMAIL_PATTERN);
        if (isNonEmpty(email) && emailPattern.matcher(email).matches()) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 格式化时间为默认样式,yyyy-MM-dd HH:mm:ss
     *
     * @param date
     * @return
     */
    public static String formateDate(Date date) {
        return formateDate(date, "yyyy-MM-dd HH:mm:ss");
    }

    /**
     * 格式化样式为指定样式
     *
     * @param date
     * @param formate
     * @return
     */
    public static String formateDate(Date date, String formate) {
        SimpleDateFormat format = new SimpleDateFormat(formate);
        return format.format(date);
    }

    /**
     * 转化时间字符为Date,默认yyyy-MM-dd HH:mm:ss
     *
     * @param date
     * @return
     */
    public static Date parseDate(String time) {
        return parseDate(time, "yyyy-MM-dd HH:mm:ss");
    }

    /**
     * 转化时间字符为Date指定样式
     *
     * @param date
     * @param formate
     * @return
     */
    public static Date parseDate(String time, String formate) {
        SimpleDateFormat format = new SimpleDateFormat(formate);
        Date date = null;
        try {
            date = format.parse(time);
        } catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return date;
    }

    /**
     * 拼装一个URL路径去掉重复的"/"或者"\"
     *
     * @param originalName 原始NAME
     * @param targetName   目标NAME
     * @return
     */
    public static String assemblePath(String originalName, String targetName) {
        String result = null;
        if (isNonEmpty(originalName) && isNonEmpty(targetName)) {
            originalName = originalName.replace("\\", "/");
            if (targetName.endsWith("/") || targetName.endsWith("\\"))
                targetName = targetName.substring(0, targetName.length() - 1);
            if ((originalName.endsWith("/") || originalName.endsWith("\\"))
                    && (!targetName.startsWith("/") || !targetName.startsWith("\\"))) {
                result = originalName + targetName;
            } else if ((originalName.endsWith("/") || originalName.endsWith("\\"))
                    && (targetName.startsWith("/") || targetName.startsWith("\\"))) {
                targetName = targetName.substring(1, targetName.length());
            } else if ((!originalName.endsWith("/") || !originalName.endsWith("\\"))
                    && (targetName.startsWith("/") || targetName.startsWith("\\"))) {
                result = originalName + targetName;
            } else if ((!originalName.endsWith("/") || !originalName.endsWith("\\"))
                    && (!targetName.startsWith("/") || !targetName.startsWith("\\"))) {
                result = originalName + "/" + targetName;
            }
        }
        return result;
    }

    public static Integer parseInteger(String IntegerNumber) {
        Integer result = 0;
        result = Integer.valueOf(IntegerNumber);
        return result;
    }

    public static Float parseFloat(String FloatNumber) {
        Float result = null;
        result = Float.valueOf(FloatNumber);
        return result;
    }

    public static String generateUUID() {
        return UUID.randomUUID().toString();
    }

    public static String generateUUID(Boolean simple) {
        String uuid = UUID.randomUUID().toString();
        if (simple) {
            uuid = uuid.replaceAll("-", "");
        }
        return uuid;
    }
}
