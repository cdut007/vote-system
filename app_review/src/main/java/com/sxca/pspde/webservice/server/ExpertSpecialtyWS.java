package com.sxca.pspde.webservice.server;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Java class for expertSpecialtyWS complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType name="expertSpecialtyWS">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="firstLevelAreaCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="specialtyFirstTypeCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="specialtySecondTypeCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="specialtyThirdTypeCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="expertCount" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="expertCheckInTime" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="expertCheckInAddress" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="bidEvaluateTime" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "expertSpecialtyWS", propOrder = { "firstLevelAreaCode",
		"specialtyFirstTypeCode", "specialtySecondTypeCode",
		"specialtyThirdTypeCode", "expertCount", "expertCheckInTime",
		"expertCheckInAddress", "bidEvaluateTime","extractStatus" })
public class ExpertSpecialtyWS {

	protected String firstLevelAreaCode;
	protected String specialtyFirstTypeCode;
	protected String specialtySecondTypeCode;
	protected String specialtyThirdTypeCode;
	protected Integer expertCount;
	protected String expertCheckInTime;
	protected String expertCheckInAddress;
	protected String bidEvaluateTime;
	protected String extractStatus;

	/**
	 * Gets the value of the firstLevelAreaCode property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getFirstLevelAreaCode() {
		return firstLevelAreaCode;
	}

	/**
	 * Sets the value of the firstLevelAreaCode property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setFirstLevelAreaCode(String value) {
		this.firstLevelAreaCode = value;
	}

	/**
	 * Gets the value of the specialtyFirstTypeCode property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getSpecialtyFirstTypeCode() {
		return specialtyFirstTypeCode;
	}

	/**
	 * Sets the value of the specialtyFirstTypeCode property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setSpecialtyFirstTypeCode(String value) {
		this.specialtyFirstTypeCode = value;
	}

	/**
	 * Gets the value of the specialtySecondTypeCode property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getSpecialtySecondTypeCode() {
		return specialtySecondTypeCode;
	}

	/**
	 * Sets the value of the specialtySecondTypeCode property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setSpecialtySecondTypeCode(String value) {
		this.specialtySecondTypeCode = value;
	}

	/**
	 * Gets the value of the specialtyThirdTypeCode property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getSpecialtyThirdTypeCode() {
		return specialtyThirdTypeCode;
	}

	/**
	 * Sets the value of the specialtyThirdTypeCode property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setSpecialtyThirdTypeCode(String value) {
		this.specialtyThirdTypeCode = value;
	}

	/**
	 * Gets the value of the expertCount property.
	 * 
	 * @return possible object is {@link Integer }
	 * 
	 */
	public Integer getExpertCount() {
		return expertCount;
	}

	/**
	 * Sets the value of the expertCount property.
	 * 
	 * @param value
	 *            allowed object is {@link Integer }
	 * 
	 */
	public void setExpertCount(Integer value) {
		this.expertCount = value;
	}

	/**
	 * Gets the value of the expertCheckInTime property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getExpertCheckInTime() {
		return expertCheckInTime;
	}

	/**
	 * Sets the value of the expertCheckInTime property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setExpertCheckInTime(String value) {
		this.expertCheckInTime = value;
	}

	/**
	 * Gets the value of the expertCheckInAddress property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getExpertCheckInAddress() {
		return expertCheckInAddress;
	}

	/**
	 * Sets the value of the expertCheckInAddress property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setExpertCheckInAddress(String value) {
		this.expertCheckInAddress = value;
	}

	/**
	 * Gets the value of the bidEvaluateTime property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getBidEvaluateTime() {
		return bidEvaluateTime;
	}

	/**
	 * Sets the value of the bidEvaluateTime property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setBidEvaluateTime(String value) {
		this.bidEvaluateTime = value;
	}
	
	public String getExtractStatus() {
		return extractStatus;
	}
	
	public void setExtractStatus(String extractStatus) {
		this.extractStatus = extractStatus;
	}

}
