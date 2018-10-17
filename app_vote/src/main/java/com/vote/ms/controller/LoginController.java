package com.vote.ms.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.vote.common.utils.R;
import com.vote.ms.entity.ActivityEntity;
import com.vote.ms.entity.CaptchaEntity;
import com.vote.ms.entity.UserEntity;
import com.vote.ms.form.LoginForm;
import com.vote.ms.oauth2.OAuth2Token;
import com.vote.ms.service.ActivityService;
import com.vote.ms.service.CaptchaService;
import com.vote.ms.service.UserService;
import com.vote.ms.service.UserTokenService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
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

    /**
     * 登录
     */
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody LoginForm form)throws IOException {
        boolean captcha = sysCaptchaService.validate(form.getUuid(), form.getCaptcha());
        if(!captcha){
            return R.error("验证码不正确");
        }

        //用户信息
        UserEntity user = sysUserService.queryByUserName(form.getUsername());

        //账号不存在、密码错误

        if(user == null) {
            return R.error("账号或密码不正确");
        }

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
     * 退出
     */
    @PostMapping("/logout")
    public R logout() {
        sysUserTokenService.logout(getUserId());
        return R.ok();
    }

}
