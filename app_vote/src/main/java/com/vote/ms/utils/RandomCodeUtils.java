package com.vote.ms.utils;

import java.util.Random;

public class RandomCodeUtils {
    private static final char[] codeSequenceRandom = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '1', '2', '3', '4',
            '5', '6', '7', '8', '9', '0'};
    private static final char[] numberSequenceRandom = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'};

    /**
     * 功能描述:生成字符串随机数
     *
     * @return String
     * @author 高宇飞
     */
    public static String createRandomCode(int count) {
        StringBuilder serialNum = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < count; i++) {
            String strRand = String.valueOf(codeSequenceRandom[random.nextInt(codeSequenceRandom.length)]);
            serialNum.append(strRand);
        }
        return serialNum.toString();
    }

    /**
     * 生成数字随机数
     */
    public static String createRandomNum(int count) {
        StringBuilder serialNum = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < count; i++) {
            String strRand = String.valueOf(numberSequenceRandom[random.nextInt(numberSequenceRandom.length)]);
            serialNum.append(strRand);
        }
        return serialNum.toString();
    }

}
