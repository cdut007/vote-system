package com.itender.ms.platform;

import java.util.Date;

public class Config {
    public static final String shanxiDomain="http://www.sxbid.com.cn:8080";//"http://218.26.169.140:8081";


    public static String getJCPlatformCreditCode() {

        return "91140100MA0GTCLY49";//"999999999999999000";
    }


    public static String getPlatfromSerialNumber() {
        String formatDate = com.itender.ms.utils.DateUtils.formatDate(new Date(), "yyyyMMdd");
        String last6 = "213122";
        String sn = "1400000009".concat(formatDate).concat(last6);
        return sn;
    }


    public static String getAddress() {


        return Config.shanxiDomain+"/pspde/services/pspdews?wsdl";
    }

    public static String getAttachmentAddress() {


        return Config.shanxiDomain+"/pspde/services/pspdefilews?wsdl";
    }

    public static String getAppKey() {


        return "1400000002";//"1400000009";
    }

    public static String getAppSecerety() {

        return "sxjinchan5258";//"111111";
    }
}
