package com.itender.ms.bank.CITIC;


public class Ajax {
    public static final boolean SUCCESS = true;
    public static final boolean ERROR = false;
    private boolean success = SUCCESS;
    private Object data;
    private String msg = "操作成功！";

    public Ajax() {

    }

    public Ajax(boolean success, String msg) {
        super();
        this.success = success;
        this.msg = msg;
    }

    public Ajax(boolean success, String msg, Object data) {
        super();
        this.success = success;
        this.msg = msg;
        this.data = data;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

}