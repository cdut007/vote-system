package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderReview;
import com.itender.ms.enums.ReviewStatus;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderReviewMapper;
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
	private static final String KEY = "com.itender";
    @Autowired
    private ItenderReviewMapper itenderReviewMapper;





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
		return itenderReviewMapper.selectByPrimaryKey(id);
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
	public ItenderReview add(ItenderReview review) throws APIException {
		//review.setCreateTime(new Date(System.currentTimeMillis()));
		int rows = itenderReviewMapper.insertSelective(review);

		return rows == 0?null:review;
	}

	@Override
	public List<ItenderReview> findAll() throws APIException {
		return itenderReviewMapper.selectAll();
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
			example.setOrderByClause("create_time desc");
			 itenderReview = itenderReviewMapper.selectByExample(example);
		}
        return new PageInfo<>(itenderReview);
	}


	//private ItenderReview


}
