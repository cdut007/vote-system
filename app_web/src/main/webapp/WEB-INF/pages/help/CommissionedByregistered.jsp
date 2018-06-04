<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<%-- 	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here"> 
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			视频教程
		</div>
	</div> --%>

	
<!--header/begin-->
<div id="header">
<div class="logo"><a href="#"><!-- <img src="/resources/player/images/logoCu.jpg" > --></a></div>
<div class="info"><a href="#"><!-- <img src="/resources/player/images/search.jpg" > --></a></div>
<div class="other"><a href="${pageContext.request.contextPath}/">返回首页</a></div>
</div>
<!--header/end-->

<!--content/begin-->
<div id="content" >
<div class="close_light_bg" id="close_light_bg"></div>

<!--X1 CrossPlatform /begin -->
<div class="video" id="CuPlayer" >
<SCRIPT LANGUAGE=JavaScript>
<!--
/*
* 跨平台方案X1（基于普通HTTP协议）=============
* @param {Object} vID        ID
* @param {Object} vWidth     播放器宽度设置
* @param {Object} vHeight    播放器高度设置
* @param {Object} vFile      播放器配置文件
* @param {Object} vPlayer    播放器文件
* @param {Object} vPic       视频缩略图
* @param {Object} vCssurl    移动端CSS应用文件
* @param {Object} vMp4url    视频文件地址

* 跨平台方案说明=============================
* 本实例请在IIS/Apache等网站环境下测试
* 本实例实现HTTP协议下的跨平台
* 本实例要求[视频文件地址]为mp4格式
*/
var vID        = ""; 
var vWidth     = "100%";            //播放器宽度设置
var vHeight    = 400;               //播放器高度设置
var vFile      = "/resources/player1/CuSunV2set.xml";  //播放器配置文件
var vPlayer    = "/resources/player1/player.swf?v=2.5";//播放器文件
var vPic       = "/resources/player/images/start.jpg";//视频缩略图
var vCssurl    = "/resources/player/images/mini.css"; //移动端CSS应用文件

//适配PC,安卓,iOS请用mp4文件
var vMp4url    = "/resources/video/CommissionedByregistered.mp4";  //视频文件地址
//-->
</SCRIPT> 
<script class="CuPlayerVideo" data-mce-role="CuPlayerVideo" type="text/javascript" src="/resources/player1/CuSunX1.min.js"></script>
</div>
<!--X1 CrossPlatform /end -->
<div class="title">金蝉使用指南之视频教程</div>


 <div class="clear"></div>
<h3><span>相关教程</span></h3>
<div class="piclist">
<dl>
<dt><a href="expert.html" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="expert.html" title="" target="_blank">专家教程视频</a></dd>
</dl>
<dl>
<dt><a href="TheBidOpening.html" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="TheBidOpening.html" title="" target="_blank">建立文件及开标教程</a></dd>
</dl>
<dl>
<dt><a href="margin.html" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="margin.html" title="" target="_blank">审核保证金教程</a></dd>
</dl>
<dl>
<dt><a href="TheTender.html" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="TheTender.html" title="" target="_blank">投标单位报名及投标过程</a></dd>
</dl>
<dl>
<dt><a href="CommissionedByregistered.html" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="CommissionedByregistered.html" title="" target="_blank">注册及委托字幕教程</a></dd>
</dl>
<dl>
<dt><a href="ATenderAnnouncement.html" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="ATenderAnnouncement.html" title="" target="_blank">招标公告及文件及抽专家开标</a></dd>
</dl> 
<dl>
<dt><a href="candidatePublicity.html" class="p145x100"><img src="/resources/player/images/videoLogo.jpg"  /></a></dt>
<dd class="tit"><a href="candidatePublicity.html" title="" target="_blank">中标候选人公示</a></dd>
</dl> 
</div>

</SCRIPT> 


</body>
</html>
