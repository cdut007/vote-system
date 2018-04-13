package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderReview;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderReviewMapper extends Mapper<ItenderReview> {
	
	public ItenderReview selectByReviewId(String reviewId);
	
	public ItenderReview selectByReviewName(String reviewName);
	
	public int updateReview(ItenderReview itenderReview);

	public int insertReview(ItenderReview itenderReview);

	public int deleteByReviewId(String reviewId);


	public List<ItenderReview> selectByFilter(@Param(value = "keyword") String keyword);


}
