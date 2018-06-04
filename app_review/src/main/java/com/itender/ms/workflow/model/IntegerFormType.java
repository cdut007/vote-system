package com.itender.ms.workflow.model;

import org.activiti.engine.form.AbstractFormType;
import org.apache.commons.lang3.StringUtils;

/*****
 * ACTIVITI整型表单类型
 * 
 * @author ZORO
 * 
 */
public class IntegerFormType extends AbstractFormType {

	@Override
	public Object convertFormValueToModelValue(String paramString) {
		if (StringUtils.isBlank(paramString)) {
			return null;
		}
		return Integer.parseInt(paramString);
	}

	@Override
	public String convertModelValueToFormValue(Object paramObject) {
		if (paramObject == null) {
			return null;
		}
		return paramObject.toString();
	}

	@Override
	public String getName() {
		return "integer";
	}

}
