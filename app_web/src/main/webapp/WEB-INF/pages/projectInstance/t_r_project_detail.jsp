<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<script>
 $("input[readOnly]").keydown(function(e) {
      e.preventDefault();
 });

</script>
<div class='easyui-tabs' data-options="fit:true,plain:true" style="width:850px;height:450px;">
	<div title="招标项目详细信息">
		<form:form id="projectInstance_form_detail" action="${pageContext.request.contextPath}/projectInstance/saveOrUpdate" method="post" commandName="projectInstance">
			<form:hidden path="id"/>
			<table class="mytablerow" style="width:850px;">
				<tr>
					<th width="120px">所属项目<font color="red">*</font></th><td>
					<form:hidden  path="project.xmbh00" cssClass="validate[required,maxSize[36]]"/>
					<form:input  path="project.xmmc00" readonly="true" cssStyle="background-color:#eeeeee"/>
					</td>
					<th width="120px">招标项目编号<font color="red">*</font></th><td>
					<form:input path="zbxmbh" readonly="true" cssClass="validate[required,maxSize[20]]" cssStyle="background-color:#eeeeee"/></td>
				</tr>
				<tr>
					<th width="120px">招标项目名称<font color="red">*</font></th><td><form:input path="zbxmmc" readonly="true" cssStyle="background-color:#eeeeee" cssClass="validate[required,maxSize[100]]"/></td>
				</tr>
				<tr>
					<th width="120px">招标人</th><td><form:input path="zbr000" readonly="true"  cssClass="validate[maxSize[18]]" cssStyle="background-color:#eeeeee"/></td>
					<th width="120px">代理机构</th><td><form:input id="_dljgmc" readonly="true" path="dljgmc"  cssClass="validate[maxSize[250]]" cssStyle="background-color:#eeeeee"/>
						<form:hidden id="_dljgdm" path="dljgdm" />
					</td>
				</tr>
				<tr>
					<th width="120px">招标方式<font color="red">*</font></th><td><form:select path="zbfs00"  items="${util:dictionaryTree('ZBFS00',false)}" cssClass="validate[required]" cssStyle="background-color:#eeeeee"  itemValue="itemCode" itemLabel="itemName"></form:select></td>
					<th width="120px">组织形式<font color="red">*</font></th><td><form:select path="zbzzxs"  items="${util:dictionaryTree('ZBZZXS',false)}" cssClass="validate[required]" cssStyle="background-color:#eeeeee"  itemValue="itemCode" itemLabel="itemName"/></td>
				</tr>
				<tr>
					<th width="120px">监督部门名称</th><td><form:input path="jdbmmc" readonly="true" cssClass="validate[maxSize[100]]" cssStyle="background-color:#eeeeee"/></td>
					<th width="120px">监督部门代码</th><td><form:input path="jdbmdm" readonly="true" cssClass="validate[maxSize[25]]" cssStyle="background-color:#eeeeee"/></td>
				</tr>
				<tr>
					<th width="120px">审核部门名称</th><td><form:input path="shbmmc" readonly="true" cssClass="validate[maxSize[100]]" cssStyle="background-color:#eeeeee"/></td>
					<th width="120px">审核部门代码</th><td><form:input path="shbmdm" readonly="true" cssClass="validate[maxSize[25]]" cssStyle="background-color:#eeeeee"/></td>
				</tr>
				<tr>
					<th width="120px">公共服务平台标识</th><td><form:input path="ggfwbs" readonly="true" cssClass="validate[maxSize[25]]" cssStyle="background-color:#eeeeee"/></td>
					<th width="120px">申报责任人</th><td><form:input path="zbzrr0" readonly="true" cssClass="validate[maxSize[25]]" cssStyle="background-color:#eeeeee"/></td>
				</tr>
				<tr>
					<th width="120px">招标内容与范围</th>
					<td colspan='3'>
						<form:hidden path="lxsj00"/>
					<form:textarea path="nryfw0" readonly="true" cssStyle="background-color:#eeeeee;width:96%,height:180px" cssClass="validate[maxSize[1000]]"/></td>
				</tr>
			</table>
		</form:form>
	</div>
	<div title="招标项目委托信息" style="">
		<form:form id="t_zbwtdl_form_detail" action="${pageContext.request.contextPath}/t_zbwtdl/saveOrUpdate" method="post" commandName="t_zbwtdl">
			<form:hidden path="id"/>
			<form:hidden path="projectInstanceId"/>
			<table class="mytablerow">
				<tr>
					<th width="120px">招标项目编号</th><td><form:input path="zbxmbh" cssClass="validate[maxSize[20]]" readonly="true" cssStyle="background-color:#eeeeee"/></td>
					<th width="120px">招标代理机构代码</th><td><form:input path="dljgdm" cssClass="validate[maxSize[4]]" readonly="true" cssStyle="background-color:#eeeeee"/></td>
				</tr>
				<tr>
					<th width="120px">招标代理机构名称</th><td><form:input path="dljgmc" cssClass="validate[maxSize[50]]" readonly="true" cssStyle="background-color:#eeeeee"/></td>
					<th width="120px">招标代理资格分类代码</th><td><form:input path="dlzgfl" cssClass="validate[maxSize[3]]"/></td>
				</tr>
				<tr>
					<th width="120px">招标代理资格分级代码</th><td><form:input path="dlzgfj" cssClass="validate[maxSize[3]]"/></td>
				</tr>
				<tr>
					<th width="120px">招标代理内容与范围</th><td colspan='3'>
					<form:textarea path="dlnrfw"  cssClass="validate[maxSize[2000]]" cssStyle="width:96%;height:180px"/></td>
				</tr>
				<tr>
					<th width="120px">招标代理权限</th><td colspan='3'>
					<form:textarea path="zbdlqx"  cssClass="validate[maxSize[500]]" cssStyle="width:96%;height:150px"/></td>
				</tr>
				<tr>
					<th width="120px">招标代理机构项目负责人信息</th><td colspan='3'>
					<form:textarea path="dlfzr0"  cssClass="validate[maxSize[300]]" cssStyle="width:96%;height:120px"/></td>
				</tr>
			</table>
		</form:form>
	</div>
	<div title="招标项目计划" style="">
		<form:form id="projectInstance_plan_form_detail" action="${pageContext.request.contextPath}/projectInstance_plan/saveOrUpdate" method="post" commandName="projectInstance_plan">
			<form:hidden path="id"/>
			<form:hidden path="projectInstanceId"/>
			<table class="mytablerow">
				<tr>
					
					<th width="120px">招标项目编号</th><td>
					<form:input id='zbxmbh' path="zbxmbh" cssClass="validate[maxSize[20]]" readonly="true" cssStyle="background-color:#eeeeee"/></td>
					<th width="120px">招标项目名称</th><td>
					<form:input id='zbxmmc' path="zbxmmc" cssClass="validate[maxSize[50]]" readonly="true" cssStyle="background-color:#eeeeee"/></td>
				</tr>
				<tr>
					<th width="120px">相关标段（包）编号</th><td><form:input path="bdbh00" cssClass="validate[maxSize[1000]]"/></td>
					<th></th><td></td>
				</tr>
				<tr>
					<th width="120px">工作任务计划</th><td colspan='3'>
					<form:textarea path="gzrwjh"  cssClass="validate[maxSize[1000]]" cssStyle="width:96%;height:120px"/></td>
				</tr>
				<tr>
					<th width="120px">项目团队成员组成与职责分工</th><td colspan='3'>
					<form:textarea path="xmcyzz" cssClass="validate[maxSize[1000]]" cssStyle="width:96%;height:120px"/></td>
				</tr>
			</table>
		</form:form>
	</div>
</div>
