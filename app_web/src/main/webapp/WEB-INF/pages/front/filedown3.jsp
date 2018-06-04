<%@page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>欢迎使用${util:property('business.platformName')}电子交易平台</title>
    <link href="/resources/portal/yc-css/yc-public.css" type="text/css" rel="stylesheet"/>
    <link href="/resources/portal/yc-css/yc-main.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/resources/portal/yc-js/jquery-1.4.2.min.js"></script> 
    <script type="text/javascript" src="/resources/portal/yc-js/BreakingNews.js"></script>
</head>
<body>
<jsp:include page="/front/include/header.jsp"/>
<div class="clear"></div>
<!-- 4 内容 -->
<div class="ctr marginTop border-top2">
    <!--文件下载列表-->
    <div class="boxWidth_280n left down_list">
        <span class="down_list_name">文件下载</span>
        <!--样式   down_in为当前选中项-->
        <%-- <a href="${pageContext.request.contextPath}/filedown3"><div class="down_list_btn down_in">签章软件下载</div></a> --%>
        <a href="${pageContext.request.contextPath}/filedown"><div class="down_list_btn">必装软件下载</div></a>
        <a href="${pageContext.request.contextPath}/filedown2"><div class="down_list_btn">投标文件编辑器下载</div></a>
        <div class="down_list_bottom"></div>
    </div>
    <!-- 文件下载内容-->
    <div class="boxWidth_850 right">
        <div class="down_file_name" style=" background: url('/resources/portal/yc-images/down_fedit.jpg') no-repeat 60px 20px;">
        	<span>签章软件下载</span>
            <span>为保证您正常使用交易平台，若未安装签章软件请在此处下载安装。</span>
             <span>运行当前文件夹中的 Installer.exe 按照提示安装即可。</span>
        </div>
        <div class="down_file_btn">
            <a href="/resources/portal/iSignature.zip"><span>&nbsp;&nbsp;下载安装</span></a>
            <div class="down_file_data">
                <!-- <img class="left" src="/resources/portal/yc-images/fedit_ico.jpg" width="170" height="60"/> -->
                <span>更新日期：2016年6月25日</span>
            </div>
        </div>
    </div>
</div>
<div class="clear"></div>
<br/>
<jsp:include page="/front/include/footer.jsp"/>
<div class="clear"></div>
</body>
</html>