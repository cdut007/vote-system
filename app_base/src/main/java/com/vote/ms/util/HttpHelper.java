package com.bank.guarantee.ms.util;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

/**
 * HTTP帮助类
 *
 * @author 陈泳君
 * @create 2018-04-10 上午11:10
 **/
@Component
public class HttpHelper {


    public void download(HttpServletResponse response,HttpServletRequest request,String filename,String fileType){

        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);

        try {
            response.setHeader("Content-disposition", "attachment;filename=" + prepareDownloadName(request, filename) + "." + fileType);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }

    private String prepareDownloadName(HttpServletRequest request, String documentName) throws UnsupportedEncodingException {
        String header = request.getHeader("User-Agent").toUpperCase();
        if (header.contains("MSIE") || header.contains("TRIDENT") || header.contains("EDGE")) {
            documentName = URLEncoder.encode(documentName, "utf-8");
            documentName = documentName.replace("+", "%20");    //IE下载文件名空格变+号问题
        } else {
            documentName = new String(documentName.getBytes(), "ISO8859-1");
        }
        return documentName;
    }
}
