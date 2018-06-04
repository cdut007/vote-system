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
<form:form id="projectInstance_form_id" action="${pageContext.request.contextPath}/projectInstance/saveOrUpdate" method="post" commandName="projectInstance">
	<form:hidden path="id" />
	<form:hidden path="lxsj00" />
	<table class="mytablerow" style="width:700px;">
		<tr>
			<th width="90px">所属项目<font color="red">*</font></th><td>
			<form:hidden id='_xmbh00' path="project.id" cssClass="validate[required,maxSize[36]]"/>
			<nobr><form:input id='_xmmc00' path="project.xmmc00" readonly="true"/>
			<input type='button'  onclick='queryProject()' value='选择'/></nobr>
			</td>
			<th width="90px">招标项目编号<font color="red">*</font></th><td><form:input path="zbxmbh" cssStyle="background-color:#eeeeee" readonly="true" cssClass="validate[required,maxSize[36]]"/></td>
		</tr>
		<tr>
			<th width="90px">招标项目名称<font color="red">*</font></th>
			<td><form:input path="zbxmmc" cssClass="validate[required,maxSize[100]]" /></td>
			<th>资格审核方式<font color="red">*</font></th>
			<td><form:select path="zgshfs" cssClass="validate[required]">
					<form:option value="">请选择</form:option>
					<form:options items="${util:dictionaryTree('ZGSHFS',false)}"  itemValue="itemCode" itemLabel="itemName"/>
				</form:select></td>
		</tr>
		<tr>
			<th width="90px">招标人</th>
			<td><form:input path="zbr000" cssClass="validate[maxSize[18]]" /></td>
			<th width="90px">代理机构</th>
			<td><form:input id="_dljgmc" path="dljgmc" cssClass="validate[maxSize[250]]" /> <form:hidden id="_dljgdm" path="dljgdm" /> <input type='button' value='选择' onclick='queryDljg()' /></td>
		</tr>
		<tr>
			<th width="90px">招标方式<font color="red">*</font></th>
			<td><form:select path="zbfs00" items="${util:dictionaryTree('ZBFS00',false)}" cssClass="validate[required]"></form:select></td>
			<th width="90px">组织形式<font color="red">*</font></th>
			<td><form:select path="zbzzxs" items="${util:dictionaryTree('ZBZZXS',false)}" cssClass="validate[required]"  itemValue="itemCode" itemLabel="itemName"/></td>
		</tr>
		<tr>
			<th width="90px">监督部门名称</th>
			<td><form:input path="jdbmmc" cssClass="validate[maxSize[100]]" /></td>
			<th width="90px">监督部门代码</th>
			<td><form:input path="jdbmdm" cssClass="validate[maxSize[25]]" /></td>
		</tr>
		<tr>
			<th width="90px">审核部门名称</th>
			<td><form:input path="shbmmc" cssClass="validate[maxSize[100]]" /></td>
			<th width="90px">审核部门代码</th>
			<td><form:input path="shbmdm" cssClass="validate[maxSize[25]]" /></td>
		</tr>
		<tr>
			<th width="90px">公共服务平台标识</th>
			<td><form:input path="ggfwbs" cssClass="validate[maxSize[25]]" /></td>
			<th width="90px">申报责任人</th>
			<td><form:input path="zbzrr0" cssClass="validate[maxSize[25]]" /></td>
		</tr>
		<tr>
			<th width="90px">招标内容与范围</th>
			<td colspan='3'><form:textarea path="nryfw0" cssClass="validate[maxSize[1000]]" cssStyle="width:96%;height:180px" />
		</tr>
	</table>
</form:form>
<script type="text/javascript">
	$(function() {
		$("#projectInstance_form_id").validationEngine({
			showOneMessage : true,
			promptPosition : "bottomLeft"
		});
	});

	function queryProject() {
		var dialog = addFormDialog({
			width : 920,
			height : 350,
			title : "请选择所属项目",
			url : "${pageContext.request.contextPath}/project/list_dialog",
			iframe : true,
			onClose : function() {
			},
			handler : function() {
				var inputs = $(
						dialog.find("iframe:first")[0].contentWindow.document)
						.find("form:first").find(
								":input[name='selValue']:checked");
				if (inputs.length != 1) {
					alertMsg("请选择一条记录!");
					return;
				}
				var kv = inputs.get(0).value;
				$('#_xmbh00').val(kv.split("@")[0]);
				$('#_xmmc00').val(kv.split("@")[1]);
				dialog.dialog("destroy");
			}
		});

	}

	function queryDljg() {
		var dialog = addFormDialog({
			width : 950,
			height : 550,
			title : "请选择代理机构",
			url : "${pageContext.request.contextPath}/t_organ/list_dialog?ztlx00=A",
			iframe : true,
			onClose : function() {
			},
			handler : function() {
				var inputs = $(
						dialog.find("iframe:first")[0].contentWindow.document)
						.find("form:first").find(
								":input[name='selValue']:checked");
				if (inputs.length != 1) {
					alertMsg("请选择一条记录!");
					return;
				}
				var kv = inputs.get(0).value;
				$('#_dljgmc').val(kv.split("@")[0]);
				$('#_dljgdm').val(kv.split("@")[1]);
				dialog.dialog("destroy");
			}
		});

	}
</script>
