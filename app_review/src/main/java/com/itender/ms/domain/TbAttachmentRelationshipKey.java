package com.itender.ms.domain;

import java.io.Serializable;

/**
 * @author 
 */
public class TbAttachmentRelationshipKey implements Serializable {
    private String tenderItemId;

    private String attachmentId;

    private static final long serialVersionUID = 1L;

    public String getTenderItemId() {
        return tenderItemId;
    }

    public void setTenderItemId(String tenderItemId) {
        this.tenderItemId = tenderItemId;
    }

    public String getAttachmentId() {
        return attachmentId;
    }

    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId;
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
        TbAttachmentRelationshipKey other = (TbAttachmentRelationshipKey) that;
        return (this.getTenderItemId() == null ? other.getTenderItemId() == null : this.getTenderItemId().equals(other.getTenderItemId()))
            && (this.getAttachmentId() == null ? other.getAttachmentId() == null : this.getAttachmentId().equals(other.getAttachmentId()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getTenderItemId() == null) ? 0 : getTenderItemId().hashCode());
        result = prime * result + ((getAttachmentId() == null) ? 0 : getAttachmentId().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", tenderItemId=").append(tenderItemId);
        sb.append(", attachmentId=").append(attachmentId);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}