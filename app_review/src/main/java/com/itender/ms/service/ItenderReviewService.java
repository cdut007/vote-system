package com.itender.ms.service;

import com.itender.ms.domain.*;
import com.itender.ms.exception.APIException;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderReviewService extends ItenderServiceBase<ItenderReview> {

	public void setSearchInfo(String keyword,String type);

	public void setCurrentUser(ItenderUser currentUser);


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

	public List<ItenderSign> findSignsByConfirmId(String confirmId) throws APIException;

	public List<ItenderTask> findTasksByReviewId(String reviewId) throws APIException;


	public List<ItenderConfirm> findConfirmsByReviewId(String reviewId) throws APIException;

	public ItenderAttach  findAttachByReferenceAttachId(String referenceAttachId) throws APIException;

	public ItenderAttach  findAttachByAttachId(String attachId) throws APIException;
	public ItenderConfirm findConfirmByConfirmId(String confimId) throws APIException;

	public  boolean postToResult(String reviewId) throws  APIException;

	public ItenderConfirm  updateConfrirm(ItenderConfirm confirm) throws APIException;

	public int rollbackReviewStatus(String id,String userId) throws APIException;
	public ItenderReview updateReviewStatus(String id,String assigneeId,String role,String status,String remark) throws APIException;




	public ItenderSign updateSignFileResult(String confirmId,String signId,String signResult,String description) throws APIException;



	public ItenderSign updateSignResult(String confirmId,String signId,String signResult,String description) throws APIException;





}
