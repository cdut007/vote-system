<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,minimal-ui" />
<meta name="format-detection" content="telephone=no"/>
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>金蝉使用指南之视频教程</title>
<link rel="stylesheet" type="text/css" href="/resources/player/common.css"/>
<script type="text/javascript" src="/resources/player1/jquery172.js"></script>
<script type="text/javascript" src="/resources/player1/action.js"></script>
<!-- 弹出通知 -->
<style type="text/css">
        #winpop { width:400px;color:blance; height:0px; background:#C70000; position:fixed; right:0; bottom:0; border:1px solid #666; margin:0; padding:1px; overflow:hidden; display:none;}
        #winpop .title { width:100%; height:26px; color:#FFFFFF; line-height:20px; background:#C70000; font-weight:bold; text-align:left; font-size:18px;}
        #winpop .con { width:100%; height:140px; color:black; font-size:14px; padding-left: 5px;padding-top: 7px;padding-right: 5px;}
        #winpop .bottom{ height:40px; float: right; cursor: hand;}
        .close { position:absolute; right:4px; top:-1px; color:#FFF; cursor:pointer}
</style>
<script type="text/javascript">
       function tips_pop(){
           var MsgPop=document.getElementById("winpop");
           var popH=parseInt(MsgPop.style.height);//将对象的高度转化为数字
            
           if (popH==0){
               MsgPop.style.display="block";//显示隐藏的窗口
               show=setInterval("changeH('up')",2);
           }else { 
               hide=setInterval("changeH('down')",2);
           }
       }
       function changeH(str) {
           var MsgPop=document.getElementById("winpop");
           var popH=parseInt(MsgPop.style.height);
         
           if(str=="up"){
               if (popH<=200){
                   MsgPop.style.height=(popH+4).toString()+"px";
                }else{  
                    clearInterval(show);
                }
            }
           if(str=="down"){ 
                 if (popH>=4){  
                     MsgPop.style.height=(popH-4).toString()+"px";
                 }else{ 
                     clearInterval(hide);   
                     MsgPop.style.display="none";  //隐藏DIV
                 }
            }
       }
       function showPageMsg() {//查看全部
           alert("弹出更新具体内容");
       }
       window.onload=function(){//加载
           document.getElementById('winpop').style.height='0px';
           setTimeout("tips_pop()",0);//0秒后调用tips_pop()这个函数
       }
</script>
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
var vMp4url    = "/resources/video/TheTender.mp4";  //视频文件地址
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

<div id="winpop">
	<div class="title">重要通知<span class="close" onclick="tips_pop()" style="text-align: center;">关闭</span></div>
	     <div style="background: #FFFFFF; width: 100%; height: 200px;">
	         <div class="con"><h1 align="center">友情提示</h1><br/>投标单位的付款形式已有增加，已有原来的电汇+凭证上传 拓展为 电汇+凭证上传 及 线上网银直接支付。<!-- <span style="color:red">（保证金打款账户必须是企业基本户）</span><br/>如有问题请拨打，联系电话：0351-5612491 --></div>
	<!-- 	            <div class="bottom"> <label onclick="showPageMsg()">查看全部</label></div>
	 --> </div>
	</div>
</div>   


</body>
</html>
