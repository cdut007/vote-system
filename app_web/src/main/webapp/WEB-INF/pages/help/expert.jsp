<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String videopath=request.getParameter("videopath");
	if(videopath==null||"".equals(videopath)){
		videopath="/resources/video/firstRegister.mp4";
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,minimal-ui" />
<meta name="format-detection" content="telephone=no"/>
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta charset="utf-8">
<title>金蝉使用指南之视频教程</title>
<link rel="stylesheet" type="text/css" href="/resources/player/common.css"/>
<script type="text/javascript" src="/resources/player1/jquery172.js"></script>
<script type="text/javascript" src="/resources/player1/action.js"></script>
</head>

<body>
<div id="header">
<div class="logo">专家教程视频<a href="#"><!-- <img src="/resources/player/images/logoCu.jpg" > --></a></div>
<div class="info"><a href="#"><!-- <img src="/resources/player/images/search.jpg" > --></a></div>
<div class="other"><a href="${pageContext.request.contextPath}/">返回首页</a></div>
</div>
<div id="content" >
<div class="close_light_bg" id="close_light_bg"></div>

<div class="video" id="CuPlayer" >
<SCRIPT LANGUAGE=JavaScript>
var vID        = ""; 
var vWidth     = "100%";            //播放器宽度设置
var vHeight    = 400;               //播放器高度设置
var vFile      = "/resources/player1/CuSunV2set.xml";  //播放器配置文件
var vPlayer    = "/resources/player1/player.swf?v=2.5";//播放器文件
var vPic       = "/resources/player/images/start.jpg";//视频缩略图
var vCssurl    = "/resources/player/images/mini.css"; //移动端CSS应用文件

//适配PC,安卓,iOS请用mp4文件
var vMp4url    = "<%=videopath%>";  //视频文件地址
</SCRIPT> 
<script class="CuPlayerVideo" data-mce-role="CuPlayerVideo" type="text/javascript" src="/resources/player1/CuSunX1.min.js"></script>
</div>
<div class="title">金蝉使用指南之视频教程</div>
<div class="clear"></div>
<h3><span>相关教程</span></h3>
<div class="piclist">
<dl>
<dt><a href="/help/expert?videopath=/resources/video/firstRegister.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/firstRegister.mp4" title="" target="_blank">首次注册</a></dd>
</dl>
<dl>
<dt><a href="/help/expert?videopath=/resources/video/projectAndAgencySigned.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/projectAndAgencySigned.mp4" title="" target="_blank">委托方新建项目和委托合同的签订</a></dd>
</dl>
<dl>
<dt><a href="/help/expert?videopath=/resources/video/theAgency.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/theAgency.mp4" title="" target="_blank">代理机构的使用</a></dd>
</dl>
<dl>
<dt><a href="/help/expert?videopath=/resources/video/tenderingUnits.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/tenderingUnits.mp4" title="" target="_blank">投标单位的使用</a></dd>
</dl>
<dl>
<dt><a href="/help/expert?videopath=/resources/video/expertsUse.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/expertsUse.mp4" title="" target="_blank">专家的使用</a></dd>
</dl>
<dl>
<dt><a href="/help/expert?videopath=/resources/video/keyBindingUnbundling.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/keyBindingUnbundling.mp4" title="" target="_blank">key的绑定和解除</a></dd>
</dl>
<dl>
<dt><a href="/help/expert?videopath=/resources/video/tenderFeePayments.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/tenderFeePayments.mp4" title="" target="_blank">标书费用支付</a></dd>
</dl>
<dl>
<dt><a href="/help/expert?videopath=/resources/video/winningCandidatePublic.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/winningCandidatePublic.mp4" title="" target="_blank">中标候选人公示</a></dd>
</dl>


<dl>
<dt><a href="/help/expert?videopath=/resources/video/bidDownloadUuse.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/bidDownloadUuse.mp4" title="" target="_blank">投标编辑器的下载及使用</a></dd>
</dl>
<dl>
<dt><a href="/help/expert?videopath=/resources/video/keyDriverDownload.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/keyDriverDownload.mp4" title="" target="_blank">key的驱动下载</a></dd>
</dl>
<dl>
<dt><a href="/help/expert?videopath=/resources/video/USBKeyChangePassword.mp4" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="/help/expert?videopath=/resources/video/USBKeyChangePassword.mp4" title="" target="_blank">USB+key如何更改密码</a></dd>
</dl>


</div>
</SCRIPT> 
</body>
</html>
