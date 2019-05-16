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

import com.bank.guarantee.ms.entity.ItenderOrderEntity;
import com.bank.guarantee.ms.service.ItenderOrderService;
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
@RequestMapping("ms/itenderorder")
public class ItenderOrderController {
    @Autowired
    private ItenderOrderService itenderOrderService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = itenderOrderService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") String id){
			ItenderOrderEntity itenderOrder = itenderOrderService.selectById(id);

        return R.ok().put("itenderOrder", itenderOrder);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ItenderOrderEntity itenderOrder){
			itenderOrderService.insert(itenderOrder);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody ItenderOrderEntity itenderOrder){
			itenderOrderService.updateById(itenderOrder);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody String[] ids){
			itenderOrderService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
