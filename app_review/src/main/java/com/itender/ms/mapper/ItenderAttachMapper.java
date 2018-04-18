package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderAttach;
import com.itender.ms.domain.ItenderReview;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderAttachMapper extends Mapper<ItenderAttach> {
	
	public ItenderAttach selectByAttachId(String attachId);
	
	public ItenderAttach selectByAttachName(String attachName);
	
	public int updateAttach(ItenderAttach itenderAttach);

	public int insertAttach(ItenderAttach itenderAttach);

	public int deleteByAttachId(String attachId);


	public List<ItenderAttach> selectByFilter(@Param(value = "keyword") String keyword);


}
