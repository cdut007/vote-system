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

import com.bank.guarantee.ms.entity.ItenderApplyEntity;
import com.bank.guarantee.ms.service.ItenderApplyService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.R;



/**
 * 
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2019-05-16 13:29:05
 */
@RestController
@RequestMapping("ms/itenderapply")
public class ItenderApplyController {
    @Autowired
    private ItenderApplyService itenderApplyService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = itenderApplyService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") String id){
			ItenderApplyEntity itenderApply = itenderApplyService.selectById(id);

        return R.ok().put("itenderApply", itenderApply);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ItenderApplyEntity itenderApply){
			itenderApplyService.insert(itenderApply);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody ItenderApplyEntity itenderApply){
			itenderApplyService.updateById(itenderApply);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody String[] ids){
			itenderApplyService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
