package com.itender.ms.bank.CBC.request;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;
import com.itender.ms.bank.CBC.Body;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

@JacksonXmlRootElement(localName = "ap")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ap", propOrder = { "head", "body" })
public class RequestAp {
	@JacksonXmlProperty(localName = "head")
	private RequestHead head;
	@JacksonXmlProperty(localName = "body")
	private Body<String,Object> body;
	public RequestHead getHead() {
		return head;
	}
	public void setHead(RequestHead head) {
		this.head = head;
	}
	public Body<String,Object> getBody() {
		return body;
	}
	public void setBody(Body<String,Object> body) {
		this.body = body;
	}

	
}
