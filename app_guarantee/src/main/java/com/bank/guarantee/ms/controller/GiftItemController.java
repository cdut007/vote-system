package com.bank.guarantee.ms.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.bank.guarantee.ms.entity.ParticipantEntity;
import com.bank.guarantee.ms.service.ParticipantService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bank.guarantee.ms.entity.GiftItemEntity;
import com.bank.guarantee.ms.service.GiftItemService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.R;



/**
 * 投票票数列表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-23 16:16:51
 */
@RestController
@RequestMapping("giftitem")
public class GiftItemController {
    @Autowired
    private GiftItemService giftItemService;

    /**
     * 列表
     */
    @RequestMapping("/list")
  //  @RequiresPermissions("ms:giftitem:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = giftItemService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("ms:giftitem:info")
    public R info(@PathVariable("id") String id){
			GiftItemEntity giftItem = giftItemService.selectById(id);

        return R.ok().put("giftItem", giftItem);
    }

    @Autowired
    private ParticipantService participantService;
    /**
     * 保存
     */
    @RequestMapping("/save")
  //  @RequiresPermissions("ms:giftitem:save")
    public R save(@RequestBody GiftItemEntity giftItem){
            giftItem.setCreateTime(new Date());
			giftItemService.insert(giftItem);
        ParticipantEntity participantEntity = participantService.selectOne(new EntityWrapper<ParticipantEntity>().eq("id",giftItem.getPlayerId()));
        participantEntity.setGiftCount(participantEntity.getGiftCount()+1);
        participantEntity.setVoteCount(participantEntity.getVoteCount()+giftItem.getVoteCount());
        participantService.updateById(participantEntity);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("ms:giftitem:update")
    public R update(@RequestBody GiftItemEntity giftItem){
			giftItemService.updateById(giftItem);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("ms:giftitem:delete")
    public R delete(@RequestBody String[] ids){
			giftItemService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
