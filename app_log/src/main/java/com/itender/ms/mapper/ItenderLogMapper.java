package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderLog;

import com.itender.ms.exception.APIException;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.Date;
import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderLogMapper extends Mapper<ItenderLog> {



    public List<ItenderLog> selectByFilter(@Param(value="startTime") Date startTime, @Param(value="endTime") Date endTime, @Param(value="keyword")String keyword);


}
