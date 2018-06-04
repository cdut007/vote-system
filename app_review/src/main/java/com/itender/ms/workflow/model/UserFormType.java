package com.itender.ms.workflow.model;

import org.activiti.engine.form.AbstractFormType;

/*****
 * activiti 人员表单类型
 * 
 * @author ZORO
 * 
 */
public class UserFormType extends AbstractFormType {
	@Override
	public String getName() {
		return "user";
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
		String paramString = paramObject.toString();
		return  paramString;
		//return SpringContextUtil.getBean(IBaseService.class).get(IUser.class, paramString).getUserName() + ":" + paramString;
	}
}
