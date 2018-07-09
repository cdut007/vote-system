//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.4-2 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2017.01.07 at 01:12:55 PM CST 
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
 *         &lt;element name="winBidBulletinCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;minLength value="1"/>
 *               &lt;maxLength value="64"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="tenderProjectCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="20"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="tenderProjectName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;minLength value="1"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bidSectionCodes">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;minLength value="23"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bulletinName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
 *               &lt;minLength value="1"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bulletinType">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[1|2|9]"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bulletinIssueTime">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{14}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="bulletinContent">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;minLength value="1"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="URL">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="500"/>
 *               &lt;minLength value="1"/>
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
    "winBidBulletinCode",
    "tenderProjectCode",
    "tenderProjectName",
    "bidSectionCodes",
    "bulletinName",
    "bulletinType",
    "bulletinIssueTime",
    "bulletinContent",
    "url",
    "attachmentCode",
    "version",
    "isOpen",
    "openType",
    "examinerName",
    "examinerCodeType",
    "examinerCode",
    "verifyTime"
})
@XmlRootElement(name = "winBidBulletin")
public class WinBidBulletin {

    @XmlElement(required = true)
    protected String winBidBulletinCode;
    @XmlElement(required = true)
    protected String tenderProjectCode;
    @XmlElement(required = true)
    protected String tenderProjectName;
    @XmlElement(required = true)
    protected String bidSectionCodes;
    @XmlElement(required = true)
    protected String bulletinName;
    @XmlElement(required = true)
    protected String bulletinType;
    @XmlElement(required = true)
    protected String bulletinIssueTime;
    @XmlElement(required = true)
    protected String bulletinContent;
    @XmlElement(name = "URL", required = true)
    protected String url;
    @XmlElement(required = true)
    protected String attachmentCode;
    @XmlElement(required = true)
    protected String version;
    @XmlElement(required = true)
    protected String isOpen;
    @XmlElement(required = true)
    protected String openType;
    @XmlElement(required = true)
    protected String examinerName;
    @XmlElement(required = true)
    protected String examinerCodeType;
    @XmlElement(required = true)
    protected String examinerCode;
    @XmlElement(required = true)
    protected String verifyTime;

    /**
     * Gets the value of the winBidBulletinCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWinBidBulletinCode() {
        return winBidBulletinCode;
    }

    /**
     * Sets the value of the winBidBulletinCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWinBidBulletinCode(String value) {
        this.winBidBulletinCode = value;
    }

    /**
     * Gets the value of the tenderProjectCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTenderProjectCode() {
        return tenderProjectCode;
    }

    /**
     * Sets the value of the tenderProjectCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTenderProjectCode(String value) {
        this.tenderProjectCode = value;
    }

    /**
     * Gets the value of the tenderProjectName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTenderProjectName() {
        return tenderProjectName;
    }

    /**
     * Sets the value of the tenderProjectName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTenderProjectName(String value) {
        this.tenderProjectName = value;
    }

    /**
     * Gets the value of the bidSectionCodes property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBidSectionCodes() {
        return bidSectionCodes;
    }

    /**
     * Sets the value of the bidSectionCodes property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBidSectionCodes(String value) {
        this.bidSectionCodes = value;
    }

    /**
     * Gets the value of the bulletinName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBulletinName() {
        return bulletinName;
    }

    /**
     * Sets the value of the bulletinName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBulletinName(String value) {
        this.bulletinName = value;
    }

    /**
     * Gets the value of the bulletinType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBulletinType() {
        return bulletinType;
    }

    /**
     * Sets the value of the bulletinType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBulletinType(String value) {
        this.bulletinType = value;
    }

    /**
     * Gets the value of the bulletinIssueTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBulletinIssueTime() {
        return bulletinIssueTime;
    }

    /**
     * Sets the value of the bulletinIssueTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBulletinIssueTime(String value) {
        this.bulletinIssueTime = value;
    }

    /**
     * Gets the value of the bulletinContent property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBulletinContent() {
        return bulletinContent;
    }

    /**
     * Sets the value of the bulletinContent property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBulletinContent(String value) {
        this.bulletinContent = value;
    }

    /**
     * Gets the value of the url property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getURL() {
        return url;
    }

    /**
     * Sets the value of the url property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setURL(String value) {
        this.url = value;
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