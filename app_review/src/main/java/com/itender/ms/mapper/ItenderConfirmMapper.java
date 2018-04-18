package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderAttach;
import com.itender.ms.domain.ItenderConfirm;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderConfirmMapper extends Mapper<ItenderConfirm> {
	
	public ItenderConfirm selectByConfirmId(String confirmId);
	
	public ItenderConfirm selectByConfirmName(String confirmName);
	
	public int updateConfirm(ItenderConfirm itenderConfirm);

	public int insertConfirm(ItenderConfirm itenderConfirm);

	public int deleteByConfirmId(String confirmId);


	public List<ItenderConfirm> selectByFilter(@Param(value = "keyword") String keyword);


}
