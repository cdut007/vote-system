package com.itender.ms.directive;

import com.itender.ms.util.CommonUtility;
import freemarker.template.TemplateModelException;
import freemarker.template.TemplateNumberModel;
import freemarker.template.TemplateScalarModel;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import java.util.Map;

/**
 * 模板工具类
 * @author Administrator
 *
 */
@Component
public class FreemarkerTemplateUtility extends ApplicationObjectSupport {
	private static ApplicationContext context;
//	private static FreeMarkerConfigurer freemarkerConfig;

	/**
	 * 创建静态页面
	 * @param templatePath	模板路径（相对配置的根目录）
	 * @param htmlPath 生产页面路径（绝对路径）
	 * @param rootMap 传入模板的变量
	 * @return
	 */
//	public static boolean createHtml(String templatePath, String htmlPath,
//			Map<String, Object> rootMap) {
//		Writer out = null;
//		boolean result = true;
//		try {
//			Template t = getTemplate(templatePath);
//			t.setEncoding("UTF-8");
//			File file = new File(htmlPath);
//			String parent = file.getParent();
//			File dir = new File(parent);
//			if(!dir.exists()) {
//				dir.mkdirs();
//			}
//
//			if(!file.exists()) {
//				file.createNewFile();
//			}
//			out = new BufferedWriter(new OutputStreamWriter(
//					new FileOutputStream(file),"UTF-8"));
//			t.process(rootMap, out);
//			out.flush();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			result = false;
//		} finally {
//			try {
//				out.close();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//				result = false;
//			}
//		}
//		return result;
//	}

	/**
	 * 输出到客户端
	 * @param templatePath 模板路径（绝对路径）
	 * @param response
	 * @param rootMap
	 * @return
	 */
//	public static boolean write2Client(String templatePath,
//			HttpServletResponse response, Map<String, Object> rootMap) {
//		return respone2client(templatePath, response, rootMap, "UTF-8");
//	}

	/**
	 * 输出到客户端
	 * @param templateName 模板路径（绝对路径）
	 * @param response
	 * @param rootMap
	 * @param code 编码方式
	 * @return
	 */
//	public static boolean write2Client(String templateName,
//			HttpServletResponse response, Map<String, Object> rootMap,
//			String code) {
//		return respone2client(templateName, response, rootMap, code);
//	}

//	private static boolean respone2client(String templateName,
//			HttpServletResponse response, Map<String, Object> rootMap,
//			String code) {
//		Writer out = null;
//		boolean result = true;
//		try {
//			Template t = getTemplate(templateName);
//			response.setCharacterEncoding(code);
//			response.setContentType("text/html;charset=" + code);
//			out = response.getWriter();
//			t.process(rootMap, out);
//			out.flush();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			result = false;
//		} finally {
//			try {
//				out.close();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//				result = false;
//			}
//		}
//		return result;
//	}

//	private static Template getTemplate(String templateName) throws IOException, TemplateException {
//		freemarkerConfig.setTemplateLoaderPaths("/", CMSThemeUtil.getThemePath(),templateName.substring(0,templateName.lastIndexOf("\\")));
//		Configuration defualtConf = freemarkerConfig.getConfiguration();
//		Configuration conf = freemarkerConfig.createConfiguration();
//		Set set = defualtConf.getSharedVariableNames();
//		if(set != null) {
//			Iterator iter  = set.iterator();
//			while(iter.hasNext()) {
//				String key = (String) iter.next();
//				conf.setSharedVariable(key,defualtConf.getSharedVariable(key));
//			}
//		}
//		return conf.getTemplate(templateName, "utf-8");
//	}

	/**
	 * 将模板输出结果返回
	 * @param templatePath 模板路径（绝对路径）
	 * @param rootMap 变量
	 * @return String
	 */
//	public static String getTemplateAsString(String templatePath,
//			Map<String, Object> rootMap) {
//		Writer writer = null;
//		String result = null;
//		try {
//			Template t = getTemplate(templatePath);
//			writer = new StringWriter();
//			t.process(rootMap, writer);
//			result = writer.toString();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} finally {
//			try {
//				writer.close();
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
//		return result;
//	}

	/**
	 * 从MAP中获取String类参数
	 * 
	 * @param params
	 * @param key
	 * @return
	 */
	public static String getStringValueFromParams(@SuppressWarnings("rawtypes") Map params, String key) {
		String value = null;
		try {
			if (params != null && CommonUtility.isNonEmpty(key)) {
				Object valueObj = params.get(key);
				if (valueObj != null) {
					if (valueObj instanceof TemplateScalarModel) {
						TemplateScalarModel valueModel = (TemplateScalarModel) valueObj;
						value = valueModel.getAsString();
					} else {
						throw new TemplateModelException(key
								+ " must be string!");
					}
				}
			}
		} catch (TemplateModelException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return CommonUtility.isNonEmpty(value)?value:null;
	}

	public static Integer getIntValueFromParams(@SuppressWarnings("rawtypes") Map params, String key) {
		Integer value = null;
		try {
			if (params != null && CommonUtility.isNonEmpty(key)) {
				Object valueObj = params.get(key);
				if (valueObj != null) {
					if (valueObj instanceof TemplateScalarModel) {
						TemplateScalarModel valueModel = (TemplateScalarModel) valueObj;
						String valueStr = valueModel.getAsString();
						if(CommonUtility.isNumber(valueStr)){
							value = Integer.parseInt(valueStr);
						}else{
							value = null;
						}
					} else if (valueObj instanceof TemplateNumberModel) {
						value = ((TemplateNumberModel) valueObj).getAsNumber()
								.intValue();
					} else {
						throw new TemplateModelException(key
								+ " must be a string or number!");
					}
				}
			}
		} catch (TemplateModelException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return value;
	}

//	@Override
//	protected void initApplicationContext(ApplicationContext c)
//			throws BeansException {
//		// TODO Auto-generated method stubthi
//			context = c;
//			freemarkerConfig = (FreeMarkerConfigurer) context
//					.getBean("freemarkerConfig");
//		super.initApplicationContext(c);
//	}
}
