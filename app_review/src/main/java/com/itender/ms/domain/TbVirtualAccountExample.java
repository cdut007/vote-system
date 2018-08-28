package com.itender.ms.domain;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TbVirtualAccountExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public TbVirtualAccountExample() {
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

        public Criteria andAccountNumberIsNull() {
            addCriterion("ACCOUNT_NUMBER is null");
            return (Criteria) this;
        }

        public Criteria andAccountNumberIsNotNull() {
            addCriterion("ACCOUNT_NUMBER is not null");
            return (Criteria) this;
        }

        public Criteria andAccountNumberEqualTo(String value) {
            addCriterion("ACCOUNT_NUMBER =", value, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberNotEqualTo(String value) {
            addCriterion("ACCOUNT_NUMBER <>", value, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberGreaterThan(String value) {
            addCriterion("ACCOUNT_NUMBER >", value, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberGreaterThanOrEqualTo(String value) {
            addCriterion("ACCOUNT_NUMBER >=", value, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberLessThan(String value) {
            addCriterion("ACCOUNT_NUMBER <", value, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberLessThanOrEqualTo(String value) {
            addCriterion("ACCOUNT_NUMBER <=", value, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberLike(String value) {
            addCriterion("ACCOUNT_NUMBER like", value, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberNotLike(String value) {
            addCriterion("ACCOUNT_NUMBER not like", value, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberIn(List<String> values) {
            addCriterion("ACCOUNT_NUMBER in", values, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberNotIn(List<String> values) {
            addCriterion("ACCOUNT_NUMBER not in", values, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberBetween(String value1, String value2) {
            addCriterion("ACCOUNT_NUMBER between", value1, value2, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNumberNotBetween(String value1, String value2) {
            addCriterion("ACCOUNT_NUMBER not between", value1, value2, "accountNumber");
            return (Criteria) this;
        }

        public Criteria andAccountNameIsNull() {
            addCriterion("ACCOUNT_NAME is null");
            return (Criteria) this;
        }

        public Criteria andAccountNameIsNotNull() {
            addCriterion("ACCOUNT_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andAccountNameEqualTo(String value) {
            addCriterion("ACCOUNT_NAME =", value, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameNotEqualTo(String value) {
            addCriterion("ACCOUNT_NAME <>", value, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameGreaterThan(String value) {
            addCriterion("ACCOUNT_NAME >", value, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameGreaterThanOrEqualTo(String value) {
            addCriterion("ACCOUNT_NAME >=", value, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameLessThan(String value) {
            addCriterion("ACCOUNT_NAME <", value, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameLessThanOrEqualTo(String value) {
            addCriterion("ACCOUNT_NAME <=", value, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameLike(String value) {
            addCriterion("ACCOUNT_NAME like", value, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameNotLike(String value) {
            addCriterion("ACCOUNT_NAME not like", value, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameIn(List<String> values) {
            addCriterion("ACCOUNT_NAME in", values, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameNotIn(List<String> values) {
            addCriterion("ACCOUNT_NAME not in", values, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameBetween(String value1, String value2) {
            addCriterion("ACCOUNT_NAME between", value1, value2, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountNameNotBetween(String value1, String value2) {
            addCriterion("ACCOUNT_NAME not between", value1, value2, "accountName");
            return (Criteria) this;
        }

        public Criteria andAccountStatusIsNull() {
            addCriterion("ACCOUNT_STATUS is null");
            return (Criteria) this;
        }

        public Criteria andAccountStatusIsNotNull() {
            addCriterion("ACCOUNT_STATUS is not null");
            return (Criteria) this;
        }

        public Criteria andAccountStatusEqualTo(String value) {
            addCriterion("ACCOUNT_STATUS =", value, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusNotEqualTo(String value) {
            addCriterion("ACCOUNT_STATUS <>", value, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusGreaterThan(String value) {
            addCriterion("ACCOUNT_STATUS >", value, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusGreaterThanOrEqualTo(String value) {
            addCriterion("ACCOUNT_STATUS >=", value, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusLessThan(String value) {
            addCriterion("ACCOUNT_STATUS <", value, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusLessThanOrEqualTo(String value) {
            addCriterion("ACCOUNT_STATUS <=", value, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusLike(String value) {
            addCriterion("ACCOUNT_STATUS like", value, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusNotLike(String value) {
            addCriterion("ACCOUNT_STATUS not like", value, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusIn(List<String> values) {
            addCriterion("ACCOUNT_STATUS in", values, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusNotIn(List<String> values) {
            addCriterion("ACCOUNT_STATUS not in", values, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusBetween(String value1, String value2) {
            addCriterion("ACCOUNT_STATUS between", value1, value2, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountStatusNotBetween(String value1, String value2) {
            addCriterion("ACCOUNT_STATUS not between", value1, value2, "accountStatus");
            return (Criteria) this;
        }

        public Criteria andAccountTypeIsNull() {
            addCriterion("ACCOUNT_TYPE is null");
            return (Criteria) this;
        }

        public Criteria andAccountTypeIsNotNull() {
            addCriterion("ACCOUNT_TYPE is not null");
            return (Criteria) this;
        }

        public Criteria andAccountTypeEqualTo(String value) {
            addCriterion("ACCOUNT_TYPE =", value, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeNotEqualTo(String value) {
            addCriterion("ACCOUNT_TYPE <>", value, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeGreaterThan(String value) {
            addCriterion("ACCOUNT_TYPE >", value, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeGreaterThanOrEqualTo(String value) {
            addCriterion("ACCOUNT_TYPE >=", value, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeLessThan(String value) {
            addCriterion("ACCOUNT_TYPE <", value, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeLessThanOrEqualTo(String value) {
            addCriterion("ACCOUNT_TYPE <=", value, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeLike(String value) {
            addCriterion("ACCOUNT_TYPE like", value, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeNotLike(String value) {
            addCriterion("ACCOUNT_TYPE not like", value, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeIn(List<String> values) {
            addCriterion("ACCOUNT_TYPE in", values, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeNotIn(List<String> values) {
            addCriterion("ACCOUNT_TYPE not in", values, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeBetween(String value1, String value2) {
            addCriterion("ACCOUNT_TYPE between", value1, value2, "accountType");
            return (Criteria) this;
        }

        public Criteria andAccountTypeNotBetween(String value1, String value2) {
            addCriterion("ACCOUNT_TYPE not between", value1, value2, "accountType");
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

        public Criteria andOrganAIdIsNull() {
            addCriterion("ORGAN_A_ID is null");
            return (Criteria) this;
        }

        public Criteria andOrganAIdIsNotNull() {
            addCriterion("ORGAN_A_ID is not null");
            return (Criteria) this;
        }

        public Criteria andOrganAIdEqualTo(String value) {
            addCriterion("ORGAN_A_ID =", value, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdNotEqualTo(String value) {
            addCriterion("ORGAN_A_ID <>", value, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdGreaterThan(String value) {
            addCriterion("ORGAN_A_ID >", value, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdGreaterThanOrEqualTo(String value) {
            addCriterion("ORGAN_A_ID >=", value, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdLessThan(String value) {
            addCriterion("ORGAN_A_ID <", value, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdLessThanOrEqualTo(String value) {
            addCriterion("ORGAN_A_ID <=", value, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdLike(String value) {
            addCriterion("ORGAN_A_ID like", value, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdNotLike(String value) {
            addCriterion("ORGAN_A_ID not like", value, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdIn(List<String> values) {
            addCriterion("ORGAN_A_ID in", values, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdNotIn(List<String> values) {
            addCriterion("ORGAN_A_ID not in", values, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdBetween(String value1, String value2) {
            addCriterion("ORGAN_A_ID between", value1, value2, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganAIdNotBetween(String value1, String value2) {
            addCriterion("ORGAN_A_ID not between", value1, value2, "organAId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdIsNull() {
            addCriterion("ORGAN_B_ID is null");
            return (Criteria) this;
        }

        public Criteria andOrganBIdIsNotNull() {
            addCriterion("ORGAN_B_ID is not null");
            return (Criteria) this;
        }

        public Criteria andOrganBIdEqualTo(String value) {
            addCriterion("ORGAN_B_ID =", value, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdNotEqualTo(String value) {
            addCriterion("ORGAN_B_ID <>", value, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdGreaterThan(String value) {
            addCriterion("ORGAN_B_ID >", value, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdGreaterThanOrEqualTo(String value) {
            addCriterion("ORGAN_B_ID >=", value, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdLessThan(String value) {
            addCriterion("ORGAN_B_ID <", value, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdLessThanOrEqualTo(String value) {
            addCriterion("ORGAN_B_ID <=", value, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdLike(String value) {
            addCriterion("ORGAN_B_ID like", value, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdNotLike(String value) {
            addCriterion("ORGAN_B_ID not like", value, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdIn(List<String> values) {
            addCriterion("ORGAN_B_ID in", values, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdNotIn(List<String> values) {
            addCriterion("ORGAN_B_ID not in", values, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdBetween(String value1, String value2) {
            addCriterion("ORGAN_B_ID between", value1, value2, "organBId");
            return (Criteria) this;
        }

        public Criteria andOrganBIdNotBetween(String value1, String value2) {
            addCriterion("ORGAN_B_ID not between", value1, value2, "organBId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdIsNull() {
            addCriterion("PROJECT_INSTANCE_ID is null");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdIsNotNull() {
            addCriterion("PROJECT_INSTANCE_ID is not null");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdEqualTo(String value) {
            addCriterion("PROJECT_INSTANCE_ID =", value, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdNotEqualTo(String value) {
            addCriterion("PROJECT_INSTANCE_ID <>", value, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdGreaterThan(String value) {
            addCriterion("PROJECT_INSTANCE_ID >", value, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdGreaterThanOrEqualTo(String value) {
            addCriterion("PROJECT_INSTANCE_ID >=", value, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdLessThan(String value) {
            addCriterion("PROJECT_INSTANCE_ID <", value, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdLessThanOrEqualTo(String value) {
            addCriterion("PROJECT_INSTANCE_ID <=", value, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdLike(String value) {
            addCriterion("PROJECT_INSTANCE_ID like", value, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdNotLike(String value) {
            addCriterion("PROJECT_INSTANCE_ID not like", value, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdIn(List<String> values) {
            addCriterion("PROJECT_INSTANCE_ID in", values, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdNotIn(List<String> values) {
            addCriterion("PROJECT_INSTANCE_ID not in", values, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdBetween(String value1, String value2) {
            addCriterion("PROJECT_INSTANCE_ID between", value1, value2, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectInstanceIdNotBetween(String value1, String value2) {
            addCriterion("PROJECT_INSTANCE_ID not between", value1, value2, "projectInstanceId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdIsNull() {
            addCriterion("PROJECT_ITEM_ID is null");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdIsNotNull() {
            addCriterion("PROJECT_ITEM_ID is not null");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdEqualTo(String value) {
            addCriterion("PROJECT_ITEM_ID =", value, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdNotEqualTo(String value) {
            addCriterion("PROJECT_ITEM_ID <>", value, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdGreaterThan(String value) {
            addCriterion("PROJECT_ITEM_ID >", value, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdGreaterThanOrEqualTo(String value) {
            addCriterion("PROJECT_ITEM_ID >=", value, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdLessThan(String value) {
            addCriterion("PROJECT_ITEM_ID <", value, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdLessThanOrEqualTo(String value) {
            addCriterion("PROJECT_ITEM_ID <=", value, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdLike(String value) {
            addCriterion("PROJECT_ITEM_ID like", value, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdNotLike(String value) {
            addCriterion("PROJECT_ITEM_ID not like", value, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdIn(List<String> values) {
            addCriterion("PROJECT_ITEM_ID in", values, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdNotIn(List<String> values) {
            addCriterion("PROJECT_ITEM_ID not in", values, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdBetween(String value1, String value2) {
            addCriterion("PROJECT_ITEM_ID between", value1, value2, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andProjectItemIdNotBetween(String value1, String value2) {
            addCriterion("PROJECT_ITEM_ID not between", value1, value2, "projectItemId");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameIsNull() {
            addCriterion("ALIAS_ACCOUNT_NAME is null");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameIsNotNull() {
            addCriterion("ALIAS_ACCOUNT_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameEqualTo(String value) {
            addCriterion("ALIAS_ACCOUNT_NAME =", value, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameNotEqualTo(String value) {
            addCriterion("ALIAS_ACCOUNT_NAME <>", value, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameGreaterThan(String value) {
            addCriterion("ALIAS_ACCOUNT_NAME >", value, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameGreaterThanOrEqualTo(String value) {
            addCriterion("ALIAS_ACCOUNT_NAME >=", value, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameLessThan(String value) {
            addCriterion("ALIAS_ACCOUNT_NAME <", value, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameLessThanOrEqualTo(String value) {
            addCriterion("ALIAS_ACCOUNT_NAME <=", value, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameLike(String value) {
            addCriterion("ALIAS_ACCOUNT_NAME like", value, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameNotLike(String value) {
            addCriterion("ALIAS_ACCOUNT_NAME not like", value, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameIn(List<String> values) {
            addCriterion("ALIAS_ACCOUNT_NAME in", values, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameNotIn(List<String> values) {
            addCriterion("ALIAS_ACCOUNT_NAME not in", values, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameBetween(String value1, String value2) {
            addCriterion("ALIAS_ACCOUNT_NAME between", value1, value2, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andAliasAccountNameNotBetween(String value1, String value2) {
            addCriterion("ALIAS_ACCOUNT_NAME not between", value1, value2, "aliasAccountName");
            return (Criteria) this;
        }

        public Criteria andCloseTimeIsNull() {
            addCriterion("CLOSE_TIME is null");
            return (Criteria) this;
        }

        public Criteria andCloseTimeIsNotNull() {
            addCriterion("CLOSE_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andCloseTimeEqualTo(Date value) {
            addCriterion("CLOSE_TIME =", value, "closeTime");
            return (Criteria) this;
        }

        public Criteria andCloseTimeNotEqualTo(Date value) {
            addCriterion("CLOSE_TIME <>", value, "closeTime");
            return (Criteria) this;
        }

        public Criteria andCloseTimeGreaterThan(Date value) {
            addCriterion("CLOSE_TIME >", value, "closeTime");
            return (Criteria) this;
        }

        public Criteria andCloseTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("CLOSE_TIME >=", value, "closeTime");
            return (Criteria) this;
        }

        public Criteria andCloseTimeLessThan(Date value) {
            addCriterion("CLOSE_TIME <", value, "closeTime");
            return (Criteria) this;
        }

        public Criteria andCloseTimeLessThanOrEqualTo(Date value) {
            addCriterion("CLOSE_TIME <=", value, "closeTime");
            return (Criteria) this;
        }

        public Criteria andCloseTimeIn(List<Date> values) {
            addCriterion("CLOSE_TIME in", values, "closeTime");
            return (Criteria) this;
        }

        public Criteria andCloseTimeNotIn(List<Date> values) {
            addCriterion("CLOSE_TIME not in", values, "closeTime");
            return (Criteria) this;
        }

        public Criteria andCloseTimeBetween(Date value1, Date value2) {
            addCriterion("CLOSE_TIME between", value1, value2, "closeTime");
            return (Criteria) this;
        }

        public Criteria andCloseTimeNotBetween(Date value1, Date value2) {
            addCriterion("CLOSE_TIME not between", value1, value2, "closeTime");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoIsNull() {
            addCriterion("MAIN_ACCOUNT_NO is null");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoIsNotNull() {
            addCriterion("MAIN_ACCOUNT_NO is not null");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoEqualTo(String value) {
            addCriterion("MAIN_ACCOUNT_NO =", value, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoNotEqualTo(String value) {
            addCriterion("MAIN_ACCOUNT_NO <>", value, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoGreaterThan(String value) {
            addCriterion("MAIN_ACCOUNT_NO >", value, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoGreaterThanOrEqualTo(String value) {
            addCriterion("MAIN_ACCOUNT_NO >=", value, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoLessThan(String value) {
            addCriterion("MAIN_ACCOUNT_NO <", value, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoLessThanOrEqualTo(String value) {
            addCriterion("MAIN_ACCOUNT_NO <=", value, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoLike(String value) {
            addCriterion("MAIN_ACCOUNT_NO like", value, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoNotLike(String value) {
            addCriterion("MAIN_ACCOUNT_NO not like", value, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoIn(List<String> values) {
            addCriterion("MAIN_ACCOUNT_NO in", values, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoNotIn(List<String> values) {
            addCriterion("MAIN_ACCOUNT_NO not in", values, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoBetween(String value1, String value2) {
            addCriterion("MAIN_ACCOUNT_NO between", value1, value2, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andMainAccountNoNotBetween(String value1, String value2) {
            addCriterion("MAIN_ACCOUNT_NO not between", value1, value2, "mainAccountNo");
            return (Criteria) this;
        }

        public Criteria andOrganANameIsNull() {
            addCriterion("ORGAN_A_NAME is null");
            return (Criteria) this;
        }

        public Criteria andOrganANameIsNotNull() {
            addCriterion("ORGAN_A_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andOrganANameEqualTo(String value) {
            addCriterion("ORGAN_A_NAME =", value, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameNotEqualTo(String value) {
            addCriterion("ORGAN_A_NAME <>", value, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameGreaterThan(String value) {
            addCriterion("ORGAN_A_NAME >", value, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameGreaterThanOrEqualTo(String value) {
            addCriterion("ORGAN_A_NAME >=", value, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameLessThan(String value) {
            addCriterion("ORGAN_A_NAME <", value, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameLessThanOrEqualTo(String value) {
            addCriterion("ORGAN_A_NAME <=", value, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameLike(String value) {
            addCriterion("ORGAN_A_NAME like", value, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameNotLike(String value) {
            addCriterion("ORGAN_A_NAME not like", value, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameIn(List<String> values) {
            addCriterion("ORGAN_A_NAME in", values, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameNotIn(List<String> values) {
            addCriterion("ORGAN_A_NAME not in", values, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameBetween(String value1, String value2) {
            addCriterion("ORGAN_A_NAME between", value1, value2, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganANameNotBetween(String value1, String value2) {
            addCriterion("ORGAN_A_NAME not between", value1, value2, "organAName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameIsNull() {
            addCriterion("ORGAN_B_NAME is null");
            return (Criteria) this;
        }

        public Criteria andOrganBNameIsNotNull() {
            addCriterion("ORGAN_B_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andOrganBNameEqualTo(String value) {
            addCriterion("ORGAN_B_NAME =", value, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameNotEqualTo(String value) {
            addCriterion("ORGAN_B_NAME <>", value, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameGreaterThan(String value) {
            addCriterion("ORGAN_B_NAME >", value, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameGreaterThanOrEqualTo(String value) {
            addCriterion("ORGAN_B_NAME >=", value, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameLessThan(String value) {
            addCriterion("ORGAN_B_NAME <", value, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameLessThanOrEqualTo(String value) {
            addCriterion("ORGAN_B_NAME <=", value, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameLike(String value) {
            addCriterion("ORGAN_B_NAME like", value, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameNotLike(String value) {
            addCriterion("ORGAN_B_NAME not like", value, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameIn(List<String> values) {
            addCriterion("ORGAN_B_NAME in", values, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameNotIn(List<String> values) {
            addCriterion("ORGAN_B_NAME not in", values, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameBetween(String value1, String value2) {
            addCriterion("ORGAN_B_NAME between", value1, value2, "organBName");
            return (Criteria) this;
        }

        public Criteria andOrganBNameNotBetween(String value1, String value2) {
            addCriterion("ORGAN_B_NAME not between", value1, value2, "organBName");
            return (Criteria) this;
        }

        public Criteria andBankNameIsNull() {
            addCriterion("BANK_NAME is null");
            return (Criteria) this;
        }

        public Criteria andBankNameIsNotNull() {
            addCriterion("BANK_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andBankNameEqualTo(String value) {
            addCriterion("BANK_NAME =", value, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameNotEqualTo(String value) {
            addCriterion("BANK_NAME <>", value, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameGreaterThan(String value) {
            addCriterion("BANK_NAME >", value, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameGreaterThanOrEqualTo(String value) {
            addCriterion("BANK_NAME >=", value, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameLessThan(String value) {
            addCriterion("BANK_NAME <", value, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameLessThanOrEqualTo(String value) {
            addCriterion("BANK_NAME <=", value, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameLike(String value) {
            addCriterion("BANK_NAME like", value, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameNotLike(String value) {
            addCriterion("BANK_NAME not like", value, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameIn(List<String> values) {
            addCriterion("BANK_NAME in", values, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameNotIn(List<String> values) {
            addCriterion("BANK_NAME not in", values, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameBetween(String value1, String value2) {
            addCriterion("BANK_NAME between", value1, value2, "bankName");
            return (Criteria) this;
        }

        public Criteria andBankNameNotBetween(String value1, String value2) {
            addCriterion("BANK_NAME not between", value1, value2, "bankName");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoIsNull() {
            addCriterion("UNION_BANK_NO is null");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoIsNotNull() {
            addCriterion("UNION_BANK_NO is not null");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoEqualTo(String value) {
            addCriterion("UNION_BANK_NO =", value, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoNotEqualTo(String value) {
            addCriterion("UNION_BANK_NO <>", value, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoGreaterThan(String value) {
            addCriterion("UNION_BANK_NO >", value, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoGreaterThanOrEqualTo(String value) {
            addCriterion("UNION_BANK_NO >=", value, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoLessThan(String value) {
            addCriterion("UNION_BANK_NO <", value, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoLessThanOrEqualTo(String value) {
            addCriterion("UNION_BANK_NO <=", value, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoLike(String value) {
            addCriterion("UNION_BANK_NO like", value, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoNotLike(String value) {
            addCriterion("UNION_BANK_NO not like", value, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoIn(List<String> values) {
            addCriterion("UNION_BANK_NO in", values, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoNotIn(List<String> values) {
            addCriterion("UNION_BANK_NO not in", values, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoBetween(String value1, String value2) {
            addCriterion("UNION_BANK_NO between", value1, value2, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andUnionBankNoNotBetween(String value1, String value2) {
            addCriterion("UNION_BANK_NO not between", value1, value2, "unionBankNo");
            return (Criteria) this;
        }

        public Criteria andIsLogoutIsNull() {
            addCriterion("IS_LOGOUT is null");
            return (Criteria) this;
        }

        public Criteria andIsLogoutIsNotNull() {
            addCriterion("IS_LOGOUT is not null");
            return (Criteria) this;
        }

        public Criteria andIsLogoutEqualTo(BigDecimal value) {
            addCriterion("IS_LOGOUT =", value, "isLogout");
            return (Criteria) this;
        }

        public Criteria andIsLogoutNotEqualTo(BigDecimal value) {
            addCriterion("IS_LOGOUT <>", value, "isLogout");
            return (Criteria) this;
        }

        public Criteria andIsLogoutGreaterThan(BigDecimal value) {
            addCriterion("IS_LOGOUT >", value, "isLogout");
            return (Criteria) this;
        }

        public Criteria andIsLogoutGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("IS_LOGOUT >=", value, "isLogout");
            return (Criteria) this;
        }

        public Criteria andIsLogoutLessThan(BigDecimal value) {
            addCriterion("IS_LOGOUT <", value, "isLogout");
            return (Criteria) this;
        }

        public Criteria andIsLogoutLessThanOrEqualTo(BigDecimal value) {
            addCriterion("IS_LOGOUT <=", value, "isLogout");
            return (Criteria) this;
        }

        public Criteria andIsLogoutIn(List<BigDecimal> values) {
            addCriterion("IS_LOGOUT in", values, "isLogout");
            return (Criteria) this;
        }

        public Criteria andIsLogoutNotIn(List<BigDecimal> values) {
            addCriterion("IS_LOGOUT not in", values, "isLogout");
            return (Criteria) this;
        }

        public Criteria andIsLogoutBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("IS_LOGOUT between", value1, value2, "isLogout");
            return (Criteria) this;
        }

        public Criteria andIsLogoutNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("IS_LOGOUT not between", value1, value2, "isLogout");
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