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
		industryCategory:{
			validator:function(value,param){
				value=$("#hide-project_industry").val();
				value=value.substring(1,3).toString();
				var reg = /^[0-9]*$/;
				if(reg.test(value)==true){
					return value;
				}
			},
			message:'请选择到具体的行业类型'
		},
		city:{
			validator:function(value,param){
				value=$("#hide-project_region").val();
				value=value.substring(2,6);
				return value!='0000';
			},
			message:'选择省份时请选到市一级'
		 }
	});
});

$(document).ready(function(){
	$("#zbfs_sel").change(function(){
		if($(this).children("option:selected").val() != 1){
			$.messager.confirm('系统提示','目前只支持公开招标');
			$(this).prop('selectedIndex', 0);
		}
	});
	$("#zzxs_sel").change(function(){
		if($(this).children("option:selected").val() != 2){
			$.messager.confirm('系统提示','目前只支持委托招标');
			$(this).prop('selectedIndex', 1);
		}
	});
});
</script>
<table width="98%" style="margin:0 auto;">
	<tr>
		<td class="need">*</td>
		<td style="width:100px;">招标人：</td>
		<td colspan="5">
			<c:choose>
				<c:when test="${empty project.organ}">
					<span class="textbox combo" style="width: 98%; height: 20px;">
						<span class="textbox-addon textbox-addon-right" style="right: 0px;">
							<a class="textbox-icon combo-arrow searchbox-button" style="width: 18px; height: 20px;border:1px solid #a5aeb6" href="javascript:void(0)" icon-index="0" id="xuanze"></a>
						</span>
						<input id="shuru-text" type="text" name="organTName" class="easyui-validatebox textbox-text textbox-text-readonly" style="width: 98%; padding-top: 3px; padding-bottom: 3px; margin-right: 18px; margin-left: 0px;" type="text" readonly="readonly" placeholder="" autocomplete="off" data-options="required:true"/>
						<input id="shuru-value" type="hidden" class="textbox-value" name="organId"/>
					</span>
				</c:when>
				<c:otherwise>
					<b>${project.organ.ztmc00}</b>
				</c:otherwise>
			</c:choose> 
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>项目名称：</td>
		<td colspan="5"><input name="xmmc00" value="${project.xmmc00}" class="inputxt easyui-validatebox" datatype="*1-100" nullmsg="项目名称不能为空！" errormsg="项目名称最多100个字符！" data-options="required:true,validType:'length[0,100]'" style="width: 672px" /></td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>项目地址：</td>
		<td colspan="5"><input name="xmdz00" value="${project.xmdz00}" class="inputxt easyui-validatebox" datatype="*1-100" nullmsg="请输入项目地址！" errormsg="请输入项目地址！" data-options="required:true,validType:'length[0,100]'" style="width: 672px" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>项目行政区划：</td>
		<td style="width:210px;"><sys:treeselect id="project_region" title="请选择行政区划" includeRoot="false" name="region" value="${project.region}"  cssClass="inputxt easyui-validatebox" dataOptions="required:true,validType:'city'" typeCode="REGION" maxLevelNo="3"/></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">*</td>
		<td>项目法人：</td>
		<td><input name="xmfr00" value="${project.xmfr00}" class="inputxt easyui-validatebox" datatype="*" nullmsg="请输入项目法人！" errormsg="请输入项目法人！" data-options="required:true,validType:'length[0,25]'" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>项目行业类型：</td>
		<td><sys:treeselect title="请选择项目行业类型" includeRoot="false" name="industry" value="${project.industry}" id="project_industry" cssClass="inputxt easyui-validatebox" dataOptions="required:true, validType:'industryCategory' " typeCode="INDUSTRY" maxLevelNo="3" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>投资金额币种：</td>
		<td><sys:treeselect title="请选择金额币种" includeRoot="false" name="currencyCode" value="${156}" id="project_currencyCode" cssClass="inputxt easyui-validatebox" typeCode="CURRENCY" maxLevelNo="3" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>投资金额：</td>
		<td><input name="investmentAmount" value="${project.investmentAmount}" class="easyui-numberbox" errormsg="请输入投资金额！" data-options="onChange: function(value){$('#vv').text(value);}" style="width:165px" /></td>
		<td><select name="priceUnit" class="easyui-validatebox" data-options="required:true" style="width:60px">
				<c:forEach items="${util:dictionaryTree('JEDWDM',false)}" var="item">
					<option value="${item.itemCode}" ${item.itemCode==project.priceUnit?"selected":""}>${item.itemName}</option>
				</c:forEach>
		</select></td>
		

	</tr>
	<tr>
		<td class="need">*</td>
		<td>项目批文名称：</td>
		<td colspan="5"><input name="approvalName" value="${project.approvalName}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入项目批文名称！" data-options="required:true,validType:'length[0,64]'" style="width: 672px" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>招标方案核准号：</td>
		<td><input name="zbfaNumber" value="${project.zbfaNumber}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入招标方案核准号！" data-options="validType:'length[0,127]'"/></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>上传项目批文：</td>
		<td colspan="5"><a id="approvalfile" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">上传附件</a> <input type="hidden" id="attachmentId" name="approvalfileId" /> &nbsp;&nbsp;<span id="container"></span><span style="color: red">(支持附件类型jpg,pdf,zip,rar)</span></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>项目批文单位：</td>
		<td><input name="approvalAuthority" value="${project.approvalAuthority}" class="inputxt easyui-validatebox" datatype="*" errormsg="请输入项目批文单位！" data-options="validType:'length[0,64]'"/></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>批准文号：</td>
		<td><input name="pzwh00" value="${project.pzwh00}" class="inputxt easyui-validatebox" datatype="*" errormsg="请输入批准文号！" data-options="validType:'length[0,100]'"/></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		
	</tr>
	<tr>		
		<td class="need">*</td>
		<td>项目规模：</td>
		<td colspan="5"><textarea name="xmgm00" value="${project.xmgm00}" class="inputxt easyui-validatebox" enullmsg="请输入项目规模！" data-options="required:true,validType:'length[0,500]'" style="width:672px;height:100px" >${project.xmgm00}</textarea></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>资金来源：</td>
		<td><input type="hidden" name="funding" /> <c:forEach items="${util:dictionaryTree('ZJLYDM',false)}" var="item">
				<div>
					<input id="ZJLYDM-${item.id}" name="zjly00" type="checkbox" value="${item.itemCode}" ${project.funding.contains(item.itemName)?"checked='checked'":""} /> <label for="ZJLYDM-${item.id}">${item.itemName}</label>
				</div>
			</c:forEach></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>		
		<td class="need">*</td>
		<td>是否依法必须招标项目：</td>
		<td><c:forEach items="${util:dictionaryTree('ACCORDING_TO_LAW',false)}" var="item">
				<div>
					<input id="ACCORDING_LAW-${item.id}" name="accordingToLaw" type="radio" value="${item.itemCode}" ${item.itemCode==project.accordingToLaw?"checked='checked'":""} /> <label for="ACCORDING_LAW-${item.id}">${item.itemName}</label>
				</div>
			</c:forEach></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>		
	</tr>
	<tr>
		<td class="need"></td>
		<td>出资比例：</td>
		<td colspan="5"><textarea name="czbl" value="${project.czbl}" class="inputxt easyui-validatebox" enullmsg="请输入出资比例！" data-options="validType:'length[0,1000]'" style="width:672px;height:100px" >${project.czbl}</textarea></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>	
	<tr>	
		<td class="need">*</td>
		<td>项目审批时间：</td>		
			<td><input type="text" id="xmlxsj" value="<fmt:formatDate value="${project.xmlxsj}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />" name="xmlxsj" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%yyyy-%MM-%dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" missingMessage="请选择项目立项时间！" />&nbsp;</td>				
		<td>
			<div class="Validform_checktip"></div>
		</td>
		
		<td class="need">*</td>
		<td>是否进场：</td>		
			<td>
				<select name="sfjc00" class="easyui-validatebox" data-options="required:true">
					<c:forEach items="${util:dictionaryTree('YES_NO',false)}" var="item">
						<option value="${item.itemCode}" <c:if test="${sfjc00 == item.itemCode}"> selected="selected" </c:if> >${item.itemName}</option>
					</c:forEach>
				</select>
			</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>	
	</tr>	
	<tr>
		<td class="need">*</td>
		<td>联系人：</td>
		<td><input name="contacts" value="${project.contacts}" class="inputxt easyui-validatebox" datatype="*" nullmsg="请输入联系人！" errormsg="请输入联系人！" data-options="required:true,validType:'length[0,25]'" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">*</td>
		<td>联系方式：</td>
		<td><input name="phones" value="${project.phones}" class="inputxt easyui-validatebox" datatype="*" nullmsg="请输入联系方式！" errormsg="请输入联系方式！" data-options="required:true,validType:'MobileOrPhone'" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>


	
</table>