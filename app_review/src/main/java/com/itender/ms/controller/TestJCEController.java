package com.itender.ms.controller;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.JsonSerializable;
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
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.TextNode;
import org.jsoup.select.Elements;
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
        String url = getDomain()+"/logout";
         sessionId = null;
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "任务流程详细接口",notes = "用于任务流程详细")
    @RequestMapping(value = "/workflow/customTaskForm",method = RequestMethod.GET)
    public ResponseEntity<Map<String,Object>> customTaskForm(HttpServletRequest request,
                                                             @RequestParam(required = true) String taskId
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();

        try {
            JSONObject   jsonObject = new JSONObject();
            jsonObject.put("token","");
            jsonObject.put("createByAgency"," false");
            Jsoup jsoup;//委托代理机构
            String url = getDomain()+"/workflow/customTaskForm?taskId="+taskId;
            ResponseEntity resultInfo =  clientForm(url,HttpMethod.GET,jsonObject);
            if(resultInfo.getStatusCodeValue() == 200){
                //parse 關鍵字
                String html = (String) resultInfo.getBody();
                Document doc = Jsoup.parse(html);
                 Element element = doc.getElementById("ur_here");
                List<TextNode> textNodes = element.textNodes();
                result.put("status", true);
                for (int i = 0; i < textNodes.size(); i++) {
                    if(textNodes.get(i).text().contains("委托代理机构")){
                        parseChooseOrganizationA(doc,result);
                        break;
                    }
                }

//                JSONObject  resultData = new JSONObject(json);
//
//                result.put("status", resultData.optBoolean("success"));
//                result.put("msg", resultData.optString("msg"));
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

    private void parseChooseOrganizationA(Document doc, Map<String, Object> result) {
        Element table = doc.select("table.mytable").first();
        Elements trs = table.select("tr");

        com.alibaba.fastjson.JSONArray jsonArray = new com.alibaba.fastjson.JSONArray();
        for (Element tr : trs) {
            Elements tds = tr.select("td");
            if(tds.size()>1){
                Elements alinks = tds.get(1).select("a");
                if(alinks!=null && alinks.size()>0){
                    Element a  = alinks.first();
                    String linkHref = a.attr("href");
                    String title =  a.attr("title");
                    com.alibaba.fastjson.JSONObject data = new com.alibaba.fastjson.JSONObject();
                    data.put("title",title);
                     Map params = URLRequest(linkHref);
                    data.put("organizationAId",params.get("id"));
                    data.put("taskId",params.get("taskId"));
                    jsonArray.add(data);
                }

            }else{
                continue;
            }

        }

        result.put("data",jsonArray);
    }


    /**
     * 解析出url参数中的键值对
     * 如 "index.jsp?Action=del&id=123"，解析出Action:del,id:123存入map中
     *
     * @param URL url地址
     * @return url请求参数部分
     */
    public static Map<String, String> URLRequest(String URL) {
        Map<String, String> mapRequest = new HashMap<String, String>();

        String[] arrSplit = null;

        String strUrlParam = TruncateUrlPage(URL);
        if (strUrlParam == null) {
            return mapRequest;
        }
        //每个键值为一组 www.2cto.com
        arrSplit = strUrlParam.split("[&]");
        for (String strSplit : arrSplit) {
            String[] arrSplitEqual = null;
            arrSplitEqual = strSplit.split("[=]");

            //解析出键值
            if (arrSplitEqual.length > 1) {
                //正确解析
                mapRequest.put(arrSplitEqual[0], arrSplitEqual[1]);

            } else {
                if (arrSplitEqual[0] != "") {
                    //只有参数没有值，不加入
                    mapRequest.put(arrSplitEqual[0], "");
                }
            }
        }
        return mapRequest;
    }
    /**
     * 去掉url中的路径，留下请求参数部分
     *
     * @param strURL url地址
     * @return url请求参数部分
     */
    private static String TruncateUrlPage(String strURL) {
        String strAllParam = null;
        String[] arrSplit = null;

        strURL = strURL.trim();

        arrSplit = strURL.split("[?]");
        if (strURL.length() > 1) {
            if (arrSplit.length > 1) {
                if (arrSplit[1] != null) {
                    strAllParam = arrSplit[1];
                }
            }
        }

        return strAllParam;
    }

    private String getDomain(){
        return  domain;
    }

    public void setDomain(String domain) {
        if(domain == null||StringUtils.isEmpty(domain)){
            return;
        }
        this.domain = domain;
    }

    @ApiOperation(value = "获取任务列表",notes = "用于获取任务列表")
    @RequestMapping(value = "/workflow/pagingTask",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> getTaskList(HttpServletRequest request,
                                                          @RequestParam(required = false) Integer pageNum,
                                                          @RequestParam(required = false) Integer pagesize
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
//api url地址
        String url =  getDomain()+"/workflow/pagingTask";
        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;
        JSONObject   jsonObject = new JSONObject();
        try {

            jsonObject.put("page",pageNum);
            jsonObject.put("pageSize",pagesize);

            ResponseEntity resultInfo =  clientForm(url,HttpMethod.POST,jsonObject);
            if(resultInfo.getStatusCodeValue() == 200){
                //parse 關鍵字
                String json = (String) resultInfo.getBody();
                JSONObject  resultData = new JSONObject(json);

                result.put("status", resultData.optBoolean("success"));
                result.put("msg", resultData.optString("msg"));
                return ResponseEntity.ok(convertToLayuiData(resultData,200,"success"));
            }else{
                result.put("status", false);
                result.put("msg", "获取失敗!");
                return ResponseEntity.ok(convertToLayuiData(new JSONObject(""),200,"success"));
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok(convertToLayuiData(jsonObject,200,"success"));
    }

    public static final LayuiTableData convertToLayuiData(JSONObject jsonObject,Integer statusCode,String msg) {
        LayuiTableData<Object> objectLayuiTableData = new LayuiTableData<>();
        List<Object> jsonObjectList = new ArrayList<>();
        JSONArray jsonArray = jsonObject.optJSONArray("rows");

        if(jsonArray!=null){
            for (int i = 0; i < jsonArray.length(); i++) {
                try {

                    jsonObjectList.add( JSON.parse(jsonArray.getJSONObject(i).toString()));
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }

        objectLayuiTableData.setData(jsonObjectList);
        objectLayuiTableData.setPageNum(jsonObject.optInt("page"));
        objectLayuiTableData.setPages(jsonObject.optInt("pages"));
        objectLayuiTableData.setPageSize(jsonObject.optInt("pageSize"));
        objectLayuiTableData.setStatusCode(statusCode);
        objectLayuiTableData.setMsg(msg);
        objectLayuiTableData.setTotal((long) (jsonObject.optInt("total")));
        return objectLayuiTableData;
    }


    @ApiOperation(value = "創建項目",notes = "用于創建項目")
    @RequestMapping(value = "/createProject",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> createProject(HttpServletRequest request
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
//api url地址
        String url =  getDomain()+"/projectInstance/saveProjectInstance";
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
            jsonObject.put("projectId","c0af1ffe-f435-443a-a40d-28f415aa2c3b");
            jsonObject.put("zbxmmc","程序自動測試，请勿操作test***"+currentDate);
            jsonObject.put("organProjectCode","");
            jsonObject.put("projectInstanceType","A01");
            jsonObject.put("zbzrr0","james");
            jsonObject.put("zbfs00","1");
            jsonObject.put("zbzzxs","2");
            jsonObject.put("reviewType","1");
            jsonObject.put("prereviewType","2");
            jsonObject.put("nryfw0","ttt");
            jsonObject.put("shbmmc","22");
            jsonObject.put("shbmdm","");
            jsonObject.put("jdbmmc","1");
            jsonObject.put("jdbmdm","");
            jsonObject.put("jdbmfzr","james");
            jsonObject.put("jdbmdh","18688173429");
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




    @ApiOperation(value = "选择代理机构接口",notes = "用于选择代理机构")
    @RequestMapping(value = "/commitOrgazationA",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> commitOrgazationA(HttpServletRequest request,
                                                    @ApiParam(name = "orgId",value = "代理机构id",required = true) @RequestParam(required = true) String orgId,
                                                                @ApiParam(name = "organAName",value = "代理机构organAName",required = false) @RequestParam(required = false) String organAName,
                                                    @ApiParam(name = "taskId",value = "任务id",required = true) @RequestParam(required = true) String taskId
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();

        String url =  getDomain()+"/workflow/completeForm";
        JSONObject   jsonObject = new JSONObject();


        try {
            jsonObject.put("taskId",taskId);
            jsonObject.put("organId",orgId);
            jsonObject.put("organAName",organAName);
            jsonObject.put("contractSignMode",true);//默认在线签订

            ResponseEntity resultInfo =  clientForm(url,HttpMethod.POST,jsonObject);
            if(resultInfo.getStatusCodeValue() == 200){
                String json = (String) resultInfo.getBody();
                if(json.contains("系统内部错误，请联系管理员")){
                    result.put("status", false);
                    result.put("msg", "选择代理机构失败!");
                    return ResponseEntity.ok(result);
                }

                result.put("status", true);
                //result.put("msg", resultData.optString("msg"));

            }else if(resultInfo.getStatusCodeValue() == 302){
                result.put("status", true);
              //  result.put("msg", resultData.optString("msg"));
                return ResponseEntity.ok(result);
            }else{
                result.put("status", false);
                result.put("msg", "选择代理机构失败!");
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
                                                    @ApiParam(name = "verify",value = "verify",required = true) @RequestParam(required = true) String verify,
                                                    @ApiParam(name = "domain",value = "domain",required = false) @RequestParam(required = false) String domain
    ) throws APIException{
        sessionId =null;
        Map<String,Object> result = new HashMap<>();
        setDomain(domain);
//api url地址
        String url =  getDomain()+"/login";
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
            ResponseEntity<String> response =   client.exchange(url, method, entity, String.class);
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
