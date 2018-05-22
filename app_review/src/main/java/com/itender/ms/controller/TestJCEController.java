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
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.client.LaxRedirectStrategy;
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
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.*;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import springfox.documentation.annotations.ApiIgnore;

import javax.net.ssl.SSLContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
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
    private String domain = "https://stage.jcebid.com";//"http://192.168.99.44:8080";
    private HashMap<String, String> sessionIdMap = new HashMap<>();


    String getProjectId() {
        //666666 项目固定
        return "c0af1ffe-f435-443a-a40d-28f415aa2c3b";
    }

    public RestTemplate restTemplateRequestFactory() {
        try {
            return restTemplateRequestFactory(false);
        } catch (KeyStoreException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }
        return null;
    }

    public RestTemplate restTemplateRequestFactory(boolean redirect) throws KeyStoreException, NoSuchAlgorithmException, KeyManagementException {
        TrustStrategy acceptingTrustStrategy = (X509Certificate[] chain, String authType) -> true;

        SSLContext sslContext = org.apache.http.ssl.SSLContexts.custom()
                .loadTrustMaterial(null, acceptingTrustStrategy)
                .build();

        SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext);

        CloseableHttpClient httpClient = null;
        if (redirect) {
            httpClient = HttpClients.custom()
                    .setSSLSocketFactory(csf).setRedirectStrategy(new LaxRedirectStrategy()).build();
        } else {
            httpClient = HttpClients.custom()
                    .setSSLSocketFactory(csf).build();
        }


        HttpComponentsClientHttpRequestFactory requestFactory =
                new HttpComponentsClientHttpRequestFactory();

        requestFactory.setHttpClient(httpClient);

        RestTemplate client = new RestTemplate();
        client.setRequestFactory(requestFactory);

        return client;
    }


    public static boolean isLinux(String OS) {
        return OS.indexOf("linux") >= 0;
    }

    public static boolean isMacOS(String OS) {
        return OS.indexOf("mac") >= 0 && OS.indexOf("os") > 0 && OS.indexOf("x") < 0;
    }

    public static boolean isMacOSX(String OS) {
        return OS.indexOf("mac") >= 0 && OS.indexOf("os") > 0 && OS.indexOf("x") > 0;
    }

    public static boolean isWindows(String OS) {
        return OS.indexOf("windows") >= 0;
    }

    static void parseChooseOrganizationA(Document doc, Map<String, Object> result, String type) {
        result.put("type", type);
        Element table = doc.select("table.mytable").first();
        Elements trs = table.select("tr");

        com.alibaba.fastjson.JSONArray jsonArray = new com.alibaba.fastjson.JSONArray();
        for (Element tr : trs) {
            Elements tds = tr.select("td");
            if (tds.size() > 1) {
                Elements alinks = tds.get(1).select("a");
                if (alinks != null && alinks.size() > 0) {
                    Element a = alinks.first();
                    String linkHref = a.attr("href");
                    String title = a.attr("title");
                    com.alibaba.fastjson.JSONObject data = new com.alibaba.fastjson.JSONObject();
                    data.put("title", title);
                    Map params = URLRequest(linkHref);
                    data.put("organizationAId", params.get("id"));
                    data.put("taskId", params.get("taskId"));
                    jsonArray.add(data);
                }

            } else {
                continue;
            }

        }

        result.put("data", jsonArray);
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

    public static final LayuiTableData convertToLayuiData(JSONObject jsonObject, Integer statusCode, String msg) {
        LayuiTableData<Object> objectLayuiTableData = new LayuiTableData<>();
        List<Object> jsonObjectList = new ArrayList<>();
        JSONArray jsonArray = jsonObject.optJSONArray("rows");

        if (jsonArray != null) {
            for (int i = 0; i < jsonArray.length(); i++) {
                try {

                    jsonObjectList.add(JSON.parse(jsonArray.getJSONObject(i).toString()));
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

    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "test/test";
    }

    @ApiIgnore
    @RequestMapping("/test")
    public String test(HttpServletRequest request, HttpServletResponse response) {
        return "test/test";
    }

    @ApiOperation(value = "用户登录接口", notes = "用于用户登出")
    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> logOut(HttpServletRequest request
    ) throws APIException {
        Map<String, Object> result = new HashMap<>();
//api url地址
        String url = getDomain() + "/logout";
        removeUserSessionCache(request.getParameter("userId"));

        return ResponseEntity.ok(result);
    }

    boolean removeUserSessionCache(String userId) {

        sessionIdMap.remove(userId);
        return true;
    }

    String getUserSessionCache(String userId) {

        return sessionIdMap.get(userId);
    }

    void setUserSessionCache(String userId, String sessionId) {
        sessionIdMap.put(userId, sessionId);
    }


    @ApiOperation(value = "报名", notes = "报名")
    @RequestMapping(value = "/tenderApplicationForm", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> tenderApplicationForm(HttpServletRequest request
    ) throws APIException {


        Map<String, Object> result = new HashMap<>();
        String noticeId = request.getParameter("noticeId");
        if (noticeId == null) {
            noticeId = (String) request.getAttribute("noticeId");//for test
        }
        String url = getDomain() + "/tenderApply/tenderApplyForm?noticeId=" + noticeId;
        ResponseEntity resultInfo = clientForm(getUserSessionCache(request.getParameter("userId")), url, HttpMethod.GET, new JSONObject());
        if (resultInfo.getStatusCodeValue() != 200) {
            //parse 關鍵字
            result.put("status", false);
            return ResponseEntity.ok(result);
        }

        String html = (String) resultInfo.getBody();
        Document doc = Jsoup.parse(html);
        Element itemName = doc.getElementsByAttributeValue("name", "item_ids").first();
        String itemId = itemName.attr("value");
        String id = doc.getElementById("id").attr("value");
        String projectInstanceId = doc.getElementById("projectInstanceId").attr("value");

        //save init first

        String initUrl = getDomain() + "/tenderApply/tenderApply";
        JSONObject initJsonObject = new JSONObject();

        try {
            initJsonObject.put("signData_raw", "1234556677");
            initJsonObject.put(itemId, "1234556677");
            initJsonObject.put("noticeId", noticeId);
            initJsonObject.put("projectInstanceId", projectInstanceId);
            initJsonObject.put("tenderItemList[0].projectItemId", itemId);
            initJsonObject.put("isComplete", "false");
            initJsonObject.put("token", doc.getElementsByAttributeValue("name", "token").first().attr("value"));
            initJsonObject.put("signatureData", null);
            initJsonObject.put("sealName", "四川投标测试单位1");
            initJsonObject.put("content", doc.getElementById("content").attr("value"));
        } catch (JSONException e) {
            e.printStackTrace();
        }

        ResponseEntity initResultInfo = clientForm(getUserSessionCache(request.getParameter("userId")), initUrl, HttpMethod.POST, initJsonObject);
        if (initResultInfo.getStatusCodeValue() != 200) {
            result.put("status", false);
            result.put("msg", "init upload failed");
            return ResponseEntity.ok(result);
        }

        //上传附件
        String uploadUrl = getDomain() + "/attachment/uploadAttachment";
        JSONObject uploadJsonObject = new JSONObject();

        try {
            if (StringUtils.isEmpty(id)) {
                id = new JSONObject((String) initResultInfo.getBody()).optString("data");
            }
            uploadJsonObject.put("fjsszt", id);
            uploadJsonObject.put("fjgslx", "39");
            uploadJsonObject.put("fjmc00", "test");
            uploadJsonObject.put("fjdzqm", "test");
        } catch (JSONException e) {
            e.printStackTrace();
        }

        File attachFile = new File(getFileDirByName("attach_files") + "test.pdf");
        ResponseEntity uploadResultInfo = clientFileForm(getUserSessionCache(request.getParameter("userId")), uploadUrl, attachFile.getPath(), uploadJsonObject);
        if (uploadResultInfo.getStatusCodeValue() != 200) {
            result.put("status", false);
            result.put("msg", "upload failed");
            return ResponseEntity.ok(result);
        }


        String uploadJson = (String) uploadResultInfo.getBody();

        if (uploadJson.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "上传文件失败!");
            return ResponseEntity.ok(result);
        }

        JSONObject resultUploadData = null;
        try {
            resultUploadData = new JSONObject(uploadJson);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        if (!resultUploadData.optBoolean("success")) {
            return ResponseEntity.ok(result);
        }


        String applyUrl = getDomain() + "/tenderApply/tenderApply";
        JSONObject tenderInfo = new JSONObject();
        try {
            tenderInfo.put("signData_raw", "1234556677");
            tenderInfo.put(itemId, "1234556677");
            tenderInfo.put("noticeId", noticeId);
            tenderInfo.put("projectInstanceId", projectInstanceId);
            tenderInfo.put("tenderItemList[0].projectItemId", itemId);
            tenderInfo.put("isComplete", "true");

            tenderInfo.put("id", id);
            tenderInfo.put("token", doc.getElementsByAttributeValue("name", "token").first().attr("value"));
            tenderInfo.put("signatureData", null);
            tenderInfo.put("sealName", "四川投标测试单位1");
            tenderInfo.put("content", doc.getElementById("content").attr("value"));

        } catch (JSONException e) {
            e.printStackTrace();
        }
        ResponseEntity applyResultInfo = clientForm(getUserSessionCache(request.getParameter("userId")), applyUrl, HttpMethod.POST, tenderInfo);
        if (applyResultInfo.getStatusCodeValue() != 200) {
            //parse 關鍵字

            result.put("status", false);
            return ResponseEntity.ok(result);
        }

        JSONObject resultData = null;
        try {
            resultData = new JSONObject((String) applyResultInfo.getBody());
            if (!resultData.optBoolean("success")) {
                result.put("status", false);
                return ResponseEntity.ok(result);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }


        String joinUrl = getDomain() + "/tenderApply/tenderApplyStartFlow";
        JSONObject joinJsonObject = new JSONObject();

        try {
            joinJsonObject.put("tenderId", resultData.optString("data"));

        } catch (JSONException e) {
            e.printStackTrace();
        }

        File joinFile = new File(getFileDirByName("attach_files") + "test_sign.aip");
        ResponseEntity joinResultInfo = clientFileForm(getUserSessionCache(request.getParameter("userId")), joinUrl, joinFile.getPath(), joinJsonObject);
        if (joinResultInfo.getStatusCodeValue() != 200) {
            result.put("status", false);
            result.put("msg", "upload failed");
            return ResponseEntity.ok(result);
        }

        String joinJson = (String) joinResultInfo.getBody();

        if (joinJson.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "上传文件失败!");
            return ResponseEntity.ok(result);
        }


        result.put("status", true);
        return ResponseEntity.ok(result);


    }


    @ApiOperation(value = "获取投标报名项目列表", notes = "获取投标报名项目列表")
    @RequestMapping(value = "/getTenderProjectList", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> getProjectTenderList(HttpServletRequest request
    ) throws APIException {
        Map<String, Object> result = new HashMap<>();
        String url = getDomain() + "/front_notice/pagingNotice";
        ResponseEntity resultInfo = clientForm(getUserSessionCache(request.getParameter("userId")), url, HttpMethod.GET, new JSONObject());
        if (resultInfo.getStatusCodeValue() != 200) {
            //parse 關鍵字

            result.put("status", false);
            return ResponseEntity.ok(result);
        }
        String html = (String) resultInfo.getBody();
        Document doc = Jsoup.parse(html);
        Elements noticeItems = doc.select("span.titleG");


        com.alibaba.fastjson.JSONArray jsonArray = new com.alibaba.fastjson.JSONArray();
        for (Element tr : noticeItems) {

            Elements alinks = tr.select("a");
            if (alinks != null && alinks.size() > 0) {
                Element a = alinks.get(1);
                String linkHref = a.attr("href");
                String title = a.text();
                com.alibaba.fastjson.JSONObject data = new com.alibaba.fastjson.JSONObject();
                data.put("title", title);
                String id = linkHref.substring(linkHref.lastIndexOf("/") + 1);
                data.put("noticeId", id);
                jsonArray.add(data);
            }


        }

        result.put("data", jsonArray);
        result.put("status", true);
        return ResponseEntity.ok(result);


    }


    @ApiOperation(value = "任务流程详细接口", notes = "用于任务流程详细")
    @RequestMapping(value = "/workflow/customTaskForm", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> customTaskForm(HttpServletRequest request,
                                                              @RequestParam(required = true) String taskId
    ) throws APIException {
        Map<String, Object> result = new HashMap<>();

        try {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("token", "");
            jsonObject.put("createByAgency", " false");
            String assignee = request.getParameter("assignee");
            if (StringUtils.isEmpty(assignee)) {
                String url = getDomain() + "/workflow/claim?taskId=" + taskId;
                ResponseEntity resultInfo = clientForm(getUserSessionCache(request.getParameter("userId")), url, HttpMethod.GET, jsonObject);
                if (resultInfo.getStatusCodeValue() != 200) {
                    result.put("status", false);
                    result.put("msg", "处理失敗!");
                    return ResponseEntity.ok(result);
                }

                result.put("status", true);
                result.put("msg", "签收成功!");
                return ResponseEntity.ok(result);
            }


            String url = getDomain() + "/workflow/customTaskForm?taskId=" + taskId;
            ResponseEntity resultInfo = clientForm(getUserSessionCache(request.getParameter("userId")), url, HttpMethod.GET, jsonObject);
            if (resultInfo.getStatusCodeValue() == 200) {
                //parse 關鍵字
                String html = (String) resultInfo.getBody();
                Document doc = Jsoup.parse(html);
                Element element = doc.getElementById("ur_here");

                String title = doc.title();

                result.put("status", true);
                List<TextNode> textNodes = null;
                if (element != null && (textNodes = element.textNodes()) != null) {
                    for (int i = 0; i < textNodes.size(); i++) {
                        String text = textNodes.get(i).text();
                        if (text.contains("委托代理机构")) {
                            parseChooseOrganizationA(doc, result, "委托代理机构");
                            break;
                        } else if (text.contains("上传委托代理合同")) {
                            boolean isOk = parseUploadCommissionContract(request.getParameter("userId"), doc, result, "上传委托代理合同");
                            if (!isOk) {
                                result.put("status", false);
                                result.put("msg", "处理失敗!");
                                return ResponseEntity.ok(result);
                            } else {
                                break;
                            }

                        } else if (text.contains("指定项目经理")) {
                            //张经理id 3227a76b-5305-48ce-a171-b2681bd02cce
                            parseDeliveryPeople("3227a76b-5305-48ce-a171-b2681bd02cce", request.getParameter("userId"), taskId, doc, result, "指定项目经理");
                            break;
                        } else if (text.contains("指定待办人")) {
                            //赵专员id 8bff5fac-c6ad-4382-bed4-17d490872252
                            parseDeliveryPeople("8bff5fac-c6ad-4382-bed4-17d490872252", request.getParameter("userId"), taskId, doc, result, "指定待办人");
                            break;
                        } else if (text.contains("指定报名审核专员")) {
                            //赵专员id 8bff5fac-c6ad-4382-bed4-17d490872252
                            parseDeliveryPeople("8bff5fac-c6ad-4382-bed4-17d490872252", request.getParameter("userId"), taskId, doc, result, "指定报名审核专员");
                            break;
                        } else if (text.contains("项目管理")) {
                            //
                            parseProjectPublish(request.getParameter("userId"), taskId, doc, result, "项目管理");
                            break;
                        } else if (text.contains("招标/资格预审公告审核")) {
                            parseProjectReview(taskId, request.getParameter("userId"), doc, result, "招标/资格预审公告审核");
                            break;
                        } else if (text.contains("专家抽取申请信息")) {
                            parseProjectReview(taskId, request.getParameter("userId"), doc, result, "专家抽取申请信息");
                            break;
                        } else if (text.contains("报名申请")) {

//                            if(true){
//                                request.setAttribute("noticeId","5f8f0ca4-69f7-436f-a067-af9b4b98b8e3");
//                                tenderApplicationForm(request);
//                                return ResponseEntity.ok(result);
//                            }
                            parseProjectReview(taskId, request.getParameter("userId"), doc, result, "报名申请");
                            break;
                        } else if (text.contains("投标文件上传") && !text.contains("回执")) {
                            uploadTenderBidFile(request.getParameter("userId"), taskId, doc, result, "投标文件上传");
                            break;
                        } else if (text.contains("开标现场")) {
                            parseProjectReview(taskId, request.getParameter("userId"), doc, result, "开标现场");
                            break;
                        } else if(text.contains("专家签到")){
                            exportSign(request.getParameter("userId"), taskId, doc, result, "专家签到");
                            break;
                        }else if (text.contains("投标文件上传回执")){
                            parseProjectReview(taskId, request.getParameter("userId"), doc, result, "投标文件上传回执");
                            break;
                        }
                    }
                } else {
                    if ("招标文件项目经理审核".equals(title)) {
                        parseProjectReview(taskId, request.getParameter("userId"), doc, result, "招标文件项目经理审核");

                    } else if ("招标文件代理机构审核".equals(title)) {
                        parseProjectReview(taskId, request.getParameter("userId"), doc, result, "招标文件代理机构审核");
                    }
                }


//                JSONObject  resultData = new JSONObject(json);
//
//                result.put("status", resultData.optBoolean("success"));
//                result.put("msg", resultData.optString("msg"));
            } else {
                result.put("status", false);
                result.put("msg", "处理失敗!");
                return ResponseEntity.ok(result);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok(result);

    }


    String getFileDirByName(String name) {
        String root = "C:\\\\";
        String os = System.getProperty("os.name").toLowerCase();
        if (isMacOS(os) || isMacOSX(os)) {
            root = "/Users/mac/Downloads";
        } else if (isLinux(os)) {
            root = "/root";
        }

        String filePath = root + File.separator + "data" + File.separator + name + File.separator;
        return filePath;
    }


    private  boolean exportSign(String userId, String taskId, Document doc, Map<String, Object> result, String type) throws JSONException {
        result.put("type", type);
        String exportUrl = getDomain() + "/expertPromise/expertPromiseSave";
        JSONObject expoertSignJsonObject = new JSONObject();
        File signAttachFile = new File(getFileDirByName("attach_files") + "test_sign.aip");
        expoertSignJsonObject.put("name", signAttachFile.getName());
        expoertSignJsonObject.put("taskId", taskId);
        expoertSignJsonObject.put("projectInstanceId", doc.getElementsByAttributeValue("name","projectInstanceId").first().attr("value"));
        expoertSignJsonObject.put("projectInstanceName", doc.getElementsByAttributeValue("name","projectInstanceName").first().attr("value"));
        expoertSignJsonObject.put("userType", "1");
        String expertApplyId = doc.getElementsByAttributeValue("name","expertApplyId").first().attr("value");
        expoertSignJsonObject.put("expertApplyId", expertApplyId);
        String getExportIdUrl = getDomain() + "/expertPromise/expertPromise?expertApplyId="+expoertSignJsonObject.get("expertApplyId")+"&taskId="+taskId;

        ResponseEntity docmentIdInfo = clientForm(getUserSessionCache(userId), getExportIdUrl, HttpMethod.GET, new JSONObject());
        if (docmentIdInfo.getStatusCodeValue() != 200) {

            result.put("status", false);
            result.put("msg", "处理失败!");
            return false;

        }

        String expertPromiseId = Jsoup.parse((String) docmentIdInfo.getBody()).getElementById("DocumentID").attr("value");
        expoertSignJsonObject.put("id", expertPromiseId);
        expoertSignJsonObject.put("DocumentID", expertPromiseId);

        ResponseEntity uploadResultInfo = clientFileForm(getUserSessionCache(userId), exportUrl, signAttachFile.getPath(), expoertSignJsonObject);
        if (uploadResultInfo.getStatusCodeValue() != 200) {
            result.put("status", false);
            result.put("msg", "upload failed");
            return false;
        }

        String uploadJson = (String) uploadResultInfo.getBody();

        if (uploadJson != null && uploadJson.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "审核失败!");
            return false;
        }

        //更新工作流状态
        String activitiUrl = getDomain() + "/expertPromise/expertPromiseAvoid";
        JSONObject activitiJsonObject = new JSONObject();

        activitiJsonObject.put("taskId", taskId);
        activitiJsonObject.put("expertApplyId", expertApplyId);

        ResponseEntity taskResultInfo = clientForm(getUserSessionCache(userId), activitiUrl, HttpMethod.POST, activitiJsonObject);
        if (taskResultInfo.getStatusCodeValue() != 200) {

            result.put("status", false);
            result.put("msg", "处理失败!");
            return false;

        }

        uploadJson = (String) taskResultInfo.getBody();

        if (uploadJson != null && uploadJson.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "审核失败!");
            return false;
        }


        //回避承诺书
        exportUrl = getDomain() + "/expertPromise/expertPromiseAvoidSave";
        uploadResultInfo = clientFileForm(getUserSessionCache(userId), exportUrl, signAttachFile.getPath(), expoertSignJsonObject);
        if (uploadResultInfo.getStatusCodeValue() != 200) {
            result.put("status", false);
            result.put("msg", "upload failed");
            return false;
        }

         uploadJson = (String) uploadResultInfo.getBody();

        if (uploadJson != null && uploadJson.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "审核失败!");
            return false;
        }

        result.put("status", true);

        return true;



    }

    private boolean uploadTenderBidFile(String userId, String taskId, Document doc, Map<String, Object> result, String type) throws JSONException {
        result.put("type", type);

        String uploadBidFileUrl = getDomain() + "/uploadBidFile";
        JSONObject bidJsonObject = new JSONObject();
        File signAttachFile = new File(getFileDirByName("attach_files") + "test_tender_file.ebid");
        bidJsonObject.put("name", signAttachFile.getName());
        String tenderItemId = doc.getElementById("tenderItemId").attr("value");
        bidJsonObject.put("fjsszt", tenderItemId);
        bidJsonObject.put("tenderItemId", tenderItemId);
        bidJsonObject.put("fjgslx", "10");
        bidJsonObject.put("envelopeTypeOrder", "first");
        bidJsonObject.put("unique", "true");

        ResponseEntity uploadResultInfo = clientFileForm(getUserSessionCache(userId), uploadBidFileUrl, signAttachFile.getPath(), bidJsonObject);
        if (uploadResultInfo.getStatusCodeValue() != 200) {
            result.put("status", false);
            result.put("msg", "upload failed");
            return false;
        }

        String uploadJson = (String) uploadResultInfo.getBody();

        if (uploadJson != null && uploadJson.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "审核失败!");
            return false;
        }

        JSONObject resultUploadData = new JSONObject(uploadJson);
        if (!resultUploadData.optBoolean("success")) {
            return false;
        }

        uploadBidFileUrl = getDomain() + "/attachment/uploadAttachment";
        bidJsonObject = new JSONObject();
        signAttachFile = new File(getFileDirByName("attach_files") + "test_tender_pic.png");
        bidJsonObject.put("name", signAttachFile.getName());
        bidJsonObject.put("fjsszt", tenderItemId);
        bidJsonObject.put("fjgslx", "24");
        bidJsonObject.put("unique", "false");

        uploadResultInfo = clientFileForm(getUserSessionCache(userId), uploadBidFileUrl, signAttachFile.getPath(), bidJsonObject);
        if (uploadResultInfo.getStatusCodeValue() != 200) {
            result.put("status", false);
            result.put("msg", "upload failed");
            return false;
        }

        uploadJson = (String) uploadResultInfo.getBody();

        if (uploadJson != null && uploadJson.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "审核失败!");
            return false;
        }

        resultUploadData = new JSONObject(uploadJson);
        if (!resultUploadData.optBoolean("success")) {
            return false;
        }


        result.put("status", true);

        return true;


    }

    boolean parseDeliveryPeople(String ownnerId, String userId, String taskId, Document doc, Map<String, Object> result, String type) throws JSONException {

        result.put("type", type);


        //更新工作流状态
        String activitiUrl = getDomain() + "/workflow/completeForm";
        JSONObject activitiJsonObject = new JSONObject();


        activitiJsonObject.put("taskId", taskId);
        activitiJsonObject.put("ownerId", ownnerId);

        ResponseEntity taskResultInfo = clientForm(getUserSessionCache(userId), activitiUrl, HttpMethod.POST, activitiJsonObject);
        if (taskResultInfo.getStatusCodeValue() != 302) {

            result.put("status", false);
            result.put("msg", "处理失败!");
            return false;

        }
        result.put("status", true);
        String json = (String) taskResultInfo.getBody();
//        JSONObject resultData = new JSONObject(json);
//        result.put("status", resultData.optBoolean("success"));
//        result.put("msg", resultData.optString("msg"));

        return true;
    }

    private boolean parseProjectReview(String taskId, String userId, Document doc, Map<String, Object> result, String type) throws JSONException {
        result.put("type", type);
        Element reviewId = doc.getElementsByAttributeValue("name", "id").first();//招标内容

        JSONObject reviewJsonObject = new JSONObject();
        if (reviewId != null) {
            String id = reviewId.attr("value");
            reviewJsonObject.put("id", id);
        }


        reviewJsonObject.put("taskId", taskId);
        reviewJsonObject.put("pass", "true");
        reviewJsonObject.put("shyj", "程序自动同意");

        //更新工作流状态
        // 1 如果是代理机构需要传盖章的文件
        //上传附件 id="sign"
        if (doc.getElementById("sign") != null) {
            boolean completeTask = false;
            String uploadUrl = getDomain() + "/notice/noticeReviewTOrA";
            if (type.equals("招标文件代理机构审核")) {
                uploadUrl = getDomain() + "/recruitFile/updateRecruitFilePdf";
                String html = doc.html();
                String content = "\"id\":";
                int pos = html.indexOf(content);
                if (pos > 0) {
                    String subStr = html.substring(pos + content.length(), pos + 100);
                    int first = subStr.indexOf("\"") + 1;
                    String id = subStr.substring(first, subStr.indexOf("\"", first));
                    reviewJsonObject.put("id", id);
                }
                completeTask = true;
            } else if (type.equals("专家抽取申请信息")) {
                uploadUrl = getDomain() + "/expertApplication/expertApplyArchiveA";

                String html = doc.html();
                String content = "\"DocumentID\":";
                String expertApplyId = "\"expertApplyId\":";
                int pos = html.indexOf(content);
                if (pos > 0) {
                    String subStr = html.substring(pos + content.length(), pos + 200);
                    int first = subStr.indexOf("\"") + 1;
                    String id = subStr.substring(first, subStr.indexOf("\"", first));
                    reviewJsonObject.put("DocumentID", id);

                    int pos2 = subStr.indexOf(expertApplyId);
                    if (pos2 > 0) {
                        String sub2Str = subStr.substring(pos2 + expertApplyId.length());
                        int first2 = sub2Str.indexOf("\"") + 1;
                        String expertApplyIdStr = sub2Str.substring(first2, sub2Str.indexOf("\"", first2));
                        reviewJsonObject.put("expertApplyId", expertApplyIdStr);
                    }

                }

            }else if (type.equals("投标文件上传回执")){
                uploadUrl = getDomain() + "/tenderApply/saveBidReceipt";

                reviewJsonObject.put("id", doc.getElementsByAttributeValue("name","id").first().attr("value"));
                completeTask = true;
            }


            File signAttachFile = new File(getFileDirByName("attach_files") + "test_sign.aip");
            ResponseEntity uploadResultInfo = clientFileForm(getUserSessionCache(userId), uploadUrl, signAttachFile.getPath(), reviewJsonObject);
            if (uploadResultInfo.getStatusCodeValue() != 200) {
                result.put("status", false);
                result.put("msg", "upload failed");
                return false;
            }

            String uploadJson = (String) uploadResultInfo.getBody();

            if (uploadJson != null && uploadJson.contains("系统内部错误，请联系管理员")) {
                result.put("status", false);
                result.put("msg", "审核失败!");
                return false;
            }

            if (completeTask) {
                String activitiUrl = getDomain() + "/workflow/completeForm";
                ResponseEntity taskResultInfo = clientForm(getUserSessionCache(userId), activitiUrl, HttpMethod.POST, reviewJsonObject);
                if (taskResultInfo.getStatusCodeValue() != 302) {

                    result.put("status", false);
                    result.put("msg", "审核失败!");
                    return false;

                }
            }

        } else {

            if (type.equals("报名申请")) {

                String applyUrl = getDomain() + "/tenderApply/startTenderReceiptFlow";
                String id = doc.getElementById("id").attr("value");
                JSONObject applyObject = new JSONObject();
                applyObject.put("id", id);
                ResponseEntity applyResultInfo = clientForm(getUserSessionCache(userId), applyUrl, HttpMethod.POST, applyObject);
                if (applyResultInfo.getStatusCodeValue() != 200) {

                    result.put("status", false);
                    result.put("msg", "审核失败!");
                    return false;
                }

                boolean ok = new JSONObject((String) applyResultInfo.getBody()).optBoolean("success");
                if (!ok) {
                    result.put("status", false);
                    result.put("msg", "审核失败!");
                    return false;
                }
                reviewJsonObject.put("nopassReason", "");
                reviewJsonObject.put("id", id);
                reviewJsonObject.put("projectInstanceId", doc.getElementById("projectInstanceId").attr("value"));
                reviewJsonObject.put("noticeId", doc.getElementById("noticeId").attr("value"));


            }else if (type.equals("开标现场")){
                reviewJsonObject.put("projectInstanceId", doc.getElementsByAttributeValue("name","projectInstanceId").first().attr("value"));
                reviewJsonObject.put("projectInstanceName",  doc.getElementsByAttributeValue("name","projectInstanceName").first().attr("value"));
                reviewJsonObject.put("expertApplyId",  doc.getElementsByAttributeValue("name","expertApplyId").first().attr("value"));
                reviewJsonObject.put("userType", "3");

            }


            String activitiUrl = getDomain() + "/workflow/completeForm";
            ResponseEntity taskResultInfo = clientForm(getUserSessionCache(userId), activitiUrl, HttpMethod.POST, reviewJsonObject);
            if (taskResultInfo.getStatusCodeValue() != 302) {

                result.put("status", false);
                result.put("msg", "审核失败!");
                return false;

            }
        }


        result.put("status", "true");
        result.put("msg", "同意");

        return true;

    }

    boolean parseProjectPublish(String userId, String taskId, Document doc, Map<String, Object> result, String type) throws JSONException {
        result.put("type", type);

        Element projectInstance = doc.getElementById("id");
        String projectInstanceId = projectInstance.attr("value");


        //查询存在的标段
        String projectItemCheckUrl = getDomain() + "/projectItem/pagingProjectItemData";
        JSONObject projectItemJsonObject = new JSONObject();
        JSONArray projectItemDatas = new JSONArray();
        projectItemJsonObject.put("projectInstanceId", projectInstanceId);
        ResponseEntity projectItemJsonInfo = clientForm(getUserSessionCache(userId), projectItemCheckUrl, HttpMethod.POST, projectItemJsonObject);
        if (projectItemJsonInfo.getStatusCodeValue() == 200) {

            try {
                JSONArray datas = new JSONArray((String) projectItemJsonInfo.getBody());

                if (datas != null && datas.length() > 0) {
                    projectItemDatas = datas;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        //查询招标文件是否已经通过
        String projectStatusCheckUrl = getDomain() + "/recruitFile/pagingRecruitFileData";
        JSONObject projectStatusJsonObject = new JSONObject();
        JSONArray projectStatusDatas = new JSONArray();
        projectStatusJsonObject.put("projectInstanceId", projectInstanceId);
        projectStatusJsonObject.put("page", "1");
        projectStatusJsonObject.put("pageSize", "10");
        ResponseEntity projectStatusJsonInfo = clientForm(getUserSessionCache(userId), projectStatusCheckUrl, HttpMethod.POST, projectStatusJsonObject);
        if (projectStatusJsonInfo.getStatusCodeValue() == 200) {

            try {
                JSONObject data = new JSONObject((String) projectStatusJsonInfo.getBody());
                JSONArray datas = data.optJSONArray("rows");

                if (datas != null && datas.length() > 0) {

                    int reviewStatus = datas.getJSONObject(0).optInt("reviewStatus");
                    if (reviewStatus == 9) {
                        //抽专家
                        parseExpert(userId, taskId, doc, result, projectInstanceId, projectItemDatas.getJSONObject(0).optString("id"));
                        return true;
                    }
                    return false;
                }
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }

        }


        //检查当前已经创建的通知是否存在并审核通过

        String currentNoticesStatusUrl = getDomain() + "/notice/bidNoticeList";
        JSONObject queryNoticeStatusJsonObject = new JSONObject();

        queryNoticeStatusJsonObject.put("projectInstanceId", projectInstanceId);
        queryNoticeStatusJsonObject.put("page", "1");
        queryNoticeStatusJsonObject.put("pageSize", "10");
        ResponseEntity noticeStatusInfo = clientForm(getUserSessionCache(userId), currentNoticesStatusUrl, HttpMethod.POST, queryNoticeStatusJsonObject);
        if (noticeStatusInfo.getStatusCodeValue() == 200) {

            JSONObject datas = new JSONObject((String) noticeStatusInfo.getBody());

            JSONArray rows = datas.optJSONArray("rows");

            if (rows != null && rows.length() > 0) {
                String status = rows.optJSONObject(0).optString("ggzt");
                if (status.equals("审核通过")) {
                    //如果制作完毕 等待报名开标
                    //1 登录招标编辑器发布招标文件关联，2 制作招标文件 3 抽专家
                    loginTenderEditorCreateTender(result, projectInstanceId, projectItemDatas.getJSONObject(0).optString("id"));
                    parseTenderProjectCreate(userId, doc, result, projectInstanceId, projectItemDatas.getJSONObject(0).optString("id"));
                    return true;
                }

                result.put("status", false);
                result.put("msg", "正在审核招标文件!");
                return false;

            }

        }


        if (projectItemDatas.length() > 0) {
            //标段已经存在
            result.put("status", false);
            result.put("msg", "标段已经存在!");
            return false;
        }


        Element nryfw0 = doc.getElementById("nryfw0");//招标内容

        Element terms = doc.getElementsByAttributeValue("name", "terms").first();//招标内容
        //保存招标内容
        String saveProjectUrl = getDomain() + "/projectInstance/updateProjectInstanceByAgentUser";
        JSONObject saveJsonObject = new JSONObject();

        saveJsonObject.put("id", projectInstanceId);
        saveJsonObject.put("nryfw0", nryfw0.text());
        saveJsonObject.put("terms", terms.text());
        saveJsonObject.put("contacts", "james");
        saveJsonObject.put("phones", "18688173429");
        ResponseEntity saveResultInfo = clientForm(getUserSessionCache(userId), saveProjectUrl, HttpMethod.POST, saveJsonObject);
        if (saveResultInfo.getStatusCodeValue() != 200) {

            result.put("status", false);
            result.put("msg", "更新失败!");
            return false;

        }

        String uploadJson = (String) saveResultInfo.getBody();

        if (uploadJson.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "更新招标文件失败!");
            return false;
        }

        JSONObject resultUploadData = new JSONObject(uploadJson);
        if (!resultUploadData.optBoolean("success")) {
            return false;
        }


        //得到long类型当前时间
        long l = System.currentTimeMillis();
//new日期对象
        Date date = new Date(l);
//转换提日期输出格式
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDate = dateFormat.format(date);
        //提交标段
        String url = getDomain() + "/projectItem/saveOrUpdateProjectItem";

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("projectInstanceId", projectInstanceId);
        jsonObject.put("organProjectItemCode", "AUTO-TEST-" + currentDate);
        jsonObject.put("projectItemType", "A");
        jsonObject.put("bdfldm", "A080304");

        jsonObject.put("bdmc00", "标段编号程序自动化测试***" + currentDate);
        jsonObject.put("bdnr00", "标段内容程序自动测试***" + currentDate);
        jsonObject.put("jhkgrq", "2018-05-16");

        jsonObject.put("timeLimit", "30");
        jsonObject.put("tbzgtj", "自动测试 有钱有钱有钱");
        jsonObject.put("bdhtgj", "1000000");

        jsonObject.put("bdgjdw", "1");
        jsonObject.put("bdgjdm", "156");
        jsonObject.put("price", "100.00");


        ResponseEntity resultInfo = clientForm(getUserSessionCache(userId), url, HttpMethod.POST, jsonObject);
        if (resultInfo.getStatusCodeValue() != 200) {

            result.put("status", false);
            result.put("msg", "更新失败!");
            return false;
        }


        String saveItemPackageJson = (String) resultInfo.getBody();

        if (saveItemPackageJson.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "更新招标文件失败!");
            return false;
        }

        JSONObject saveItemPackageData = new JSONObject(saveItemPackageJson);
        JSONObject packageItemData = saveItemPackageData.optJSONObject("data");
        if (packageItemData == null) {
            result.put("status", false);
            result.put("msg", "保存标段失败!");
            return false;
        }


        String noticePageUrl = getDomain() + "/notice/addOrEditBidNotice?projectInstanceId=" + projectInstanceId + "&ggxzdm=1&gglxdm=1";

        //       ResponseEntity noticePageResultInfo = clientForm(getUserSessionCache(userId), noticePageUrl, HttpMethod.GET, new JSONObject());
        String attachmentSsztId = "", token = "";
//        if (noticePageResultInfo.getStatusCodeValue() == 200) {
//            String html = (String) noticePageResultInfo.getBody();
//            Document docPage = Jsoup.parse(html);
//            token = docPage.getElementsByAttributeValue("name", "token").first().attr("value");//招标内容
//            attachmentSsztId = docPage.getElementById("attachmentSsztId").attr("value");
//        }


        //创建资格后审公告 默认
        JSONObject noticeJsonObject = new JSONObject();
        String noticeUrl = getDomain() + "/notice/saveOrUpdateBidNotice";
        noticeJsonObject.put("changeContent", "<br/>程序自动测试<br/>");

        noticeJsonObject.put("ggnrwbverify", "");
        noticeJsonObject.put("token", token);
        noticeJsonObject.put("attachmentSsztId", attachmentSsztId);
        noticeJsonObject.put("projectInstanceId", projectInstanceId);
        noticeJsonObject.put("projectItemList", packageItemData.optString("id"));
        String projectName = doc.getElementsContainingOwnText("招标项目名称").first().nextElementSibling().text();
        noticeJsonObject.put("noticeTitle", projectName + "招标公告");
        noticeJsonObject.put("applyProjectNumber", "000001");
        noticeJsonObject.put("referenceNoticeId", "");
        noticeJsonObject.put("id", "");
        noticeJsonObject.put("content", "");
        noticeJsonObject.put("ggfbsj", getDate(System.currentTimeMillis()));//公告发布时间
        String time1, time2, time3, time4;
        String time;
        noticeJsonObject.put("tenderNoticeData.applyDateBegin", time1 = getDate(System.currentTimeMillis() + 5 * 60 * 1000));//招标文件获取时间
        noticeJsonObject.put("tenderNoticeData.applyDateEnd", time2 = getDate(System.currentTimeMillis() + 40 * 60 * 1000));//招标文件获取截止时间
        noticeJsonObject.put("tenderNoticeData.bidDeadline", time3 = getDate(System.currentTimeMillis() + 50 * 60 * 1000));//投标文件递交截止时间
        noticeJsonObject.put("tenderNoticeData.bidOpenDate", time4 = getDate(System.currentTimeMillis() + 60 * 60 * 1000));//开标时间

        time = "招标文件开始获取时间：" + time1 + ";招标文件获取截止时间：" + time2 + ";投标文件递交截止时间:" + time3 + ";开标时间：" + time4;
        noticeJsonObject.put("ggjssj", getDate(System.currentTimeMillis() + 60 * 60 * 1000));//公告结束时间
        noticeJsonObject.put("attachmentRequirementList[0].content", "test");
        noticeJsonObject.put("gglxdm", "1");
        noticeJsonObject.put("ggxzdm", "1");
        noticeJsonObject.put("tenderNoticeData.deliveryPlace", "(交货/施工/服务)地点---程序自動測試+" + currentDate);
        noticeJsonObject.put("isAudit", "1");
        noticeJsonObject.put("tenderNoticeData.quality", "质量要求---程序自動測試+" + currentDate);
        noticeJsonObject.put("tenderNoticeData.applyPlace", "文件获取地点---程序自動測試+" + currentDate);
        noticeJsonObject.put("tenderNoticeData.bidPlace", "投标地点---程序自動測試+" + currentDate);
        noticeJsonObject.put("tenderNoticeData.bidFileObtainWay", "招标文件获取方法---程序自動測試+" + currentDate);
        noticeJsonObject.put("tenderNoticeData.bidSendForm", "投标文件递交方法---程序自動測試+" + currentDate);
        noticeJsonObject.put("tenderNoticeData.bidOpenPlace", "开标地点---程序自動測試+" + currentDate);
        noticeJsonObject.put("payType", "1");
        noticeJsonObject.put("isWorkHoliday", "0");
        noticeJsonObject.put("isComboBid", "0");
        noticeJsonObject.put("fbzrr0", "公告发布责任人test");
        noticeJsonObject.put("yzzrr0", "交易平台验证责任人test");
        noticeJsonObject.put("content", "报名资料要求---程序自動測試+" + currentDate);
        noticeJsonObject.put("ggfbmtNameArray", "山西招投标网");
        noticeJsonObject.put("_ggfbmtNameArray", "on");
        noticeJsonObject.put("sealName", "SigndataStr");
        noticeJsonObject.put("signData", "");
        noticeJsonObject.put("SigndataStrSealName", "");
        noticeJsonObject.put("SigndataStrSignData", "");

        noticeJsonObject.put("isComplete", "true");
        noticeJsonObject.put("ggnrwb", "<p style = \"text-indent:0em;\" > <span > 一、</span > 自动测试项目 </p > <p style = \"text-indent:0em;\" > <span ></\n" +
                "        span ><span class=\"need_input u\" name = \"projectInstance.terms\" > 本招标项目 程序自動測試，请勿操作" + time + "</span > </p > <p > <br > </\n" +
                "        p >");

        ResponseEntity noticeResultInfo = clientForm(getUserSessionCache(userId), noticeUrl, HttpMethod.POST, noticeJsonObject);
        if (noticeResultInfo.getStatusCodeValue() != 200) {

            result.put("status", false);
            result.put("msg", "公告发布失败!");
            return false;
        }

        String json = (String) noticeResultInfo.getBody();

        if (json.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "公告发布失败!");
            return false;
        }


        JSONObject resultData = new JSONObject(json);
        result.put("status", resultData.optBoolean("success"));
        result.put("msg", resultData.optString("msg"));

        return true;
    }


    private boolean parseTenderProjectCreate(String userId, Document doc, Map<String, Object> result, String projectInstanceId, String itemId) throws JSONException {
        JSONObject tenderPoject = new JSONObject();
        //   tenderPoject.put("id", "2c91b4bc-63724367-0163-72598a94-000f");
        tenderPoject.put("isPrejudication", "false");
        tenderPoject.put("projectItemId", itemId);
        // tenderPoject.put("tenderNoticeData.deliveryPlace", "(交货/施工/服务)地点---程序自動測試+2018-05-17 18:58:53");
        tenderPoject.put("advanceTenderFileId", result.get("docId"));

        tenderPoject.put("tenderNoticeData.applyDateBegin", getDate(System.currentTimeMillis() + 5 * 60 * 1000));//招标文件获取时间

        tenderPoject.put("tenderNoticeData.applyDateEnd", getDate(System.currentTimeMillis() + 40 * 60 * 1000));//招标文件获取截止时间
        tenderPoject.put("tenderNoticeData.bidDeadline", getDate(System.currentTimeMillis() + 50 * 60 * 1000));//投标文件递交截止时间
        tenderPoject.put("tenderNoticeData.bidOpenDate", getDate(System.currentTimeMillis() + 60 * 60 * 1000));//开标时间

        tenderPoject.put("recruitFileData.bidValidity", "90");
        tenderPoject.put("clarifytime", getDate(System.currentTimeMillis()));
        tenderPoject.put("controlPrice", "100000");
        tenderPoject.put("controlPricePart", "100000");
        tenderPoject.put("controlPriceMeasure", "100000");
        tenderPoject.put("recruitFileData.bidDepositType", "1");
        tenderPoject.put("recruitFileData.bidDepositAmount", "1000.00");
        tenderPoject.put("recruitFileData.bidDepositUnit", "1");
        //tenderPoject.put("tenderNoticeData.bidSendForm","投标文件递交方法-- - 程序自動測試 + 2018 - 05 - 17 18:58:53");

        //  tenderPoject.put("tenderNoticeData.bidOpenPlace","开标地点-- - 程序自動測試 + 2018 - 05 - 17 18:58:53");
        tenderPoject.put("recruitFileData.bidOpenForm", "test开标方式");
        tenderPoject.put("recruitFileData.juryTUserNum", "0");
        tenderPoject.put("recruitFileData.juryExpertNum", "5");
        tenderPoject.put("recruitFileData.evaluationMethodId", "2.0");
        tenderPoject.put("recruitFileData.benchmarkId", "a789f3dd-9256-427a-990e-9dbec8d661a8");
        tenderPoject.put("recruitFileData.reviewMode", "SCORE");
        tenderPoject.put("preliminaryReviewType", "形式评审");
        tenderPoject.put("evaluationFactor", "测试");
        tenderPoject.put("reviewStandard", "测试");
        tenderPoject.put("preliminaryReviewType", "资格评审");
        tenderPoject.put("evaluationFactor", "测试");
        tenderPoject.put("reviewStandard", "是");
        tenderPoject.put("preliminaryReviewType", "响应性评审");
        tenderPoject.put("evaluationFactor", "测试");
        tenderPoject.put("reviewStandard", "是");
        tenderPoject.put("groupFlag", "price");
        tenderPoject.put("firstGroup", "报价部分");
        tenderPoject.put("flag", "price");
        tenderPoject.put("groupName", "报价部分");
        tenderPoject.put("needUnify", "1");
        tenderPoject.put("groupFullScore", "55.00");
        tenderPoject.put("groupFlag", "施工组织设计");
        tenderPoject.put("firstGroup", "施工组织设计");
        tenderPoject.put("groupAlgorithm", "0");
        tenderPoject.put("flag", "施工组织设计");
        tenderPoject.put("groupName", "施工组织设计");
        tenderPoject.put("needUnify", "0");
        tenderPoject.put("groupFullScore", "25.00");
        tenderPoject.put("evaluationFactor", "测试");
        tenderPoject.put("reviewStandard", "测试");
        tenderPoject.put("itemFullScore", "25.00");
        tenderPoject.put("groupFlag", "投标人资信");
        tenderPoject.put("firstGroup", "投标人资信");
        tenderPoject.put("groupAlgorithm", "0");
        tenderPoject.put("flag", "投标人资信");
        tenderPoject.put("groupName", "投标人资信");
        tenderPoject.put("needUnify", "0");
        tenderPoject.put("groupFullScore", "20.00");
        tenderPoject.put("evaluationFactor", "测试");
        tenderPoject.put("reviewStandard", "测试");
        tenderPoject.put("itemFullScore", "20.00");
        tenderPoject.put("recruitFileData.candidateNum", "1");
        tenderPoject.put("DBFS", "1");
        tenderPoject.put("qualificationReviewList[0].reviewStage", "-1");
        tenderPoject.put("qualificationReviewList[0].preliminaryReviewType", "形式评审");
        tenderPoject.put("qualificationReviewList[0].evaluationFactor", "测试");
        tenderPoject.put("qualificationReviewList[0].reviewStandard", "测试");
        tenderPoject.put("qualificationReviewList[1].reviewStage", "-1");
        tenderPoject.put("qualificationReviewList[1].preliminaryReviewType", "资格评审");
        tenderPoject.put("qualificationReviewList[1].evaluationFactor", "测试");
        tenderPoject.put("qualificationReviewList[1].reviewStandard", "是");
        tenderPoject.put("qualificationReviewList[2].reviewStage", "-1");
        tenderPoject.put("qualificationReviewList[2].preliminaryReviewType", "响应性评审");
        tenderPoject.put("qualificationReviewList[2].evaluationFactor", "测试");
        tenderPoject.put("qualificationReviewList[2].reviewStandard", "是");
        tenderPoject.put("scoreReviewList[0].reviewStage", "1");
        tenderPoject.put("scoreReviewList[0].flag", "price");
        tenderPoject.put("scoreReviewList[0].groupName", "报价部分");
        tenderPoject.put("scoreReviewList[0].needUnify", "1");
        tenderPoject.put("scoreReviewList[0].groupFullScore", "55.00");
        tenderPoject.put("qualificationGroupList[0].reviewStage", "1");
        tenderPoject.put("qualificationGroupList[0].groupFlag", "price");
        tenderPoject.put("qualificationGroupList[0].firstGroup", "报价部分");
        tenderPoject.put("qualificationGroupList[0].groupName", "报价部分");
        tenderPoject.put("qualificationGroupList[1].reviewStage", "1");
        tenderPoject.put("qualificationGroupList[1].groupFlag", "施工组织设计");
        tenderPoject.put("qualificationGroupList[1].firstGroup", "施工组织设计");
        tenderPoject.put("qualificationGroupList[1].groupAlgorithm", "0");
        tenderPoject.put("qualificationGroupList[1].flag", "施工组织设计");
        tenderPoject.put("qualificationGroupList[1].groupName", "施工组织设计");
        tenderPoject.put("qualificationGroupList[1].needUnify", "0");
        tenderPoject.put("qualificationGroupList[1].groupFullScore", "25.00");
        tenderPoject.put("qualificationGroupList[1].groupAlgorithm", "0");
        tenderPoject.put("scoreReviewList[1].reviewStage", "1");
        tenderPoject.put("scoreReviewList[1].flag", "施工组织设计");
        tenderPoject.put("scoreReviewList[1].groupName", "施工组织设计");
        tenderPoject.put("scoreReviewList[1].needUnify", "0");
        tenderPoject.put("scoreReviewList[1].groupFullScore", "25.00");
        tenderPoject.put("scoreReviewList[1].evaluationFactor", "测试");
        tenderPoject.put("scoreReviewList[1].reviewStandard", "测试");
        tenderPoject.put("scoreReviewList[1].itemFullScore", "25.00");
        tenderPoject.put("qualificationGroupList[2].reviewStage", "1");
        tenderPoject.put("qualificationGroupList[2].groupFlag", "投标人资信");
        tenderPoject.put("qualificationGroupList[2].firstGroup", "投标人资信");
        tenderPoject.put("qualificationGroupList[2].groupAlgorithm", "0");
        tenderPoject.put("qualificationGroupList[2].flag", "投标人资信");
        tenderPoject.put("qualificationGroupList[2].groupName", "投标人资信");
        tenderPoject.put("qualificationGroupList[2].needUnify", "0");
        tenderPoject.put("qualificationGroupList[2].groupFullScore", "20.00");
        tenderPoject.put("qualificationGroupList[2].groupAlgorithm", "0");
        tenderPoject.put("scoreReviewList[2].reviewStage", "1");
        tenderPoject.put("scoreReviewList[2].flag", "投标人资信");
        tenderPoject.put("scoreReviewList[2].groupName", "投标人资信");
        tenderPoject.put("scoreReviewList[2].needUnify", "0");
        tenderPoject.put("scoreReviewList[2].groupFullScore", "20.00");
        tenderPoject.put("scoreReviewList[2].evaluationFactor", "测试");
        tenderPoject.put("scoreReviewList[2].reviewStandard", "测试");
        tenderPoject.put("scoreReviewList[2].itemFullScore", "20.00");
        tenderPoject.put("isComplete", "true");

        String noticeUrl = getDomain() + "/recruitFileData/saveOrUpdateRecruitFileData";
        ResponseEntity noticeResultInfo = clientForm(getUserSessionCache(userId), noticeUrl, HttpMethod.POST, tenderPoject);
        if (noticeResultInfo.getStatusCodeValue() != 200) {

            result.put("status", false);
            result.put("msg", "公告发布失败!");
            return false;
        }

        String json = (String) noticeResultInfo.getBody();

        if (json.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "公告发布失败!");
            return false;
        }


        JSONObject resultData = new JSONObject(json);
        result.put("status", resultData.optBoolean("success"));
        result.put("msg", resultData.optString("msg"));
        return true;
    }

    private boolean parseExpert(String userId, String taskId, Document doc, Map<String, Object> result, String projectInstanceId, String itemId) throws JSONException {

        //查询是否存在标段组合id

        JSONObject queryExportPoject = new JSONObject();
        queryExportPoject.put("projectInstanceId", projectInstanceId);
        queryExportPoject.put("page", "1");
        queryExportPoject.put("pageSize", "10");
        String queryExportUrl = getDomain() + "/projectItem/expertApplyListForEdit";
        ResponseEntity queryExportStatus = clientForm(getUserSessionCache(userId), queryExportUrl, HttpMethod.POST, queryExportPoject);

        if (queryExportStatus.getStatusCodeValue() != 200) {

            return false;
        }

        boolean exsitId = false;
        String id = null;
        try {
            String json = (String) queryExportStatus.getBody();
            JSONArray resultArrayData = new JSONArray(json);
            if (resultArrayData.length() > 0) {
                exsitId = true;
                //获取组合id
                id = resultArrayData.optJSONObject(0).optString("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (!exsitId) {
            JSONObject exportPoject = new JSONObject();
            exportPoject.put("projectInstanceId", projectInstanceId);
            exportPoject.put("projectItemList[0].id", itemId);
            String saveExportUrl = getDomain() + "/expertApplication/save";
            ResponseEntity exportStatus = clientForm(getUserSessionCache(userId), saveExportUrl, HttpMethod.POST, exportPoject);

            if (exportStatus.getStatusCodeValue() != 200) {
                return false;
            }
            String json = (String) exportStatus.getBody();
            JSONObject resultData = new JSONObject(json);
            if (!resultData.optBoolean("success")) {

                return false;
            }
            //获取组合id
            id = resultData.optJSONObject("data").optString("id");
        }


        //抽专家
        JSONObject getExport = new JSONObject();
        getExport.put("id", id);
        getExport.put("projectInstanceId", projectInstanceId);
        getExport.put("juryExpertNum", "5");
        getExport.put("juryTUserNum", "0");
        getExport.put("bidOpenDate", getDate(System.currentTimeMillis()));
        getExport.put("juryTUserNum", "0");
        getExport.put("currentBidStage", "2");
        getExport.put("evaluateTime", getDate(System.currentTimeMillis()));
        getExport.put("evaluatePlace", "评标地点自动测试");
        getExport.put("dayNumber", "-1");
        getExport.put("expertDatabase", "01");
        getExport.put("expertRegion", "140100");
        getExport.put("expertElect", "1");
        getExport.put("extractTerminalCode", "140000006");

        getExport.put("expertDemandList[0].expertLevel", "05");
        getExport.put("expertDemandList[0].specialtyFirstType", "C04");
        getExport.put("expertDemandList[0].specialtySecondType", "C0408");
        getExport.put("expertDemandList[0].expertCount", "5");
        getExport.put("expertDemandList[0].expertCheckInTime", "2018-05-21 11:46:35");
        getExport.put("expertDemandList[0].expertCheckInAddress", "自动测试报到地点");
        getExport.put("expertDemandList[0].demand2items[0].projectItemId", itemId);
        getExport.put("expertDemandList[0].demand2items[0].expertApplyId", id);
        getExport.put("expertDemandList[0].specialtyFirstTypeName", "工商管理");
        getExport.put("expertDemandList[0].specialtySecondTypeName", "宾馆管理");
        getExport.put("avoidanceOrganList[0].organCode", "91140109736344762L");
        getExport.put("avoidanceOrganList[0].organName", "四川招标测试单位一");
        getExport.put("avoidanceOrganList[0].serialversionuid", "1");


        String commitExportUrl = getDomain() + "/expertApplication/saveOrUpdates?isComplete=true";
        ResponseEntity commitExportStatus = clientForm(getUserSessionCache(userId), commitExportUrl, HttpMethod.POST, getExport);

        if (commitExportStatus.getStatusCodeValue() != 200) {
            return false;
        }
        String json = (String) commitExportStatus.getBody();
        JSONObject resultData = new JSONObject(json);
        if (!resultData.optBoolean("success")) {

            return false;
        }

        return true;

    }

    private boolean loginTenderEditorCreateTender(Map<String, Object> result, String projectInstanceId, String itemId) throws JSONException {

        String loginUrl = getDomain() + ":9090/management/user/login";
        JSONObject loginObj = new JSONObject();
        loginObj.put("username", "admin");
        loginObj.put("password", "123");
        ResponseEntity loginStatus = clientForm(null, loginUrl, HttpMethod.POST, loginObj);
        String sessionCookie = null;
        if (loginStatus.getStatusCodeValue() != 200) {
            return false;
        }

        List<String> cookies = loginStatus.getHeaders().get("Set-Cookie");

        for (String cookie : cookies) {
            if (cookie.startsWith("JSESSIONID")) {
                sessionCookie = cookie;
                break;
            }
        }

        //create file
        String checkTempleFileUrl = getDomain() + ":9090/invitation/documents/add";
        JSONObject tempFileObj = new JSONObject();

        ResponseEntity tempFileStatus = clientForm(sessionCookie, checkTempleFileUrl, HttpMethod.GET, tempFileObj);
        if (tempFileStatus.getStatusCodeValue() != 200) {
            return false;
        }

        String html = (String) tempFileStatus.getBody();
        Document doc = Jsoup.parse(html);
        String templ = null;
        Elements options = doc.select("option");
        for (int i = 0; i < options.size(); i++) {
            Element option = options.get(i);
            if (option.text().contains("测试自动化")) {
                templ = option.attr("value");
                break;
            }
        }

        if (templ == null) {
            return false;
        }

        String createTempleFileUrl = getDomain() + ":9090/invitation/documents";
        JSONObject createFileObj = new JSONObject();
        createFileObj.put("metaTemplateId", templ);
        createFileObj.put("invitationDocumentName", "自动测试招标文件-" + itemId);

        ResponseEntity createFileStatus = clientForm(sessionCookie, createTempleFileUrl, HttpMethod.POST, createFileObj);
        if (createFileStatus.getStatusCodeValue() != 302) {
            return false;
        }

        String location = createFileStatus.getHeaders().get("Location").get(0);
        Map<String, String> params = URLRequest(location);
        String docId = params.get("id");


        //上传附件
        String uploadUrl = getDomain() + ":9090/invitation/documents/style/word/save";
        JSONObject uploadJsonObject = new JSONObject();
        uploadJsonObject.put("documentId", docId);
        File attachFile = new File(getFileDirByName("attach_files") + "tender_test.pdf");
        ResponseEntity uploadResultInfo = clientFileForm(sessionCookie, uploadUrl, attachFile.getPath(), uploadJsonObject);
        if (uploadResultInfo.getStatusCodeValue() != 200) {

            return false;
        }

        String updateTempleFileUrl = getDomain() + ":9090/invitation/documents/project";
        JSONObject updateFileObj = new JSONObject();
        updateFileObj.put("documentId", docId);
        updateFileObj.put("itenderProjectId", getProjectId());
        updateFileObj.put("itenderInstanceId", projectInstanceId);
        updateFileObj.put("itenderProjectItemId", itemId);
        ResponseEntity updateFileStatus = clientForm(sessionCookie, updateTempleFileUrl, HttpMethod.PATCH, updateFileObj);
        if (updateFileStatus.getStatusCodeValue() != 200) {
            return false;
        }

        //同步评标算法
        String method = "{\n" +
                "\t\"id\": \"6c71d6176f68076de053443411accd13\",\n" +
                "\t\"industryGenera\": \"HOUSE_BUILDING\",\n" +
                "\t\"methodName\": \"房建基准价3\",\n" +
                "\t\"industryType\": \"工程建设项目招标投标-房屋建筑\",\n" +
                "\t\"industryTypeCode\": \"A01\",\n" +
                "\t\"evaluationMethodId\": \"2\",\n" +
                "\t\"evaluationMethod\": \"综合评标办法（基准价满分）\",\n" +
                "\t\"benchmarkPriceId\": \"a789f3dd-9256-427a-990e-9dbec8d661a8\",\n" +
                "\t\"benchmarkPrice\": \"评标基准价3(房建)\",\n" +
                "\t\"pullDownPercent\": \"3\",\n" +
                "\t\"reviewMode\": \"SCORE\",\n" +
                "\t\"reviewModeTwo\": null,\n" +
                "\t\"groupDesignLowestPercent\": \"60\",\n" +
                "\t\"preliminaryReviewTable\": \"<table class=\\\"layui-table\\\" id=\\\"preliminaryReviewTable\\\" style=\\\"border-collapse: collapse;\\\" border=\\\"0\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\">             <thead><tr><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>序号</span></div></th><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审类型</span></div></th><th style=\\\"padding: 0px;\\\"><div class=\\\"layui-table-cell \\\"><span>评审内容</span></div></th></tr></thead><tbody><tr><td style=\\\"text-align: center;\\\"><pre>1</pre></td><td style=\\\"text-align: center;\\\"><pre>形式评审</pre></td><td style=\\\"padding: 0px;\\\"><table style=\\\"border-width: 0px; border-style: hidden; width: 100%; border-collapse: collapse;\\\" border=\\\"1\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\"><thead><tr><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>序号</span></div></th><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审因素</span></div></th><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审标准</span></div></th></tr></thead><tbody><tr><td style=\\\"text-align: center;\\\"><pre>1</pre></td><td style=\\\"text-align: center;\\\"><pre>测试</pre></td><td style=\\\"text-align: center;\\\"><pre>测试</pre></td></tr></tbody><tfoot></tfoot></table></td></tr><tr><td style=\\\"text-align: center;\\\"><pre>1</pre></td><td style=\\\"text-align: center;\\\"><pre>资格评审</pre></td><td style=\\\"padding: 0px;\\\"><table style=\\\"border-width: 0px; border-style: hidden; width: 100%; border-collapse: collapse;\\\" border=\\\"1\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\"><thead><tr><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>序号</span></div></th><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审因素</span></div></th><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审标准</span></div></th></tr></thead><tbody><tr><td style=\\\"text-align: center;\\\"><pre>2</pre></td><td style=\\\"text-align: center;\\\"><pre>测试</pre></td><td style=\\\"text-align: center;\\\"><pre>是</pre></td></tr></tbody><tfoot></tfoot></table></td></tr><tr><td style=\\\"text-align: center;\\\"><pre>1</pre></td><td style=\\\"text-align: center;\\\"><pre>响应性评审</pre></td><td style=\\\"padding: 0px;\\\"><table style=\\\"border-width: 0px; border-style: hidden; width: 100%; border-collapse: collapse;\\\" border=\\\"1\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\"><thead><tr><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>序号</span></div></th><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审因素</span></div></th><th style=\\\"text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审标准</span></div></th></tr></thead><tbody><tr><td style=\\\"text-align: center;\\\"><pre>3</pre></td><td style=\\\"text-align: center;\\\"><pre>测试</pre></td><td style=\\\"text-align: center;\\\"><pre>是</pre></td></tr></tbody><tfoot></tfoot></table></td></tr></tbody><tfoot></tfoot></table>\",\n" +
                "\t\"preliminaryReviewTableJson\": \"[{\\\"id\\\":\\\"1\\\",\\\"pslx\\\":\\\"形式评审\\\",\\\"psnr\\\":[{\\\"id\\\":\\\"1\\\",\\\"psys\\\":\\\"测试\\\",\\\"psbz\\\":\\\"测试\\\",\\\"op\\\":\\\"\\\"}],\\\"op\\\":\\\"\\\"},{\\\"id\\\":\\\"1\\\",\\\"pslx\\\":\\\"资格评审\\\",\\\"psnr\\\":[{\\\"id\\\":\\\"2\\\",\\\"psys\\\":\\\"测试\\\",\\\"psbz\\\":\\\"是\\\",\\\"op\\\":\\\"\\\"}],\\\"op\\\":\\\"\\\"},{\\\"id\\\":\\\"1\\\",\\\"pslx\\\":\\\"响应性评审\\\",\\\"psnr\\\":[{\\\"id\\\":\\\"3\\\",\\\"psys\\\":\\\"测试\\\",\\\"psbz\\\":\\\"是\\\",\\\"op\\\":\\\"\\\"}],\\\"op\\\":\\\"\\\"}]\",\n" +
                "\t\"detailedReviewTable\": \"<table class=\\\"layui-table\\\" id=\\\"detailedReviewTable\\\" style=\\\"border-collapse: collapse;\\\" border=\\\"0\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\">             <thead><tr><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>序号</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>分类</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>合计</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>详评项目</span></div></th></tr></thead><tbody><tr><td style=\\\"padding: 0px; text-align: center;\\\"><pre>1</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>报价部分</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>55</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><table style=\\\"border-width: 0px; border-style: hidden; width: 100%; border-collapse: collapse;\\\" border=\\\"1\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\"><thead><tr><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>序号</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>分值构成</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>是否合议</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>分值(分)</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>详细</span></div></th></tr></thead><tbody><tr><td style=\\\"padding: 0px; text-align: center;\\\"><pre>1</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>报价部分</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>否</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>55</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre><pre><pre><pre>评标基准价=合成范围内随机抽取9家投标报价（不足的全部抽取）中去掉一个最高投标报价和一个最低投标报价的算术平均值。</pre></pre></pre></pre></td></tr></tbody><tfoot><tr><th><div class=\\\"layui-table-cell \\\"><span>合计</span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span>55</span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th></tr></tfoot></table></td></tr><tr><td style=\\\"padding: 0px; text-align: center;\\\"><pre>2</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>施工组织设计</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>25</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><table style=\\\"border-width: 0px; border-style: hidden; width: 100%; border-collapse: collapse;\\\" border=\\\"1\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\"><thead><tr><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>序号</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>分值构成</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>是否合议</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>分值(分)</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>详细</span></div></th></tr></thead><tbody><tr><td style=\\\"padding: 0px; text-align: center;\\\"><pre>1</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>施工组织设计</pre></td><td style=\\\"padding: 0px; text-align: center;\\\">否</td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>25</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><table style=\\\"border-width: 0px; border-style: hidden; width: 100%; border-collapse: collapse;\\\" border=\\\"1\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\"><thead><tr><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>序号</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审因素</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审标准</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>分值(分)</span></div></th></tr></thead><tbody><tr><td style=\\\"padding: 0px; text-align: center;\\\"><pre>1</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>测试</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>测试</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>25</pre></td></tr></tbody><tfoot><tr><th><div class=\\\"layui-table-cell \\\"><span>小计</span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span>25</span></div></th></tr></tfoot></table></td></tr></tbody><tfoot><tr><th><div class=\\\"layui-table-cell \\\"><span>合计</span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span>25</span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th></tr></tfoot></table></td></tr><tr><td style=\\\"padding: 0px; text-align: center;\\\"><pre>3</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>投标人资信</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>20</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><table style=\\\"border-width: 0px; border-style: hidden; width: 100%; border-collapse: collapse;\\\" border=\\\"1\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\"><thead><tr><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>序号</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>分值构成</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>是否合议</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>分值(分)</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>详细</span></div></th></tr></thead><tbody><tr><td style=\\\"padding: 0px; text-align: center;\\\"><pre>2</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>投标人资信</pre></td><td style=\\\"padding: 0px; text-align: center;\\\">否</td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>20</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><table style=\\\"border-width: 0px; border-style: hidden; width: 100%; border-collapse: collapse;\\\" border=\\\"1\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\"><thead><tr><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>序号</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审因素</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>评审标准</span></div></th><th style=\\\"padding: 0px; text-align: center;\\\"><div class=\\\"layui-table-cell \\\"><span>分值(分)</span></div></th></tr></thead><tbody><tr><td style=\\\"padding: 0px; text-align: center;\\\"><pre>2</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>测试</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>测试</pre></td><td style=\\\"padding: 0px; text-align: center;\\\"><pre>20</pre></td></tr></tbody><tfoot><tr><th><div class=\\\"layui-table-cell \\\"><span>小计</span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span>20</span></div></th></tr></tfoot></table></td></tr></tbody><tfoot><tr><th><div class=\\\"layui-table-cell \\\"><span>合计</span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span>20</span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th></tr></tfoot></table></td></tr></tbody><tfoot><tr><th><div class=\\\"layui-table-cell \\\"><span>总计</span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th><th><div class=\\\"layui-table-cell \\\"><span>100</span></div></th><th><div class=\\\"layui-table-cell \\\"><span></span></div></th></tr></tfoot></table>\",\n" +
                "\t\"detailedReviewTableJson\": \"[{\\\"id\\\":\\\"1\\\",\\\"fennei\\\":\\\"报价部分\\\",\\\"suanfa\\\":\\\"平均法\\\",\\\"heji\\\":\\\"55\\\",\\\"xiangPingXiangMu\\\":[{\\\"id\\\":\\\"1\\\",\\\"fenZhiGouCheng\\\":\\\"报价部分\\\",\\\"shiFouHeYi\\\":\\\"否\\\",\\\"score\\\":\\\"55\\\",\\\"op\\\":\\\"\\\",\\\"detail\\\":\\\"<pre><pre><pre><pre>评标基准价=合成范围内随机抽取9家投标报价（不足的全部抽取）中去掉一个最高投标报价和一个最低投标报价的算术平均值。</pre></pre></pre></pre>\\\"}],\\\"op\\\":\\\"\\\"},{\\\"id\\\":\\\"2\\\",\\\"fennei\\\":\\\"施工组织设计\\\",\\\"suanfa\\\":\\\"pingjun\\\",\\\"heji\\\":\\\"25\\\",\\\"xiangPingXiangMu\\\":[{\\\"id\\\":\\\"1\\\",\\\"fenZhiGouCheng\\\":\\\"施工组织设计\\\",\\\"shiFouHeYi\\\":\\\"no\\\",\\\"score\\\":\\\"25\\\",\\\"op\\\":\\\"\\\",\\\"detail\\\":[{\\\"id\\\":\\\"1\\\",\\\"psys\\\":\\\"测试\\\",\\\"psbz\\\":\\\"测试\\\",\\\"score\\\":\\\"25\\\",\\\"op\\\":\\\"\\\"}]}],\\\"op\\\":\\\"\\\"},{\\\"id\\\":\\\"3\\\",\\\"fennei\\\":\\\"投标人资信\\\",\\\"suanfa\\\":\\\"pingjun\\\",\\\"heji\\\":\\\"20\\\",\\\"xiangPingXiangMu\\\":[{\\\"id\\\":\\\"2\\\",\\\"fenZhiGouCheng\\\":\\\"投标人资信\\\",\\\"shiFouHeYi\\\":\\\"no\\\",\\\"score\\\":\\\"20\\\",\\\"op\\\":\\\"\\\",\\\"detail\\\":[{\\\"id\\\":\\\"2\\\",\\\"psys\\\":\\\"测试\\\",\\\"psbz\\\":\\\"测试\\\",\\\"score\\\":\\\"20\\\",\\\"op\\\":\\\"\\\"}]}],\\\"op\\\":\\\"\\\"}]\",\n" +
                "\t\"preliminaryReviewTableTwo\": null,\n" +
                "\t\"preliminaryReviewTableJsonTwo\": null,\n" +
                "\t\"detailedReviewTableTwo\": null,\n" +
                "\t\"detailedReviewTableJsonTwo\": null,\n" +
                "\t\"viewEvaluationTableJson\": \"[{\\\"id\\\":\\\"1\\\",\\\"pbff\\\":\\\"评标方法\\\",\\\"content\\\":\\\"\\\"}]\",\n" +
                "\t\"benchmarkPriceTableJson\": \"[{\\\"id\\\":\\\"\\\",\\\"title\\\":\\\"分值构成（总分100分）\\\",\\\"content\\\":\\\"评标价：100分\\\"},{\\\"id\\\":\\\"\\\",\\\"title\\\":\\\"评标基准价计算方法\\\",\\\"content\\\":\\\"评标基准价=合成范围内随机抽取9家投标报价（不足的全部抽取）中去掉一个最高投标报价和一个最低投标报价的算术平均值。\\\"},{\\\"id\\\":\\\"\\\",\\\"title\\\":\\\"评标价的偏差率计算公式\\\",\\\"content\\\":\\\"\\\"}]\",\n" +
                "\t\"pbjTableJson\": \"[{\\\"id\\\":\\\"\\\",\\\"title\\\":\\\"评标价\\\",\\\"content\\\":\\\"100分\\\"}]\",\n" +
                "\t\"jszdjTableJson\": \"[{\\\"id\\\":\\\"\\\",\\\"title\\\":\\\"第一个信封评分分值构成（总分100分）\\\",\\\"content\\\":\\\"\\\"},{\\\"id\\\":\\\"\\\",\\\"title\\\":\\\"第二个信封详细评审标准\\\",\\\"content\\\":\\\"\\\"},{\\\"id\\\":\\\"\\\",\\\"title\\\":\\\"通过第一个信封详细评审的投标人数量\\\",\\\"content\\\":\\\"按照投标人的商务和技术得分由高到低排序，选择前____名通过详细评审\\\"}]\",\n" +
                "\t\"jpslhTableJson\": \"[{\\\"id\\\":\\\"\\\",\\\"psbz\\\":\\\"详细评审标准\\\",\\\"lhys\\\":\\\"评标价计算\\\",\\\"lhbz\\\":\\\"\\\"}]\",\n" +
                "\t\"createTime\": 1526442097949,\n" +
                "\t\"operator\": \"admin\"\n" +
                "}";
        String syncMethodFileUrl = getDomain() + ":9090/invitation/documents/sync/evaluation";
        JSONObject syncMethodFileObj = new JSONObject();
        syncMethodFileObj.put("id", docId);
        syncMethodFileObj.put("evaluationMethodJson", method);
        ResponseEntity syncMethodFileStatus = client(sessionCookie, syncMethodFileUrl, HttpMethod.PATCH, syncMethodFileObj);
        if (syncMethodFileStatus.getStatusCodeValue() != 200) {
            return false;
        }


        //发布招标文件
        String publishTempleFileUrl = getDomain() + ":9090/invitation/documents/deploy";
        JSONObject publishFileObj = new JSONObject();
        publishFileObj.put("documentId", docId);
        ResponseEntity publishFileStatus = clientForm(sessionCookie, publishTempleFileUrl, HttpMethod.PATCH, publishFileObj);
        if (publishFileStatus.getStatusCodeValue() != 200) {
            return false;
        }

        result.put("docId", docId);

        return true;
    }

    String getDate(long time) {
        //得到long类型当前时间
        long tenderPushlishTime = time;
//new日期对象
        Date dateTender = new Date(tenderPushlishTime);
//转换提日期输出格式
        SimpleDateFormat tenderDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateTenderStr = tenderDateFormat.format(dateTender);
        return dateTenderStr;
    }


    boolean parseUploadCommissionContract(String userId, Document doc, Map<String, Object> result, String type) throws JSONException {
        result.put("type", type);
        Element projectInstance = doc.getElementById("projectInstanceId");
        String projectInstanceId = projectInstance.attr("value");
        Element task = doc.getElementById("taskId");
        String taskId = task.attr("value");

        //上传附件
        String uploadUrl = getDomain() + "/commissionContract/uploadCommissionContract";
        JSONObject uploadJsonObject = new JSONObject();
        uploadJsonObject.put("projectInstanceId", projectInstanceId);
        File attachFile = new File(getFileDirByName("attach_files") + "test.pdf");
        ResponseEntity uploadResultInfo = clientFileForm(getUserSessionCache(userId), uploadUrl, attachFile.getPath(), uploadJsonObject);
        if (uploadResultInfo.getStatusCodeValue() != 200) {
            result.put("status", false);
            result.put("msg", "upload failed");
            return false;
        }


        String uploadJson = (String) uploadResultInfo.getBody();

        if (uploadJson.contains("系统内部错误，请联系管理员")) {
            result.put("status", false);
            result.put("msg", "上传文件失败!");
            return false;
        }

        JSONObject resultUploadData = new JSONObject(uploadJson);
        if (!resultUploadData.optBoolean("success")) {
            return false;
        }

        JSONObject uploadFileData = resultUploadData.optJSONObject("data");

        String attachmentId = uploadFileData.optString("fjid00");


        //提交代理合同
        String url = getDomain() + "/commissionContract/createOrUpdateCommissionContract";

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("projectInstanceId", projectInstanceId);
        jsonObject.put("taskId", taskId);
        jsonObject.put("attachmentId", attachmentId);

        ResponseEntity resultInfo = clientForm(getUserSessionCache(userId), url, HttpMethod.POST, jsonObject);
        if (resultInfo.getStatusCodeValue() != 200) {

            result.put("status", false);
            result.put("msg", "更新失败!");
            return false;
        }


        //更新工作流状态
        String activitiUrl = getDomain() + "/workflow/completeForm";
        JSONObject activitiJsonObject = new JSONObject();


        activitiJsonObject.put("taskId", taskId);
        activitiJsonObject.put("projectInstanceId", projectInstanceId);
        activitiJsonObject.put("attachmentId", attachmentId);

        ResponseEntity taskResultInfo = clientForm(getUserSessionCache(userId), activitiUrl, HttpMethod.POST, activitiJsonObject);
        if (taskResultInfo.getStatusCodeValue() != 302) {

            result.put("status", false);
            result.put("msg", "更新失败!");
            return false;

        }

        String json = (String) resultInfo.getBody();
        JSONObject resultData = new JSONObject(json);
        result.put("status", resultData.optBoolean("success"));
        result.put("msg", resultData.optString("msg"));

        return true;
    }

    private String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        if (domain == null || StringUtils.isEmpty(domain)) {
            return;
        }
        this.domain = domain;
    }

    @ApiOperation(value = "获取任务列表", notes = "用于获取任务列表")
    @RequestMapping(value = "/workflow/pagingTask", method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> getTaskList(HttpServletRequest request,
                                                      @RequestParam(required = false) Integer pageNum,
                                                      @RequestParam(required = false) Integer pagesize
    ) throws APIException {
        Map<String, Object> result = new HashMap<>();
//api url地址
        String url = getDomain() + "/workflow/pagingTask";
        pageNum = pageNum == null ? 1 : pageNum;
        pagesize = pagesize == null ? 10 : pagesize;
        JSONObject jsonObject = new JSONObject();
        try {

            jsonObject.put("page", pageNum);
            jsonObject.put("pageSize", pagesize);

            ResponseEntity resultInfo = clientForm(getUserSessionCache(request.getParameter("userId")), url, HttpMethod.POST, jsonObject);
            if (resultInfo.getStatusCodeValue() == 200) {
                //parse 關鍵字
                String json = (String) resultInfo.getBody();
                JSONObject resultData = new JSONObject(json);

                result.put("status", resultData.optBoolean("success"));
                result.put("msg", resultData.optString("msg"));
                return ResponseEntity.ok(convertToLayuiData(resultData, 200, "success"));
            } else {
                result.put("status", false);
                result.put("msg", "获取失敗!");
                return ResponseEntity.ok(convertToLayuiData(new JSONObject("{}"), 200, "success"));
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok(convertToLayuiData(jsonObject, 200, "success"));
    }

    @ApiOperation(value = "創建項目", notes = "用于創建項目")
    @RequestMapping(value = "/createProject", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> createProject(HttpServletRequest request
    ) throws APIException {
        Map<String, Object> result = new HashMap<>();
//api url地址
        String url = getDomain() + "/projectInstance/saveProjectInstance";
        JSONObject jsonObject = new JSONObject();
        //得到long类型当前时间
        long l = System.currentTimeMillis();
//new日期对象
        Date date = new Date(l);
//转换提日期输出格式
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDate = dateFormat.format(date);
        try {

            jsonObject.put("token", "");
            jsonObject.put("createByAgency", " false");
            jsonObject.put("projectId", getProjectId());
            jsonObject.put("zbxmmc", "程序自動測試，请勿操作test***" + currentDate);
            jsonObject.put("organProjectCode", "");
            jsonObject.put("projectInstanceType", "A01");
            jsonObject.put("zbzrr0", "james");
            jsonObject.put("zbfs00", "1");
            jsonObject.put("zbzzxs", "2");
            jsonObject.put("reviewType", "1");
            jsonObject.put("prereviewType", "2");
            jsonObject.put("nryfw0", "ttt");
            jsonObject.put("shbmmc", "22");
            jsonObject.put("shbmdm", "");
            jsonObject.put("jdbmmc", "1");
            jsonObject.put("jdbmdm", "");
            jsonObject.put("jdbmfzr", "james");
            jsonObject.put("jdbmdh", "18688173429");
            ResponseEntity resultInfo = clientForm(getUserSessionCache(request.getParameter("userId")), url, HttpMethod.POST, jsonObject);
            if (resultInfo.getStatusCodeValue() == 200) {
                //parse 關鍵字
                String json = (String) resultInfo.getBody();
                JSONObject resultData = new JSONObject(json);

                result.put("status", resultData.optBoolean("success"));
                result.put("msg", resultData.optString("msg"));
            } else {
                result.put("status", false);
                result.put("msg", "創建失敗!");
                return ResponseEntity.ok(result);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "选择代理机构接口", notes = "用于选择代理机构")
    @RequestMapping(value = "/commitOrgazationA", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> commitOrgazationA(HttpServletRequest request,
                                                                 @ApiParam(name = "orgId", value = "代理机构id", required = true) @RequestParam(required = true) String orgId,
                                                                 @ApiParam(name = "organAName", value = "代理机构organAName", required = false) @RequestParam(required = false) String organAName,
                                                                 @ApiParam(name = "taskId", value = "任务id", required = true) @RequestParam(required = true) String taskId
    ) throws APIException {

        Map<String, Object> result = new HashMap<>();

        String url = getDomain() + "/workflow/completeForm";
        JSONObject jsonObject = new JSONObject();


        try {
            jsonObject.put("taskId", taskId);
            jsonObject.put("organId", orgId);
            jsonObject.put("organAName", organAName);
            jsonObject.put("contractSignMode", true);//默认在线签订

            ResponseEntity resultInfo = clientForm(getUserSessionCache(request.getParameter("userId")), url, HttpMethod.POST, jsonObject);
            if (resultInfo.getStatusCodeValue() == 200) {
                String json = (String) resultInfo.getBody();
                if (json.contains("系统内部错误，请联系管理员")) {
                    result.put("status", false);
                    result.put("msg", "选择代理机构失败!");
                    return ResponseEntity.ok(result);
                }

                result.put("status", true);
                //result.put("msg", resultData.optString("msg"));

            } else if (resultInfo.getStatusCodeValue() == 302) {
                result.put("status", true);
                //  result.put("msg", resultData.optString("msg"));
                return ResponseEntity.ok(result);
            } else {
                result.put("status", false);
                result.put("msg", "选择代理机构失败!");
                return ResponseEntity.ok(result);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "用户登录接口", notes = "用于用户登录")
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> login(HttpServletRequest request,
                                                     @ApiParam(name = "username", value = "用户名", required = true) @RequestParam(required = true) String username,
                                                     @ApiParam(name = "password", value = "密码", required = true) @RequestParam(required = true) String password,
                                                     @ApiParam(name = "verify", value = "verify", required = true) @RequestParam(required = true) String verify,
                                                     @ApiParam(name = "domain", value = "domain", required = false) @RequestParam(required = false) String domain
    ) throws APIException {

        removeUserSessionCache(request.getParameter("userId"));
        Map<String, Object> result = new HashMap<>();
        setDomain(domain);
//api url地址
        String url = getDomain() + "/login";
        JSONObject jsonObject = new JSONObject();


        try {
            jsonObject.put("username", username);
            jsonObject.put("password", password);
            jsonObject.put("validateCode", "");
            jsonObject.put("isVerify", "");
            jsonObject.put("verify", verify);
            ResponseEntity resultInfo = clientForm(getUserSessionCache(request.getParameter("userId")), url, HttpMethod.POST, jsonObject);
            if (resultInfo.getStatusCodeValue() == 302) {
                HttpHeaders headers = resultInfo.getHeaders();
                List<String> cookies = headers.get("Set-Cookie");
                if (cookies == null) {
                    result.put("status", true);
                    result.put("msg", "登录成功!");
                    return ResponseEntity.ok(result);
                }
                for (String cookie : cookies) {
                    if (cookie.startsWith("shiro.session.id")) {
                        setUserSessionCache(request.getParameter("userId"), cookie);
                        result.put("status", true);
                        result.put("msg", "登录成功!");
                        return ResponseEntity.ok(result);
                    }
                }

            } else {
                result.put("status", false);
                result.put("msg", "用戶名密碼錯誤!");
                return ResponseEntity.ok(result);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok(result);
    }


    public ResponseEntity clientFileForm(String sessionId, String url, String filePath, JSONObject jsonObject) {
        RestTemplate client = restTemplateRequestFactory();
        HttpHeaders headers = new HttpHeaders();
        headers.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko");
        //  请勿轻易改变此提交方式，大部分的情况下，提交方式都是表单提交
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        FileSystemResource fileSystemResource = new FileSystemResource(filePath);
        MediaType type = MediaType.parseMediaType("multipart/form-data");
        headers.setContentType(type);
        String cd = "filename=\"" + new File(filePath).getName() + ".pdf\"";
        headers.add("Content-Disposition", cd);

        if (sessionId != null) {
            headers.set("Cookie", sessionId);
        }
        Iterator<String> it = jsonObject.keys();
        MultiValueMap<String, Object> form = new LinkedMultiValueMap<String, Object>();
        while (it.hasNext()) {
// 获得key
            String key = it.next();
            String value = jsonObject.optString(key);
            System.out.println("key: " + key + ",value:" + value);
            form.add(key, value);

        }

        form.add("file", fileSystemResource);
        HttpEntity<MultiValueMap<String, Object>> files = new HttpEntity<>(form, headers);


        //  执行HTTP请求
        try {
            ResponseEntity<String> response = client.postForEntity(url, files, String.class);
            return response;
        } catch (RestClientException e) {
            e.printStackTrace();
            return null;
        }


    }


    public ResponseEntity clientForm(String sessionId, String url, HttpMethod method, JSONObject jsonObject) {
        return clientForm(false, sessionId, url, method, jsonObject);
    }

    public ResponseEntity clientForm(boolean redirect, String sessionId, String url, HttpMethod method, JSONObject jsonObject) {
        RestTemplate client = null;
        try {
            client = restTemplateRequestFactory(redirect);
        } catch (KeyStoreException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }

        HttpHeaders headers = new HttpHeaders();
        headers.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko");
        //  请勿轻易改变此提交方式，大部分的情况下，提交方式都是表单提交
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        if (sessionId != null) {
            headers.set("Cookie", sessionId);
        }
        Iterator<String> it = jsonObject.keys();
        String bodyValTemplate = "";
        while (it.hasNext()) {
// 获得key
            String key = it.next();
            String value = jsonObject.optString(key);
            System.out.println("key: " + key + ",value:" + value);
            try {
                bodyValTemplate += "&" + key + "=" + URLEncoder.encode(value, "utf-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        HttpEntity entity = new HttpEntity(bodyValTemplate, headers);

        //  执行HTTP请求
        try {
            ResponseEntity<String> response = client.exchange(url, method, entity, String.class);
            return response;
        } catch (RestClientException e) {
            e.printStackTrace();
            return null;
        }


    }


    public ResponseEntity client(String sessionId, String url, HttpMethod method, JSONObject jsonObject) {
        RestTemplate client = restTemplateRequestFactory();
        HttpHeaders headers = new HttpHeaders();
        headers.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko");

        if (sessionId != null) {
            headers.set("Cookie", sessionId);
        }

        headers.setContentType(MediaType.APPLICATION_JSON_UTF8);


        HttpEntity<String> requestEntity = new HttpEntity<String>(jsonObject.toString(), headers);
        //  执行HTTP请求
        try {
            ResponseEntity<String> response = client.exchange(url, method, requestEntity, String.class);
            return response;
        } catch (RestClientException e) {
            e.printStackTrace();
            return null;
        }


    }

}
