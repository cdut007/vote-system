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
<jsp:include page="/common/link.jsp" />
<style type="text/css">

.div_left{float:left;width:807px;margin-top:5px;}
.div_right{float:right;width:807px;margin-top:5px;}
.div_left_div{border:1px solid #ccc;line-height:28px;margin-top:0px;padding:0px}
.div_right_div{border:1px solid #ccc;line-height:28px;margin-top:0px;padding:0px}
.div_left_title{width:96%;border-bottom:1px solid #ccc;line-height:28px;}
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
			<p style='font-size:14px;font-weight:bold;color:#FFC125'>招标项目：${tender.zbxmmc}&nbsp;&nbsp;
			标段编号：${tender.tbbdbh}&nbsp;&nbsp;
			标段编号：${tender.tbbdmc}
			</p>
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
					<!-- 	接收人：${clarification_item.jsrmc0} -->
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
					<!-- 	接收人：${clarification_item.jsrmc0} -->
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
					<input type='hidden' name='tenderid' value="${tender.id}"/>
					<input type='hidden' name='bdbh00' value="${tender.tbbdbh}"/>
					<table width="98%" style="table-layout:fixed;margin:0 auto;">
						<tr>
							<td class="need" style="width:10px;">*</td>
							<td style="width:50px;">内容：</td>
							<td style="width:210px;">
							<textarea name='fsnr00' rows="10" cols="100" datatype="*" nullmsg="发送内容不能为空！" style="width:600px;height:120px;overflow:hidden"></textarea></td>
							<td><div class="infostyle">
									<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
								</div></td>
						</tr>
						<tr>
							<td colspan='3' style="text-align:center"><input type='submit' class='button red' value="发送"/></td>
						</tr>
					</table>
				</form>
			</div>
		
	</div>
</div>
</body>
</html>
