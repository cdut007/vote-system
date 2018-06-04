<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>

<c:set var="projectInstance" value="${projectInstanceService.createProjectInstanceQuery().projectInstanceId(processBusinessKey).singleResult()}" scope="request" />
<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 招标文件基本信息
author: ZORO
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" plupload="true"></sys:link> 
<title>招标项目管理</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
#bigJE {
	color: #f00;
	font-size: 14px;
	font-weight: 900
}
</style>
<script type="text/javascript" src="/resources/page/recruit/node_6.js"></script>
<script type="text/javascript" src="/resources/page/recruit/node_6.projectItem.js"></script>
<script type="text/javascript" src="/resources/page/recruit/node_6.notice.js"></script>
<script type="text/javascript" src="/resources/page/recruit/node_6.recruitFile.js"></script> 
<script type="text/javascript" src="/resources/page/recruit/node_6.recruitFileQuestion.js"></script>
<script type="text/javascript" src="/resources/page/recruit/node_6.projectItemGroupNeedInitExpert.js"></script>
<script type="text/javascript" src="/resources/page/recruit/node_6.invitationFile.js"></script> 


<script type="text/javascript">
$(function(){
	$.extend($.fn.validatebox.defaults.rules,{
		MobileOrPhone : {
			validator : function(value) {
				var mobileReg = /^1[3|4|5|7|8|9]\d{9}$/;
				var phoneReg = /^(^0\d{2}-?\d{8}$)|(^0\d{3}-?\d{7,8}$)|(^0\d2 -?\d{8}$)|(^0\d3 -?\d{7,8}$)$/;
				if (mobileReg.test(value) || phoneReg.test(value)) {
					return true;
				} else {
					return false;
				}
			},
			message : '请输入正确的手机号码或固定电话号码'
		}
	});
});

var projectInstanceId = "${projectInstance.id}";
var env="<%=com.mhb.common.component.ConfigBean.isProductEnvironment()%>";
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			项目管理
		</div>
		<div class="usBox">
			<div class="clearfix">
				<c:if test="${not empty reason}">
					<div class="demo-info" style="margin:10px auto;background-color:#fffee6;padding:12px;">
						<span class="demo-tip icon-tip" style="width: 16px; height: 16px;margin-right: 8px;float: left;">&nbsp;</span>
						不通过原因：${reason}
					</div>
					<div class="blank10"></div>
				</c:if>
				<div class="easyui-panel" data-options="title:'招标项目信息'">
					<form:form id="projectInstanceForm" method="post"  style="padding:8px;" action="${pageContext.request.contextPath}/projectInstance/updateProjectInstanceByAgentUser" modelAttribute="projectInstance" onsubmit="return $(this).form('validate');">
						<form:hidden path="id" />
						<table style="width:100%;table-layout: inherit;">
							<tbody>

								<tr>
									<td class="need"></td>
									<td width="120px">招标项目名称：</td>
									<td>${projectInstance.zbxmmc}</td>
								</tr>
								<tr>
									<td class="need"></td>
									<td width="120px">招标人：</td>
									<td>${projectInstance.organTName}</td>
								</tr>
								<tr>
									<td class="need"></td>
									<td width="120px">招标方式：</td>
									<td>${util:dictionary('ZBFS00',projectInstance.zbfs00)}</td>
								</tr>
								<tr>
									<td class="need"></td>
									<td width="120px">招标组织形式：</td>
									<td>${util:dictionary('ZBZZXS',projectInstance.zbzzxs)}</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>资金来源：</td>
									<td>
										${projectInstance.project.funding}
									</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>招标内容：</td>
									<td>
										<form:textarea path="nryfw0" style="width:98%;height:45px;"  readonly="true"/>
									</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>招标条件：</td>
									<td>
										<c:if test="${empty projectInstance.terms}">
											<c:if test="${projectInstance.project.accordingToLaw=='1'}">
													<c:set var="terms" value="本招标项目  ${projectInstance.zbxmmc} 已由  ${projectInstance.project.approvalAuthority}${projectInstance.project.pzwh00} 批准，招标人为 ${projectInstance.project.organ.ztmc00}，建设资金为${projectInstance.project.funding}。项目已具备招标条件，现对该项目进行公开招标 。"></c:set> 
											</c:if>
											<c:if test="${projectInstance.project.accordingToLaw!='1'}">
												<c:set var="terms" value=" ${projectInstance.organAName} 受   ${projectInstance.project.organ.ztmc00} 的委托，对  ${projectInstance.zbxmmc} 进行公开招标，招标人为 ${projectInstance.organTName} 。项目已具备招标条件，现对该项目的监理进行公开招标。"></c:set> 
											</c:if>
										</c:if>
										<textarea name="terms" readonly="readonly" style="width:98%;height:45px;">${empty projectInstance.terms?terms:projectInstance.terms}</textarea>
									</td>
								</tr>
								<%-- <tr>
									<td class="need">*</td>
									<td>资格审核方式：</td>
									<td>
										<c:forEach items="${util:dictionaryTree('ZGSHFS',false)}" var="item">
											<form:radiobutton path="zgshfs" label="${item.itemName}" value="${item.itemCode}"/>
										</c:forEach>
									</td>
								</tr> --%>
								<tr>
									<td class="need">*</td>
									<td>招标单位联系人：</td>
									<td>${projectInstance.project.contacts}</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>招标单位联系方式：</td>
									<td>${projectInstance.project.phones}</td>
								</tr>
								<c:if test="${projectInstance.zbzzxs!='1'}">
								<tr>
									<td class="need">*</td>
									<td>代理机构联系人：</td>
									<td>
										<input name="contacts" class="inputxt easyui-validatebox" style="width:98%;" data-options="required:true,validType:'length[0,25]'" value="${projectInstance.contacts}"/>
<%-- 										<form:input path="contacts" class="inputxt easyui-validatebox" style="width:98%;" data-options="required:true" /> --%>
									</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>代理机构联系方式：</td>
									<td>
										<input name="phones" class="inputxt easyui-validatebox" style="width:98%;" data-options="required:true,validType:'MobileOrPhone'" value="${projectInstance.phones}"/>
<%-- 										<form:input path="phones" cssClass="inputxt easyui-validatebox" style="width:98%;" data-options="required:true,validType:'MobileOrPhone'" /> --%>
									</td>
								</tr>
								</c:if>
							</tbody>
						</table>
						<div class="blank10"></div>
						<a class="button red" id="saveBaseInfo">保存</a>
					</form:form>
				</div>
				<div class="blank10"></div>
				<table id="projectitem-datagrid"></table>
				<div class="blank10"></div>
				
				<c:if test="${projectInstance.zbfs00=='1'}">
					<table id="tendernotice-datagrid"></table>
					<div class="blank10"></div>
					<table id="recruitfile-datagrid"></table>
					<div class="blank10"></div>
				</c:if>
				
				<c:if test="${projectInstance.zbfs00=='2'}">
					<table id="invitationfile-datagrid"></table>
					<div class="blank10"></div>
					<table id="invitefile-datagrid"></table>
					<div class="blank10"></div>
				</c:if>
				<table id="recruitfilequestion-datagrid"></table>
				<div class="blank10"></div>
				
		
				<div>
				
			指定标段组合：
				<div>
				
				<div style="display:inline;" id="itemsForSelect">
				</div><input type="button" id="preInitApply" class='button red' value="确定选择" />
				</div>
				</div>
				
				<table id="projectitemgroupneedexpert-datagrid"></table>
				<div class="blank10"></div>
				
				<div id="recruitfile_download_history_dialog">
					<table class="recruitfile_download_history" id="recruitfile_download_history"></table>
				</div>
				<input type="hidden" name="projectItemId_withquestion" id="projectItemId_withquestion"></input>
				<form id="workFlowForm" action="${pageContext.request.contextPath}/workflow/completeForm" onsubmit="return confirm('确认提交吗?')">
					<input type='hidden' name="taskId" value="${taskId}" />
					
					
					<button id="complete" class="button red">招标完成</button>
					<a id="end" class="button red">关闭招标</a>
				</form>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>