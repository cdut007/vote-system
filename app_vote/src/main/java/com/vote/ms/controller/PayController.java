package com.vote.ms.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.github.wxpay.sdk.WXPay;
import com.vote.common.utils.R;
import com.vote.ms.entity.ActivityEntity;
import com.vote.ms.entity.UserEntity;
import com.vote.ms.form.LoginForm;
import com.vote.ms.oauth2.OAuth2Token;
import com.vote.ms.service.ActivityService;
import com.vote.ms.service.CaptchaService;
import com.vote.ms.service.UserService;
import com.vote.ms.service.UserTokenService;
import com.vote.wxpay.sdk.MyConfig;
import org.apache.shiro.SecurityUtils;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 支付相关
 *
 * @author james
 */

@RestController
@RequestMapping("pay")
public class PayController extends AbstractController{


    /**
     * 创建订单
     */
    @PostMapping("/createOrder")
    public R  createOrder(@RequestBody LoginForm form)throws Exception {
        MyConfig config = new MyConfig();
        WXPay wxpay = new WXPay(config);

        Map<String, String> data = new HashMap<String, String>();
        data.put("body", "腾讯充值中心-QQ会员充值");
        data.put("out_trade_no", "2016090910595900000012");
        data.put("device_info", "");
        data.put("fee_type", "CNY");
        data.put("total_fee", "1");
        data.put("spbill_create_ip", "123.12.12.123");
        data.put("notify_url", "http://www.example.com/wxpay/notify");
        data.put("trade_type", "NATIVE");  // 此处指定为扫码支付
        data.put("product_id", "12");

        try {
            Map<String, String> resp = wxpay.unifiedOrder(data);
            System.out.println(resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return R.ok();
    }


    public static void main(String[] args) throws Exception {

        MyConfig config = new MyConfig();
        WXPay wxpay = new WXPay(config);

        Map<String, String> data = new HashMap<String, String>();
        data.put("body", "测试-QQ会员充值");
        data.put("out_trade_no", "2016090910595900000013");
        data.put("device_info", "");
        data.put("fee_type", "CNY");
        data.put("total_fee", "1");
        data.put("spbill_create_ip", "123.12.12.123");
        data.put("notify_url", "http://www.example.com/wxpay/notify");
        data.put("trade_type", "NATIVE");  // 此处指定为扫码支付
        data.put("product_id", "12");

        try {
            Map<String, String> resp = wxpay.unifiedOrder(data);
            System.out.println(resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }




}
