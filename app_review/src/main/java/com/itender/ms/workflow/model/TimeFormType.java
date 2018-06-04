package com.itender.ms.workflow.model;

import org.activiti.engine.form.AbstractFormType;

/****
 * activiti 时间表单类型
 * 
 * @author ZORO
 * 
 */
public class TimeFormType extends AbstractFormType {

	@Override
	public String getName() {
		return "time";
	}

	@Override
	public Object convertFormValueToModelValue(String paramString) {
		return paramString;
	}

	@Override
	public String convertModelValueToFormValue(Object paramObject) {
		if (paramObject == null) {
			return null;
		}
		return paramObject.toString();
	}
}
