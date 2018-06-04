package com.itender.ms.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.domain.TbArticle;
import com.itender.ms.domain.TbArticleExample;
import com.itender.ms.domain.TbAttachment;
import com.itender.ms.domain.TbAttachmentExample;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.TbArticleMapper;
import com.itender.ms.mapper.TbAttachmentMapper;
import com.itender.ms.util.HttpHelper;
import com.itender.ms.workflow.model.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.activiti.engine.form.AbstractFormType;
import org.activiti.spring.SpringProcessEngineConfiguration;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.client.LaxRedirectStrategy;
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
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.*;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import springfox.documentation.annotations.ApiIgnore;

import javax.net.ssl.SSLContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.*;

@Validated
@Controller
@RequestMapping("/home")
public class HomeController {




    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);



    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "home";
    }



}
