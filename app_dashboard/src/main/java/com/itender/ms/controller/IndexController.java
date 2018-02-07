package com.itender.ms.controller;

import com.itender.ms.util.ViewUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;

/**
 * 系统入库
 *
 * @author 邓洁芃
 * @create 2017-12-26 下午5:09
 **/
@Controller
@ApiIgnore
public class IndexController {


    @RequestMapping(value = "")
    public String loginView(){
        return ViewUtil.forward("login");
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(HttpServletRequest req){

        return ViewUtil.redirect("/dashboard");
    }
}
