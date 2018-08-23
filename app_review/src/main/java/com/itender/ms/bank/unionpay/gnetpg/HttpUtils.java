package com.itender.ms.bank.unionpay.gnetpg;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

/**
 * 功能说明
 * <ul>
 * <li>创建文件描述：HttpUtils工具，doPost、doGet</li>
 * <li>修改文件描述：</li>
 * </ul>
 * 
 * @author <ul>
 *         <li>创建者：<a href="mailto:43840397@qq.com">蔡越锐 </a></li>
 *         <li>修改者：</li>
 *         </ul>
 * @version <ul>
 *          <li>创建版本：v1.0.0 日期：2011-11-19</li>
 *          <li>修改版本：</li>
 *          </ul>
 */
public class HttpUtils
{
	private int httpStatus = -1;
	private final int TIME_OUT = 60000;
	
	public String doHttpPost(String postUrl, String params, String charset, String Referer)
	{
		return doHttpPost(postUrl, params, charset, Referer, null,null);
	}

	public String doHttpPost(String postUrl, String params, String charset, String Referer, String ContentType,String cookie)
	{
		System.out.println("系统使用HTTP-doHttpPost:"+postUrl);
		int timeOut = TIME_OUT;
		charset = charset == null ? "UTF-8" : charset;
		StringBuffer buffer = new StringBuffer();
		buffer.append("发送失败");
		HttpURLConnection c = null;
		try
		{
			if (postUrl == null || "".equals(postUrl.trim()))
				throw new Exception("PostUrl不能为空");
			if (params == null || "".equals(params.trim()))
				throw new Exception("POST参数不能为空");
//			if (Referer == null || "".equals(Referer.trim()))
//				throw new Exception("商户域名不能为空");

			URL url = new URL(postUrl);
			c = (HttpURLConnection) url.openConnection();
			c.setInstanceFollowRedirects(true);
			c.setRequestMethod("POST");
			c.setRequestProperty("Accept-Language", "zh-cn"); 
			c.setRequestProperty("Accept", "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*");
			if (ContentType == null || "".equals(ContentType.trim())) c.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			else c.setRequestProperty("ContenGneteMerchantAPI/api/PayV36t-Type", ContentType);
			c.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Mathon 2.0)");
			c.setRequestProperty("Connection", "Keep-Alive");
			c.setRequestProperty("Accept-Charset", charset);
			c.setRequestProperty("Charsert", charset);
			if(Referer!=null){
				c.setRequestProperty("Referer", Referer);
			}

			if(cookie!=null){
				c.setRequestProperty("Cookie", cookie);
			}
			c.setDoOutput(true);
			c.setDoInput(true);
			c.setConnectTimeout(timeOut);// 设置连接主机超时（单位：毫秒）
			c.setReadTimeout(timeOut);// 设置从主机读取数据超时（单位：毫秒）
			c.connect();
			PrintWriter out = new PrintWriter(new OutputStreamWriter(c.getOutputStream(), charset));// 发送数据
			out.print(params);
			out.flush();
			out.close();
			String header;
			for (int i = 0; true; i++)
			{
				header = c.getHeaderField(i);
				if (header == null)
					break;
			}
			int res = 0;
			res = c.getResponseCode();
			this.httpStatus = res;
//			if(httpStatus == 302){
//				Map<String, List<String>> headers = c.getHeaderFields();
//
//			  List<String>	locations = headers.get("Location");
//			  if(locations!=null && locations.size()>0){
//				  Map<String, List<String>> cookies = c.getRequestProperties();
//			     return  doHttpPost(locations.get(0),params,charset,Referer,ContentType,	c.getRequestProperty("Cookie"));
//			  }
//			}

			InputStream u = c.getInputStream();
			BufferedReader in = new BufferedReader(new InputStreamReader(u, charset));
			String line = "";
			buffer = new StringBuffer();
			char _line = 10;
			while ((line = in.readLine()) != null)
			{
				buffer.append(line).append(_line);
			}
			u.close();
			in.close();
		}
		catch (IOException ex)
		{
			ex.printStackTrace();
			return ex.toString();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			return ex.toString();
		}
		finally
		{
			if (c != null)
				c.disconnect();
		}
		return buffer.toString();
	}

	public Map<String, String> getParam(String httpParam)
	{
		String[] httpParamList = httpParam.split("&");
		Map<String, String> map = new HashMap<String, String>();
		for (String Param : httpParamList)
		{
			int flag = Param.indexOf("=");
			if (flag == -1)
				continue;
			String _key = Param.substring(0, flag);
			String _value = Param.substring(flag + 1, Param.length());
			map.put(_key, _value);
		}
		return map;
	}


	/**
	 * 得到参数列表字符串
	 * @param method   请求类型 get or  post
	 * @param paramValues 参数map对象
	 * @return  参数列表字符串
	 */
	public static String getParams(String method,Map<String, String> paramValues)
	{
		String params="";
		Set<String> key = paramValues.keySet();
		String beginLetter="";
		if (method.equalsIgnoreCase("get"))
		{
			beginLetter="?";
		}

		for (Iterator<String> it = key.iterator(); it.hasNext();) {
			String s = (String) it.next();
			if (params.equals(""))
			{
				params += beginLetter + s + "=" + paramValues.get(s);
			}
			else
			{
				params += "&" + s + "=" + paramValues.get(s);
			}
		}
		return params;
	}


	public int getHttpStatus()
	{
		return httpStatus;
	}
}
