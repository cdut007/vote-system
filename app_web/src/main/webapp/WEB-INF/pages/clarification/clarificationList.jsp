<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<title>招标文件澄清</title>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/ChatManager.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<jsp:include page="/common/link.jsp" />
<style type="text/css">

.div_left{/*float:left;*/width:970px;margin-top:5px;}
.div_right{/*float:right;*/width:970px;margin-top:5px;}
.div_left_div{border:1px solid #ccc;line-height:28px;margin-top:0px;padding:0px}
.div_right_div{border:1px solid #ccc;line-height:28px;margin-top:0px;padding:0px;text-align:center}
.div_left_title{width:96%;border-bottom:1px solid #ccc;line-height:28px;margin-left:auto;margin-right:auto;}
.div_right_title{text-align:right;width:96%;border-bottom:1px solid #ccc;line-height:28px;}
.div_right_content{padding-left:20px;padding-top:0px;margin-bottom:2px;}
.div_right_content ul{list-style:none;margin-top:0px;padding:0px}
.div_right_content li{float:left;line-height:28px;width:50%;height:28px;}
.div_right_content span{padding-left:5px;padding-right:5px;}
		
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			澄清内容
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class='tableTitle' style="cursor:pointer;">项目：${tender.projectInstance.zbxmmc}（单击显示）</div>
			<table class='mytableStyle none'>
				<tr>
					<th width="120px">所属项目</th>
					<td colspan='3'>${tender.projectInstance.project.xmmc00}</td>
				</tr>
				<tr>
					<th>招标项目编号:</th>
					<td>${tender.projectInstance.zbxmbh}</td>
					<th>招标项目名称:</th>
					<td>${tender.projectInstance.zbxmmc}</td>
				</tr>
				<tr>
					<th width="120px">招标人</th>
					<td>${tender.projectInstance.project.organ.ztmc00}</td>
					<th width="120px">代理机构</th>
					<td>${tender.projectInstance.organ.ztmc00}</td>
				</tr>
				<tr>
					<th width="120px">招标方式</th>
					<td></td>
					<th width="120px">组织形式</th>
					<td></td>
				</tr>
				<tr>
					<th width="120px">招标内容与范围</th>
					<td colspan='3'><pre>${tender.projectInstance.nryfw0}</pre></td>
				</tr>
			</table>
		</div>
		<div class="usBox" style="margin-top:1px;">
			<c:forEach items="${page.rows}" var="clarification_item" varStatus="status">
			<c:choose>
				<c:when test="${clarification_item.fsrzj0==loginUser.id}">
					<div class="div_right">
						<div class="div_right_div">
							<div class='div_right_title'>
								<h4>${status.count}楼&nbsp;&nbsp;
								发送人：${clarification_item.fsrmc0}&nbsp;&nbsp;
						 		接收人：${clarification_item.jsrmc0}
								发送时间：${clarification_item.fssj00}
								</h4>
							</div>
							<div class='div_right_content' style="word-wrap:break-word">
								<pre>内容：<br/>${clarification_item.fsnr00}</pre>
							</div>		
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="div_left">
					<div class="div_left_div">
						<div class='div_left_title'>
							<h4>${status.count}楼&nbsp;&nbsp;
							发送人：${clarification_item.fsrmc0}&nbsp;&nbsp;
					 	<%-- 接收人：${clarification_item.jsrmc0} --%>
							发送时间：${clarification_item.fssj00}
							</h4>
						</div>
						<div class='div_right_content' style="word-wrap:break-word">
							<pre>内容：<br/>${clarification_item.fsnr00}</pre>
						</div>		
				</div>
			</div>
				</c:otherwise>
			</c:choose>
			</c:forEach>
			<c:if test="${empty page.rows}">
				<c:out value="暂无澄清内容！"></c:out>
			</c:if>
			<div class="blank10"></div>
			<div style='width:100%;'>
				<form class="registerform" action="${pageContext.request.contextPath}/clarification/saveOrUpdate"  method='post'>
					<input type='hidden' name='projectInstanceId' value="${clarification.projectInstanceId}"/>
					<input type='hidden' name='jsrzj0' value="${tender.ownerId}"/>
					<input type='hidden' name='tenderId' value="${tender.id}"/>
					<%-- <input type='hidden' name='bdbh00' value="${tender.tbbdbh}"/> --%>
					<table width="98%" style="table-layout:fixed;margin:0 auto;">
						<tr>
							<td class="need" style="width:10px;">*</td>
							<td style="width:50px;">内容：</td>
							<td>
							<textarea name='fsnr00' rows="10" cols="100" datatype="*" nullmsg="发送内容不能为空！" style="width:90%;height:120px;"></textarea></td>
							<td style="width:5px"><div class="infostyle">
									<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
								</div></td>
						</tr>
						<tr>
							<td colspan='4' style="text-align:center"><input type='submit' class='button red' value="发送"/></td>
						</tr>
					</table>
				</form>
			</div>
	</div>
	<jsp:include page="/common/chatRoom.jsp"></jsp:include>
</div>
</body>
</html>
