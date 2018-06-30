/**
 * Result.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.itender.ms.platform.webservice;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="result") 
public class Result_ZT  implements java.io.Serializable {

	private String message;

    private String resultNum;

    private boolean serviceFlag;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getResultNum() {
		return resultNum;
	}

	public void setResultNum(String resultNum) {
		this.resultNum = resultNum;
	}

	public boolean isServiceFlag() {
		return serviceFlag;
	}

	public void setServiceFlag(boolean serviceFlag) {
		this.serviceFlag = serviceFlag;
	}
	
//	public boolean getServiceFlag(){
//		return serviceFlag;
//	}
}
