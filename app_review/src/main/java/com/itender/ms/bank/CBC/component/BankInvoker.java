package com.itender.ms.bank.CBC.component;

import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.itender.ms.bank.CBC.request.RequestAp;
import com.itender.ms.bank.CBC.response.ResponseAp;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@Component
public class BankInvoker {
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	//@Value(value = "${bank.host}")
	private String HOST="bank-server";//="59.49.39.55";
	//@Value(value = "${bank.port}")
	private int PORT=8899;//=8899;

	private XmlMapper xml = new XmlMapper();

	public ResponseAp call(RequestAp ap) throws Exception {
		String xmlString = xml.writeValueAsString(ap);
		logger.debug("请求报文:" + xmlString);
		URL url = new URL("http://" + HOST + ":" + PORT);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setDoInput(true);
		connection.setDoOutput(true);
		connection.setConnectTimeout(60000);
		connection.setReadTimeout(60000);
		BufferedOutputStream out = new BufferedOutputStream(connection.getOutputStream());
		//String param = URLEncoder.encode(xmlString, Constants.encoding_GBK);
		String param =xmlString;
		byte[] buf = param.getBytes();
		out.write(buf, 0, buf.length);
		out.flush();
		out.close();
		BufferedReader in = new BufferedReader(new InputStreamReader(new BufferedInputStream(connection.getInputStream()),"GBK"));
		String line = null;
		StringBuffer sb = new StringBuffer();
		while (null != (line = in.readLine())) {
			sb.append(line);
		}
		in.close();
		logger.debug("响应报文:" + sb);
		ResponseAp responseAp = xml.readValue(sb.toString(), ResponseAp.class);
		if (!"0000".equals(responseAp.getHead().getParticularCode())) {
			logger.error(responseAp.getHead().getParticularInfo());
			throw new RuntimeException(responseAp.getHead().getParticularInfo());
		}
		connection.disconnect();

		return responseAp;
	}
}
