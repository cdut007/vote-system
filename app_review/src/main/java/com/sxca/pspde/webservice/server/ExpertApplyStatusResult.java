package com.sxca.pspde.webservice.server;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * Java class for expertApplyStatusResult complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType name="expertApplyStatusResult">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="errorCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="errorMessage" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="expertApplyStatus" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="expertSpecialtyWSList" type="{http://server.webservice.pspde.sxca.com/}expertSpecialtyWS" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="success" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "expertApplyStatusResult", propOrder = { "errorCode",
		"errorMessage", "expertApplyStatus", "expertSpecialtyWSList", "success" })
public class ExpertApplyStatusResult {

	protected String errorCode;
	protected String errorMessage;
	protected String expertApplyStatus;
	@XmlElement(nillable = true)
	protected List<ExpertSpecialtyWS> expertSpecialtyWSList;
	protected boolean success;

	/**
	 * Gets the value of the errorCode property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getErrorCode() {
		return errorCode;
	}

	/**
	 * Sets the value of the errorCode property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setErrorCode(String value) {
		this.errorCode = value;
	}

	/**
	 * Gets the value of the errorMessage property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getErrorMessage() {
		return errorMessage;
	}

	/**
	 * Sets the value of the errorMessage property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setErrorMessage(String value) {
		this.errorMessage = value;
	}

	/**
	 * Gets the value of the expertApplyStatus property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getExpertApplyStatus() {
		return expertApplyStatus;
	}

	/**
	 * Sets the value of the expertApplyStatus property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setExpertApplyStatus(String value) {
		this.expertApplyStatus = value;
	}

	/**
	 * Gets the value of the expertSpecialtyWSList property.
	 * 
	 * <p>
	 * This accessor method returns a reference to the live list, not a
	 * snapshot. Therefore any modification you make to the returned list will
	 * be present inside the JAXB object. This is why there is not a
	 * <CODE>set</CODE> method for the expertSpecialtyWSList property.
	 * 
	 * <p>
	 * For example, to add a new item, do as follows:
	 * 
	 * <pre>
	 * getExpertSpecialtyWSList().add(newItem);
	 * </pre>
	 * 
	 * 
	 * <p>
	 * Objects of the following type(s) are allowed in the list
	 * {@link ExpertSpecialtyWS }
	 * 
	 * 
	 */
	public List<ExpertSpecialtyWS> getExpertSpecialtyWSList() {
		if (expertSpecialtyWSList == null) {
			expertSpecialtyWSList = new ArrayList<ExpertSpecialtyWS>();
		}
		return this.expertSpecialtyWSList;
	}

	/**
	 * Gets the value of the success property.
	 * 
	 */
	public boolean isSuccess() {
		return success;
	}

	/**
	 * Sets the value of the success property.
	 * 
	 */
	public void setSuccess(boolean value) {
		this.success = value;
	}

}
