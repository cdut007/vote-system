package com.itender.ms.exception;

import com.itender.ms.domain.ErrorResponse;

/**
 * Created by djiep on 2017/4/22.
 */
public class APIException extends Exception {
    private ErrorResponse errorResponse;

    public APIException(String message) {
        super(message);
    }

    public APIException() {
        super();
    }

    public APIException(int status, String code, String message) {
        super(message);
        errorResponse = new ErrorResponse(status, code, message);
    }

    public ErrorResponse getErrorResponse() {
        return this.errorResponse;
    }
}
