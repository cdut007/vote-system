<%@page import="com.mhb.common.util.DateUtils"%>
<%@page import="com.mhb.common.Constants"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib
	prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>



<p style="margin-top: auto; text-align: center; line-height: 64px">
	<strong><span style="font-size: 32px; font-family: 宋体">确认通知</span></strong>
</p>
<p
	style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 24px">
	<span style="font-size: 16px; font-family: 宋体"><span style="text-decoration: underline;" id="bidder_ztmc">${invitationFile.projectInstance.project.organ.ztmc00}</span></span>
</p>


<p style="margin: 5px 0; line-height: 33px">
	
		
		<span style="">我方已于<span style="text-decoration:underline;">&nbsp;<fmt:formatDate value="${currentDate}" pattern="yyyy年MM月dd日" type="both" dateStyle="default" timeStyle="default" />&nbsp;</span>收到你方
		<span style="text-decoration:underline;">&nbsp;<fmt:formatDate value="${invitationFile.sendDate}" pattern="yyyy年MM月dd日" type="both" dateStyle="default" timeStyle="default" />&nbsp;</span>
		日发出的 <span style="text-decoration:underline;">&nbsp;${invitationFile.projectInstance.zbxmmc}&nbsp;</span>设备采购招标的投标邀请书，
		并确认<span style="text-decoration:underline;" id="accept_str">&nbsp;接受&nbsp;</span>投标。 
特此确认。  
		
</p>



<p
	style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 33px;text-align: right;">
	<span style="font-size: 16px; font-family: 宋体">被邀请单位名称:<span style="text-decoration: underline;" id="bidder_ztmc">&nbsp;${curretnUser.organ.ztmc00}&nbsp;</span></span>
</p>
<p style="margin: 5px 0; line-height: 33px;text-align: right;">
	<span style="text-decoration:underline;">&nbsp;<fmt:formatDate value="${currentDate}" pattern="yyyy年MM月dd日" type="both" dateStyle="default" timeStyle="default" />&nbsp;</span>
</p>

