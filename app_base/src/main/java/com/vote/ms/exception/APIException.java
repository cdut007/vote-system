package com.vote.ms.exception;


/**
 * Created by djiep on 2017/4/22.
 */
public class APIException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    private String msg;
    private int code = 500;

    public APIException(String msg) {
        super(msg);
        this.msg = msg;
    }

    public APIException(String msg, Throwable e) {
        super(msg, e);
        this.msg = msg;
    }

    public APIException(String msg, int code) {
        super(msg);
        this.msg = msg;
        this.code = code;
    }

    public APIException(String msg, int code, Throwable e) {
        super(msg, e);
        this.msg = msg;
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

}
