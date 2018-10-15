package com.vote.ms.enums;

/**
 * Created by djiep on 2017/4/22.
 */
public enum ServiceCode {
    REQUEST_OK("100000","request ok"),

    VALIDATE_ERROR("200500","validate error"),

    NOT_FOUND_USER("100404", "user not found"),

    TOPUP_FAILED("100500", "topup failed"),

    SAVE_FAILED("100501", "save failed"),

    NOT_UNIQUENESS("100100", "not uniqueness"),

    CAN_NOT_DELETE_RELATIONSHIP("100600", "can not delete relationship"),   //不能删除有引用关系的数据

    NOT_ENOUGH_BALANCE("100502", "not enough balance"),

    SMS_SEND_FREQUENTLY("100600", "sms send frequently"),

    SMS_OTP_ERROR("100601", "sms otp error"),

    SMS_OTP_EXPIRED("100602", "sms otp expired"),

    SMS_OTP_USED("100603", "sms otp has been used"),

    SMS_URL_ERROR("100604", "sms url error"),

    SERVICE_URL_ERROR("100700", "service url error"),

    UNIQUENESS_ERROR("110001", "uniqueness error"),

    NOT_FOUND("110404", "not found error"),

    OPERATION_FAILED("110400", "operation failed"),

    SERVICE_ERROR("110000", "service error");

    private final String code;

    private final String reason;

    private ServiceCode(String code, String reason) {
        this.code = code;
        this.reason = reason;
    }


    public String value() {
        return this.code;
    }

    public String getReason() {
        return this.reason;
    }

    @Override
    public String toString() {
        return this.code;
    }
}
