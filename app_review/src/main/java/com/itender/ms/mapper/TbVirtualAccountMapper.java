package com.itender.ms.mapper;

import java.util.List;

import com.itender.ms.domain.TbVirtualAccount;
import com.itender.ms.domain.TbVirtualAccountExample;
import org.apache.ibatis.annotations.Param;

public interface TbVirtualAccountMapper {
    long countByExample(TbVirtualAccountExample example);

    int deleteByExample(TbVirtualAccountExample example);

    int deleteByPrimaryKey(String accountNumber);

    int insert(TbVirtualAccount record);

    int insertSelective(TbVirtualAccount record);

    List<TbVirtualAccount> selectByExample(TbVirtualAccountExample example);

    TbVirtualAccount selectByPrimaryKey(String accountNumber);

    int updateByExampleSelective(@Param("record") TbVirtualAccount record, @Param("example") TbVirtualAccountExample example);

    int updateByExample(@Param("record") TbVirtualAccount record, @Param("example") TbVirtualAccountExample example);

    int updateByPrimaryKeySelective(TbVirtualAccount record);

    int updateByPrimaryKey(TbVirtualAccount record);
}