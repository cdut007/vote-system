<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<script type="text/javascript">
$(function(){
	$.extend($.fn.validatebox.defaults.rules,{
		 /***********************************************************
			 * 审核部门代码
			 */
			shbmdm : {
				validator : function(value, param) {
					var reg = /(^[\dA-Z]{8}\-[\dA-Z]$)|(^[\dA-Z]{18}$)/;
					return reg.test(value);
				},
				message : "审核部门代码格式错误"
			},
			
			/***********************************************************
			 * 监督部门代码
			 */
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
});
</script>
<table width="98%" style="margin:0 auto;">
	
	<tr>
		<td class="need">*</td>
		<td>项目名称：</td>
		<td colspan="5">
		<%--<select id="projectId" name="projectId" style="width:60%" class="easyui-validatebox" missingMessage="请选择项目！" data-options="required:true">
			<option value="">---==请选择==---</option>
			<c:forEach items="${projectList}" var="project">
				<c:choose>
					<c:when test="${project.id == projectInstance.projectId}">
						<option value="${project.id}" selected="selected">${project.xmmc00 }</option>
					</c:when>
					<c:otherwise>
						<option value="${project.id}">${project.xmmc00 }</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select> --%>
		${project.xmmc00}
		</td>
	</tr>

	<!-- 以下是招标项目，需要重新做一个页面 -->
	<tr>
		<td class="need">*</td>
		<td>招标项目名称：</td>
		<td colspan="5"><input name="zbxmmc" value="${instance.zbxmmc}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入招标项目名称！" data-options="required:true,validType:'length[0,100]'" style="width: 672px" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td width="120px">招标编号：</td>
		<td>
			<input name="" disabled="disabled" value="${instance.zbxmbh}" class="inputxt easyui-validatebox" placeholder="无需填写，自动生成" style="font-size:12px"/>
		</td>
		<td></td>
		<td class="need"></td>
		<td width="120px">机构内部招标编号：</td>
		<td>
			<input name="organProjectCode"  value="${instance.organProjectCode}" class="inputxt easyui-validatebox" data-options="validType:'length[0,128]'" />
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>招标项目类型：</td>
		<td>
		<%-- 	<c:forEach items="${util:dictionaryTree('PROJECT_ITEM_TYPE',false)}" var="item">
				<div>
					<input class="easyui-validatebox" name="tenderProjectClassifyCode" id="PROJECT_ITEM_TYPE-${item.id}" type="radio" value="${item.itemCode}" data-options="validType:'requireRadio[&quot;tenderProjectClassifyCode&quot;]'" />
					<label for="PROJECT_ITEM_TYPE-${item.id}">${item.itemName}</label>
				</div>
			</c:forEach> --%> 
			
	
		<select id="projectInstanceType" name="projectInstanceType" class="easyui-validatebox" tabindex="-1" data-options="required:true" >
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
				
			<!-- 	<option value="B01">土地使用权出让-土地使用权出让</option>
				<option value="B02">土地使用权出让-探矿权出让</option>
				<option value="B03">土地使用权出让-采矿权出让</option>
				
				<option value="C01">国有产权交易-行政事业单位产权交易</option>
				<option value="C02">国有产权交易-国有及国有控股企业产权交易</option>
				<option value="C03">国有产权交易-金融企业国有资产转让交易</option>
				
				<option value="D01">政府采购-货物类（含药品集中采购）</option>
				<option value="D02">政府采购-工程类</option>
				<option value="D03">政府采购-服务类</option>
				
				<option value="E01">碳排放权交易-排放配额交易</option>
				<option value="E02">碳排放权交易-工程类</option>
				<option value="E03">政府采购-服务类</option>
				<option value="A99">工程建设项目招标投标-其他</option> -->
		</select>
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">*</td>
		<td>申报责任人：</td>
		<td><input name="zbzrr0" value="${instance.zbzrr0}" class="inputxt easyui-validatebox" datatype="*1-50" errormsg="申报责任人！" data-options="required:true,validType:'length[0,25]'" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>招标方式：</td>
		<td>
			<select name="zbfs00" class="easyui-validatebox" data-options="required:true" id="zbfs_sel">
				<c:forEach items="${util:dictionaryTree('ZBFS00',false)}" var="item">
					<option value="${item.itemCode}" ${instance.zbfs00==item.itemCode?"selected":""} >${item.itemName}</option>
				</c:forEach>
			</select>
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">*</td>
		<td>组织形式：</td>
		<td>
			<select name="zbzzxs" id="zzxs_sel">
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
		<td class="need">*</td>
		<td>审核方式：</td>
		<td>
			<select name="reviewType" class="easyui-validatebox" data-options="required:true" id="reviewType">
				<%-- <c:forEach items="${util:dictionaryTree('REVIEW_TYPE',false)}" var="item">
					<option value="${item.itemCode}">${item.itemName}</option>
				</c:forEach>--%>
				<option value="1" ${instance.reviewType=="1"?"selected":""}>资格预审</option>
				<option value="2" ${instance.reviewType=="2"?"selected":""}>资格后审</option>
			</select>
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">*</td>
		<td>预审方式：</td>
		<td>
			<select name="prereviewType" id="prereviewType">
				<%--<c:forEach items="${util:dictionaryTree('PREREVIEW_TYPE',false)}" var="item">
					<option value="${item.itemCode}" ${item.itemCode=='2'?"selected":""}>${item.itemName}</option>
				</c:forEach> --%>
				<option value="2" ${instance.prereviewType=="2"?"selected":""}>合格制</option>
				<option value="1" ${instance.prereviewType=="1"?"selected":""}>合格制（打分）</option>
				<option value="3" ${instance.prereviewType=="3"?"selected":""}>有限数量制</option>
			</select>
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	
	<tr>
		<td class="need">*</td>
		<td>招标内容与范围:</td>
		<td colspan='5'><textarea name="nryfw0" style="width:672px;height:100px" class="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,1000]'">${instance.nryfw0}</textarea></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>审核部门名称：</td>
		<td> <input name="shbmmc" value="${instance.shbmmc}" class="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		
		<td class="need"></td>
		<td>审核部门代码：</td>
		<td> <input name="shbmdm" path="shbmdm" value="${instance.shbmdm}" class="inputxt easyui-validatebox" errormsg="请输入监督部门统一社会信用代码或组织机构代码！" data-options="missingMessage:'请输入组织机构代码  或 统一社会信用代码',validType:'shbmdm'" /></td>
		<td>
			<div class="Validform_checktip">
				<form:errors path="shbmdm" cssClass="Validform_wrong" />
			</div>
		</td>
	</tr>
	
	<tr>
		<td class="need">*</td>
		<td>监督部门名称：</td>
		<td> <input name="jdbmmc" value="${instance.jdbmmc}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入监督部门名称！" data-options="required:true,validType:'length[0,100]'" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>监督部门代码：</td>
		<td><input name="jdbmdm" path="jdbmdm" value="${instance.jdbmdm}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入监督部门统一社会信用代码或组织机构代码！" data-options="missingMessage:'请输入组织机构代码  或 统一社会信用代码',validType:'jdbmdm'" /></td>
		<td>
			<div class="Validform_checktip">
				<form:errors path="jdbmdm" cssClass="Validform_wrong" />
			</div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>监督部门负责人：</td>
		<td> <input name="jdbmfzr" value="${instance.jdbmfzr}" class="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,25]'"/></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">*</td>
		<td>监督部门电话：</td>
		<td><input name="jdbmdh" value="${instance.jdbmdh}" class="inputxt easyui-validatebox"  errormsg="请输入监督部门电话！"  datatype="s1-100"  data-options="required:true,missingMessage:'请输入监督部门电话！',validType:'MobileOrPhone'" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
</table>