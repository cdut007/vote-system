package com.itender.ms.aop;

import com.itender.ms.AopUtil;
import com.itender.ms.domain.ItenderBook;
import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.domain.ItenderLog;
import com.itender.ms.domain.ItenderRoom;
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


    /**
     *
     * for room  add or  update  or delete
     *
     * */


    @Pointcut("execution(public * com.itender.ms.controller.RoomController.addRoom(..))")
    public void addRoom() {
    }

    @After("addRoom()")
    public void afterAddRoom(JoinPoint joinPoint) throws APIException {
        ItenderRoom room = null;
        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {
            if (arg instanceof ItenderRoom) {
                room = (ItenderRoom) arg;
            }
        }

        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        ItenderLog itenderLog = AopUtil.initInfo(requestAttributes.getRequest());

        if (room != null) {
            itenderLog.setContent("新建房间:" + room.getName());
        } else {
            itenderLog.setContent("新建房间:新建房间失败!");
        }

        itenderLogService.add(itenderLog);
    }


    @Pointcut("execution(public * com.itender.ms.controller.RoomController.updateRoom(..))")
    public void updateRoom() {
    }

    @After("updateRoom()")
    public void afterUpdateRoom(JoinPoint joinPoint) throws APIException {
        ItenderRoom room = null;
        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {
            if (arg instanceof ItenderRoom) {
                room = (ItenderRoom) arg;
            }
        }

        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        ItenderLog itenderLog = AopUtil.initInfo(requestAttributes.getRequest());

        if (room != null) {
            itenderLog.setContent("更新房间:" + room.getName());
        } else {
            itenderLog.setContent("更新房间:更新房间失败!");
        }

        itenderLogService.add(itenderLog);
    }


    @Pointcut("execution(public * com.itender.ms.controller.RoomController.delRoom(..))")
    public void deleteRoom() {
    }

    @After("deleteRoom()")
    public void afterDeleteRoom(JoinPoint joinPoint) throws APIException {
        ItenderRoom room = null;
        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {
            if (arg instanceof ItenderRoom) {
                room = (ItenderRoom) arg;
            }
        }

        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        ItenderLog itenderLog = AopUtil.initInfo(requestAttributes.getRequest());

        if (room != null) {
            itenderLog.setContent("删除房间:" + room.getName());
        } else {
            itenderLog.setContent("删除房间:删除房间失败!");
        }

        itenderLogService.add(itenderLog);
    }




    /**
     *
     * for book add or cancel
     *
     * */

    @Pointcut("execution(public * com.itender.ms.controller.BookController.addBook(..))")
    public void addBook() {
    }

    @After("addBook()")
    public void afterAddBook(JoinPoint joinPoint) throws APIException {
        ItenderBook book = null;
        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {
            if (arg instanceof ItenderBook) {
                book = (ItenderBook) arg;
            }
        }

        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        ItenderLog itenderLog = AopUtil.initInfo(requestAttributes.getRequest());

        if (book != null) {
            itenderLog.setContent("预订房间:" + book.getContent());
        } else {
            itenderLog.setContent("预订房间:预订房间失败!");
        }

        itenderLogService.add(itenderLog);
    }



    @Pointcut("execution(public * com.itender.ms.controller.BookController.cancelBook(..))")
    public void cancelBook() {
    }

    @After("cancelBook()")
    public void afterCancelBook(JoinPoint joinPoint) throws APIException {
        ItenderBook book = null;
        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {
            if (arg instanceof ItenderBook) {
                book = (ItenderBook) arg;
            }
        }

        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        ItenderLog itenderLog = AopUtil.initInfo(requestAttributes.getRequest());

        if (book != null) {
            itenderLog.setContent("取消预订房间:" + book.getContent());
        } else {
            itenderLog.setContent("取消预订房间:取消预订房间失败!");
        }

        itenderLogService.add(itenderLog);
    }

/**
 * 进入房间 ，离开房间 ，打开视频
 * */
    @Pointcut("execution(public * com.itender.ms.controller.SupervisionController.logRecord(..))")
    public void logRecord() {
    }

    @After("logRecord()")
    public void afterlogRecord(JoinPoint joinPoint) throws APIException {

        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {

        }

        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        ItenderLog itenderLog = AopUtil.initInfo(requestAttributes.getRequest());



       // itenderLogService.add(itenderLog);
    }

    @Pointcut("execution(public * com.itender.ms.controller.SupervisionController.startSupervise(..))")
    public void startSupervise() {
    }

    @After("startSupervise()")
    public void afterstartSupervise(JoinPoint joinPoint) throws APIException {

        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        ItenderLog itenderLog = AopUtil.initInfo(requestAttributes.getRequest());

        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {

        }

        itenderLog.setContent("打开视频:打开监控视频!");

        itenderLogService.add(itenderLog);
    }







}
