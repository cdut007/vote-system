package com.vote.ms.controller;

import java.util.Arrays;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.vote.ms.entity.GiftInfoEntity;
import com.vote.ms.service.GiftInfoService;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.R;



/**
 * 
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-23 16:16:51
 */
@RestController
@RequestMapping("giftinfo")
public class GiftInfoController {
    @Autowired
    private GiftInfoService giftInfoService;

    /**
     * 列表
     */
    @RequestMapping("/list")
   // @RequiresPermissions("ms:giftinfo:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = giftInfoService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("ms:giftinfo:info")
    public R info(@PathVariable("id") String id){
			GiftInfoEntity giftInfo = giftInfoService.selectById(id);

        return R.ok().put("giftInfo", giftInfo);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("ms:giftinfo:save")
    public R save(@RequestBody GiftInfoEntity giftInfo){
			giftInfoService.insert(giftInfo);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("ms:giftinfo:update")
    public R update(@RequestBody GiftInfoEntity giftInfo){
			giftInfoService.updateById(giftInfo);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("ms:giftinfo:delete")
    public R delete(@RequestBody String[] ids){
			giftInfoService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
