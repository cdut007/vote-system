package com.sxca.pspde.webservice.server;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Java class for getExpertApplyStatusResponse complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType name="getExpertApplyStatusResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="return" type="{http://server.webservice.pspde.sxca.com/}expertApplyStatusResult" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "getExpertApplyStatusResponse", propOrder = { "_return" })
public class GetExpertApplyStatusResponse {

	@XmlElement(name = "return")
	protected ExpertApplyStatusResult _return;

	/**
	 * Gets the value of the return property.
	 * 
	 * @return possible object is {@link ExpertApplyStatusResult }
	 * 
	 */
	public ExpertApplyStatusResult getReturn() {
		return _return;
	}

	/**
	 * Sets the value of the return property.
	 * 
	 * @param value
	 *            allowed object is {@link ExpertApplyStatusResult }
	 * 
	 */
	public void setReturn(ExpertApplyStatusResult value) {
		this._return = value;
	}

}
