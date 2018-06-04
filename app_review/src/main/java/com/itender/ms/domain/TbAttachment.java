package com.itender.ms.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 
 */
public class TbAttachment implements Serializable {
    private String fjid00;

    private Date uploadTime;

    private String fjmc00;

    private String fjgslx;

    private String fjlx00;

    private String fjsszt;

    private String uploadUserId;

    private String tbxmzj;

    private String bdzj00;

    private String fjdzqm;

    private String qmzsgy;

    private String isDecrypt;

    private BigDecimal length;

    private String md5;

    private String extendName;

    private String path;

    private String envelopeTypeOrder;

    private static final long serialVersionUID = 1L;

    public String getFjid00() {
        return fjid00;
    }

    public void setFjid00(String fjid00) {
        this.fjid00 = fjid00;
    }

    public Date getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
    }

    public String getFjmc00() {
        return fjmc00;
    }

    public void setFjmc00(String fjmc00) {
        this.fjmc00 = fjmc00;
    }

    public String getFjgslx() {
        return fjgslx;
    }

    public void setFjgslx(String fjgslx) {
        this.fjgslx = fjgslx;
    }

    public String getFjlx00() {
        return fjlx00;
    }

    public void setFjlx00(String fjlx00) {
        this.fjlx00 = fjlx00;
    }

    public String getFjsszt() {
        return fjsszt;
    }

    public void setFjsszt(String fjsszt) {
        this.fjsszt = fjsszt;
    }

    public String getUploadUserId() {
        return uploadUserId;
    }

    public void setUploadUserId(String uploadUserId) {
        this.uploadUserId = uploadUserId;
    }

    public String getTbxmzj() {
        return tbxmzj;
    }

    public void setTbxmzj(String tbxmzj) {
        this.tbxmzj = tbxmzj;
    }

    public String getBdzj00() {
        return bdzj00;
    }

    public void setBdzj00(String bdzj00) {
        this.bdzj00 = bdzj00;
    }

    public String getFjdzqm() {
        return fjdzqm;
    }

    public void setFjdzqm(String fjdzqm) {
        this.fjdzqm = fjdzqm;
    }

    public String getQmzsgy() {
        return qmzsgy;
    }

    public void setQmzsgy(String qmzsgy) {
        this.qmzsgy = qmzsgy;
    }

    public String getIsDecrypt() {
        return isDecrypt;
    }

    public void setIsDecrypt(String isDecrypt) {
        this.isDecrypt = isDecrypt;
    }

    public BigDecimal getLength() {
        return length;
    }

    public void setLength(BigDecimal length) {
        this.length = length;
    }

    public String getMd5() {
        return md5;
    }

    public void setMd5(String md5) {
        this.md5 = md5;
    }

    public String getExtendName() {
        return extendName;
    }

    public void setExtendName(String extendName) {
        this.extendName = extendName;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getEnvelopeTypeOrder() {
        return envelopeTypeOrder;
    }

    public void setEnvelopeTypeOrder(String envelopeTypeOrder) {
        this.envelopeTypeOrder = envelopeTypeOrder;
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
        TbAttachment other = (TbAttachment) that;
        return (this.getFjid00() == null ? other.getFjid00() == null : this.getFjid00().equals(other.getFjid00()))
            && (this.getUploadTime() == null ? other.getUploadTime() == null : this.getUploadTime().equals(other.getUploadTime()))
            && (this.getFjmc00() == null ? other.getFjmc00() == null : this.getFjmc00().equals(other.getFjmc00()))
            && (this.getFjgslx() == null ? other.getFjgslx() == null : this.getFjgslx().equals(other.getFjgslx()))
            && (this.getFjlx00() == null ? other.getFjlx00() == null : this.getFjlx00().equals(other.getFjlx00()))
            && (this.getFjsszt() == null ? other.getFjsszt() == null : this.getFjsszt().equals(other.getFjsszt()))
            && (this.getUploadUserId() == null ? other.getUploadUserId() == null : this.getUploadUserId().equals(other.getUploadUserId()))
            && (this.getTbxmzj() == null ? other.getTbxmzj() == null : this.getTbxmzj().equals(other.getTbxmzj()))
            && (this.getBdzj00() == null ? other.getBdzj00() == null : this.getBdzj00().equals(other.getBdzj00()))
            && (this.getFjdzqm() == null ? other.getFjdzqm() == null : this.getFjdzqm().equals(other.getFjdzqm()))
            && (this.getQmzsgy() == null ? other.getQmzsgy() == null : this.getQmzsgy().equals(other.getQmzsgy()))
            && (this.getIsDecrypt() == null ? other.getIsDecrypt() == null : this.getIsDecrypt().equals(other.getIsDecrypt()))
            && (this.getLength() == null ? other.getLength() == null : this.getLength().equals(other.getLength()))
            && (this.getMd5() == null ? other.getMd5() == null : this.getMd5().equals(other.getMd5()))
            && (this.getExtendName() == null ? other.getExtendName() == null : this.getExtendName().equals(other.getExtendName()))
            && (this.getPath() == null ? other.getPath() == null : this.getPath().equals(other.getPath()))
            && (this.getEnvelopeTypeOrder() == null ? other.getEnvelopeTypeOrder() == null : this.getEnvelopeTypeOrder().equals(other.getEnvelopeTypeOrder()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getFjid00() == null) ? 0 : getFjid00().hashCode());
        result = prime * result + ((getUploadTime() == null) ? 0 : getUploadTime().hashCode());
        result = prime * result + ((getFjmc00() == null) ? 0 : getFjmc00().hashCode());
        result = prime * result + ((getFjgslx() == null) ? 0 : getFjgslx().hashCode());
        result = prime * result + ((getFjlx00() == null) ? 0 : getFjlx00().hashCode());
        result = prime * result + ((getFjsszt() == null) ? 0 : getFjsszt().hashCode());
        result = prime * result + ((getUploadUserId() == null) ? 0 : getUploadUserId().hashCode());
        result = prime * result + ((getTbxmzj() == null) ? 0 : getTbxmzj().hashCode());
        result = prime * result + ((getBdzj00() == null) ? 0 : getBdzj00().hashCode());
        result = prime * result + ((getFjdzqm() == null) ? 0 : getFjdzqm().hashCode());
        result = prime * result + ((getQmzsgy() == null) ? 0 : getQmzsgy().hashCode());
        result = prime * result + ((getIsDecrypt() == null) ? 0 : getIsDecrypt().hashCode());
        result = prime * result + ((getLength() == null) ? 0 : getLength().hashCode());
        result = prime * result + ((getMd5() == null) ? 0 : getMd5().hashCode());
        result = prime * result + ((getExtendName() == null) ? 0 : getExtendName().hashCode());
        result = prime * result + ((getPath() == null) ? 0 : getPath().hashCode());
        result = prime * result + ((getEnvelopeTypeOrder() == null) ? 0 : getEnvelopeTypeOrder().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", fjid00=").append(fjid00);
        sb.append(", uploadTime=").append(uploadTime);
        sb.append(", fjmc00=").append(fjmc00);
        sb.append(", fjgslx=").append(fjgslx);
        sb.append(", fjlx00=").append(fjlx00);
        sb.append(", fjsszt=").append(fjsszt);
        sb.append(", uploadUserId=").append(uploadUserId);
        sb.append(", tbxmzj=").append(tbxmzj);
        sb.append(", bdzj00=").append(bdzj00);
        sb.append(", fjdzqm=").append(fjdzqm);
        sb.append(", qmzsgy=").append(qmzsgy);
        sb.append(", isDecrypt=").append(isDecrypt);
        sb.append(", length=").append(length);
        sb.append(", md5=").append(md5);
        sb.append(", extendName=").append(extendName);
        sb.append(", path=").append(path);
        sb.append(", envelopeTypeOrder=").append(envelopeTypeOrder);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}