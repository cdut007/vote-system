package com.bank.guarantee.ms.controller;

import java.util.Arrays;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.bank.guarantee.ms.entity.UserEntity;
import com.bank.guarantee.ms.service.UserService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.R;



/**
 * 用户表
 *
 * @author 陈泳君
 * @email 316458704@qq.com
 * @date 2018-10-15 10:06:52
 */
@RestController
@RequestMapping("sys/user")
public class UserController extends AbstractController{
    @Autowired
    private UserService userService;

    /**
     * 列表
     */
    @RequestMapping("/list")
   // @RequiresPermissions("ms:user:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = userService.queryPage(params);

        return R.ok().put("page", page);
    }

    /**
     * 获取登录的用户信息
     */
    @GetMapping("/info")
    public R info(){
        return R.ok().put("user", getUser());
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
   // @RequiresPermissions("ms:user:info")
    public R info(@PathVariable("id") String id){
			UserEntity user = userService.selectById(id);

        return R.ok().put("user", user);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
   // @RequiresPermissions("ms:user:save")
    public R save(@RequestBody UserEntity user){
			userService.insert(user);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
   // @RequiresPermissions("ms:user:update")
    public R update(@RequestBody UserEntity user){
			userService.updateById(user);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("ms:user:delete")
    public R delete(@RequestBody String[] ids){
			userService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
