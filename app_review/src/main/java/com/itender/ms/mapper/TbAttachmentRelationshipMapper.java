package com.itender.ms.mapper;

import com.itender.ms.domain.TbAttachmentRelationshipExample;
import com.itender.ms.domain.TbAttachmentRelationshipKey;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TbAttachmentRelationshipMapper {
    long countByExample(TbAttachmentRelationshipExample example);

    int deleteByExample(TbAttachmentRelationshipExample example);

    int deleteByPrimaryKey(TbAttachmentRelationshipKey key);

    int insert(TbAttachmentRelationshipKey record);

    int insertSelective(TbAttachmentRelationshipKey record);

    List<TbAttachmentRelationshipKey> selectByExample(TbAttachmentRelationshipExample example);

    int updateByExampleSelective(@Param("record") TbAttachmentRelationshipKey record, @Param("example") TbAttachmentRelationshipExample example);

    int updateByExample(@Param("record") TbAttachmentRelationshipKey record, @Param("example") TbAttachmentRelationshipExample example);
}