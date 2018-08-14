package com.itender.ms.bank.CBC;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import java.math.BigDecimal;
import java.util.HashMap;

@XmlAccessorType(XmlAccessType.FIELD)
public class Body<K, V> extends HashMap<String, Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7064462313076259904L;

	public Integer getInteger(String key) {
		String v = (String) super.get(key);
		if (v != null) {
			return Integer.valueOf(v);
		} else {
			return null;
		}
	}

	public String getString(String key) {
		String v = (String) super.get(key);
		return v;
	}

	public BigDecimal getBigDecimal(String key) {
		String v = (String) super.get(key);
		return new BigDecimal(v);
	}

}
