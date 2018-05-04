package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.config.HttpConfig;
import com.itender.ms.domain.*;
import com.itender.ms.enums.ReviewRole;
import com.itender.ms.enums.ReviewStatus;
import com.itender.ms.enums.SignResult;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.*;
import com.itender.ms.service.HttpClientService;
import com.itender.ms.service.ItenderReviewService;
import com.itender.ms.util.CommonUtility;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
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

	@Autowired
	private ItenderSignMapper itenderSignMapper;

    @Autowired
    private HttpConfig httpConfig;
    @Autowired
    HttpClientService httpClient;






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

    @Override
    public List<ItenderConfirm> findConfirmsByReviewId(String reviewId) throws APIException {
        ItenderReview itenderReview = findById(reviewId);
        if(itenderReview!=null){
            return  itenderReview.getConfirms();
        }
        return null;
    }

	@Override
	public ItenderAttach findAttachByReferenceAttachId(String referenceAttachId) {
		if(StringUtils.isEmpty(referenceAttachId)){
			return  null;
		}

		Example example = new Example(ItenderAttach.class);
		example.createCriteria().andEqualTo("referenceId",referenceAttachId);

		List<ItenderAttach> attaches = itenderAttachMapper.selectByExample(example);

		if(attaches!=null && !attaches.isEmpty()){
			return  attaches.get(0);
		}
		return  null;
	}

	@Override
    public ItenderAttach findAttachByAttachId(String attachId) {
        if(attachId == null){
            return  null;
        }

        return itenderAttachMapper.selectByPrimaryKey(attachId);
    }


	@Override
	public List<ItenderTask> findTasksByReviewId(String reviewId)throws APIException {
		if(reviewId == null){
			return  null;
		}
		Example example = new Example(ItenderTask.class);
		example.createCriteria().andEqualTo("reviewId",reviewId);
		List<ItenderTask> itenderTasks = itenderTaskMapper.selectByExample(example);


		return itenderTasks;
	}

	@Override
	public ItenderConfirm findConfirmByConfirmId(String confimId) throws APIException {

		if(confimId == null){
			return  null;
		}

		return itenderConfirmMapper.selectByPrimaryKey(confimId);
	}


	@Override
	public List<ItenderSign> findSignsByConfirmId(String confirmId) {
		Example example = new Example(ItenderSign.class);
		example.createCriteria().andEqualTo("confirmId",confirmId);
		return itenderSignMapper.selectByExample(example);
	}

	@Override
	public ItenderConfirm updateConfrirm(ItenderConfirm confirm) throws APIException {
		int  code =itenderConfirmMapper.updateByPrimaryKeySelective(confirm);

		return  findConfirmByConfirmId(confirm.getId());
	}


	private void findAttachsAndConfirms(ItenderReview itenderReview){
		Example example = new Example(ItenderAttach.class);
		example.createCriteria().andEqualTo("reviewId",itenderReview.getId());
		itenderReview.setAttaches(itenderAttachMapper.selectByExample(example));
		Example example2 = new Example(ItenderConfirm.class);
		example2.createCriteria().andEqualTo("reviewId",itenderReview.getId());
		List<ItenderConfirm> confirms = itenderConfirmMapper.selectByExample(example2);
		if(confirms!=null && !confirms.isEmpty()){
			for (int i = 0; i < confirms.size(); i++) {
				ItenderConfirm itenderConfirm = confirms.get(i);
				Example example3 = new Example(ItenderSign.class);
				String userId = null;
				if(user!=null){
					userId = user.getId();
					user = null;
				}
				example3.createCriteria().andEqualTo("confirmId",itenderConfirm.getId()).andEqualTo("signId",userId);
				List<ItenderSign> itenderSigns = itenderSignMapper.selectByExample(example3);
				if(itenderSigns!=null && !itenderSigns.isEmpty()) {
					ItenderSign itenderSign = itenderSigns.get(0);
					itenderConfirm.setStatus(itenderSign.getResult());
				}
			}
		}
		itenderReview.setConfirms(confirms);
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

	private String searchKeyword,searchType;

	@Override
	public void setSearchInfo(String keyword,String type) {
		if(keyword!=null){
			keyword = keyword.trim();
		}
		if(!StringUtils.isEmpty(keyword)){

			searchKeyword = keyword;
			searchModel = true;
		}

		if(!StringUtils.isEmpty(type)){
			searchType = type;
		}


	}
	void resetSearch(){
		searchModel = false;
		searchType = null;
		searchKeyword = null;
	}

	@Override
	public ItenderReview findByReviewReferenceId(String referenceId) {
		Example example = new Example(ItenderReview.class);
		example.createCriteria().andEqualTo("referenceId",referenceId);
		List<ItenderReview> reviews = itenderReviewMapper.selectByExample(example);
		if(reviews!=null && !reviews.isEmpty()){
			return reviews.get(0);
		}

		return null;

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



	private  String   getPrevOperator(String operator) {

		String[] operators = new String []{ReviewRole.operator.name(),ReviewRole.department_leader.name(),ReviewRole.branch_leader.name(),ReviewRole.approver.name()};
		for(int i = operators.length -1 ; i >= 0;i--){
			if(operators[i].equals(operator)){
				if(i-1>=0){
					return operators[i-1];
				}else{

					return null;
				}

			}
		}

		return null;
	}

	@Override
	public boolean postToResult(String reviewId) {
		ItenderReview itenderReview = findById(reviewId);
		//api url地址
		String url = httpConfig.getDomain()+"/supervisePlatform/callback";
		//post请求
		HttpMethod method =HttpMethod.POST;
		// 封装参数，千万不要替换为Map与HashMap，否则参数无法传递
		MultiValueMap<String, String> params= new LinkedMultiValueMap<String, String>();

		boolean resultOk=false;

		List<ItenderConfirm> confirms = itenderReview.getConfirms();



		JSONObject jsonObject = null;
		try {
			jsonObject = new JSONObject();
			jsonObject.put("referenceId",itenderReview.getReferenceId());
			if(confirms!=null && !confirms.isEmpty()){
				JSONArray confirmsArray = new JSONArray();
			for (int j = 0; j < confirms.size(); j++) {
				JSONObject confirmObject = new JSONObject();
				ItenderConfirm confirm = confirms.get(j);
				confirmObject.put("referenceId",confirm.getReferenceId());
				//confirmObject.put("path",confirm.get());

						Example example4 = new Example(ItenderSign.class);
				example4.createCriteria().andEqualTo("confirmId",confirm.getId());
				List<ItenderSign> signList = itenderSignMapper.selectByExample(example4);
				JSONArray checkInfos = new JSONArray();

				for (int i = 0; i < signList.size(); i++) {
					JSONObject checkInfoObject = new JSONObject();
					ItenderSign sign = signList.get(i);
					checkInfoObject.put("success",SignResult.approved.equals(sign.getResult()));
					//checkInfoObject.put("ruleName",);
					checkInfoObject.put("desc",sign.getDescription());
					checkInfoObject.put("time",sign.getCreateTime().toString());

					checkInfos.put(checkInfoObject);
				}

				confirmObject.put("checkInfos",checkInfos);

				confirmsArray.put(confirmObject);

			}
				jsonObject.put("confirms",confirmsArray);
		}


		} catch (JSONException e) {
			e.printStackTrace();
		}

		if(ReviewStatus.approved.name().equals(itenderReview.getStatus())){
			//发送http请求并返回结果
			try {
				jsonObject.put("result","true");
			} catch (JSONException e) {
				e.printStackTrace();
			}
			logger.info("httpClient request="+url+";param="+jsonObject.toString());
			String response  = httpClient.client(url,method,jsonObject);
			logger.info("httpClient response="+response);

			try {
				JSONObject result = new JSONObject(response);
				resultOk = result.optBoolean("success");
			} catch (JSONException e) {
				e.printStackTrace();
			}

		}else{
			try {
				jsonObject.put("result","false");
			} catch (JSONException e) {
				e.printStackTrace();
			}
			//发送http请求并返回结果
			String response  = httpClient.client(url,method,jsonObject);
			try {
				JSONObject result = new JSONObject(response);
				resultOk = result.optBoolean("success");
			} catch (JSONException e) {
				e.printStackTrace();
			}


		}

		if(!resultOk){
			return false;
		}





		//delele task
		Example example = new Example(ItenderTask.class);
		example.createCriteria().andEqualTo("reviewId",itenderReview.getId());
		itenderTaskMapper.deleteByExample(example);

		Example example2 = new Example(ItenderConfirm.class);
		example2.createCriteria().andEqualTo("reviewId",itenderReview.getId());
		itenderConfirmMapper.deleteByExample(example2);

		confirms = itenderReview.getConfirms();
		if(confirms!=null && !confirms.isEmpty()){
			for (int j = 0; j < confirms.size(); j++) {
				Example example4 = new Example(ItenderSign.class);
				example4.createCriteria().andEqualTo("confirmId",confirms.get(j).getId());
				itenderSignMapper.deleteByExample(example4);
			}
		}


		Example example3 = new Example(ItenderAttach.class);
		example3.createCriteria().andEqualTo("reviewId",itenderReview.getId());
		itenderAttachMapper.deleteByExample(example3);
		itenderReviewMapper.delete(itenderReview);
		return resultOk;
	}

	@Override
	public int rollbackReviewStatus(String id, String userId) throws APIException {

		ItenderReview rollbackItenderReview = findById(id);

		if(rollbackItenderReview == null){
			return  -1;
		}

		Example example = new Example(ItenderTask.class);
		example.createCriteria().andEqualTo("reviewId",id);
		List<ItenderTask> itenderTasks = itenderTaskMapper.selectByExample(example);
		//reset
        boolean isOperatorSign = false;
        boolean hasForbiddenSign = false;
		if(itenderTasks!=null&& !itenderTasks.isEmpty()){
			String rollbackRole = null;
			for (int i = 0; i < itenderTasks.size(); i++) {
				ItenderTask rollbackTask = itenderTasks.get(i);
				if(rollbackTask.getUserId()!=null && rollbackTask.getUserId().equals(userId) && rollbackTask.getCurrentTask()){
					logger.info("find the task exsit.");
					rollbackRole = rollbackTask.getRole();
					itenderTaskMapper.delete(rollbackTask);
					List<ItenderConfirm> confirms = rollbackItenderReview.getConfirms();
					if(confirms!=null && !confirms.isEmpty()){
						for (int j = 0; j < confirms.size(); j++) {
							Example example2 = new Example(ItenderSign.class);
							example2.createCriteria().andEqualTo("signId",userId).andEqualTo("confirmId",confirms.get(j).getId());
							List<ItenderSign> signList = itenderSignMapper.selectByExample(example2);
                            if(ReviewRole.operator.name().equals(rollbackRole)){
                                if(signList!=null && !signList.isEmpty()){
                                    isOperatorSign = true;
                                }else{

                                    confirms.get(j).setCount("0");
                                    itenderConfirmMapper.updateByPrimaryKeySelective(confirms.get(j));
                                }
                            }

                            if(signList!=null && !signList.isEmpty()){
								for (int k = 0; k < signList.size(); k++) {
									ItenderSign itenderSign = signList.get(k);
									itenderSign.setDelete(true);
									itenderSignMapper.updateByPrimaryKeySelective(itenderSign);
									if(SignResult.forbidden.name().equals(itenderSign.getResult())){
										hasForbiddenSign = true;
									}
								}
							}
						}
					}

					break;
				}
			}

			//
			if(ReviewRole.operator.name().equals(rollbackRole)){
			    if(!isOperatorSign){
                    rollbackItenderReview.setAssigneeId("");
                    itenderReviewMapper.updateByPrimaryKeySelective(rollbackItenderReview);
                    return 0;
                }else{
			    	//不通过原因
					postToResult(rollbackItenderReview.getId());
                    return  0;
                }
            }

			for (int i = 0; i < itenderTasks.size(); i++) {
				ItenderTask itenderTask = itenderTasks.get(i);
				String role = getPrevOperator(rollbackRole);
				if(itenderTask.getUserId()!=null && itenderTask.getRole()!=null && itenderTask.getRole().equals(role)){
					itenderTask.setCurrentTask(true);
					itenderTask.setCreateTime(new Date());
					if(hasForbiddenSign){
						itenderTask.setStatus(ReviewStatus.forbidden.name());
					}else {
						itenderTask.setStatus(ReviewStatus.verify.name());
					}
					itenderTaskMapper.updateByPrimaryKeySelective(itenderTask);
					ItenderReview itenderReview = new ItenderReview();
					itenderReview.setId(itenderTask.getReviewId());
					itenderReview.setAssigneeId(itenderTask.getUserId());

					itenderReviewMapper.updateByPrimaryKeySelective(itenderReview);
					return 0;
					}


				}
			}


		return -2;
	}




	@Override
	public ItenderReview updateReviewStatus(String id,String assigneeId,String role,String status,String remark) throws APIException {
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
			itenderTask.setRemark(remark);
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
			//delete sign mark = 1
			ItenderReview rollbackItenderReview = findById(id);
			List<ItenderConfirm> confirms = rollbackItenderReview.getConfirms();
			if(confirms!=null && !confirms.isEmpty()){
				for (int j = 0; j < confirms.size(); j++) {
					Example example2 = new Example(ItenderSign.class);
					example2.createCriteria().andEqualTo("isDelete",true).andEqualTo("confirmId",confirms.get(j).getId());
					itenderSignMapper.deleteByExample(example2);
				}
			}


		}else if(ReviewStatus.forbidden.name().equals(status)){
//			ItenderTask itenderTask = new ItenderTask();
//			itenderTask.setRemark(remark);
			ItenderReview itenderReview = new ItenderReview();
			itenderReview.setId(id);
			itenderReview.setStatus(ReviewStatus.forbidden.name());
			itenderReviewMapper.updateByPrimaryKeySelective(itenderReview);
		}

		ItenderReview reviewExsit = findById(id);



		return reviewExsit;
	}


	@Override
	public ItenderSign updateSignFileResult(String confirmId,String signId,String signResult,String description) throws APIException {
		Example example = new Example(ItenderSign.class);
		example.createCriteria().andEqualTo("confirmId",confirmId).andEqualTo("signId",signId);
		List<ItenderSign> itenderSigns = itenderSignMapper.selectByExample(example);
		ItenderSign itenderSign;
		if(itenderSigns!=null && !itenderSigns.isEmpty()){
			itenderSign = itenderSigns.get(0);
			itenderSign.setDelete(false);
			itenderSign.setFileSignResult(signResult);
			//itenderSign.setDescription(description);
			itenderSignMapper.updateByPrimaryKeySelective(itenderSign);
			return itenderSign;
		}else{
			return  null;
		}

	}


	@Override
	public ItenderSign updateSignResult(String confirmId,String signId,String signResult,String description) throws APIException {
		Example example = new Example(ItenderSign.class);
		example.createCriteria().andEqualTo("confirmId",confirmId).andEqualTo("signId",signId);
		List<ItenderSign> itenderSigns = itenderSignMapper.selectByExample(example);
		ItenderSign itenderSign;
		if(itenderSigns!=null && !itenderSigns.isEmpty()){
			 itenderSign = itenderSigns.get(0);
			itenderSign.setResult(signResult);
			itenderSign.setDelete(false);
			itenderSign.setDescription(description);
			itenderSignMapper.updateByPrimaryKeySelective(itenderSign);
		}else{
			 itenderSign = new ItenderSign();
			itenderSign.setConfirmId(confirmId);
			itenderSign.setResult(signResult);
			itenderSign.setCreateTime(new Date());
			itenderSign.setDescription(description);
			itenderSign.setSignId(signId);
			itenderSignMapper.insertSelective(itenderSign);
		}
		return itenderSign;
	}


	@Override
	public ItenderReview add(ItenderReview review) throws APIException {
		//review.setCreateTime(new Date(System.currentTimeMillis()));
		review.setStatus(ReviewStatus.verify.name());
		int rows = itenderReviewMapper.insertSelective(review);
		if(review.getAttaches()!=null){
			List<ItenderAttach> attaches = review.getAttaches();
			for (int i = 0; i < attaches.size(); i++) {
				ItenderAttach attach = attaches.get(i);
				attach.setReviewId(review.getId());
				itenderAttachMapper.insertSelective(attach);
			}

		}
//        ItenderTask itenderTask = new ItenderTask();
//        itenderTask.setRole(ReviewRole.operator.name());
//        itenderTask.setStatus(ReviewStatus.verify.name());
//        itenderTask.setCreateTime(review.getCreateTime());
//        itenderTask.setReviewId(review.getId());
//        itenderTask.setCurrentTask(true);
//        itenderTaskMapper.insertSelective(itenderTask);

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
		List<ItenderReview> itenderReviews = null;
		if(searchModel){
			logger.debug("==searchModel=");
			logger.debug("==searchKeyword="+searchKeyword+";searchType=="+searchType);
			if(StringUtils.isEmpty(searchKeyword)){
				searchKeyword = null;
			}

			if(StringUtils.isEmpty(searchType)){
				searchType = null;
			}

			Example.Criteria criteria = example.createCriteria();
			if(user!=null){

				criteria.andEqualTo("assigneeId",user.getId());

				user = null;
			}else{
				criteria.andIsNull("assigneeId").orEqualTo("assigneeId","");
			}

			criteria.andCondition("(name like "+"'%"+searchKeyword+"%'"+" or "+"tender_name like "+"'%"+searchKeyword+"%' )");

			if(!StringUtils.isEmpty(searchType)){
				criteria.andEqualTo("type",searchType);
			}

			example.setOrderByClause("create_time desc");
			itenderReviews = itenderReviewMapper.selectByExample(example);

			//reset
			resetSearch();
		}else {
			Example.Criteria criteria = example.createCriteria();
			if(user!=null){

				criteria.andEqualTo("assigneeId",user.getId());

				user = null;
			}else{
				criteria.andIsNull("assigneeId").orEqualTo("assigneeId","");
			}

			if(!StringUtils.isEmpty(searchType)){
				criteria.andEqualTo("type",searchType);
				searchType = null;
			}

			example.setOrderByClause("create_time desc");
			 itenderReviews = itenderReviewMapper.selectByExample(example);
		}

		if(itenderReviews!=null && !itenderReviews.isEmpty()){
			for (int i = 0; i < itenderReviews.size(); i++) {
				checkTask(itenderReviews.get(i));
			}
		}

        return new PageInfo<>(itenderReviews);
	}


	//private ItenderReview


}
