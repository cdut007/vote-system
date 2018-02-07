package com.itender.listener;

import com.itender.ms.service.ItenderPrivilegeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class PrivilegeInitListener implements ServletContextListener {
    private static final Logger logger = LoggerFactory.getLogger(PrivilegeInitListener.class);


    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext sc = servletContextEvent.getServletContext();
        ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(sc);
        ItenderPrivilegeService itenderPrivilegeService = ac.getBean(ItenderPrivilegeService.class);
        logger.debug("###########################初始化权限###############################");
        itenderPrivilegeService.initPrivilege();
        logger.debug("###########################初始化完成###############################");
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
