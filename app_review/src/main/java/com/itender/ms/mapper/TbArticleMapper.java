package com.itender.ms.mapper;

import com.itender.ms.domain.TbArticle;

import java.util.List;

import com.itender.ms.domain.TbArticleExample;
import org.apache.ibatis.annotations.Param;

public interface TbArticleMapper {
    long countByExample(TbArticleExample example);

    int deleteByExample(TbArticleExample example);

    int deleteByPrimaryKey(String id);

    int insert(TbArticle record);

    int insertSelective(TbArticle record);

    List<TbArticle> selectByExampleWithBLOBs(TbArticleExample example);

    List<TbArticle> selectByExample(TbArticleExample example);

    TbArticle selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") TbArticle record, @Param("example") TbArticleExample example);

    int updateByExampleWithBLOBs(@Param("record") TbArticle record, @Param("example") TbArticleExample example);

    int updateByExample(@Param("record") TbArticle record, @Param("example") TbArticleExample example);

    int updateByPrimaryKeySelective(TbArticle record);

    int updateByPrimaryKeyWithBLOBs(TbArticle record);

    int updateByPrimaryKey(TbArticle record);
}