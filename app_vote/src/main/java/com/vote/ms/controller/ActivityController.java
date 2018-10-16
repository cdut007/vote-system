package com.vote.ms.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.vote.ms.entity.ActivityEntity;
import com.vote.ms.service.ActivityService;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.R;



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
