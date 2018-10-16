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

import com.vote.ms.entity.ParticipantEntity;
import com.vote.ms.service.ParticipantService;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.R;



/**
 * 选手列表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
@RestController
@RequestMapping("participant")
public class ParticipantController {
    @Autowired
    private ParticipantService participantService;

    /**
     * 列表
     */
    @RequestMapping("/list")
   // @RequiresPermissions("ms:participant:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = participantService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
  //  @RequiresPermissions("ms:participant:info")
    public R info(@PathVariable("id") String id){
			ParticipantEntity participant = participantService.selectById(id);

        return R.ok().put("participant", participant);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
 //   @RequiresPermissions("ms:participant:save")
    public R save(@RequestBody ParticipantEntity participant){
			participantService.insert(participant);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
 //   @RequiresPermissions("ms:participant:update")
    public R update(@RequestBody ParticipantEntity participant){
			participantService.updateById(participant);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
 //   @RequiresPermissions("ms:participant:delete")
    public R delete(@RequestBody String[] ids){
			participantService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
