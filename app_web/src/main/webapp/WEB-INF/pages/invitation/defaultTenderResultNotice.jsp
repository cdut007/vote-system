<%@page pageEncoding="UTF-8"  import="com.mhb.common.util.DateUtils"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div style="background:#fff;width:400px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">
	<div style="font-family:'仿宋_GB2312';font-size:18px;line-height:28pt; ">
		<p style="text-align:center;height:100px; "></p>
		<p style="text-align:center; ">
			<span style="letter-spacing:0pt; font-weight:bold; font-size:18pt; font-family:'宋体'; ">资格预审结果通知书</span>
		</p>
		<p style="height:40px;"></p>
		
		<%-- <p style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
				<span style="font-size: 16px;font-family: 宋体">委托人：
				<span style="text-decoration:underline;">&nbsp; ${projectInstance.project.organ.ztmc00} &nbsp;</span></span>
		</p> --%>
		
		<p style="text-align:center; ">
			<span style="letter-spacing:0pt; font-weight:bold; font-size:13pt; font-family:'宋体'; ">
				<span style="text-decoration:underline">&nbsp;${tenderItem.projectInstanceName } &nbsp;</span>
				<span style="text-decoration:underline">&nbsp;${tenderItem.projectItemName } &nbsp;</span>资格预审结果通知书
			</span>
		</p>
		<p style="height:5px;"></p>
		<p style="text-align:left; ">
			<span style="letter-spacing:0pt; font-weight:bold; font-size:12pt; font-family:'宋体'; ">
				<span style="text-decoration:underline">&nbsp;${tenderItem.organBName } &nbsp;</span>:</span>
		</p>
		
		
		<p style="height:5px;"></p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;line-height:20pt;  ">感谢贵公司参加我司
				<span style="text-decoration:underline">&nbsp;${tenderItem.projectInstanceName } &nbsp;</span>项目的资格预审工作。由于贵司
				<span style="text-decoration:underline">&nbsp; &nbsp;</span>的原因，未能通过资格预审。感谢贵司对我司工作的支持。
 			</span>
		</p>
		
		<p style="height:20px;"></p>
		<p style="line-height: 150%;text-indent: 350px;">
			<span style="font-family: 宋体; font-size: 14px;">${tenderItem.organAName }</span>
		</p>
		
		<p style="line-height: 150%;text-indent: 350px;">
			<span style="font-family: 宋体; font-size: 14px;"><%=DateUtils.getYear()%>年<%=DateUtils.getMonth()%>月<%=DateUtils.getDay()%>日</span>
		</p>
		
		
		
	</div>
	<!--EndFragment-->
</div>