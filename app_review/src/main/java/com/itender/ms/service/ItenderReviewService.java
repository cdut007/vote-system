package com.itender.ms.service;

import com.itender.ms.domain.ItenderReview;
import com.itender.ms.exception.APIException;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderReviewService extends ItenderServiceBase<ItenderReview> {

	public void setSearchInfo(String keyword);


	public ItenderReview findByReviewId(String reviewId);
	/**
	 * 按审批名查询
	 * @param reviewName
	 * @return
	 */
	public ItenderReview findByReviewName(String reviewName) throws APIException;
	
	/**
	 * 更新审批信息
	 * @param review
	 * @return
	 */
	public ItenderReview updateReview(ItenderReview review) throws APIException;




}
