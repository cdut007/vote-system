package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderTask;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderTaskMapper extends Mapper<ItenderTask> {
	
	public ItenderTask selectByTaskId(String taskId);
	
	public ItenderTask selectByTaskName(String taskName);
	
	public int updateTask(ItenderTask itenderTask);

	public int insertTask(ItenderTask itenderTask);

	public int deleteByTaskId(String taskId);


	public List<ItenderTask> selectByFilter(@Param(value = "keyword") String keyword);


}
