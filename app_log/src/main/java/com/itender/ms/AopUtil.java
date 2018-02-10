package com.itender.ms;

import com.itender.ms.domain.BasicUserInfo;
import com.itender.ms.domain.ItenderLog;
import com.itender.ms.domain.ItenderUser;
import eu.bitwalker.useragentutils.UserAgent;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * Aop工具类
 *
 * @author 邓洁芃
 * @create 2018-02-10 下午4:27
 **/
public class AopUtil {

    public static ItenderLog initInfo(HttpServletRequest request) {
        ItenderLog itenderLog = new ItenderLog();

        HttpSession session = request.getSession();
        ItenderUser user = (ItenderUser) session.getAttribute("user");
        if (user == null) {
            return null;
        }

        UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));

        itenderLog.setBrowserType(userAgent.getBrowser().getName());
        itenderLog.setIp(request.getRemoteAddr());
        itenderLog.setUser(user.getNickName());
        itenderLog.setLevel("1");
        itenderLog.setStartTime(new Date());

        return itenderLog;
    }
}
