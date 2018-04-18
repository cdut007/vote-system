package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.*;
import com.itender.ms.enums.ReviewRole;
import com.itender.ms.enums.ReviewStatus;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderAttachMapper;
import com.itender.ms.mapper.ItenderConfirmMapper;
import com.itender.ms.mapper.ItenderReviewMapper;
import com.itender.ms.mapper.ItenderTaskMapper;
import com.itender.ms.service.ItenderReviewService;
import com.itender.ms.util.CommonUtility;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 16:48
 */
@Service
public class ItenderReviewServiceImpl implements ItenderReviewService {
	private static final Logger logger = LoggerFactory.getLogger(ItenderReviewServiceImpl.class);

    @Autowired
    private ItenderReviewMapper itenderReviewMapper;

	@Autowired
	private ItenderAttachMapper itenderAttachMapper;


	@Autowired
	private ItenderConfirmMapper itenderConfirmMapper;


    @Autowired
    private ItenderTaskMapper itenderTaskMapper;






	public static void main(String[] args) throws APIException{
		ItenderReviewServiceImpl s = new ItenderReviewServiceImpl();
		String ss = "123";
		String dss = "iAWSYC2JKHXp8Mxue3ObBg==";
		//System.out.println(s.enPassword(ss));

	}


	@Override
	public Integer deleteById(String id) {
		ItenderReview itenderReview = new ItenderReview();
		itenderReview.setId(id);
		return itenderReviewMapper.delete(itenderReview);
	}

	@Override
	public ItenderReview findById(String id) {
		ItenderReview itenderReview = itenderReviewMapper.selectByPrimaryKey(id);
		findAttachsAndConfirms(itenderReview);
		checkTask(itenderReview);
		return itenderReview;
	}

	private void findAttachsAndConfirms(ItenderReview itenderReview){
		Example example = new Example(ItenderAttach.class);
		example.createCriteria().andEqualTo("reviewId",itenderReview.getId());
		itenderReview.setAttaches(itenderAttachMapper.selectByExample(example));
		Example example2 = new Example(ItenderConfirm.class);
		example2.createCriteria().andEqualTo("reviewId",itenderReview.getId());
		itenderReview.setConfirms(itenderConfirmMapper.selectByExample(example2));
	}

    private void checkTask(ItenderReview itenderReview){
        Example example = new Example(ItenderTask.class);
        example.createCriteria().andEqualTo("reviewId",itenderReview.getId()).andEqualTo("isCurrentTask","1");
        List<ItenderTask> tasks = itenderTaskMapper.selectByExample(example);
       if(tasks!=null && tasks.size() > 0){
           ItenderTask itenderTask = tasks.get(0);
           itenderReview.setRole(itenderTask.getRole());
           itenderReview.setStatus(itenderTask.getStatus());
       }

    }

	private  boolean  searchModel = false;

	private String searchKeyword;

	@Override
	public void setSearchInfo(String keyword) {
		if(keyword!=null){
			keyword = keyword.trim();
		}
		if(!StringUtils.isEmpty(keyword)){

			searchKeyword = keyword;
			searchModel = true;
		}

	}
	void resetSearch(){
		searchModel = false;

		searchKeyword = null;
	}

	@Override
	public ItenderReview findByReviewId(String reviewId) {
		 return itenderReviewMapper.selectByPrimaryKey(reviewId);
	}

	@Override
	public ItenderReview findByReviewName(String reviewName) throws APIException {
		return itenderReviewMapper.selectByReviewName(reviewName);
	}

	@Override
	public ItenderReview updateReview(ItenderReview review) throws APIException {
		if(review == null){
			return null;
		}

		int rows = itenderReviewMapper.updateReview(review);
		return rows == 0?null:review;
	}

	@Override
	public ItenderReview updateReviewStatus(String id,String assigneeId,String role,String status) throws APIException {
		Example example = new Example(ItenderTask.class);
		example.createCriteria().andEqualTo("reviewId",id).andEqualTo("isCurrentTask","1");
		List<ItenderTask> itenderTasks = itenderTaskMapper.selectByExample(example);
		//reset
		if(itenderTasks!=null&& !itenderTasks.isEmpty()){
			ItenderTask itenderTask = itenderTasks.get(0);
			if(itenderTask.getUserId()!=null && itenderTask.getUserId().equals(assigneeId)){
				logger.info("the task exsit.");
				return null;
			}
			itenderTask.setCurrentTask(false);
			itenderTask.setStatus(status);
			itenderTaskMapper.updateByPrimaryKeySelective(itenderTask);

		}
		if(ReviewStatus.approved.name().equals(status)){
			ItenderTask itenderTask = new ItenderTask();
			itenderTask.setRole(role);
			itenderTask.setStatus(ReviewStatus.verify.name());
			itenderTask.setCreateTime(new Date());
			itenderTask.setReviewId(id);
			itenderTask.setUserId(assigneeId);
			itenderTask.setCurrentTask(true);
			itenderTaskMapper.insertSelective(itenderTask);
			ItenderReview itenderReview = new ItenderReview();
			itenderReview.setId(id);
			itenderReview.setAssigneeId(assigneeId);
			itenderReviewMapper.updateByPrimaryKeySelective(itenderReview);

		}else if(ReviewStatus.forbidden.name().equals(status)){
			ItenderTask itenderTask = new ItenderTask();
		}

		ItenderReview reviewExsit = findById(id);

		return reviewExsit;
	}

	@Override
	public ItenderReview updateSignStatus(ItenderReview review) throws APIException {
		return null;
	}


	@Override
	public ItenderReview add(ItenderReview review) throws APIException {
		//review.setCreateTime(new Date(System.currentTimeMillis()));
		int rows = itenderReviewMapper.insertSelective(review);
		if(review.getAttaches()!=null){
			List<ItenderAttach> attaches = review.getAttaches();
			for (int i = 0; i < attaches.size(); i++) {
				ItenderAttach attach = attaches.get(i);
				attach.setReviewId(review.getId());
				itenderAttachMapper.insertSelective(attach);
			}

		}
        ItenderTask itenderTask = new ItenderTask();
        itenderTask.setRole(ReviewRole.operator.name());
        itenderTask.setStatus(ReviewStatus.verify.name());
        itenderTask.setCreateTime(review.getCreateTime());
        itenderTask.setReviewId(review.getId());
        itenderTask.setCurrentTask(true);
        itenderTaskMapper.insertSelective(itenderTask);

		if(review.getConfirms()!=null){

			List<ItenderConfirm> confirms = review.getConfirms();
				for (int i = 0; i < confirms.size(); i++) {
					ItenderConfirm confirm = confirms.get(i);
					confirm.setReviewId(review.getId());
					itenderConfirmMapper.insertSelective(confirm);
				}


		}


		return rows == 0?null:review;
	}

	@Override
	public List<ItenderReview> findAll() throws APIException {
		return itenderReviewMapper.selectAll();
	}

	ItenderUser user;
	@Override
	public void setCurrentUser(ItenderUser currentUser) {
		user  = currentUser;
	}

	@Override
	public PageInfo<ItenderReview> findPage(Integer pageNum, Integer pagesize) throws APIException {
		PageHelper.startPage(pageNum,pagesize);

        Example example = new Example(ItenderReview.class);
		List<ItenderReview> itenderReview = null;
		if(searchModel){
			logger.debug("==searchModel=");
			logger.debug("==searchKeyword="+searchKeyword);
			if(StringUtils.isEmpty(searchKeyword)){
				searchKeyword = null;
			}

			itenderReview = itenderReviewMapper.selectByFilter(searchKeyword);
			//reset
			resetSearch();
		}else {
			if(user!=null){

					if(!ReviewRole.operator.name().equals(user.getOperator())){

					 example.createCriteria().andEqualTo("assigneeId",user.getId());
				   }else{

						example.createCriteria().andEqualTo("assigneeId","Assignee");
					}

				user = null;
			}

			example.setOrderByClause("create_time desc");
			 itenderReview = itenderReviewMapper.selectByExample(example);
		}
        return new PageInfo<>(itenderReview);
	}


	//private ItenderReview


}
