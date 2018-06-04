<%@page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- 
Describe:中标通知模板
Copyright:2017
Company: 成都爱特联科技
author:  lihq
--%>
<center><p style="font-size:18px"><b>中标结果通知书</b></p></center><br/>
<!--<p><span style="text-decoration: underline;">${organ.ztmc00}</span>：</p>-->
<p>&nbsp;&nbsp;我方已接受&nbsp;<span style="text-decoration: underline;">${organ.ztmc00}</span>&nbsp;于<span style="text-decoration: underline;"><fmt:formatDate value="${bid.tbsj00}" type="both" pattern="yyyy-MM-dd"/></span>&nbsp;日所递交的&nbsp;
<span style="text-decoration: underline;">${projectInstance.zbxmmc}</span>&nbsp;<span style="text-decoration: underline;">${projectItem.bdmc00}</span>&nbsp;标段（包）投标文件，确定&nbsp;<span style="text-decoration: underline;">${organ.ztmc00}</span>&nbsp;为中标人。
你方所递交的&nbsp;<span style="text-decoration: underline;">${projectInstance.zbxmmc}</span>&nbsp;<span style="text-decoration: underline;">${projectItem.bdmc00}</span>&nbsp;标段（包）投标文件未被我方接受。</p>
<br/><br/>
<p>&nbsp;&nbsp;谢谢你单位对我们工作的大力支持！</p><br/><br/>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
招标代理机构：<span style="text-decoration: underline;">${user.organ.ztmc00}</span>&nbsp;&nbsp;（公章）</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span style="text-decoration: underline;">${notifyDate}</span></p>
		