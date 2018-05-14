package com.itender.ms.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.*;
import com.itender.ms.enums.ReviewSignType;
import com.itender.ms.enums.ReviewType;
import com.itender.ms.enums.SignResult;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderReviewService;
import com.itender.ms.service.ItenderUserService;
import com.itender.ms.service.impl.SocketIoService;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.HttpHelper;
import com.itender.ms.util.ViewUtil;
import com.itextpdf.text.pdf.BaseFont;
import fr.opensagres.xdocreport.itext.extension.font.IFontProvider;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.poi.xwpf.converter.pdf.PdfConverter;
import org.apache.poi.xwpf.converter.pdf.PdfOptions;
import org.apache.poi.xwpf.usermodel.*;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

@Api(description = "测试交易平台接口")
@Validated
@Controller
@RequestMapping("/test")
public class TestJCEController {
	 private static final Logger logger = LoggerFactory.getLogger(TestJCEController.class);


    @Autowired
    private HttpHelper httpHelper;
    private String domain="http://47.93.99.57";//"http://192.168.99.44:8080";



    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request,HttpServletResponse response){
        return "test/test";
    }

    @ApiIgnore
    @RequestMapping("/test")
    public String test(HttpServletRequest request,HttpServletResponse response){
        return "test/test";
    }

    private String sessionId;


    @ApiOperation(value = "用户登录接口",notes = "用于用户登出")
    @RequestMapping(value = "/logout",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> logOut(HttpServletRequest request
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
//api url地址
        String url = domain+"/logout";
         sessionId = null;
        return ResponseEntity.ok(result);
    }



    @ApiOperation(value = "創建項目",notes = "用于創建項目")
    @RequestMapping(value = "/createProject",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> createProject(HttpServletRequest request
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
//api url地址
        String url = domain+"/projectInstance/saveProjectInstance";
        JSONObject   jsonObject = new JSONObject();
        //得到long类型当前时间
        long l = System.currentTimeMillis();
//new日期对象
        Date date = new Date(l);
//转换提日期输出格式
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDate = dateFormat.format(date);
        try {

            jsonObject.put("token","");
                    jsonObject.put("createByAgency"," false");
            jsonObject.put("projectId","da72b534-f47a-49b8-a500-a82a50c6617e");
            jsonObject.put("zbxmmc","自動測試test***"+currentDate);
            jsonObject.put("organProjectCode","");
            jsonObject.put("projectInstanceType","A01");
            jsonObject.put("zbzrr0","222");
            jsonObject.put("zbfs00","1");
            jsonObject.put("zbzzxs","2");
            jsonObject.put("reviewType","1");
            jsonObject.put("prereviewType","2");
            jsonObject.put("nryfw0","ttt");
            jsonObject.put("shbmmc","22");
            jsonObject.put("shbmdm","");
            jsonObject.put("jdbmmc","1");
            jsonObject.put("jdbmdm","");
            jsonObject.put("jdbmfzr","12");
            jsonObject.put("jdbmdh","13123456789");
            ResponseEntity resultInfo =  clientForm(url,HttpMethod.POST,jsonObject);
            if(resultInfo.getStatusCodeValue() == 200){
              //parse 關鍵字
               String json = (String) resultInfo.getBody();
               JSONObject  resultData = new JSONObject(json);

                result.put("status", resultData.optBoolean("success"));
                result.put("msg", resultData.optString("msg"));
            }else{
                result.put("status", false);
                result.put("msg", "創建失敗!");
                return ResponseEntity.ok(result);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok(result);
    }



    @ApiOperation(value = "用户登录接口",notes = "用于用户登录")
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> login(HttpServletRequest request,
                                                    @ApiParam(name = "username",value = "用户名",required = true) @RequestParam(required = true) String username,
                                                    @ApiParam(name = "password",value = "密码",required = true) @RequestParam(required = true) String password,
                                                    @ApiParam(name = "verify",value = "verify",required = true) @RequestParam(required = true) String verify
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
//api url地址
        String url = domain+"/login";
        JSONObject   jsonObject = new JSONObject();
        try {
            jsonObject.put("username",username);
            jsonObject.put("password",password);
            jsonObject.put("validateCode","");
            jsonObject.put("isVerify","");
            jsonObject.put("verify",verify);
            ResponseEntity resultInfo =  clientForm(url,HttpMethod.POST,jsonObject);
            if(resultInfo.getStatusCodeValue() == 302){
                HttpHeaders headers = resultInfo.getHeaders();
                List<String> cookies = headers.get("Set-Cookie");
                if(cookies == null){
                    result.put("status", true);
                    result.put("msg", "登录成功!");
                    return ResponseEntity.ok(result);
                }
                for (String cookie : cookies) {
                   if(cookie.startsWith("shiro.session.id")){
                       sessionId = cookie;
                       result.put("status", true);
                       result.put("msg", "登录成功!");
                       return ResponseEntity.ok(result);
                   }
                }

            }else{
                result.put("status", false);
                result.put("msg", "用戶名密碼錯誤!");
                return ResponseEntity.ok(result);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok(result);
    }



    public ResponseEntity clientForm(String url, HttpMethod method, JSONObject jsonObject){
        RestTemplate client = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("User-Agent","Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko");
        //  请勿轻易改变此提交方式，大部分的情况下，提交方式都是表单提交
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
       if(sessionId!=null){
           headers.set("Cookie",sessionId);
       }
        Iterator<String> it = jsonObject.keys();
        String bodyValTemplate = "";
        while(it.hasNext()){
// 获得key
            String key = it.next();
            String value = jsonObject.optString(key);
            System.out.println("key: "+key+",value:"+value);
            try {
                bodyValTemplate += "&"+key+"="+URLEncoder.encode(value,"utf-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }

        }
        HttpEntity entity = new HttpEntity(bodyValTemplate, headers);

        //  执行HTTP请求
        try{
            ResponseEntity<String> response =   client.exchange(url, HttpMethod.POST, entity, String.class);
            return response;
        }catch (RestClientException e){
            e.printStackTrace();
            return null;
        }


    }


    public String client(String url, HttpMethod method, JSONObject jsonObject){
        RestTemplate client = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("User-Agent","Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko");
        //  请勿轻易改变此提交方式，大部分的情况下，提交方式都是表单提交
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        if(sessionId!=null){
            headers.set("Cookie",sessionId);
        }
        //  请勿轻易改变此提交方式，大部分的情况下，提交方式都是表单提交
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
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
