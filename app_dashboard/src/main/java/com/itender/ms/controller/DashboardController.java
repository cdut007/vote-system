package com.itender.ms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import springfox.documentation.annotations.ApiIgnore;

/**
 * 控制台controller
 *
 * @author 邓洁芃
 * @create 2017-12-26 下午4:33
 **/
@Controller
@RequestMapping(value = "/dashboard")
@ApiIgnore
public class DashboardController {

    @RequestMapping(value = "")
    public String dashboardView() {
        return "dashboard";
    }
}
