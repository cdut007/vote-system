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

import com.bank.guarantee.ms.entity.ItenderMessageEntity;
import com.bank.guarantee.ms.service.ItenderMessageService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.R;



/**
 * 
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2019-05-16 13:29:04
 */
@RestController
@RequestMapping("ms/itendermessage")
public class ItenderMessageController {
    @Autowired
    private ItenderMessageService itenderMessageService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = itenderMessageService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") String id){
			ItenderMessageEntity itenderMessage = itenderMessageService.selectById(id);

        return R.ok().put("itenderMessage", itenderMessage);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ItenderMessageEntity itenderMessage){
			itenderMessageService.insert(itenderMessage);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody ItenderMessageEntity itenderMessage){
			itenderMessageService.updateById(itenderMessage);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody String[] ids){
			itenderMessageService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
