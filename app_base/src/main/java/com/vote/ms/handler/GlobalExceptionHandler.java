package com.vote.ms.handler;

import com.vote.ms.domain.ErrorResponse;
import com.vote.ms.enums.ServiceCode;
import com.vote.ms.exception.APIException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@ControllerAdvice
@Component
public class GlobalExceptionHandler {
    private final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler
    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map handle(MethodArgumentNotValidException exception) {
        return error(exception.getBindingResult().getFieldErrors()
                .stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.toList()));
    }


    @ExceptionHandler
    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handle(ConstraintViolationException exception) {
        List<String> collect = exception.getConstraintViolations()
                .stream()
                .map(ConstraintViolation::getMessage)
                .collect(Collectors.toList());


        return new ErrorResponse(HttpStatus.BAD_REQUEST.value(),
                ServiceCode.VALIDATE_ERROR.value(),
                collect.get(0));
    }


    @ExceptionHandler
    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handle(APIException bindException) {
        return bindException.getErrorResponse();
    }

//    @ExceptionHandler
//    @ResponseBody
//    @ResponseStatus(HttpStatus.BAD_REQUEST)
//    public ErrorResponse handle(MySQLIntegrityConstraintViolationException ex) {
//        return new ErrorResponse(HttpStatus.BAD_REQUEST.value(),
//                ServiceCode.UNIQUENESS_ERROR.value(),
//                ex.getMessage());
//    }

    @ExceptionHandler
    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handle(org.springframework.dao.DuplicateKeyException ex) {
        return new ErrorResponse(HttpStatus.BAD_REQUEST.value(),
                ServiceCode.UNIQUENESS_ERROR.value(),
                ex.getCause().getMessage());
    }

//    @ExceptionHandler
//    @ResponseBody
//    @ResponseStatus(HttpStatus.BAD_REQUEST)
//    public ErrorResponse handle(Exception ex) {
//        ex.printStackTrace();
//        return new ErrorResponse(HttpStatus.BAD_REQUEST.value(),
//                ServiceCode.SERVICE_ERROR.value(),
//                ex.getCause().toString() + ex.getMessage());
//    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ResponseBody
    public ErrorResponse handle(org.springframework.validation.BindException bindException) {
        BindingResult bindingResult = bindException.getBindingResult();

        Map error = bindingResult.getFieldErrors()
                .stream()
                .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));

        if (error == null || error.size() == 0) {
            error = error(bindingResult.getAllErrors()
                    .stream()
                    .map(ObjectError::getDefaultMessage)
                    .collect(Collectors.toList()));
        }

        ErrorResponse errorResponse = new ErrorResponse(HttpStatus.BAD_REQUEST.value(),
                ServiceCode.VALIDATE_ERROR.value(),
                ServiceCode.VALIDATE_ERROR.getReason());

        errorResponse.setErrors(error);
        return errorResponse;
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ResponseBody
    public ErrorResponse handle(MissingServletRequestParameterException ex) {
        ErrorResponse errorResponse = new ErrorResponse(HttpStatus.BAD_REQUEST.value(),
                ServiceCode.VALIDATE_ERROR.value(),
                ServiceCode.VALIDATE_ERROR.getReason());
        errorResponse.setErrors(error(ex.getMessage()));
        return errorResponse;
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ResponseBody
    public ErrorResponse handle(UncategorizedSQLException ex) {
        ErrorResponse errorResponse = new ErrorResponse(HttpStatus.BAD_REQUEST.value(),
                ServiceCode.SERVICE_ERROR.value(),
                ServiceCode.SERVICE_ERROR.getReason());

        String errMsg = ex.getMessage();
        String returnMsg = "";
        //不能删除有引用的异常
        if (errMsg.contains("ORA-01407")) {
            returnMsg = "不能删除有引用关系的数据";
            errorResponse = new ErrorResponse(HttpStatus.BAD_REQUEST.value(),
                    ServiceCode.CAN_NOT_DELETE_RELATIONSHIP.value(),
                    ServiceCode.CAN_NOT_DELETE_RELATIONSHIP.getReason());
        }
        errorResponse.setErrors(error(returnMsg));
        return errorResponse;
    }


    @ExceptionHandler(value = Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ResponseBody
    public ErrorResponse handle(Exception ex) {
        ErrorResponse errorResponse = new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR.value(),
                ServiceCode.SERVICE_ERROR.value(),
                ex.getMessage());
        errorResponse.setErrors(error(ex.getMessage()));

        logger.error("", ex);
        ex.printStackTrace();
        return errorResponse;
    }

    private Map error(Object message) {
        return Collections.singletonMap("error", message);
    }

}