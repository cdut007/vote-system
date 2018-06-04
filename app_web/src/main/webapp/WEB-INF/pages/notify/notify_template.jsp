<%@page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- 
Describe:中标通知模板
Copyright:2017
Company: 成都爱特联科技
author:  lihq
--%>
<center><p style="font-size:18px"><b>中标通知书</b></p></center>
<p><span style="text-decoration: underline;">${organ.ztmc00}</span>：</p>
<p>&#160;&#160;&#160;你方于<span style="text-decoration: underline;"><fmt:formatDate value="${bid.tbsj00}" type="both" pattern="yyyy-MM-dd"/></span>&#160;日所递交的<span style="text-decoration: underline;">${projectInstance.zbxmmc}</span>&#160;<span style="text-decoration: underline;">${projectItem.bdmc00}</span>&#160;标段（包）投标文件已被我方接受，被确定为中标人。</p>
<p>&#160;&#160;&#160;标价：<span style="text-decoration: underline;"><fmt:formatNumber value="${notice.price}" pattern="#,#00.##"/></span>&#160;元</p>
<p>&#160;&#160;&#160;交货期：<span style="text-decoration: underline;">${bid.gq0000}</span>&#160;天</p>
<p>&#160;&#160;&#160;你方在接到本通知书后的&#160;<span style="text-decoration: underline;">${days}</span>&#160;日内到 <span style="text-decoration: underline;">${organ.address}</span>&#160;与我方&#160;<span style="text-decoration: underline;">${linkman}</span>&#160;签订合同。</p><br/><br/><br/>
<p>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
招标代理机构：<span style="text-decoration: underline;">${user.organ.ztmc00}</span>&#160;（公章）</p>
<p>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
<span style="text-decoration: underline;">${notifyDate}</span>
</p>
		