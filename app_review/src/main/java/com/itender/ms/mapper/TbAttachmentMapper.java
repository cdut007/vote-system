package com.itender.ms.mapper;

import com.itender.ms.domain.TbAttachment;
import com.itender.ms.domain.TbAttachmentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TbAttachmentMapper {
    long countByExample(TbAttachmentExample example);

    int deleteByExample(TbAttachmentExample example);

    int deleteByPrimaryKey(String fjid00);

    int insert(TbAttachment record);

    int insertSelective(TbAttachment record);

    List<TbAttachment> selectByExample(TbAttachmentExample example);

    TbAttachment selectByPrimaryKey(String fjid00);

    int updateByExampleSelective(@Param("record") TbAttachment record, @Param("example") TbAttachmentExample example);

    int updateByExample(@Param("record") TbAttachment record, @Param("example") TbAttachmentExample example);

    int updateByPrimaryKeySelective(TbAttachment record);

    int updateByPrimaryKey(TbAttachment record);
}