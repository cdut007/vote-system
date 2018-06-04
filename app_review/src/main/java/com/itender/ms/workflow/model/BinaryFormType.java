package com.itender.ms.workflow.model;

import org.activiti.engine.form.AbstractFormType;

public class BinaryFormType extends AbstractFormType {

	@Override
	public String getName() {
		return "binary";
	}

	@Override
	public Object convertFormValueToModelValue(String paramString) {
		return paramString;
	}

	@Override
	public String convertModelValueToFormValue(Object paramObject) {
		return (String) paramObject;
	}

}
