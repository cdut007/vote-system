package com.sxca.pspde.webservice.server;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Java class for result complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType name="result">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="errorCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="errorMessage" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
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
@XmlType(name = "result", propOrder = { "errorCode", "errorMessage", "success" })
public class Result {

	protected String errorCode;
	protected String errorMessage;
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
	
	public String toString() {
		return this.success + ":" + this.errorCode + ":" + this.errorMessage;
	}

}
