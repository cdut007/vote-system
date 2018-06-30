//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.4-2 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2017.01.07 at 01:12:34 PM CST 
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
 *         &lt;element name="tendererCodeType">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{2}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="tendererCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="50"/>
 *               &lt;minLength value="1"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="tendererName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
 *               &lt;minLength value="1"/>
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
 *         &lt;element name="artificialPerson">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="artificialPersonCodeType">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{2}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="artificialPersonCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="50"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="contactNumber">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
 *               &lt;minLength value="1"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="participantType">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[T|B|A]|[T|B|A]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="countryRegion">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{3}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="unitNature">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{3}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="regionCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{6}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="industryCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="3"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="licNumber">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="50"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="caCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="50"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="taxNumber">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="50"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="creditRate">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="50"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="openingBank">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="basicAccount">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="50"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="regCapital">
 *           &lt;simpleType>
 *             &lt;restriction base="{}decimal-or-empty">
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="regCapCurrency">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{3}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="regUnit">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[1|2]|[1|2]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="infoReporterName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="infoReporterCodeType">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{2}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="infoReporterCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="50"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="infoReporterContactNumber">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="11"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="contactAddress">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="zipCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{6}|[0-9]{0}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="email">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
 *               &lt;minLength value="1"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="platfVerifier">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="platfVerifierTime">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9]{14}|[0-9]{0}"/>
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
 *         &lt;element name="platformCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;pattern value="[0-9A-Z]{11}"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="platformName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="100"/>
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
 *         &lt;element name="organizationAttachmentCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="licAttachmentCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="taxAttachmentCode">
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
    "tendererCodeType",
    "tendererCode",
    "tendererName",
    "bidSectionCode",
    "artificialPerson",
    "artificialPersonCodeType",
    "artificialPersonCode",
    "contactNumber",
    "participantType",
    "countryRegion",
    "unitNature",
    "regionCode",
    "industryCode",
    "licNumber",
    "caCode",
    "taxNumber",
    "creditRate",
    "openingBank",
    "basicAccount",
    "regCapital",
    "regCapCurrency",
    "regUnit",
    "infoReporterName",
    "infoReporterCodeType",
    "infoReporterCode",
    "infoReporterContactNumber",
    "contactAddress",
    "zipCode",
    "email",
    "platfVerifier",
    "platfVerifierTime",
    "verifyTime",
    "platformCode",
    "platformName",
    "examinerName",
    "examinerCodeType",
    "examinerCode",
    "organizationAttachmentCode",
    "licAttachmentCode",
    "taxAttachmentCode",
    "version"
})
@XmlRootElement(name = "tendererInfo")
public class TendererInfo {

    @XmlElement(required = true)
    protected String tendererCodeType;
    @XmlElement(required = true)
    protected String tendererCode;
    @XmlElement(required = true)
    protected String tendererName;
    @XmlElement(required = true)
    protected String bidSectionCode;
    @XmlElement(required = true)
    protected String artificialPerson;
    @XmlElement(required = true)
    protected String artificialPersonCodeType;
    @XmlElement(required = true)
    protected String artificialPersonCode;
    @XmlElement(required = true)
    protected String contactNumber;
    @XmlElement(required = true)
    protected String participantType;
    @XmlElement(required = true)
    protected String countryRegion;
    @XmlElement(required = true)
    protected String unitNature;
    @XmlElement(required = true)
    protected String regionCode;
    @XmlElement(required = true)
    protected String industryCode;
    @XmlElement(required = true)
    protected String licNumber;
    @XmlElement(required = true)
    protected String caCode;
    @XmlElement(required = true)
    protected String taxNumber;
    @XmlElement(required = true)
    protected String creditRate;
    @XmlElement(required = true)
    protected String openingBank;
    @XmlElement(required = true)
    protected String basicAccount;
    @XmlElement(required = true)
    protected String regCapital;
    @XmlElement(required = true)
    protected String regCapCurrency;
    @XmlElement(required = true)
    protected String regUnit;
    @XmlElement(required = true)
    protected String infoReporterName;
    @XmlElement(required = true)
    protected String infoReporterCodeType;
    @XmlElement(required = true)
    protected String infoReporterCode;
    @XmlElement(required = true)
    protected String infoReporterContactNumber;
    @XmlElement(required = true)
    protected String contactAddress;
    @XmlElement(required = true)
    protected String zipCode;
    @XmlElement(required = true)
    protected String email;
    @XmlElement(required = true)
    protected String platfVerifier;
    @XmlElement(required = true)
    protected String platfVerifierTime;
    @XmlElement(required = true)
    protected String verifyTime;
    @XmlElement(required = true)
    protected String platformCode;
    @XmlElement(required = true)
    protected String platformName;
    @XmlElement(required = true)
    protected String examinerName;
    @XmlElement(required = true)
    protected String examinerCodeType;
    @XmlElement(required = true)
    protected String examinerCode;
    @XmlElement(required = true)
    protected String organizationAttachmentCode;
    @XmlElement(required = true)
    protected String licAttachmentCode;
    @XmlElement(required = true)
    protected String taxAttachmentCode;
    @XmlElement(required = true)
    protected String version;

    /**
     * Gets the value of the tendererCodeType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTendererCodeType() {
        return tendererCodeType;
    }

    /**
     * Sets the value of the tendererCodeType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTendererCodeType(String value) {
        this.tendererCodeType = value;
    }

    /**
     * Gets the value of the tendererCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTendererCode() {
        return tendererCode;
    }

    /**
     * Sets the value of the tendererCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTendererCode(String value) {
        this.tendererCode = value;
    }

    /**
     * Gets the value of the tendererName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTendererName() {
        return tendererName;
    }

    /**
     * Sets the value of the tendererName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTendererName(String value) {
        this.tendererName = value;
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
     * Gets the value of the artificialPerson property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getArtificialPerson() {
        return artificialPerson;
    }

    /**
     * Sets the value of the artificialPerson property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setArtificialPerson(String value) {
        this.artificialPerson = value;
    }

    /**
     * Gets the value of the artificialPersonCodeType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getArtificialPersonCodeType() {
        return artificialPersonCodeType;
    }

    /**
     * Sets the value of the artificialPersonCodeType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setArtificialPersonCodeType(String value) {
        this.artificialPersonCodeType = value;
    }

    /**
     * Gets the value of the artificialPersonCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getArtificialPersonCode() {
        return artificialPersonCode;
    }

    /**
     * Sets the value of the artificialPersonCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setArtificialPersonCode(String value) {
        this.artificialPersonCode = value;
    }

    /**
     * Gets the value of the contactNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getContactNumber() {
        return contactNumber;
    }

    /**
     * Sets the value of the contactNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setContactNumber(String value) {
        this.contactNumber = value;
    }

    /**
     * Gets the value of the participantType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getParticipantType() {
        return participantType;
    }

    /**
     * Sets the value of the participantType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setParticipantType(String value) {
        this.participantType = value;
    }

    /**
     * Gets the value of the countryRegion property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCountryRegion() {
        return countryRegion;
    }

    /**
     * Sets the value of the countryRegion property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCountryRegion(String value) {
        this.countryRegion = value;
    }

    /**
     * Gets the value of the unitNature property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUnitNature() {
        return unitNature;
    }

    /**
     * Sets the value of the unitNature property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUnitNature(String value) {
        this.unitNature = value;
    }

    /**
     * Gets the value of the regionCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRegionCode() {
        return regionCode;
    }

    /**
     * Sets the value of the regionCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRegionCode(String value) {
        this.regionCode = value;
    }

    /**
     * Gets the value of the industryCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIndustryCode() {
        return industryCode;
    }

    /**
     * Sets the value of the industryCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIndustryCode(String value) {
        this.industryCode = value;
    }

    /**
     * Gets the value of the licNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLicNumber() {
        return licNumber;
    }

    /**
     * Sets the value of the licNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLicNumber(String value) {
        this.licNumber = value;
    }

    /**
     * Gets the value of the caCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCaCode() {
        return caCode;
    }

    /**
     * Sets the value of the caCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCaCode(String value) {
        this.caCode = value;
    }

    /**
     * Gets the value of the taxNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTaxNumber() {
        return taxNumber;
    }

    /**
     * Sets the value of the taxNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTaxNumber(String value) {
        this.taxNumber = value;
    }

    /**
     * Gets the value of the creditRate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreditRate() {
        return creditRate;
    }

    /**
     * Sets the value of the creditRate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreditRate(String value) {
        this.creditRate = value;
    }

    /**
     * Gets the value of the openingBank property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOpeningBank() {
        return openingBank;
    }

    /**
     * Sets the value of the openingBank property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOpeningBank(String value) {
        this.openingBank = value;
    }

    /**
     * Gets the value of the basicAccount property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBasicAccount() {
        return basicAccount;
    }

    /**
     * Sets the value of the basicAccount property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBasicAccount(String value) {
        this.basicAccount = value;
    }

    /**
     * Gets the value of the regCapital property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRegCapital() {
        return regCapital;
    }

    /**
     * Sets the value of the regCapital property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRegCapital(String value) {
        this.regCapital = value;
    }

    /**
     * Gets the value of the regCapCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRegCapCurrency() {
        return regCapCurrency;
    }

    /**
     * Sets the value of the regCapCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRegCapCurrency(String value) {
        this.regCapCurrency = value;
    }

    /**
     * Gets the value of the regUnit property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRegUnit() {
        return regUnit;
    }

    /**
     * Sets the value of the regUnit property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRegUnit(String value) {
        this.regUnit = value;
    }

    /**
     * Gets the value of the infoReporterName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInfoReporterName() {
        return infoReporterName;
    }

    /**
     * Sets the value of the infoReporterName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInfoReporterName(String value) {
        this.infoReporterName = value;
    }

    /**
     * Gets the value of the infoReporterCodeType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInfoReporterCodeType() {
        return infoReporterCodeType;
    }

    /**
     * Sets the value of the infoReporterCodeType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInfoReporterCodeType(String value) {
        this.infoReporterCodeType = value;
    }

    /**
     * Gets the value of the infoReporterCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInfoReporterCode() {
        return infoReporterCode;
    }

    /**
     * Sets the value of the infoReporterCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInfoReporterCode(String value) {
        this.infoReporterCode = value;
    }

    /**
     * Gets the value of the infoReporterContactNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInfoReporterContactNumber() {
        return infoReporterContactNumber;
    }

    /**
     * Sets the value of the infoReporterContactNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInfoReporterContactNumber(String value) {
        this.infoReporterContactNumber = value;
    }

    /**
     * Gets the value of the contactAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getContactAddress() {
        return contactAddress;
    }

    /**
     * Sets the value of the contactAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setContactAddress(String value) {
        this.contactAddress = value;
    }

    /**
     * Gets the value of the zipCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getZipCode() {
        return zipCode;
    }

    /**
     * Sets the value of the zipCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setZipCode(String value) {
        this.zipCode = value;
    }

    /**
     * Gets the value of the email property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the value of the email property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEmail(String value) {
        this.email = value;
    }

    /**
     * Gets the value of the platfVerifier property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPlatfVerifier() {
        return platfVerifier;
    }

    /**
     * Sets the value of the platfVerifier property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPlatfVerifier(String value) {
        this.platfVerifier = value;
    }

    /**
     * Gets the value of the platfVerifierTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPlatfVerifierTime() {
        return platfVerifierTime;
    }

    /**
     * Sets the value of the platfVerifierTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPlatfVerifierTime(String value) {
        this.platfVerifierTime = value;
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

    /**
     * Gets the value of the platformCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPlatformCode() {
        return platformCode;
    }

    /**
     * Sets the value of the platformCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPlatformCode(String value) {
        this.platformCode = value;
    }

    /**
     * Gets the value of the platformName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPlatformName() {
        return platformName;
    }

    /**
     * Sets the value of the platformName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPlatformName(String value) {
        this.platformName = value;
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
     * Gets the value of the organizationAttachmentCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrganizationAttachmentCode() {
        return organizationAttachmentCode;
    }

    /**
     * Sets the value of the organizationAttachmentCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrganizationAttachmentCode(String value) {
        this.organizationAttachmentCode = value;
    }

    /**
     * Gets the value of the licAttachmentCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLicAttachmentCode() {
        return licAttachmentCode;
    }

    /**
     * Sets the value of the licAttachmentCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLicAttachmentCode(String value) {
        this.licAttachmentCode = value;
    }

    /**
     * Gets the value of the taxAttachmentCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTaxAttachmentCode() {
        return taxAttachmentCode;
    }

    /**
     * Sets the value of the taxAttachmentCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTaxAttachmentCode(String value) {
        this.taxAttachmentCode = value;
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

}
