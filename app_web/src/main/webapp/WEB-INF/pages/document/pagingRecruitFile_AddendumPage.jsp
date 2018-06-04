<%@page import="com.mhb.common.util.DateUtils" pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" datepicker="true" jgrowl="true" uedit="true" ca="true"/>
<script type="text/javascript"></script>
<script>
	$(function() {
		$("#subBtn").click(function(){
			$("#content").val($("#contentHTML").html());
			formSubmit(2);
		});
		$("#saveBtn").click(function(){
			
		});
		
		$(document).on("blur",":input", function() {
			if($(this).attr("type")=="button"||$(this).attr("type")=="submit"){
				return;
			}
			loadDefaultRecruitFileAddendum();
		});
		
		function loadDefaultRecruitFileAddendum() {
			$.ajax({
				url : ctx + "/recruitFile/defaultAddendum",
				type : "post",
				data : $("#recruitFileAddendumForm").serialize(),
				dataType : "html",
				success : function(data) {
					$("#contentHTML").html(data);
				}
			});
		}
		function formSubmit(submitType) {
			$("#recruitFileAddendumForm").ajaxSubmit({
				type:"post",
				beforeSend:function(){
					var valid = true;
					if(2 == submitType){
						valid = $("#recruitFileAddendumForm").form("validate");
					}
					if(valid){
						$.messager.progress({
							title : "系统提示",
							msg : "正在提交数据"
						});
					}
					return valid;
				},
				success:function(){
					$.messager.confirm("系统提示","提交成功！如涉及重大变更，请自行发布延期公告",function(){
						window.location.href="/home";
					});
				},
				error:function(e,s1,s2){
					//$.messager.alert(s1);
				}
			});
		}
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标文件补遗
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				<c:choose>
					<c:when test="${recruitFileAddendum.id==null}">新增</c:when>
					<c:otherwise>修改</c:otherwise>
				</c:choose>
				招标文件补遗
			</h4>
			<form:form id="recruitFileAddendumForm" method="post" action='${pageContext.request.contextPath}/recruitFile/saveRecruitFileAddendum' modelAttribute="recruitFileAddendum">
				<form:hidden path="id" />
				<form:hidden path="recruitFileId" value="${recruitFileId }" />
				<input type="hidden" value="${token}" name="token" />
				<table width="100%" style="table-layout:fixed">
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:12%">题 目：</td>
						<td colspan="4">
							${recruitFileAddendum.title}<form:hidden path="title"/>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td style="vertical-align:middle;">主 题:</td>
						<td style="padding-left:3px;" colspan="4">
							<form:input cssStyle="width:99%" path="subject" cssClass="inputxt easyui-validatebox" data-options="required:true"/>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>项目编号：</td>
						<td style="text-align: left" colspan="4">
							${recruitFileAddendum.projectCode}<form:hidden path="projectCode"/>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td>招标人：</td>
						<td style="text-align: left" colspan="4">
							${recruitFileAddendum.organTName}<form:hidden path="organTName"/>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:12%;">监督单位：</td>
						<td colspan="4">
							<form:input cssStyle="width:99%" path="supervisingUnit" cssClass="inputxt easyui-validatebox" data-options="required:true"/>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:12%;">代理机构：</td>
						<td colspan="4">
							${recruitFileAddendum.organAName}<form:hidden path="organAName"/>
						</td>
					</tr>
				</table>
					
				<table width="100%" style="table-layout:fixed">
					
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:12%">电 话：</td>
						<td>
							<form:input cssStyle="inputxt" path="phone" cssClass="inputxt easyui-validatebox" data-options="required:true"/>
						</td>
						<td class="need" style="width:10px;"></td>
						<td style="width:12%">传 真：</td>
						<td>
							<form:input cssStyle="inputxt" path="fax" cssClass="inputxt easyui-validatebox"/>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>发件人：</td>
						<td>
							<form:input cssStyle="inputxt" path="sendingUnit" cssClass="inputxt easyui-validatebox" data-options="required:true"/>
						</td>
						<td class="need" style="width:10px;">*</td>
						<td>收件人：</td>
						<td>
							<form:input cssStyle="inputxt" path="receivingUnit" cssClass="inputxt easyui-validatebox" data-options="required:true"/>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>日 期：</td>
						<td>
							<span><%=DateUtils.getYear()%>年<%=DateUtils.getMonth()%>月<%=DateUtils.getDay()%>日</span>
						</td>
						<td class="need" style="width:10px;"></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="6">
							<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
								<div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;" id="contentHTML" ${"contenteditable='true'"}></div>
								<input type="hidden" id="content" name="content"/>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="6" style="padding:10px 0 18px 0;">
							<!-- <input type="button" class="button red" value="保存草稿" id="saveBtn"/> -->
							<input type="button" class="button red" value="提交审核" id="subBtn" />
							<input type="button" class="button red" value="返回" onclick="history.go(-1)" />
						</td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</body>
</html>