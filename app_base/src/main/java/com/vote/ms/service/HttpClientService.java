package com.bank.guarantee.ms.service;

import org.json.JSONObject;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

@Service
public class HttpClientService {


	public String client(String url, HttpMethod method, JSONObject jsonObject){
		RestTemplate client = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		//  请勿轻易改变此提交方式，大部分的情况下，提交方式都是表单提交
		headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
		HttpEntity<String> requestEntity = new HttpEntity<String>(jsonObject.toString(),headers);
		//  执行HTTP请求
		try{
			ResponseEntity<String> response = client.exchange(url, HttpMethod.POST, requestEntity, String.class);
			return response.getBody();
		}catch (RestClientException e){
			e.printStackTrace();
			return e.getLocalizedMessage();
		}


	}

}
