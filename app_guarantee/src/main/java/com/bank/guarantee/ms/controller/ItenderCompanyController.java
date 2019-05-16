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

import com.bank.guarantee.ms.entity.ItenderCompanyEntity;
import com.bank.guarantee.ms.service.ItenderCompanyService;
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
@RequestMapping("ms/itendercompany")
public class ItenderCompanyController {
    @Autowired
    private ItenderCompanyService itenderCompanyService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = itenderCompanyService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") String id){
			ItenderCompanyEntity itenderCompany = itenderCompanyService.selectById(id);

        return R.ok().put("itenderCompany", itenderCompany);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ItenderCompanyEntity itenderCompany){
			itenderCompanyService.insert(itenderCompany);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody ItenderCompanyEntity itenderCompany){
			itenderCompanyService.updateById(itenderCompany);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody String[] ids){
			itenderCompanyService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
