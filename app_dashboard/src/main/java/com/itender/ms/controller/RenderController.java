package com.itender.ms.controller;

import com.itender.ms.util.ViewUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import springfox.documentation.annotations.ApiIgnore;

/**
 * 渲染控制器
 *
 * @author 邓洁芃
 * @create 2018-01-03 下午2:19
 **/
@Controller
@RequestMapping("/render")
@ApiIgnore
public class RenderController {

    @RequestMapping(value = "",method = RequestMethod.GET)
    public String parse(){
        return ViewUtil.forward("/render/render_tmp");
    }
}
