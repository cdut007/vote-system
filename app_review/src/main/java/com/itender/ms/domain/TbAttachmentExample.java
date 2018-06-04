package com.itender.ms.domain;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class TbAttachmentExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public TbAttachmentExample() {
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

        protected void addCriterionForJDBCDate(String condition, Date value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            addCriterion(condition, new java.sql.Date(value.getTime()), property);
        }

        protected void addCriterionForJDBCDate(String condition, List<Date> values, String property) {
            if (values == null || values.size() == 0) {
                throw new RuntimeException("Value list for " + property + " cannot be null or empty");
            }
            List<java.sql.Date> dateList = new ArrayList<java.sql.Date>();
            Iterator<Date> iter = values.iterator();
            while (iter.hasNext()) {
                dateList.add(new java.sql.Date(iter.next().getTime()));
            }
            addCriterion(condition, dateList, property);
        }

        protected void addCriterionForJDBCDate(String condition, Date value1, Date value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            addCriterion(condition, new java.sql.Date(value1.getTime()), new java.sql.Date(value2.getTime()), property);
        }

        public Criteria andFjid00IsNull() {
            addCriterion("FJID00 is null");
            return (Criteria) this;
        }

        public Criteria andFjid00IsNotNull() {
            addCriterion("FJID00 is not null");
            return (Criteria) this;
        }

        public Criteria andFjid00EqualTo(String value) {
            addCriterion("FJID00 =", value, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00NotEqualTo(String value) {
            addCriterion("FJID00 <>", value, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00GreaterThan(String value) {
            addCriterion("FJID00 >", value, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00GreaterThanOrEqualTo(String value) {
            addCriterion("FJID00 >=", value, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00LessThan(String value) {
            addCriterion("FJID00 <", value, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00LessThanOrEqualTo(String value) {
            addCriterion("FJID00 <=", value, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00Like(String value) {
            addCriterion("FJID00 like", value, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00NotLike(String value) {
            addCriterion("FJID00 not like", value, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00In(List<String> values) {
            addCriterion("FJID00 in", values, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00NotIn(List<String> values) {
            addCriterion("FJID00 not in", values, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00Between(String value1, String value2) {
            addCriterion("FJID00 between", value1, value2, "fjid00");
            return (Criteria) this;
        }

        public Criteria andFjid00NotBetween(String value1, String value2) {
            addCriterion("FJID00 not between", value1, value2, "fjid00");
            return (Criteria) this;
        }

        public Criteria andUploadTimeIsNull() {
            addCriterion("UPLOAD_TIME is null");
            return (Criteria) this;
        }

        public Criteria andUploadTimeIsNotNull() {
            addCriterion("UPLOAD_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andUploadTimeEqualTo(Date value) {
            addCriterionForJDBCDate("UPLOAD_TIME =", value, "uploadTime");
            return (Criteria) this;
        }

        public Criteria andUploadTimeNotEqualTo(Date value) {
            addCriterionForJDBCDate("UPLOAD_TIME <>", value, "uploadTime");
            return (Criteria) this;
        }

        public Criteria andUploadTimeGreaterThan(Date value) {
            addCriterionForJDBCDate("UPLOAD_TIME >", value, "uploadTime");
            return (Criteria) this;
        }

        public Criteria andUploadTimeGreaterThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("UPLOAD_TIME >=", value, "uploadTime");
            return (Criteria) this;
        }

        public Criteria andUploadTimeLessThan(Date value) {
            addCriterionForJDBCDate("UPLOAD_TIME <", value, "uploadTime");
            return (Criteria) this;
        }

        public Criteria andUploadTimeLessThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("UPLOAD_TIME <=", value, "uploadTime");
            return (Criteria) this;
        }

        public Criteria andUploadTimeIn(List<Date> values) {
            addCriterionForJDBCDate("UPLOAD_TIME in", values, "uploadTime");
            return (Criteria) this;
        }

        public Criteria andUploadTimeNotIn(List<Date> values) {
            addCriterionForJDBCDate("UPLOAD_TIME not in", values, "uploadTime");
            return (Criteria) this;
        }

        public Criteria andUploadTimeBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("UPLOAD_TIME between", value1, value2, "uploadTime");
            return (Criteria) this;
        }

        public Criteria andUploadTimeNotBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("UPLOAD_TIME not between", value1, value2, "uploadTime");
            return (Criteria) this;
        }

        public Criteria andFjmc00IsNull() {
            addCriterion("FJMC00 is null");
            return (Criteria) this;
        }

        public Criteria andFjmc00IsNotNull() {
            addCriterion("FJMC00 is not null");
            return (Criteria) this;
        }

        public Criteria andFjmc00EqualTo(String value) {
            addCriterion("FJMC00 =", value, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00NotEqualTo(String value) {
            addCriterion("FJMC00 <>", value, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00GreaterThan(String value) {
            addCriterion("FJMC00 >", value, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00GreaterThanOrEqualTo(String value) {
            addCriterion("FJMC00 >=", value, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00LessThan(String value) {
            addCriterion("FJMC00 <", value, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00LessThanOrEqualTo(String value) {
            addCriterion("FJMC00 <=", value, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00Like(String value) {
            addCriterion("FJMC00 like", value, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00NotLike(String value) {
            addCriterion("FJMC00 not like", value, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00In(List<String> values) {
            addCriterion("FJMC00 in", values, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00NotIn(List<String> values) {
            addCriterion("FJMC00 not in", values, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00Between(String value1, String value2) {
            addCriterion("FJMC00 between", value1, value2, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjmc00NotBetween(String value1, String value2) {
            addCriterion("FJMC00 not between", value1, value2, "fjmc00");
            return (Criteria) this;
        }

        public Criteria andFjgslxIsNull() {
            addCriterion("FJGSLX is null");
            return (Criteria) this;
        }

        public Criteria andFjgslxIsNotNull() {
            addCriterion("FJGSLX is not null");
            return (Criteria) this;
        }

        public Criteria andFjgslxEqualTo(String value) {
            addCriterion("FJGSLX =", value, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxNotEqualTo(String value) {
            addCriterion("FJGSLX <>", value, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxGreaterThan(String value) {
            addCriterion("FJGSLX >", value, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxGreaterThanOrEqualTo(String value) {
            addCriterion("FJGSLX >=", value, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxLessThan(String value) {
            addCriterion("FJGSLX <", value, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxLessThanOrEqualTo(String value) {
            addCriterion("FJGSLX <=", value, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxLike(String value) {
            addCriterion("FJGSLX like", value, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxNotLike(String value) {
            addCriterion("FJGSLX not like", value, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxIn(List<String> values) {
            addCriterion("FJGSLX in", values, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxNotIn(List<String> values) {
            addCriterion("FJGSLX not in", values, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxBetween(String value1, String value2) {
            addCriterion("FJGSLX between", value1, value2, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjgslxNotBetween(String value1, String value2) {
            addCriterion("FJGSLX not between", value1, value2, "fjgslx");
            return (Criteria) this;
        }

        public Criteria andFjlx00IsNull() {
            addCriterion("FJLX00 is null");
            return (Criteria) this;
        }

        public Criteria andFjlx00IsNotNull() {
            addCriterion("FJLX00 is not null");
            return (Criteria) this;
        }

        public Criteria andFjlx00EqualTo(String value) {
            addCriterion("FJLX00 =", value, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00NotEqualTo(String value) {
            addCriterion("FJLX00 <>", value, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00GreaterThan(String value) {
            addCriterion("FJLX00 >", value, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00GreaterThanOrEqualTo(String value) {
            addCriterion("FJLX00 >=", value, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00LessThan(String value) {
            addCriterion("FJLX00 <", value, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00LessThanOrEqualTo(String value) {
            addCriterion("FJLX00 <=", value, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00Like(String value) {
            addCriterion("FJLX00 like", value, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00NotLike(String value) {
            addCriterion("FJLX00 not like", value, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00In(List<String> values) {
            addCriterion("FJLX00 in", values, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00NotIn(List<String> values) {
            addCriterion("FJLX00 not in", values, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00Between(String value1, String value2) {
            addCriterion("FJLX00 between", value1, value2, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjlx00NotBetween(String value1, String value2) {
            addCriterion("FJLX00 not between", value1, value2, "fjlx00");
            return (Criteria) this;
        }

        public Criteria andFjssztIsNull() {
            addCriterion("FJSSZT is null");
            return (Criteria) this;
        }

        public Criteria andFjssztIsNotNull() {
            addCriterion("FJSSZT is not null");
            return (Criteria) this;
        }

        public Criteria andFjssztEqualTo(String value) {
            addCriterion("FJSSZT =", value, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztNotEqualTo(String value) {
            addCriterion("FJSSZT <>", value, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztGreaterThan(String value) {
            addCriterion("FJSSZT >", value, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztGreaterThanOrEqualTo(String value) {
            addCriterion("FJSSZT >=", value, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztLessThan(String value) {
            addCriterion("FJSSZT <", value, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztLessThanOrEqualTo(String value) {
            addCriterion("FJSSZT <=", value, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztLike(String value) {
            addCriterion("FJSSZT like", value, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztNotLike(String value) {
            addCriterion("FJSSZT not like", value, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztIn(List<String> values) {
            addCriterion("FJSSZT in", values, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztNotIn(List<String> values) {
            addCriterion("FJSSZT not in", values, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztBetween(String value1, String value2) {
            addCriterion("FJSSZT between", value1, value2, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andFjssztNotBetween(String value1, String value2) {
            addCriterion("FJSSZT not between", value1, value2, "fjsszt");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdIsNull() {
            addCriterion("UPLOAD_USER_ID is null");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdIsNotNull() {
            addCriterion("UPLOAD_USER_ID is not null");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdEqualTo(String value) {
            addCriterion("UPLOAD_USER_ID =", value, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdNotEqualTo(String value) {
            addCriterion("UPLOAD_USER_ID <>", value, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdGreaterThan(String value) {
            addCriterion("UPLOAD_USER_ID >", value, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdGreaterThanOrEqualTo(String value) {
            addCriterion("UPLOAD_USER_ID >=", value, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdLessThan(String value) {
            addCriterion("UPLOAD_USER_ID <", value, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdLessThanOrEqualTo(String value) {
            addCriterion("UPLOAD_USER_ID <=", value, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdLike(String value) {
            addCriterion("UPLOAD_USER_ID like", value, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdNotLike(String value) {
            addCriterion("UPLOAD_USER_ID not like", value, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdIn(List<String> values) {
            addCriterion("UPLOAD_USER_ID in", values, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdNotIn(List<String> values) {
            addCriterion("UPLOAD_USER_ID not in", values, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdBetween(String value1, String value2) {
            addCriterion("UPLOAD_USER_ID between", value1, value2, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andUploadUserIdNotBetween(String value1, String value2) {
            addCriterion("UPLOAD_USER_ID not between", value1, value2, "uploadUserId");
            return (Criteria) this;
        }

        public Criteria andTbxmzjIsNull() {
            addCriterion("TBXMZJ is null");
            return (Criteria) this;
        }

        public Criteria andTbxmzjIsNotNull() {
            addCriterion("TBXMZJ is not null");
            return (Criteria) this;
        }

        public Criteria andTbxmzjEqualTo(String value) {
            addCriterion("TBXMZJ =", value, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjNotEqualTo(String value) {
            addCriterion("TBXMZJ <>", value, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjGreaterThan(String value) {
            addCriterion("TBXMZJ >", value, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjGreaterThanOrEqualTo(String value) {
            addCriterion("TBXMZJ >=", value, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjLessThan(String value) {
            addCriterion("TBXMZJ <", value, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjLessThanOrEqualTo(String value) {
            addCriterion("TBXMZJ <=", value, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjLike(String value) {
            addCriterion("TBXMZJ like", value, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjNotLike(String value) {
            addCriterion("TBXMZJ not like", value, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjIn(List<String> values) {
            addCriterion("TBXMZJ in", values, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjNotIn(List<String> values) {
            addCriterion("TBXMZJ not in", values, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjBetween(String value1, String value2) {
            addCriterion("TBXMZJ between", value1, value2, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andTbxmzjNotBetween(String value1, String value2) {
            addCriterion("TBXMZJ not between", value1, value2, "tbxmzj");
            return (Criteria) this;
        }

        public Criteria andBdzj00IsNull() {
            addCriterion("BDZJ00 is null");
            return (Criteria) this;
        }

        public Criteria andBdzj00IsNotNull() {
            addCriterion("BDZJ00 is not null");
            return (Criteria) this;
        }

        public Criteria andBdzj00EqualTo(String value) {
            addCriterion("BDZJ00 =", value, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00NotEqualTo(String value) {
            addCriterion("BDZJ00 <>", value, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00GreaterThan(String value) {
            addCriterion("BDZJ00 >", value, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00GreaterThanOrEqualTo(String value) {
            addCriterion("BDZJ00 >=", value, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00LessThan(String value) {
            addCriterion("BDZJ00 <", value, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00LessThanOrEqualTo(String value) {
            addCriterion("BDZJ00 <=", value, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00Like(String value) {
            addCriterion("BDZJ00 like", value, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00NotLike(String value) {
            addCriterion("BDZJ00 not like", value, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00In(List<String> values) {
            addCriterion("BDZJ00 in", values, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00NotIn(List<String> values) {
            addCriterion("BDZJ00 not in", values, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00Between(String value1, String value2) {
            addCriterion("BDZJ00 between", value1, value2, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andBdzj00NotBetween(String value1, String value2) {
            addCriterion("BDZJ00 not between", value1, value2, "bdzj00");
            return (Criteria) this;
        }

        public Criteria andFjdzqmIsNull() {
            addCriterion("FJDZQM is null");
            return (Criteria) this;
        }

        public Criteria andFjdzqmIsNotNull() {
            addCriterion("FJDZQM is not null");
            return (Criteria) this;
        }

        public Criteria andFjdzqmEqualTo(String value) {
            addCriterion("FJDZQM =", value, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmNotEqualTo(String value) {
            addCriterion("FJDZQM <>", value, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmGreaterThan(String value) {
            addCriterion("FJDZQM >", value, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmGreaterThanOrEqualTo(String value) {
            addCriterion("FJDZQM >=", value, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmLessThan(String value) {
            addCriterion("FJDZQM <", value, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmLessThanOrEqualTo(String value) {
            addCriterion("FJDZQM <=", value, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmLike(String value) {
            addCriterion("FJDZQM like", value, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmNotLike(String value) {
            addCriterion("FJDZQM not like", value, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmIn(List<String> values) {
            addCriterion("FJDZQM in", values, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmNotIn(List<String> values) {
            addCriterion("FJDZQM not in", values, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmBetween(String value1, String value2) {
            addCriterion("FJDZQM between", value1, value2, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andFjdzqmNotBetween(String value1, String value2) {
            addCriterion("FJDZQM not between", value1, value2, "fjdzqm");
            return (Criteria) this;
        }

        public Criteria andQmzsgyIsNull() {
            addCriterion("QMZSGY is null");
            return (Criteria) this;
        }

        public Criteria andQmzsgyIsNotNull() {
            addCriterion("QMZSGY is not null");
            return (Criteria) this;
        }

        public Criteria andQmzsgyEqualTo(String value) {
            addCriterion("QMZSGY =", value, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyNotEqualTo(String value) {
            addCriterion("QMZSGY <>", value, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyGreaterThan(String value) {
            addCriterion("QMZSGY >", value, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyGreaterThanOrEqualTo(String value) {
            addCriterion("QMZSGY >=", value, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyLessThan(String value) {
            addCriterion("QMZSGY <", value, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyLessThanOrEqualTo(String value) {
            addCriterion("QMZSGY <=", value, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyLike(String value) {
            addCriterion("QMZSGY like", value, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyNotLike(String value) {
            addCriterion("QMZSGY not like", value, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyIn(List<String> values) {
            addCriterion("QMZSGY in", values, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyNotIn(List<String> values) {
            addCriterion("QMZSGY not in", values, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyBetween(String value1, String value2) {
            addCriterion("QMZSGY between", value1, value2, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andQmzsgyNotBetween(String value1, String value2) {
            addCriterion("QMZSGY not between", value1, value2, "qmzsgy");
            return (Criteria) this;
        }

        public Criteria andIsDecryptIsNull() {
            addCriterion("IS_DECRYPT is null");
            return (Criteria) this;
        }

        public Criteria andIsDecryptIsNotNull() {
            addCriterion("IS_DECRYPT is not null");
            return (Criteria) this;
        }

        public Criteria andIsDecryptEqualTo(String value) {
            addCriterion("IS_DECRYPT =", value, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptNotEqualTo(String value) {
            addCriterion("IS_DECRYPT <>", value, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptGreaterThan(String value) {
            addCriterion("IS_DECRYPT >", value, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptGreaterThanOrEqualTo(String value) {
            addCriterion("IS_DECRYPT >=", value, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptLessThan(String value) {
            addCriterion("IS_DECRYPT <", value, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptLessThanOrEqualTo(String value) {
            addCriterion("IS_DECRYPT <=", value, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptLike(String value) {
            addCriterion("IS_DECRYPT like", value, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptNotLike(String value) {
            addCriterion("IS_DECRYPT not like", value, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptIn(List<String> values) {
            addCriterion("IS_DECRYPT in", values, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptNotIn(List<String> values) {
            addCriterion("IS_DECRYPT not in", values, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptBetween(String value1, String value2) {
            addCriterion("IS_DECRYPT between", value1, value2, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andIsDecryptNotBetween(String value1, String value2) {
            addCriterion("IS_DECRYPT not between", value1, value2, "isDecrypt");
            return (Criteria) this;
        }

        public Criteria andLengthIsNull() {
            addCriterion("LENGTH is null");
            return (Criteria) this;
        }

        public Criteria andLengthIsNotNull() {
            addCriterion("LENGTH is not null");
            return (Criteria) this;
        }

        public Criteria andLengthEqualTo(BigDecimal value) {
            addCriterion("LENGTH =", value, "length");
            return (Criteria) this;
        }

        public Criteria andLengthNotEqualTo(BigDecimal value) {
            addCriterion("LENGTH <>", value, "length");
            return (Criteria) this;
        }

        public Criteria andLengthGreaterThan(BigDecimal value) {
            addCriterion("LENGTH >", value, "length");
            return (Criteria) this;
        }

        public Criteria andLengthGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("LENGTH >=", value, "length");
            return (Criteria) this;
        }

        public Criteria andLengthLessThan(BigDecimal value) {
            addCriterion("LENGTH <", value, "length");
            return (Criteria) this;
        }

        public Criteria andLengthLessThanOrEqualTo(BigDecimal value) {
            addCriterion("LENGTH <=", value, "length");
            return (Criteria) this;
        }

        public Criteria andLengthIn(List<BigDecimal> values) {
            addCriterion("LENGTH in", values, "length");
            return (Criteria) this;
        }

        public Criteria andLengthNotIn(List<BigDecimal> values) {
            addCriterion("LENGTH not in", values, "length");
            return (Criteria) this;
        }

        public Criteria andLengthBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("LENGTH between", value1, value2, "length");
            return (Criteria) this;
        }

        public Criteria andLengthNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("LENGTH not between", value1, value2, "length");
            return (Criteria) this;
        }

        public Criteria andMd5IsNull() {
            addCriterion("MD5 is null");
            return (Criteria) this;
        }

        public Criteria andMd5IsNotNull() {
            addCriterion("MD5 is not null");
            return (Criteria) this;
        }

        public Criteria andMd5EqualTo(String value) {
            addCriterion("MD5 =", value, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5NotEqualTo(String value) {
            addCriterion("MD5 <>", value, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5GreaterThan(String value) {
            addCriterion("MD5 >", value, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5GreaterThanOrEqualTo(String value) {
            addCriterion("MD5 >=", value, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5LessThan(String value) {
            addCriterion("MD5 <", value, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5LessThanOrEqualTo(String value) {
            addCriterion("MD5 <=", value, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5Like(String value) {
            addCriterion("MD5 like", value, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5NotLike(String value) {
            addCriterion("MD5 not like", value, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5In(List<String> values) {
            addCriterion("MD5 in", values, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5NotIn(List<String> values) {
            addCriterion("MD5 not in", values, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5Between(String value1, String value2) {
            addCriterion("MD5 between", value1, value2, "md5");
            return (Criteria) this;
        }

        public Criteria andMd5NotBetween(String value1, String value2) {
            addCriterion("MD5 not between", value1, value2, "md5");
            return (Criteria) this;
        }

        public Criteria andExtendNameIsNull() {
            addCriterion("EXTEND_NAME is null");
            return (Criteria) this;
        }

        public Criteria andExtendNameIsNotNull() {
            addCriterion("EXTEND_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andExtendNameEqualTo(String value) {
            addCriterion("EXTEND_NAME =", value, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameNotEqualTo(String value) {
            addCriterion("EXTEND_NAME <>", value, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameGreaterThan(String value) {
            addCriterion("EXTEND_NAME >", value, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameGreaterThanOrEqualTo(String value) {
            addCriterion("EXTEND_NAME >=", value, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameLessThan(String value) {
            addCriterion("EXTEND_NAME <", value, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameLessThanOrEqualTo(String value) {
            addCriterion("EXTEND_NAME <=", value, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameLike(String value) {
            addCriterion("EXTEND_NAME like", value, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameNotLike(String value) {
            addCriterion("EXTEND_NAME not like", value, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameIn(List<String> values) {
            addCriterion("EXTEND_NAME in", values, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameNotIn(List<String> values) {
            addCriterion("EXTEND_NAME not in", values, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameBetween(String value1, String value2) {
            addCriterion("EXTEND_NAME between", value1, value2, "extendName");
            return (Criteria) this;
        }

        public Criteria andExtendNameNotBetween(String value1, String value2) {
            addCriterion("EXTEND_NAME not between", value1, value2, "extendName");
            return (Criteria) this;
        }

        public Criteria andPathIsNull() {
            addCriterion("PATH is null");
            return (Criteria) this;
        }

        public Criteria andPathIsNotNull() {
            addCriterion("PATH is not null");
            return (Criteria) this;
        }

        public Criteria andPathEqualTo(String value) {
            addCriterion("PATH =", value, "path");
            return (Criteria) this;
        }

        public Criteria andPathNotEqualTo(String value) {
            addCriterion("PATH <>", value, "path");
            return (Criteria) this;
        }

        public Criteria andPathGreaterThan(String value) {
            addCriterion("PATH >", value, "path");
            return (Criteria) this;
        }

        public Criteria andPathGreaterThanOrEqualTo(String value) {
            addCriterion("PATH >=", value, "path");
            return (Criteria) this;
        }

        public Criteria andPathLessThan(String value) {
            addCriterion("PATH <", value, "path");
            return (Criteria) this;
        }

        public Criteria andPathLessThanOrEqualTo(String value) {
            addCriterion("PATH <=", value, "path");
            return (Criteria) this;
        }

        public Criteria andPathLike(String value) {
            addCriterion("PATH like", value, "path");
            return (Criteria) this;
        }

        public Criteria andPathNotLike(String value) {
            addCriterion("PATH not like", value, "path");
            return (Criteria) this;
        }

        public Criteria andPathIn(List<String> values) {
            addCriterion("PATH in", values, "path");
            return (Criteria) this;
        }

        public Criteria andPathNotIn(List<String> values) {
            addCriterion("PATH not in", values, "path");
            return (Criteria) this;
        }

        public Criteria andPathBetween(String value1, String value2) {
            addCriterion("PATH between", value1, value2, "path");
            return (Criteria) this;
        }

        public Criteria andPathNotBetween(String value1, String value2) {
            addCriterion("PATH not between", value1, value2, "path");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderIsNull() {
            addCriterion("ENVELOPE_TYPE_ORDER is null");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderIsNotNull() {
            addCriterion("ENVELOPE_TYPE_ORDER is not null");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderEqualTo(String value) {
            addCriterion("ENVELOPE_TYPE_ORDER =", value, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderNotEqualTo(String value) {
            addCriterion("ENVELOPE_TYPE_ORDER <>", value, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderGreaterThan(String value) {
            addCriterion("ENVELOPE_TYPE_ORDER >", value, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderGreaterThanOrEqualTo(String value) {
            addCriterion("ENVELOPE_TYPE_ORDER >=", value, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderLessThan(String value) {
            addCriterion("ENVELOPE_TYPE_ORDER <", value, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderLessThanOrEqualTo(String value) {
            addCriterion("ENVELOPE_TYPE_ORDER <=", value, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderLike(String value) {
            addCriterion("ENVELOPE_TYPE_ORDER like", value, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderNotLike(String value) {
            addCriterion("ENVELOPE_TYPE_ORDER not like", value, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderIn(List<String> values) {
            addCriterion("ENVELOPE_TYPE_ORDER in", values, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderNotIn(List<String> values) {
            addCriterion("ENVELOPE_TYPE_ORDER not in", values, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderBetween(String value1, String value2) {
            addCriterion("ENVELOPE_TYPE_ORDER between", value1, value2, "envelopeTypeOrder");
            return (Criteria) this;
        }

        public Criteria andEnvelopeTypeOrderNotBetween(String value1, String value2) {
            addCriterion("ENVELOPE_TYPE_ORDER not between", value1, value2, "envelopeTypeOrder");
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