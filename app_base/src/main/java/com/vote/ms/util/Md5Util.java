package com.vote.ms.util;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Md5Util {
    private static Logger logger = LoggerFactory.getLogger(Md5Util.class);



    private static final String hexDigIts[] = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"};

    /**
     * MD5加密
     * @param origin 字符
     * @param charsetname 编码
     * @return
     */
    public static String MD5Encode(String origin, String charsetname){
        String resultString = null;
        try{
            resultString = new String(origin);
            MessageDigest md = MessageDigest.getInstance("MD5");
            if(null == charsetname || "".equals(charsetname)){
                resultString = byteArrayToHexString(md.digest(resultString.getBytes()));
            }else{
                resultString = byteArrayToHexString(md.digest(resultString.getBytes(charsetname)));
            }
        }catch (Exception e){
        }
        return resultString;
    }


    public static String byteArrayToHexString(byte b[]){
        StringBuffer resultSb = new StringBuffer();
        for(int i = 0; i < b.length; i++){
            resultSb.append(byteToHexString(b[i]));
        }
        return resultSb.toString();
    }

    public static String byteToHexString(byte b){
        int n = b;
        if(n < 0){
            n += 256;
        }
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigIts[d1] + hexDigIts[d2];
    }


    public static String getMD5Base64(String str) {
        MessageDigest messageDigest=null;
        try {
            messageDigest = MessageDigest.getInstance("md5");
            byte[] b = messageDigest.digest(str.getBytes());
            return new String(Base64.encodeBase64(b));
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("计算文件MD5值出错！");
        }
    }

    public static String getMD5Hex(String str) {
        MessageDigest messageDigest = null;

        try {
            messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.reset();
            messageDigest.update(str.getBytes());
            // str.getBytes("US-ASCII")
            byte[] byteArray = messageDigest.digest();
            StringBuffer md5StrBuff = new StringBuffer();
            for (int i = 0; i < byteArray.length; i++) {
                if (Integer.toHexString(0xFF & byteArray[i]).length() == 1){
                    md5StrBuff.append("0").append(Integer.toHexString(0xFF & byteArray[i]));
                }else{
                    md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
                }
            }
            return md5StrBuff.toString();
        } catch (NoSuchAlgorithmException e) {
            logger.error(e.getMessage(), e);;
            throw new RuntimeException("计算文件MD5值出错！");
        }
    }

    protected static char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

    public static String md5sum(File file) throws Exception {
        FileInputStream in = new FileInputStream(file);
        String md5code = md5sum(in);
        in.close();
        return md5code;
    }

    public static String md5sum(InputStream inputStream) {
        try {
            inputStream = new BufferedInputStream(inputStream);
            MessageDigest digest = MessageDigest.getInstance("md5");
            byte[] buf = new byte[1024 * 1024 * 8];
            int num = -1;
            while (-1 != (num = inputStream.read(buf))) {
                digest.update(buf, 0, num);
            }
            byte[] bytes = digest.digest();
            int m = 0;
            int n = bytes.length;
            StringBuffer stringbuffer = new StringBuffer(2 * n);
            int k = m + n;
            for (int l = m; l < k; l++) {
                appendHexPair(bytes[l], stringbuffer);
            }
            return stringbuffer.toString();
        } catch (Exception e) {
            throw new RuntimeException("计算文件MD5值出错！");
        }
    }

    private static void appendHexPair(byte bt, StringBuffer stringbuffer) {
        char c0 = hexDigits[(bt & 0xf0) >> 4];
        char c1 = hexDigits[bt & 0xf];
        stringbuffer.append(c0);
        stringbuffer.append(c1);
    }



    public static void main(String[] args) {
        System.out.println(Md5Util.getMD5Base64("00000000016"));
        System.out.println(Md5Util.getMD5Hex("00000000016"));

    }
}
