package com.itender.ms.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 
 */
public class TbVirtualAccount implements Serializable {
    private String accountNumber;

    private String accountName;

    private String accountStatus;

    private String accountType;

    private Date createTime;

    private String organAId;

    private String organBId;

    private String projectInstanceId;

    private String projectItemId;

    private String aliasAccountName;

    private Date closeTime;

    private String mainAccountNo;

    private String organAName;

    private String organBName;

    private String bankName;

    private String unionBankNo;

    private BigDecimal isLogout;

    private static final long serialVersionUID = 1L;

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(String accountStatus) {
        this.accountStatus = accountStatus;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getOrganAId() {
        return organAId;
    }

    public void setOrganAId(String organAId) {
        this.organAId = organAId;
    }

    public String getOrganBId() {
        return organBId;
    }

    public void setOrganBId(String organBId) {
        this.organBId = organBId;
    }

    public String getProjectInstanceId() {
        return projectInstanceId;
    }

    public void setProjectInstanceId(String projectInstanceId) {
        this.projectInstanceId = projectInstanceId;
    }

    public String getProjectItemId() {
        return projectItemId;
    }

    public void setProjectItemId(String projectItemId) {
        this.projectItemId = projectItemId;
    }

    public String getAliasAccountName() {
        return aliasAccountName;
    }

    public void setAliasAccountName(String aliasAccountName) {
        this.aliasAccountName = aliasAccountName;
    }

    public Date getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(Date closeTime) {
        this.closeTime = closeTime;
    }

    public String getMainAccountNo() {
        return mainAccountNo;
    }

    public void setMainAccountNo(String mainAccountNo) {
        this.mainAccountNo = mainAccountNo;
    }

    public String getOrganAName() {
        return organAName;
    }

    public void setOrganAName(String organAName) {
        this.organAName = organAName;
    }

    public String getOrganBName() {
        return organBName;
    }

    public void setOrganBName(String organBName) {
        this.organBName = organBName;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getUnionBankNo() {
        return unionBankNo;
    }

    public void setUnionBankNo(String unionBankNo) {
        this.unionBankNo = unionBankNo;
    }

    public BigDecimal getIsLogout() {
        return isLogout;
    }

    public void setIsLogout(BigDecimal isLogout) {
        this.isLogout = isLogout;
    }

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        TbVirtualAccount other = (TbVirtualAccount) that;
        return (this.getAccountNumber() == null ? other.getAccountNumber() == null : this.getAccountNumber().equals(other.getAccountNumber()))
            && (this.getAccountName() == null ? other.getAccountName() == null : this.getAccountName().equals(other.getAccountName()))
            && (this.getAccountStatus() == null ? other.getAccountStatus() == null : this.getAccountStatus().equals(other.getAccountStatus()))
            && (this.getAccountType() == null ? other.getAccountType() == null : this.getAccountType().equals(other.getAccountType()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getOrganAId() == null ? other.getOrganAId() == null : this.getOrganAId().equals(other.getOrganAId()))
            && (this.getOrganBId() == null ? other.getOrganBId() == null : this.getOrganBId().equals(other.getOrganBId()))
            && (this.getProjectInstanceId() == null ? other.getProjectInstanceId() == null : this.getProjectInstanceId().equals(other.getProjectInstanceId()))
            && (this.getProjectItemId() == null ? other.getProjectItemId() == null : this.getProjectItemId().equals(other.getProjectItemId()))
            && (this.getAliasAccountName() == null ? other.getAliasAccountName() == null : this.getAliasAccountName().equals(other.getAliasAccountName()))
            && (this.getCloseTime() == null ? other.getCloseTime() == null : this.getCloseTime().equals(other.getCloseTime()))
            && (this.getMainAccountNo() == null ? other.getMainAccountNo() == null : this.getMainAccountNo().equals(other.getMainAccountNo()))
            && (this.getOrganAName() == null ? other.getOrganAName() == null : this.getOrganAName().equals(other.getOrganAName()))
            && (this.getOrganBName() == null ? other.getOrganBName() == null : this.getOrganBName().equals(other.getOrganBName()))
            && (this.getBankName() == null ? other.getBankName() == null : this.getBankName().equals(other.getBankName()))
            && (this.getUnionBankNo() == null ? other.getUnionBankNo() == null : this.getUnionBankNo().equals(other.getUnionBankNo()))
            && (this.getIsLogout() == null ? other.getIsLogout() == null : this.getIsLogout().equals(other.getIsLogout()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getAccountNumber() == null) ? 0 : getAccountNumber().hashCode());
        result = prime * result + ((getAccountName() == null) ? 0 : getAccountName().hashCode());
        result = prime * result + ((getAccountStatus() == null) ? 0 : getAccountStatus().hashCode());
        result = prime * result + ((getAccountType() == null) ? 0 : getAccountType().hashCode());
        result = prime * result + ((getCreateTime() == null) ? 0 : getCreateTime().hashCode());
        result = prime * result + ((getOrganAId() == null) ? 0 : getOrganAId().hashCode());
        result = prime * result + ((getOrganBId() == null) ? 0 : getOrganBId().hashCode());
        result = prime * result + ((getProjectInstanceId() == null) ? 0 : getProjectInstanceId().hashCode());
        result = prime * result + ((getProjectItemId() == null) ? 0 : getProjectItemId().hashCode());
        result = prime * result + ((getAliasAccountName() == null) ? 0 : getAliasAccountName().hashCode());
        result = prime * result + ((getCloseTime() == null) ? 0 : getCloseTime().hashCode());
        result = prime * result + ((getMainAccountNo() == null) ? 0 : getMainAccountNo().hashCode());
        result = prime * result + ((getOrganAName() == null) ? 0 : getOrganAName().hashCode());
        result = prime * result + ((getOrganBName() == null) ? 0 : getOrganBName().hashCode());
        result = prime * result + ((getBankName() == null) ? 0 : getBankName().hashCode());
        result = prime * result + ((getUnionBankNo() == null) ? 0 : getUnionBankNo().hashCode());
        result = prime * result + ((getIsLogout() == null) ? 0 : getIsLogout().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", accountNumber=").append(accountNumber);
        sb.append(", accountName=").append(accountName);
        sb.append(", accountStatus=").append(accountStatus);
        sb.append(", accountType=").append(accountType);
        sb.append(", createTime=").append(createTime);
        sb.append(", organAId=").append(organAId);
        sb.append(", organBId=").append(organBId);
        sb.append(", projectInstanceId=").append(projectInstanceId);
        sb.append(", projectItemId=").append(projectItemId);
        sb.append(", aliasAccountName=").append(aliasAccountName);
        sb.append(", closeTime=").append(closeTime);
        sb.append(", mainAccountNo=").append(mainAccountNo);
        sb.append(", organAName=").append(organAName);
        sb.append(", organBName=").append(organBName);
        sb.append(", bankName=").append(bankName);
        sb.append(", unionBankNo=").append(unionBankNo);
        sb.append(", isLogout=").append(isLogout);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}