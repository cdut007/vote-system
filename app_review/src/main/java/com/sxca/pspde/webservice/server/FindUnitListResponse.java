package com.sxca.pspde.webservice.server;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.List;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "findUnitListResponse", propOrder = { "_return" })
public class FindUnitListResponse {

	@XmlElement(name = "return")
	protected List<String> _return;

	/**
	 * Gets the value of the return property.
	 * 
	 * @return possible object is {@link Result }
	 * 
	 */
	public List<String> getReturn() {
		return _return;
	}

	/**
	 * Sets the value of the return property.
	 * 
	 * @param value
	 *            allowed object is {@link Result }
	 * 
	 */
	public void setReturn(List<String> value) {
		this._return = value;
	}

}
