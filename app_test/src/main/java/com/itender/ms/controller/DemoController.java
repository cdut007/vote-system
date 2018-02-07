package com.itender.ms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DemoController {

    @RequestMapping(value = "/autowidth")
    public String autoWidth(){
        return "/demo/auto_width";
    }

    @RequestMapping(value = "/meta/demo")
    public String ueditor(){
        return "/demo/meta_template_demo";
    }
}
