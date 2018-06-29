package com.sxca.pspde.webservice.server;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Java class for expertInfoWS complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType name="expertInfoWS">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="expertArea" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="expertLevel" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="expertName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="expertOrgName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="expertSpecialty" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="idCardNum" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="sex" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="verificationCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "expertInfoWS", propOrder = { "expertArea", "expertLevel",
		"expertName", "expertOrgName", "expertSpecialty", "idCardNum", "sex",
		"verificationCode" })
public class ExpertInfoWS {

	protected String expertArea;
	protected String expertLevel;
	protected String expertName;
	protected String expertOrgName;
	protected String expertSpecialty;
	protected String idCardNum;
	protected String sex;
	protected String verificationCode;

	/**
	 * Gets the value of the expertArea property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getExpertArea() {
		return expertArea;
	}

	/**
	 * Sets the value of the expertArea property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setExpertArea(String value) {
		this.expertArea = value;
	}

	/**
	 * Gets the value of the expertLevel property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getExpertLevel() {
		return expertLevel;
	}

	/**
	 * Sets the value of the expertLevel property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setExpertLevel(String value) {
		this.expertLevel = value;
	}

	/**
	 * Gets the value of the expertName property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getExpertName() {
		return expertName;
	}

	/**
	 * Sets the value of the expertName property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setExpertName(String value) {
		this.expertName = value;
	}

	/**
	 * Gets the value of the expertOrgName property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getExpertOrgName() {
		return expertOrgName;
	}

	/**
	 * Sets the value of the expertOrgName property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setExpertOrgName(String value) {
		this.expertOrgName = value;
	}

	/**
	 * Gets the value of the expertSpecialty property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getExpertSpecialty() {
		return expertSpecialty;
	}

	/**
	 * Sets the value of the expertSpecialty property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setExpertSpecialty(String value) {
		this.expertSpecialty = value;
	}

	/**
	 * Gets the value of the idCardNum property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getIdCardNum() {
		return idCardNum;
	}

	/**
	 * Sets the value of the idCardNum property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setIdCardNum(String value) {
		this.idCardNum = value;
	}

	/**
	 * Gets the value of the sex property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * Sets the value of the sex property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setSex(String value) {
		this.sex = value;
	}

	/**
	 * Gets the value of the verificationCode property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getVerificationCode() {
		return verificationCode;
	}

	/**
	 * Sets the value of the verificationCode property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setVerificationCode(String value) {
		this.verificationCode = value;
	}

}
