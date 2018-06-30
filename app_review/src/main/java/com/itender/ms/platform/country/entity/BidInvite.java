//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.4-2 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2017.01.07 at 01:10:20 PM CST 
//


package com.itender.ms.platform.country.entity;

import javax.xml.bind.annotation.*;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="bidInviteCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;minLength value="1"/>
 *               &lt;maxLength value="64"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bidSectionCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="23"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bidQualification">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bidderCodeType">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{2}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bidderCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;minLength value="1"/>
 *               &lt;maxLength value="50"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bidderName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;minLength value="1"/>
 *               &lt;maxLength value="100"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="tenderDocGetStartTime">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{14}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="tenderDocGetMethod">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="tenderDocDeadLine">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{14}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bidDocReferEndTime">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{14}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bidDocReferMethod" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="bidInviteEndTime">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{14}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bidInviteIssueTime">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{14}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="examinerName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="examinerCodeType">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{2}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="examinerCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="50"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="attachmentCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="version">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{14}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="isOpen">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0|1|2]|[0|1|2]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="openType">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0|1|2]"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="verifyTime">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{14}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "bidInviteCode",
    "bidSectionCode",
    "bidQualification",
    "bidderCodeType",
    "bidderCode",
    "bidderName",
    "tenderDocGetStartTime",
    "tenderDocGetMethod",
    "tenderDocDeadLine",
    "bidDocReferEndTime",
    "bidDocReferMethod",
    "bidInviteEndTime",
    "bidInviteIssueTime",
    "examinerName",
    "examinerCodeType",
    "examinerCode",
    "attachmentCode",
    "version",
    "isOpen",
    "openType",
    "verifyTime"
})
@XmlRootElement(name = "bidInvite")
public class BidInvite {

    @XmlElement(required = true)
    protected String bidInviteCode;
    @XmlElement(required = true)
    protected String bidSectionCode;
    @XmlElement(required = true)
    protected String bidQualification;
    @XmlElement(required = true)
    protected String bidderCodeType;
    @XmlElement(required = true)
    protected String bidderCode;
    @XmlElement(required = true)
    protected String bidderName;
    @XmlElement(required = true)
    protected String tenderDocGetStartTime;
    @XmlElement(required = true)
    protected String tenderDocGetMethod;
    @XmlElement(required = true)
    protected String tenderDocDeadLine;
    @XmlElement(required = true)
    protected String bidDocReferEndTime;
    @XmlElement(required = true)
    protected String bidDocReferMethod;
    @XmlElement(required = true)
    protected String bidInviteEndTime;
    @XmlElement(required = true)
    protected String bidInviteIssueTime;
    @XmlElement(required = true)
    protected String examinerName;
    @XmlElement(required = true)
    protected String examinerCodeType;
    @XmlElement(required = true)
    protected String examinerCode;
    @XmlElement(required = true)
    protected String attachmentCode;
    @XmlElement(required = true)
    protected String version;
    @XmlElement(required = true)
    protected String isOpen;
    @XmlElement(required = true)
    protected String openType;
    @XmlElement(required = true)
    protected String verifyTime;

    /**
     * Gets the value of the bidInviteCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidInviteCode() {
        return bidInviteCode;
    }

    /**
     * Sets the value of the bidInviteCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidInviteCode(String value) {
        this.bidInviteCode = value;
    }

    /**
     * Gets the value of the bidSectionCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidSectionCode() {
        return bidSectionCode;
    }

    /**
     * Sets the value of the bidSectionCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidSectionCode(String value) {
        this.bidSectionCode = value;
    }

    /**
     * Gets the value of the bidQualification property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidQualification() {
        return bidQualification;
    }

    /**
     * Sets the value of the bidQualification property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidQualification(String value) {
        this.bidQualification = value;
    }

    /**
     * Gets the value of the bidderCodeType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidderCodeType() {
        return bidderCodeType;
    }

    /**
     * Sets the value of the bidderCodeType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidderCodeType(String value) {
        this.bidderCodeType = value;
    }

    /**
     * Gets the value of the bidderCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidderCode() {
        return bidderCode;
    }

    /**
     * Sets the value of the bidderCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidderCode(String value) {
        this.bidderCode = value;
    }

    /**
     * Gets the value of the bidderName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidderName() {
        return bidderName;
    }

    /**
     * Sets the value of the bidderName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidderName(String value) {
        this.bidderName = value;
    }

    /**
     * Gets the value of the tenderDocGetStartTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTenderDocGetStartTime() {
        return tenderDocGetStartTime;
    }

    /**
     * Sets the value of the tenderDocGetStartTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTenderDocGetStartTime(String value) {
        this.tenderDocGetStartTime = value;
    }

    /**
     * Gets the value of the tenderDocGetMethod property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTenderDocGetMethod() {
        return tenderDocGetMethod;
    }

    /**
     * Sets the value of the tenderDocGetMethod property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTenderDocGetMethod(String value) {
        this.tenderDocGetMethod = value;
    }

    /**
     * Gets the value of the tenderDocDeadLine property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTenderDocDeadLine() {
        return tenderDocDeadLine;
    }

    /**
     * Sets the value of the tenderDocDeadLine property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTenderDocDeadLine(String value) {
        this.tenderDocDeadLine = value;
    }

    /**
     * Gets the value of the bidDocReferEndTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidDocReferEndTime() {
        return bidDocReferEndTime;
    }

    /**
     * Sets the value of the bidDocReferEndTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidDocReferEndTime(String value) {
        this.bidDocReferEndTime = value;
    }

    /**
     * Gets the value of the bidDocReferMethod property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidDocReferMethod() {
        return bidDocReferMethod;
    }

    /**
     * Sets the value of the bidDocReferMethod property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidDocReferMethod(String value) {
        this.bidDocReferMethod = value;
    }

    /**
     * Gets the value of the bidInviteEndTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidInviteEndTime() {
        return bidInviteEndTime;
    }

    /**
     * Sets the value of the bidInviteEndTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidInviteEndTime(String value) {
        this.bidInviteEndTime = value;
    }

    /**
     * Gets the value of the bidInviteIssueTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidInviteIssueTime() {
        return bidInviteIssueTime;
    }

    /**
     * Sets the value of the bidInviteIssueTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidInviteIssueTime(String value) {
        this.bidInviteIssueTime = value;
    }

    /**
     * Gets the value of the examinerName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getExaminerName() {
        return examinerName;
    }

    /**
     * Sets the value of the examinerName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setExaminerName(String value) {
        this.examinerName = value;
    }

    /**
     * Gets the value of the examinerCodeType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getExaminerCodeType() {
        return examinerCodeType;
    }

    /**
     * Sets the value of the examinerCodeType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setExaminerCodeType(String value) {
        this.examinerCodeType = value;
    }

    /**
     * Gets the value of the examinerCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getExaminerCode() {
        return examinerCode;
    }

    /**
     * Sets the value of the examinerCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setExaminerCode(String value) {
        this.examinerCode = value;
    }

    /**
     * Gets the value of the attachmentCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAttachmentCode() {
        return attachmentCode;
    }

    /**
     * Sets the value of the attachmentCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAttachmentCode(String value) {
        this.attachmentCode = value;
    }

    /**
     * Gets the value of the version property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getVersion() {
        return version;
    }

    /**
     * Sets the value of the version property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setVersion(String value) {
        this.version = value;
    }

    /**
     * Gets the value of the isOpen property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIsOpen() {
        return isOpen;
    }

    /**
     * Sets the value of the isOpen property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIsOpen(String value) {
        this.isOpen = value;
    }

    /**
     * Gets the value of the openType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOpenType() {
        return openType;
    }

    /**
     * Sets the value of the openType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOpenType(String value) {
        this.openType = value;
    }

    /**
     * Gets the value of the verifyTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getVerifyTime() {
        return verifyTime;
    }

    /**
     * Sets the value of the verifyTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setVerifyTime(String value) {
        this.verifyTime = value;
    }

}
