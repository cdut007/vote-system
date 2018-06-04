package com.itender.ms.workflow.model;

import org.activiti.engine.form.AbstractFormType;

import java.io.Serializable;

/****
 * ACTIVITI大文本表单类型
 * 
 * @author ZORO
 * 
 */
public class TextFormType extends AbstractFormType {

	/****
	 * 大文本类型
	 * 
	 * @author ZORO
	 * 
	 */
	public static class Text implements Serializable {
		/**
			 * 
			 */
		private static final long serialVersionUID = -4617073969142416374L;

		private String text;

		public Text(String text) {
			super();
			this.text = text;
		}

		public String getText() {
			return text;
		}

		public void setText(String text) {
			this.text = text;
		}
	}

	@Override
	public String getName() {
		return "text";
	}

	@Override
	public Object convertFormValueToModelValue(String paramString) {
		return new Text(paramString);
	}

	@Override
	public String convertModelValueToFormValue(Object paramObject) {
		if (paramObject == null) {
			return null;
		}
		return ((Text) paramObject).getText();
	}

}
