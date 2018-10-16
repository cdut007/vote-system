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

import com.vote.ms.entity.VoterEntity;
import com.vote.ms.service.VoterService;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.R;



/**
 * 投票人列表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
@RestController
@RequestMapping("ms/voter")
public class VoterController {
    @Autowired
    private VoterService voterService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("ms:voter:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = voterService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("ms:voter:info")
    public R info(@PathVariable("id") String id){
			VoterEntity voter = voterService.selectById(id);

        return R.ok().put("voter", voter);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("ms:voter:save")
    public R save(@RequestBody VoterEntity voter){
			voterService.insert(voter);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("ms:voter:update")
    public R update(@RequestBody VoterEntity voter){
			voterService.updateById(voter);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("ms:voter:delete")
    public R delete(@RequestBody String[] ids){
			voterService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
