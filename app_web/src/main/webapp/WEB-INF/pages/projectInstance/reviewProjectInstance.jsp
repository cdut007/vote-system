<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<script type="text/javascript">
/*$(function(){
	$.extend($.fn.validatebox.defaults.rules,{

			shbmdm : {
				validator : function(value, param) {
					var reg = /(^[\dA-Z]{8}\-[\dA-Z]$)|(^[\dA-Z]{18}$)/;
					return reg.test(value);
				},
				message : "审核部门代码格式错误"
			},
			

			jdbmdm : {
				validator : function(value, param) {
					var reg = /(^[\dA-Z]{8}\-[\dA-Z]$)|(^[\dA-Z]{18}$)/;
					return reg.test(value);
				},
				message : "监督部门代码格式错误"
			}
	});
});

$(document).ready(function(){
	$("#zbfs_sel").change(function(){
		if($(this).children("option:selected").val() != 1){
			$.messager.alert('系统提示','目前只支持公开招标');
			$(this).prop('selectedIndex', 0);
		}
	});
	$("#zzxs_sel").change(function(){
		if($(this).children("option:selected").val() != 2){
			$.messager.alert('系统提示','目前只支持委托招标');
			$(this).prop('selectedIndex', 1);
		}
	});
});*/
</script>
<table width="98%" style="margin:0 auto;">
	
	<tr>
		<td class="need">&nbsp;</td>
		<td>项目名称：</td>
		<td colspan="5">
		${project.xmmc00}
		</td>
	</tr>

	<!-- 以下是招标项目，需要重新做一个页面 -->
	<tr>
		<td class="need">&nbsp;</td>
		<td>招标项目名称：</td>
		<td colspan="5">${instance.zbxmmc}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">&nbsp;</td>
		<td width="120px">招标编号：</td>
		<td>
			${instance.zbxmbh}
		</td>
		<td></td>
		<td class="need"></td>
		<td width="120px">机构内部招标编号：</td>
		<td>
			${instance.organProjectCode}
		</td>
	</tr>
	<tr>
		<td class="need">&nbsp;</td>
		<td>招标项目类型：</td>
		<td>

		<select disabled id="projectInstanceType" name="projectInstanceType" class="easyui-validatebox" tabindex="-1" data-options="required:true" >
				<option value="">--=请选择=--</option>
				<option value="A01" ${instance.projectInstanceType=="A01"?"selected":""}>工程建设项目招标投标-房屋建筑</option>
				<option value="A02" ${instance.projectInstanceType=="A02"?"selected":""}>工程建设项目招标投标-市政</option>
				<option value="A03" ${instance.projectInstanceType=="A03"?"selected":""}>工程建设项目招标投标-公路</option>
				<option value="A04" ${instance.projectInstanceType=="A04"?"selected":""}>工程建设项目招标投标-铁路</option>
				<option value="A05" ${instance.projectInstanceType=="A05"?"selected":""}>工程建设项目招标投标-民航</option>
				<option value="A06" ${instance.projectInstanceType=="A06"?"selected":""}>工程建设项目招标投标-水运</option>
				<option value="A07" ${instance.projectInstanceType=="A07"?"selected":""}>工程建设项目招标投标-水利</option>
				<option value="A08" ${instance.projectInstanceType=="A08"?"selected":""}>工程建设项目招标投标-能源</option>
				<option value="A09" ${instance.projectInstanceType=="A09"?"selected":""}>工程建设项目招标投标-邮电通信</option>
				<option value="A99" ${instance.projectInstanceType=="A99"?"selected":""}>工程建设项目招标投标-其他</option>
		</select>
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">&nbsp;</td>
		<td>申报责任人：</td>
		<td>${instance.zbzrr0}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">&nbsp;</td>
		<td>招标方式：</td>
		<td>
			<select name="zbfs00" class="easyui-validatebox" disabled data-options="required:true" id="zbfs_sel">
				<c:forEach items="${util:dictionaryTree('ZBFS00',false)}" var="item">
					<option  value="${item.itemCode}" ${instance.zbfs00==item.itemCode?"selected":"" } >${item.itemName}</option>
				</c:forEach>
			</select>
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">&nbsp;</td>
		<td>组织形式：</td>
		<td>
			<select name="zbzzxs" id="zzxs_sel" disabled>
				<c:forEach items="${util:dictionaryTree('ZBZZXS',false)}" var="item">
					<option value="${item.itemCode}" ${item.itemCode=='2'?"selected":""}>${item.itemName}</option>
				</c:forEach>
			</select>
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">&nbsp;</td>
		<td>招标内容与范围:</td>
		<td colspan='5'>${instance.nryfw0}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">&nbsp;</td>
		<td>审核部门名称：</td>
		<td>${instance.shbmmc}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		
		<td class="need"></td>
		<td>审核部门代码：</td>
		<td>${instance.shbmdm}</td>
		<td>
			<div class="Validform_checktip">
				<form:errors path="shbmdm" cssClass="Validform_wrong" />
			</div>
		</td>
	</tr>
	
	<tr>
		<td class="need">&nbsp;</td>
		<td>监督部门名称：</td>
		<td>${instance.jdbmmc}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>监督部门代码：</td>
		<td>${instance.jdbmdm}</td>
		<td>
			<div class="Validform_checktip">
				<form:errors path="jdbmdm" cssClass="Validform_wrong" />
			</div>
		</td>
	</tr>
	<tr>
		<td class="need">&nbsp;</td>
		<td>监督部门负责人：</td>
		<td>${instance.jdbmfzr}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">&nbsp;</td>
		<td>监督部门电话：</td>
		<td>${instance.jdbmdh}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<!-- <tr>
		<td >&nbsp;</td>
		<td style="vertical-align:middle">审核意见：</th>
		<td colspan='6'><textarea id="shyj" name="shyj" style="width:99%;height:120px;"></textarea></td>
	</tr> -->
</table>