package com.itender.ms.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 
 */
public class TbArticle implements Serializable {
    private String id;

    private String deleteMark;

    private String newsTitle;

    private Date publishTime;

    private String publishUserId;

    private String publishWay;

    private Date editTime;

    private String editUserId;

    private String newsAuthor;

    private String newsSource;

    private Date createTime;

    private String articleType;

    private String publishOrganId;

    private String industry;

    private String newsContent;

    private static final long serialVersionUID = 1L;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDeleteMark() {
        return deleteMark;
    }

    public void setDeleteMark(String deleteMark) {
        this.deleteMark = deleteMark;
    }

    public String getNewsTitle() {
        return newsTitle;
    }

    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public String getPublishUserId() {
        return publishUserId;
    }

    public void setPublishUserId(String publishUserId) {
        this.publishUserId = publishUserId;
    }

    public String getPublishWay() {
        return publishWay;
    }

    public void setPublishWay(String publishWay) {
        this.publishWay = publishWay;
    }

    public Date getEditTime() {
        return editTime;
    }

    public void setEditTime(Date editTime) {
        this.editTime = editTime;
    }

    public String getEditUserId() {
        return editUserId;
    }

    public void setEditUserId(String editUserId) {
        this.editUserId = editUserId;
    }

    public String getNewsAuthor() {
        return newsAuthor;
    }

    public void setNewsAuthor(String newsAuthor) {
        this.newsAuthor = newsAuthor;
    }

    public String getNewsSource() {
        return newsSource;
    }

    public void setNewsSource(String newsSource) {
        this.newsSource = newsSource;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getArticleType() {
        return articleType;
    }

    public void setArticleType(String articleType) {
        this.articleType = articleType;
    }

    public String getPublishOrganId() {
        return publishOrganId;
    }

    public void setPublishOrganId(String publishOrganId) {
        this.publishOrganId = publishOrganId;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getNewsContent() {
        return newsContent;
    }

    public void setNewsContent(String newsContent) {
        this.newsContent = newsContent;
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
        TbArticle other = (TbArticle) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getDeleteMark() == null ? other.getDeleteMark() == null : this.getDeleteMark().equals(other.getDeleteMark()))
            && (this.getNewsTitle() == null ? other.getNewsTitle() == null : this.getNewsTitle().equals(other.getNewsTitle()))
            && (this.getPublishTime() == null ? other.getPublishTime() == null : this.getPublishTime().equals(other.getPublishTime()))
            && (this.getPublishUserId() == null ? other.getPublishUserId() == null : this.getPublishUserId().equals(other.getPublishUserId()))
            && (this.getPublishWay() == null ? other.getPublishWay() == null : this.getPublishWay().equals(other.getPublishWay()))
            && (this.getEditTime() == null ? other.getEditTime() == null : this.getEditTime().equals(other.getEditTime()))
            && (this.getEditUserId() == null ? other.getEditUserId() == null : this.getEditUserId().equals(other.getEditUserId()))
            && (this.getNewsAuthor() == null ? other.getNewsAuthor() == null : this.getNewsAuthor().equals(other.getNewsAuthor()))
            && (this.getNewsSource() == null ? other.getNewsSource() == null : this.getNewsSource().equals(other.getNewsSource()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getArticleType() == null ? other.getArticleType() == null : this.getArticleType().equals(other.getArticleType()))
            && (this.getPublishOrganId() == null ? other.getPublishOrganId() == null : this.getPublishOrganId().equals(other.getPublishOrganId()))
            && (this.getIndustry() == null ? other.getIndustry() == null : this.getIndustry().equals(other.getIndustry()))
            && (this.getNewsContent() == null ? other.getNewsContent() == null : this.getNewsContent().equals(other.getNewsContent()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getDeleteMark() == null) ? 0 : getDeleteMark().hashCode());
        result = prime * result + ((getNewsTitle() == null) ? 0 : getNewsTitle().hashCode());
        result = prime * result + ((getPublishTime() == null) ? 0 : getPublishTime().hashCode());
        result = prime * result + ((getPublishUserId() == null) ? 0 : getPublishUserId().hashCode());
        result = prime * result + ((getPublishWay() == null) ? 0 : getPublishWay().hashCode());
        result = prime * result + ((getEditTime() == null) ? 0 : getEditTime().hashCode());
        result = prime * result + ((getEditUserId() == null) ? 0 : getEditUserId().hashCode());
        result = prime * result + ((getNewsAuthor() == null) ? 0 : getNewsAuthor().hashCode());
        result = prime * result + ((getNewsSource() == null) ? 0 : getNewsSource().hashCode());
        result = prime * result + ((getCreateTime() == null) ? 0 : getCreateTime().hashCode());
        result = prime * result + ((getArticleType() == null) ? 0 : getArticleType().hashCode());
        result = prime * result + ((getPublishOrganId() == null) ? 0 : getPublishOrganId().hashCode());
        result = prime * result + ((getIndustry() == null) ? 0 : getIndustry().hashCode());
        result = prime * result + ((getNewsContent() == null) ? 0 : getNewsContent().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", deleteMark=").append(deleteMark);
        sb.append(", newsTitle=").append(newsTitle);
        sb.append(", publishTime=").append(publishTime);
        sb.append(", publishUserId=").append(publishUserId);
        sb.append(", publishWay=").append(publishWay);
        sb.append(", editTime=").append(editTime);
        sb.append(", editUserId=").append(editUserId);
        sb.append(", newsAuthor=").append(newsAuthor);
        sb.append(", newsSource=").append(newsSource);
        sb.append(", createTime=").append(createTime);
        sb.append(", articleType=").append(articleType);
        sb.append(", publishOrganId=").append(publishOrganId);
        sb.append(", industry=").append(industry);
        sb.append(", newsContent=").append(newsContent);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}