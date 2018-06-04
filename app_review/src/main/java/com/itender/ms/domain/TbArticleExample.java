package com.itender.ms.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TbArticleExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public TbArticleExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("ID is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("ID is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(String value) {
            addCriterion("ID =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(String value) {
            addCriterion("ID <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(String value) {
            addCriterion("ID >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(String value) {
            addCriterion("ID >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(String value) {
            addCriterion("ID <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(String value) {
            addCriterion("ID <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLike(String value) {
            addCriterion("ID like", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotLike(String value) {
            addCriterion("ID not like", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<String> values) {
            addCriterion("ID in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<String> values) {
            addCriterion("ID not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(String value1, String value2) {
            addCriterion("ID between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(String value1, String value2) {
            addCriterion("ID not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkIsNull() {
            addCriterion("DELETE_MARK is null");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkIsNotNull() {
            addCriterion("DELETE_MARK is not null");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkEqualTo(String value) {
            addCriterion("DELETE_MARK =", value, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkNotEqualTo(String value) {
            addCriterion("DELETE_MARK <>", value, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkGreaterThan(String value) {
            addCriterion("DELETE_MARK >", value, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkGreaterThanOrEqualTo(String value) {
            addCriterion("DELETE_MARK >=", value, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkLessThan(String value) {
            addCriterion("DELETE_MARK <", value, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkLessThanOrEqualTo(String value) {
            addCriterion("DELETE_MARK <=", value, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkLike(String value) {
            addCriterion("DELETE_MARK like", value, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkNotLike(String value) {
            addCriterion("DELETE_MARK not like", value, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkIn(List<String> values) {
            addCriterion("DELETE_MARK in", values, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkNotIn(List<String> values) {
            addCriterion("DELETE_MARK not in", values, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkBetween(String value1, String value2) {
            addCriterion("DELETE_MARK between", value1, value2, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andDeleteMarkNotBetween(String value1, String value2) {
            addCriterion("DELETE_MARK not between", value1, value2, "deleteMark");
            return (Criteria) this;
        }

        public Criteria andNewsTitleIsNull() {
            addCriterion("NEWS_TITLE is null");
            return (Criteria) this;
        }

        public Criteria andNewsTitleIsNotNull() {
            addCriterion("NEWS_TITLE is not null");
            return (Criteria) this;
        }

        public Criteria andNewsTitleEqualTo(String value) {
            addCriterion("NEWS_TITLE =", value, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleNotEqualTo(String value) {
            addCriterion("NEWS_TITLE <>", value, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleGreaterThan(String value) {
            addCriterion("NEWS_TITLE >", value, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleGreaterThanOrEqualTo(String value) {
            addCriterion("NEWS_TITLE >=", value, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleLessThan(String value) {
            addCriterion("NEWS_TITLE <", value, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleLessThanOrEqualTo(String value) {
            addCriterion("NEWS_TITLE <=", value, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleLike(String value) {
            addCriterion("NEWS_TITLE like", value, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleNotLike(String value) {
            addCriterion("NEWS_TITLE not like", value, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleIn(List<String> values) {
            addCriterion("NEWS_TITLE in", values, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleNotIn(List<String> values) {
            addCriterion("NEWS_TITLE not in", values, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleBetween(String value1, String value2) {
            addCriterion("NEWS_TITLE between", value1, value2, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andNewsTitleNotBetween(String value1, String value2) {
            addCriterion("NEWS_TITLE not between", value1, value2, "newsTitle");
            return (Criteria) this;
        }

        public Criteria andPublishTimeIsNull() {
            addCriterion("PUBLISH_TIME is null");
            return (Criteria) this;
        }

        public Criteria andPublishTimeIsNotNull() {
            addCriterion("PUBLISH_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andPublishTimeEqualTo(Date value) {
            addCriterion("PUBLISH_TIME =", value, "publishTime");
            return (Criteria) this;
        }

        public Criteria andPublishTimeNotEqualTo(Date value) {
            addCriterion("PUBLISH_TIME <>", value, "publishTime");
            return (Criteria) this;
        }

        public Criteria andPublishTimeGreaterThan(Date value) {
            addCriterion("PUBLISH_TIME >", value, "publishTime");
            return (Criteria) this;
        }

        public Criteria andPublishTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("PUBLISH_TIME >=", value, "publishTime");
            return (Criteria) this;
        }

        public Criteria andPublishTimeLessThan(Date value) {
            addCriterion("PUBLISH_TIME <", value, "publishTime");
            return (Criteria) this;
        }

        public Criteria andPublishTimeLessThanOrEqualTo(Date value) {
            addCriterion("PUBLISH_TIME <=", value, "publishTime");
            return (Criteria) this;
        }

        public Criteria andPublishTimeIn(List<Date> values) {
            addCriterion("PUBLISH_TIME in", values, "publishTime");
            return (Criteria) this;
        }

        public Criteria andPublishTimeNotIn(List<Date> values) {
            addCriterion("PUBLISH_TIME not in", values, "publishTime");
            return (Criteria) this;
        }

        public Criteria andPublishTimeBetween(Date value1, Date value2) {
            addCriterion("PUBLISH_TIME between", value1, value2, "publishTime");
            return (Criteria) this;
        }

        public Criteria andPublishTimeNotBetween(Date value1, Date value2) {
            addCriterion("PUBLISH_TIME not between", value1, value2, "publishTime");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdIsNull() {
            addCriterion("PUBLISH_USER_ID is null");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdIsNotNull() {
            addCriterion("PUBLISH_USER_ID is not null");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdEqualTo(String value) {
            addCriterion("PUBLISH_USER_ID =", value, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdNotEqualTo(String value) {
            addCriterion("PUBLISH_USER_ID <>", value, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdGreaterThan(String value) {
            addCriterion("PUBLISH_USER_ID >", value, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdGreaterThanOrEqualTo(String value) {
            addCriterion("PUBLISH_USER_ID >=", value, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdLessThan(String value) {
            addCriterion("PUBLISH_USER_ID <", value, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdLessThanOrEqualTo(String value) {
            addCriterion("PUBLISH_USER_ID <=", value, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdLike(String value) {
            addCriterion("PUBLISH_USER_ID like", value, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdNotLike(String value) {
            addCriterion("PUBLISH_USER_ID not like", value, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdIn(List<String> values) {
            addCriterion("PUBLISH_USER_ID in", values, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdNotIn(List<String> values) {
            addCriterion("PUBLISH_USER_ID not in", values, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdBetween(String value1, String value2) {
            addCriterion("PUBLISH_USER_ID between", value1, value2, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishUserIdNotBetween(String value1, String value2) {
            addCriterion("PUBLISH_USER_ID not between", value1, value2, "publishUserId");
            return (Criteria) this;
        }

        public Criteria andPublishWayIsNull() {
            addCriterion("PUBLISH_WAY is null");
            return (Criteria) this;
        }

        public Criteria andPublishWayIsNotNull() {
            addCriterion("PUBLISH_WAY is not null");
            return (Criteria) this;
        }

        public Criteria andPublishWayEqualTo(String value) {
            addCriterion("PUBLISH_WAY =", value, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayNotEqualTo(String value) {
            addCriterion("PUBLISH_WAY <>", value, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayGreaterThan(String value) {
            addCriterion("PUBLISH_WAY >", value, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayGreaterThanOrEqualTo(String value) {
            addCriterion("PUBLISH_WAY >=", value, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayLessThan(String value) {
            addCriterion("PUBLISH_WAY <", value, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayLessThanOrEqualTo(String value) {
            addCriterion("PUBLISH_WAY <=", value, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayLike(String value) {
            addCriterion("PUBLISH_WAY like", value, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayNotLike(String value) {
            addCriterion("PUBLISH_WAY not like", value, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayIn(List<String> values) {
            addCriterion("PUBLISH_WAY in", values, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayNotIn(List<String> values) {
            addCriterion("PUBLISH_WAY not in", values, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayBetween(String value1, String value2) {
            addCriterion("PUBLISH_WAY between", value1, value2, "publishWay");
            return (Criteria) this;
        }

        public Criteria andPublishWayNotBetween(String value1, String value2) {
            addCriterion("PUBLISH_WAY not between", value1, value2, "publishWay");
            return (Criteria) this;
        }

        public Criteria andEditTimeIsNull() {
            addCriterion("EDIT_TIME is null");
            return (Criteria) this;
        }

        public Criteria andEditTimeIsNotNull() {
            addCriterion("EDIT_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andEditTimeEqualTo(Date value) {
            addCriterion("EDIT_TIME =", value, "editTime");
            return (Criteria) this;
        }

        public Criteria andEditTimeNotEqualTo(Date value) {
            addCriterion("EDIT_TIME <>", value, "editTime");
            return (Criteria) this;
        }

        public Criteria andEditTimeGreaterThan(Date value) {
            addCriterion("EDIT_TIME >", value, "editTime");
            return (Criteria) this;
        }

        public Criteria andEditTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("EDIT_TIME >=", value, "editTime");
            return (Criteria) this;
        }

        public Criteria andEditTimeLessThan(Date value) {
            addCriterion("EDIT_TIME <", value, "editTime");
            return (Criteria) this;
        }

        public Criteria andEditTimeLessThanOrEqualTo(Date value) {
            addCriterion("EDIT_TIME <=", value, "editTime");
            return (Criteria) this;
        }

        public Criteria andEditTimeIn(List<Date> values) {
            addCriterion("EDIT_TIME in", values, "editTime");
            return (Criteria) this;
        }

        public Criteria andEditTimeNotIn(List<Date> values) {
            addCriterion("EDIT_TIME not in", values, "editTime");
            return (Criteria) this;
        }

        public Criteria andEditTimeBetween(Date value1, Date value2) {
            addCriterion("EDIT_TIME between", value1, value2, "editTime");
            return (Criteria) this;
        }

        public Criteria andEditTimeNotBetween(Date value1, Date value2) {
            addCriterion("EDIT_TIME not between", value1, value2, "editTime");
            return (Criteria) this;
        }

        public Criteria andEditUserIdIsNull() {
            addCriterion("EDIT_USER_ID is null");
            return (Criteria) this;
        }

        public Criteria andEditUserIdIsNotNull() {
            addCriterion("EDIT_USER_ID is not null");
            return (Criteria) this;
        }

        public Criteria andEditUserIdEqualTo(String value) {
            addCriterion("EDIT_USER_ID =", value, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdNotEqualTo(String value) {
            addCriterion("EDIT_USER_ID <>", value, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdGreaterThan(String value) {
            addCriterion("EDIT_USER_ID >", value, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdGreaterThanOrEqualTo(String value) {
            addCriterion("EDIT_USER_ID >=", value, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdLessThan(String value) {
            addCriterion("EDIT_USER_ID <", value, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdLessThanOrEqualTo(String value) {
            addCriterion("EDIT_USER_ID <=", value, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdLike(String value) {
            addCriterion("EDIT_USER_ID like", value, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdNotLike(String value) {
            addCriterion("EDIT_USER_ID not like", value, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdIn(List<String> values) {
            addCriterion("EDIT_USER_ID in", values, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdNotIn(List<String> values) {
            addCriterion("EDIT_USER_ID not in", values, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdBetween(String value1, String value2) {
            addCriterion("EDIT_USER_ID between", value1, value2, "editUserId");
            return (Criteria) this;
        }

        public Criteria andEditUserIdNotBetween(String value1, String value2) {
            addCriterion("EDIT_USER_ID not between", value1, value2, "editUserId");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorIsNull() {
            addCriterion("NEWS_AUTHOR is null");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorIsNotNull() {
            addCriterion("NEWS_AUTHOR is not null");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorEqualTo(String value) {
            addCriterion("NEWS_AUTHOR =", value, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorNotEqualTo(String value) {
            addCriterion("NEWS_AUTHOR <>", value, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorGreaterThan(String value) {
            addCriterion("NEWS_AUTHOR >", value, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorGreaterThanOrEqualTo(String value) {
            addCriterion("NEWS_AUTHOR >=", value, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorLessThan(String value) {
            addCriterion("NEWS_AUTHOR <", value, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorLessThanOrEqualTo(String value) {
            addCriterion("NEWS_AUTHOR <=", value, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorLike(String value) {
            addCriterion("NEWS_AUTHOR like", value, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorNotLike(String value) {
            addCriterion("NEWS_AUTHOR not like", value, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorIn(List<String> values) {
            addCriterion("NEWS_AUTHOR in", values, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorNotIn(List<String> values) {
            addCriterion("NEWS_AUTHOR not in", values, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorBetween(String value1, String value2) {
            addCriterion("NEWS_AUTHOR between", value1, value2, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsAuthorNotBetween(String value1, String value2) {
            addCriterion("NEWS_AUTHOR not between", value1, value2, "newsAuthor");
            return (Criteria) this;
        }

        public Criteria andNewsSourceIsNull() {
            addCriterion("NEWS_SOURCE is null");
            return (Criteria) this;
        }

        public Criteria andNewsSourceIsNotNull() {
            addCriterion("NEWS_SOURCE is not null");
            return (Criteria) this;
        }

        public Criteria andNewsSourceEqualTo(String value) {
            addCriterion("NEWS_SOURCE =", value, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceNotEqualTo(String value) {
            addCriterion("NEWS_SOURCE <>", value, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceGreaterThan(String value) {
            addCriterion("NEWS_SOURCE >", value, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceGreaterThanOrEqualTo(String value) {
            addCriterion("NEWS_SOURCE >=", value, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceLessThan(String value) {
            addCriterion("NEWS_SOURCE <", value, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceLessThanOrEqualTo(String value) {
            addCriterion("NEWS_SOURCE <=", value, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceLike(String value) {
            addCriterion("NEWS_SOURCE like", value, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceNotLike(String value) {
            addCriterion("NEWS_SOURCE not like", value, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceIn(List<String> values) {
            addCriterion("NEWS_SOURCE in", values, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceNotIn(List<String> values) {
            addCriterion("NEWS_SOURCE not in", values, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceBetween(String value1, String value2) {
            addCriterion("NEWS_SOURCE between", value1, value2, "newsSource");
            return (Criteria) this;
        }

        public Criteria andNewsSourceNotBetween(String value1, String value2) {
            addCriterion("NEWS_SOURCE not between", value1, value2, "newsSource");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIsNull() {
            addCriterion("CREATE_TIME is null");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIsNotNull() {
            addCriterion("CREATE_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andCreateTimeEqualTo(Date value) {
            addCriterion("CREATE_TIME =", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotEqualTo(Date value) {
            addCriterion("CREATE_TIME <>", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeGreaterThan(Date value) {
            addCriterion("CREATE_TIME >", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("CREATE_TIME >=", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeLessThan(Date value) {
            addCriterion("CREATE_TIME <", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeLessThanOrEqualTo(Date value) {
            addCriterion("CREATE_TIME <=", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIn(List<Date> values) {
            addCriterion("CREATE_TIME in", values, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotIn(List<Date> values) {
            addCriterion("CREATE_TIME not in", values, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeBetween(Date value1, Date value2) {
            addCriterion("CREATE_TIME between", value1, value2, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotBetween(Date value1, Date value2) {
            addCriterion("CREATE_TIME not between", value1, value2, "createTime");
            return (Criteria) this;
        }

        public Criteria andArticleTypeIsNull() {
            addCriterion("ARTICLE_TYPE is null");
            return (Criteria) this;
        }

        public Criteria andArticleTypeIsNotNull() {
            addCriterion("ARTICLE_TYPE is not null");
            return (Criteria) this;
        }

        public Criteria andArticleTypeEqualTo(String value) {
            addCriterion("ARTICLE_TYPE =", value, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeNotEqualTo(String value) {
            addCriterion("ARTICLE_TYPE <>", value, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeGreaterThan(String value) {
            addCriterion("ARTICLE_TYPE >", value, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeGreaterThanOrEqualTo(String value) {
            addCriterion("ARTICLE_TYPE >=", value, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeLessThan(String value) {
            addCriterion("ARTICLE_TYPE <", value, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeLessThanOrEqualTo(String value) {
            addCriterion("ARTICLE_TYPE <=", value, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeLike(String value) {
            addCriterion("ARTICLE_TYPE like", value, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeNotLike(String value) {
            addCriterion("ARTICLE_TYPE not like", value, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeIn(List<String> values) {
            addCriterion("ARTICLE_TYPE in", values, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeNotIn(List<String> values) {
            addCriterion("ARTICLE_TYPE not in", values, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeBetween(String value1, String value2) {
            addCriterion("ARTICLE_TYPE between", value1, value2, "articleType");
            return (Criteria) this;
        }

        public Criteria andArticleTypeNotBetween(String value1, String value2) {
            addCriterion("ARTICLE_TYPE not between", value1, value2, "articleType");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdIsNull() {
            addCriterion("PUBLISH_ORGAN_ID is null");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdIsNotNull() {
            addCriterion("PUBLISH_ORGAN_ID is not null");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdEqualTo(String value) {
            addCriterion("PUBLISH_ORGAN_ID =", value, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdNotEqualTo(String value) {
            addCriterion("PUBLISH_ORGAN_ID <>", value, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdGreaterThan(String value) {
            addCriterion("PUBLISH_ORGAN_ID >", value, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdGreaterThanOrEqualTo(String value) {
            addCriterion("PUBLISH_ORGAN_ID >=", value, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdLessThan(String value) {
            addCriterion("PUBLISH_ORGAN_ID <", value, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdLessThanOrEqualTo(String value) {
            addCriterion("PUBLISH_ORGAN_ID <=", value, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdLike(String value) {
            addCriterion("PUBLISH_ORGAN_ID like", value, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdNotLike(String value) {
            addCriterion("PUBLISH_ORGAN_ID not like", value, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdIn(List<String> values) {
            addCriterion("PUBLISH_ORGAN_ID in", values, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdNotIn(List<String> values) {
            addCriterion("PUBLISH_ORGAN_ID not in", values, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdBetween(String value1, String value2) {
            addCriterion("PUBLISH_ORGAN_ID between", value1, value2, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andPublishOrganIdNotBetween(String value1, String value2) {
            addCriterion("PUBLISH_ORGAN_ID not between", value1, value2, "publishOrganId");
            return (Criteria) this;
        }

        public Criteria andIndustryIsNull() {
            addCriterion("INDUSTRY is null");
            return (Criteria) this;
        }

        public Criteria andIndustryIsNotNull() {
            addCriterion("INDUSTRY is not null");
            return (Criteria) this;
        }

        public Criteria andIndustryEqualTo(String value) {
            addCriterion("INDUSTRY =", value, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryNotEqualTo(String value) {
            addCriterion("INDUSTRY <>", value, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryGreaterThan(String value) {
            addCriterion("INDUSTRY >", value, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryGreaterThanOrEqualTo(String value) {
            addCriterion("INDUSTRY >=", value, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryLessThan(String value) {
            addCriterion("INDUSTRY <", value, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryLessThanOrEqualTo(String value) {
            addCriterion("INDUSTRY <=", value, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryLike(String value) {
            addCriterion("INDUSTRY like", value, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryNotLike(String value) {
            addCriterion("INDUSTRY not like", value, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryIn(List<String> values) {
            addCriterion("INDUSTRY in", values, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryNotIn(List<String> values) {
            addCriterion("INDUSTRY not in", values, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryBetween(String value1, String value2) {
            addCriterion("INDUSTRY between", value1, value2, "industry");
            return (Criteria) this;
        }

        public Criteria andIndustryNotBetween(String value1, String value2) {
            addCriterion("INDUSTRY not between", value1, value2, "industry");
            return (Criteria) this;
        }
    }

    /**
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}