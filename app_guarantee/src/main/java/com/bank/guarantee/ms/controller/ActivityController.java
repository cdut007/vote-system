package com.bank.guarantee.ms.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.Map;

import com.bank.guarantee.common.utils.IPUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.bank.guarantee.ms.entity.ActivityEntity;
import com.bank.guarantee.ms.service.ActivityService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.R;



/**
 * 投票活动列表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
@RestController
@RequestMapping("activity")
public class ActivityController extends  AbstractController{
    @Autowired
    private ActivityService activityService;

    /**
     * 列表
     */
    @RequestMapping("/list")
   // @RequiresPermissions("ms:activity:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = activityService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
  //  @RequiresPermissions("ms:activity:info")
    public R info(@PathVariable("id") String id){
			ActivityEntity activity = activityService.selectById(id);

        return R.ok().put("activity", activity);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
   // @RequiresPermissions("ms:activity:save")
    public R save(@RequestBody ActivityEntity activity){
           activity.setCreaterId(getUserId());
           activity.setCreateTime(new Date());
		boolean save =	activityService.insert(activity);

        return R.ok().put("success",save);
    }

    @PostMapping("/share/{id}")
    public R share(@PathVariable("id") String id){
        ActivityEntity activity = activityService.selectById(id);
        if(StringUtils.isEmpty(activity.getShortUrlKey())){
            activity.setShortUrlKey(IPUtils.getShortUrl(id));
            activityService.updateById(activity);
        }

        return R.ok().put("activity", activity);
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
   // @RequiresPermissions("ms:activity:update")
    public R update(@RequestBody ActivityEntity activity){
			activityService.updateById(activity);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
  //  @RequiresPermissions("ms:activity:delete")
    public R delete(@RequestBody String[] ids){
			activityService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
