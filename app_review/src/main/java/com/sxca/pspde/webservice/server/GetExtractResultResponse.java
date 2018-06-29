package com.sxca.pspde.webservice.server;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Java class for getExtractResultResponse complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType name="getExtractResultResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="return" type="{http://server.webservice.pspde.sxca.com/}extractResult" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "getExtractResultResponse", propOrder = { "_return" })
public class GetExtractResultResponse {

	@XmlElement(name = "return")
	protected ExtractResult _return;

	/**
	 * Gets the value of the return property.
	 * 
	 * @return possible object is {@link ExtractResult }
	 * 
	 */
	public ExtractResult getReturn() {
		return _return;
	}

	/**
	 * Sets the value of the return property.
	 * 
	 * @param value
	 *            allowed object is {@link ExtractResult }
	 * 
	 */
	public void setReturn(ExtractResult value) {
		this._return = value;
	}

}
