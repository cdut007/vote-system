package com.bank.guarantee.ms.service;

import com.baomidou.mybatisplus.service.IService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.ms.entity.AttachEntity;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

/**
 * 附件表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2019-05-16 13:29:05
 */
public interface AttachService extends IService<AttachEntity> {

    PageUtils queryPage(Map<String, Object> params);

    public AttachEntity parse2Attachment(String originalFilename, InputStream inputStream);

    /**根据附件组id查询附件列表
     * @param attachGroupId
     * @return
     */
    public List<AttachEntity> findAttachByGroupId(String attachGroupId);
}

