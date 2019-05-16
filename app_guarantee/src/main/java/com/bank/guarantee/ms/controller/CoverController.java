package com.bank.guarantee.ms.controller;

import java.util.Arrays;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bank.guarantee.ms.entity.CoverEntity;
import com.bank.guarantee.ms.service.CoverService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.R;



/**
 * 封面列表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
@RestController
@RequestMapping("ms/cover")
public class CoverController {
    @Autowired
    private CoverService coverService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("ms:cover:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = coverService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("ms:cover:info")
    public R info(@PathVariable("id") String id){
			CoverEntity cover = coverService.selectById(id);

        return R.ok().put("cover", cover);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("ms:cover:save")
    public R save(@RequestBody CoverEntity cover){
			coverService.insert(cover);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("ms:cover:update")
    public R update(@RequestBody CoverEntity cover){
			coverService.updateById(cover);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("ms:cover:delete")
    public R delete(@RequestBody String[] ids){
			coverService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
