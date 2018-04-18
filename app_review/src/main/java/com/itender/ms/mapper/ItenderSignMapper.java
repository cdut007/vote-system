package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderConfirm;
import com.itender.ms.domain.ItenderSign;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderSignMapper extends Mapper<ItenderSign> {
	
	public ItenderSign selectBySignId(String signId);
	
	public ItenderSign selectBySignName(String signName);
	
	public int updateSign(ItenderConfirm itenderSign);

	public int insertSign(ItenderConfirm itenderSign);

	public int deleteBySignId(String signId);


	public List<ItenderSign> selectByFilter(@Param(value = "keyword") String keyword);


}
