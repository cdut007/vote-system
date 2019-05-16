package com.bank.guarantee.ms.domain;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonRootName;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;

/**
 * Created by djiep on 2017/4/21.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
@JsonRootName("error")
public class ErrorResponse {
    private static final Logger logger = LoggerFactory.getLogger(ErrorResponse.class);
    private Date timestamp = new Date();
    private Integer status;
    private String code;
    private String message;
    private String longMessage;
    private Object errors;

    

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getLongMessage() {
        return longMessage;
    }

    public void setLongMessage(String longMessage) {
        this.longMessage = longMessage;
    }

    public Object getErrors() {
        return errors;
    }

    public void setErrors(Object errors) {
        this.errors = errors;
    }

    public ErrorResponse(Integer status, String code, String message){
        this.status = status;
        this.code = code;
        this.message = message;
    }

    public ErrorResponse(Integer status, String code, String message, String longMessage){
        this.status = status;
        this.code = code;
        this.message = message;
        this.longMessage = longMessage;
    }

    public String toString() {
        ObjectMapper mapper = new ObjectMapper();

        try {
            return mapper.writeValueAsString(this);
        } catch (JsonProcessingException var3) {
            logger.error("parse json string error: {}", var3);
            return null;
        }
    }
}
