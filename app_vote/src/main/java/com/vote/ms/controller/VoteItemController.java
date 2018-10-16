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

import com.vote.ms.entity.VoteItemEntity;
import com.vote.ms.service.VoteItemService;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.R;



/**
 * 投票票数列表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
@RestController
@RequestMapping("ms/voteitem")
public class VoteItemController {
    @Autowired
    private VoteItemService voteItemService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("ms:voteitem:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = voteItemService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("ms:voteitem:info")
    public R info(@PathVariable("id") String id){
			VoteItemEntity voteItem = voteItemService.selectById(id);

        return R.ok().put("voteItem", voteItem);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("ms:voteitem:save")
    public R save(@RequestBody VoteItemEntity voteItem){
			voteItemService.insert(voteItem);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("ms:voteitem:update")
    public R update(@RequestBody VoteItemEntity voteItem){
			voteItemService.updateById(voteItem);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("ms:voteitem:delete")
    public R delete(@RequestBody String[] ids){
			voteItemService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
