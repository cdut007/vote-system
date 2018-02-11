package com.itender.ms.aop;

import com.itender.ms.AopUtil;
import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.domain.ItenderLog;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderLogService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * 设备日志AOP
 *
 * @author 邓洁芃
 * @create 2018-02-10 上午11:16
 **/
@Aspect
@Component
public class DeviceLogAop {
    private static final Logger logger = LoggerFactory.getLogger(DeviceLogAop.class);

    @Autowired
    private ItenderLogService itenderLogService;

    @Pointcut("execution(public * com.itender.ms.controller.DeviceController.addDevice(..))")
    public void addCut() {
    }

    @After("addCut()")
    public void after(JoinPoint joinPoint) throws APIException {
        ItenderDevice device = null;
        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {
            if (arg instanceof ItenderDevice) {
                device = (ItenderDevice) arg;
            }
        }

        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        ItenderLog itenderLog = AopUtil.initInfo(requestAttributes.getRequest());

        if (device != null) {
            itenderLog.setContent("新建设备:" + device.getName());
        } else {
            itenderLog.setContent("新建设备:设备名称丢失!");
        }

        itenderLogService.add(itenderLog);
    }


    @Pointcut("execution(public * com.itender.ms.controller.DeviceController.updateDevice(..))")
    public void updateCut() {
    }

    @After("updateCut()")
    public void afterUpdateDevice(JoinPoint joinPoint) throws APIException {
        ItenderDevice device = null;
        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {
            if (arg instanceof ItenderDevice) {
                device = (ItenderDevice) arg;
            }
        }

        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        ItenderLog itenderLog = AopUtil.initInfo(requestAttributes.getRequest());

        if (device != null) {
            itenderLog.setContent("更新设备:" + device.getName());
        } else {
            itenderLog.setContent("更新设备:设备名称丢失!");
        }

        itenderLogService.add(itenderLog);
    }



}
