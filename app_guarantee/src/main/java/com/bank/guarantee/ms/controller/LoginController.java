package com.bank.guarantee.ms.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.github.qcloudsms.SmsSingleSender;
import com.github.qcloudsms.SmsSingleSenderResult;
import com.github.qcloudsms.httpclient.HTTPException;
import com.bank.guarantee.common.utils.IPUtils;
import com.bank.guarantee.common.utils.R;
import com.bank.guarantee.ms.entity.ActivityEntity;
import com.bank.guarantee.ms.entity.CaptchaEntity;
import com.bank.guarantee.ms.entity.UserEntity;
import com.bank.guarantee.ms.form.LoginForm;
import com.bank.guarantee.ms.oauth2.OAuth2Token;
import com.bank.guarantee.ms.service.ActivityService;
import com.bank.guarantee.ms.service.CaptchaService;
import com.bank.guarantee.ms.service.UserService;
import com.bank.guarantee.ms.service.UserTokenService;
import com.bank.guarantee.ms.util.Md5Util;
import com.bank.guarantee.ms.utils.DateUtils;
import com.bank.guarantee.ms.utils.RandomCodeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

/**
 * 登录相关
 *
 * @author james
 */
@RestController
public class LoginController extends AbstractController{
    @Autowired
    private UserService sysUserService;
    @Autowired
    private UserTokenService sysUserTokenService;
    @Autowired
    private CaptchaService sysCaptchaService;

    /**
     * 验证码
     */
    @GetMapping("/captcha.jpg")
    public void captcha(HttpServletResponse response, String uuid)throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-store, no-cache");
        response.setContentType("image/jpeg");

        //获取图片验证码
        BufferedImage image = sysCaptchaService.getCaptcha(uuid);

        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(image, "jpg", out);
        IOUtils.closeQuietly(out);
    }


    @Autowired
    private ActivityService activityService;
    @GetMapping("{urlKey}")
    public R info(@PathVariable("urlKey") String key){
        ActivityEntity activity = activityService.selectOne(new EntityWrapper<ActivityEntity>().eq("short_url_key", key));
        if(activity==null){
            return R.error(-1001,"不存在该活动");
        }else{
            return R.ok().put("activity", activity);
        }


    }

    private static final String SMS_MD5_KEY = "abc123"; // KEY为自定义秘钥
    /**
     * 获取短信验证码
     */
    @PostMapping("/smsCode")
    public Map<String, Object> smsCode(@RequestBody LoginForm form)throws IOException {


        /**
         * Java 使用
         */
        String PHONE_NUMBER_REG = "^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
        if(!form.getMobile().matches(PHONE_NUMBER_REG)){
            return R.error("手机号格式不正确");
        }

        boolean captcha = sysCaptchaService.validate(form.getUuid(), form.getCaptcha());
        if(!captcha){
            return R.error("验证码不正确");
        }

        //用户信息
        UserEntity user = sysUserService.queryByUserMobile(form.getMobile());

        //账号不存在、密码错误

        if(user != null) {
            return R.error("该账户已存在");
        }


       // 短信应用SDK AppID
        int appid = 1400153884; // 1400开头

      // 短信应用SDK AppKey
        String appkey = "c9272cd0da0a8d40e58448190761b6f9";
        try {
            String randomNum = RandomCodeUtils.createRandomNum(4);// 生成随机数
            SmsSingleSender ssender = new SmsSingleSender(appid, appkey);
            SmsSingleSenderResult result = ssender.send(0, "86",form.getMobile(),
                    "您的短信验证码是"+randomNum, "", "");
            System.out.println(result);
            String hash =  Md5Util.getMD5Hex(SMS_MD5_KEY  + "@" + randomNum);//生成MD5值
            if( result.result==0){
                return R.ok().put("uuid",hash);
            }else{
                return R.error(result.result+"短信服务不可用:"+result.errMsg).put("uuid",hash);
            }
        } catch (HTTPException e) {
            // HTTP响应码错误
            e.printStackTrace();
        } catch (JSONException e) {
            // json解析错误
            e.printStackTrace();
        } catch (IOException e) {
            // 网络IO错误
            e.printStackTrace();
        }
        return R.error("短信服务不可用");
    }


    /**
     * 注册
     */
    @PostMapping("/register")
    public Map<String, Object> register(@RequestBody LoginForm form)throws IOException {

        String hash =  Md5Util.getMD5Hex(SMS_MD5_KEY  + "@" + form.getSmsCode());//生成MD5值

//        boolean captcha = sysCaptchaService.validate(form.getUuid(), form.getCaptcha());
//        if(!captcha){
//            return R.error("图片验证码不正确");
//        }

        if (!hash.equalsIgnoreCase(form.getUuid())) {
            //校验成功
            return R.error("短信验证码不正确");
        }

        //用户信息
        UserEntity user = sysUserService.queryByUserMobile(form.getMobile());

        //账号不存在、密码错误

        if(user != null) {
            return R.error("该账户已存在");
        }
        user = new UserEntity();
        user.setCreateTime(new Date());
        user.setMobile(form.getMobile());
        if(StringUtils.isEmpty(form.getUsername())){
            user.setName(form.getMobile());
        }else{
            user.setName(form.getUsername());
        }

        user.setPassword(Md5Util.getMD5Base64(form.getPassword()));
        sysUserService.insert(user);


//        if(user == null || !user.getPassword().equals(new Sha256Hash(form.getPassword(), user.getSalt()).toHex())) {
//            return R.error("账号或密码不正确");
//        }

        //账号锁定
//        if(user.getStatus() == 0){
//            return R.error("账号已被锁定,请联系管理员");
//        }



        //生成token，并保存到数据库
        R r = sysUserTokenService.createToken(user.getId());

        OAuth2Token token = new OAuth2Token(r.get("token").toString());
        SecurityUtils.getSubject().login(token);
        return r;
    }


    /**
     * 登录
     */
    @PostMapping("/login")
    public Map<String, Object> login(HttpServletRequest request,@RequestBody LoginForm form)throws IOException {
        boolean captcha = sysCaptchaService.validate(form.getUuid(), form.getCaptcha());
        if(!captcha){
            return R.error("验证码不正确");
        }

        //用户信息
        UserEntity user = sysUserService.queryByUserMobile(form.getUsername());

        //账号不存在、密码错误

        if(user == null) {
            user = sysUserService.queryByUserName(form.getUsername());

        }

        if(user == null || !user.getPassword().equals(Md5Util.getMD5Base64(form.getPassword()))) {
            return R.error("账号或密码不正确");
        }
        user.setLastLoginIp(IPUtils.getIpAddr(request));
        user.setLastLoginTime(DateUtils.format(new Date()));
        sysUserService.updateById(user);

        //账号锁定
//        if(user.getStatus() == 0){
//            return R.error("账号已被锁定,请联系管理员");
//        }



        //生成token，并保存到数据库
        R r = sysUserTokenService.createToken(user.getId());

        OAuth2Token token = new OAuth2Token(r.get("token").toString());
        SecurityUtils.getSubject().login(token);
        return r;
    }


    /**
     * 退出
     */
    @PostMapping("/logout")
    public R logout() {
        try{
            sysUserTokenService.logout(getUserId());
        }catch (Exception e){
            e.printStackTrace();
        }
        return R.ok();
    }

}
