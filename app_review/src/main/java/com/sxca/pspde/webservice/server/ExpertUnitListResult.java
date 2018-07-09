package com.sxca.pspde.webservice.server;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ExpertUnitListResult", propOrder = { "errorCode",
		"errorMessage", "expertApplyStatus", "expertSpecialtyWSList", "success" })
public class ExpertUnitListResult {

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
