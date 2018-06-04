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
		 },
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
			$.messager.confirm('系统提示','目前只支持公开招标');
			$(this).prop('selectedIndex', 0);
			/* return; */
		}
	});
	$("#zzxs_sel").change(function(){
		if($(this).children("option:selected").val() != 2){
			$.messager.confirm('系统提示','目前只支持委托招标');
			$(this).prop('selectedIndex', 1);
			/* return; */
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
				<c:when test="${empty organTId}">
					<span class="textbox combo" style="width: 98%; height: 20px;">
						<span class="textbox-addon textbox-addon-right" style="right: 0px;">
							<a class="textbox-icon combo-arrow searchbox-button" style="width: 18px; height: 20px;border:1px solid #a5aeb6" href="javascript:void(0)" icon-index="0" id="xuanze"></a>
						</span>
						<input id="shuru-text" type="text" name="project.organTName" class="easyui-validatebox textbox-text textbox-text-readonly" style="width: 98%; padding-top: 3px; padding-bottom: 3px; margin-right: 18px; margin-left: 0px;" type="text" readonly="readonly" placeholder="" autocomplete="off" data-options="required:true"/>
						<input id="shuru-value" type="hidden" class="textbox-value" name="project.organId"/>
					</span>
				</c:when>
				<c:otherwise>
					<b>${organTName}</b>
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
		<td colspan="5"><input name="project.xmmc00" class="inputxt easyui-validatebox" datatype="*1-100" nullmsg="项目名称不能为空！" errormsg="项目名称最多100个字符！" data-options="required:true" style="width: 672px" /></td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>项目地址：</td>
		<td colspan="5"><input name="project.xmdz00" value="${project.xmdz00}" class="inputxt easyui-validatebox" datatype="*1-100" nullmsg="请输入项目地址！" errormsg="请输入项目地址！" data-options="required:true" style="width: 672px" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>项目行政区划：</td>
		<td style="width:210px;"><sys:treeselect id="project_region" title="请选择行政区划" includeRoot="false" name="project.region" value="${CURRENT_USER_SESSION_INFO.organ.region}"  cssClass="inputxt easyui-validatebox" dataOptions="required:true,validType:'city'" typeCode="REGION" maxLevelNo="3"/></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">*</td>
		<td>项目法人：</td>
		<td><input name="project.xmfr00" class="inputxt easyui-validatebox" datatype="*" nullmsg="请输入项目法人！" errormsg="请输入项目法人！" data-options="required:true" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>项目行业类型：</td>
		<td><sys:treeselect title="请选择项目行业类型" includeRoot="false" name="project.industry" value="${CURRENT_USER_SESSION_INFO.organ.industry}" id="project_industry" cssClass="inputxt easyui-validatebox" dataOptions="required:true, validType:'industryCategory' " typeCode="INDUSTRY" maxLevelNo="3" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>投资金额币种：</td>
		<td><sys:treeselect title="请选择金额币种" includeRoot="false" name="project.currencyCode" value="${156}" id="project_currencyCode" cssClass="inputxt easyui-validatebox" typeCode="CURRENCY" maxLevelNo="3" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>投资金额：</td>
		<td><input name="project.investmentAmount" value="${project.investmentAmount}" class="easyui-numberbox" errormsg="请输入投资金额！" data-options="onChange: function(value){$('#vv').text(value);}" style="width:165px" /></td>
		<td><select name="project.priceUnit" class="easyui-validatebox" data-options="required:true" style="width:60px">
				<c:forEach items="${util:dictionaryTree('JEDWDM',false)}" var="item">
					<option value="${item.itemCode}" ${item.itemCode=='2'?"selected":""}>${item.itemName}</option>
				</c:forEach>
		</select></td>
		

	</tr>
	<tr>
		<td class="need">*</td>
		<td>项目批文名称：</td>
		<td colspan="5"><input name="project.approvalName" value="${project.approvalName}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入项目批文名称！" data-options="required:true" style="width: 672px" /></td>
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
		<td><input name="project.zbfaNumber" value="${project.zbfaNumber}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入招标方案核准号！"/></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">*</td>
		<td>上传项目批文：</td>
		<td colspan="5"><a id="approvalfile" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">上传附件</a> <input type="hidden" id="attachmentId" name="project.approvalfileId" /> &nbsp;&nbsp;<span id="container"></span></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>项目批文单位：</td>
		<td><input name="project.approvalAuthority" value="${project.approvalAuthority}" class="inputxt easyui-validatebox" datatype="*" errormsg="请输入项目批文单位！" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>批准文号：</td>
		<td><input name="project.pzwh00" value="${project.pzwh00}" class="inputxt easyui-validatebox" datatype="*" errormsg="请输入批准文号！" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		
	</tr>
	<tr>		
		<td class="need">*</td>
		<td>项目规模：</td>
		<td colspan="5"><textarea name="project.xmgm00" value="${project.xmgm00}" class="inputxt easyui-validatebox" enullmsg="请输入项目规模！" data-options="required:true" style="width:672px;height:100px" ></textarea></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>资金来源：</td>
		<td><input type="hidden" name="funding" /> <c:forEach items="${util:dictionaryTree('ZJLYDM',false)}" var="item">
				<div>
					<input id="ZJLYDM-${item.id}" name="project.zjly00" type="checkbox" value="${item.itemCode}" ${item.itemName=='自筹资金'?"checked='checked'":""} /> <label for="ZJLYDM-${item.id}">${item.itemName}</label>
				</div>
			</c:forEach></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>		
		<td class="need">*</td>
		<td>是否依法招标：</td>
		<td><c:forEach items="${util:dictionaryTree('ACCORDING_TO_LAW',false)}" var="item">
				<div>
					<input id="ACCORDING_LAW-${item.id}" name="project.accordingToLaw" type="radio" value="${item.itemCode}" ${item.itemCode=='0'?"checked='checked'":""} /> <label for="ACCORDING_LAW-${item.id}">${item.itemName}</label>
				</div>
			</c:forEach></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>		
	</tr>
	<tr>
		<td class="need"></td>
		<td>出资比例：</td>
		<td colspan="5"><textarea name="project.czbl" value="${project.czbl}" class="inputxt easyui-validatebox" enullmsg="请输入出资比例！" style="width:672px;height:100px" ></textarea></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>	
	<tr>	
		<td class="need">*</td>
		<td>项目立项时间：</td>		
			<td><input type="text" id="project.xmlxsj" value="<fmt:formatDate value="${project.xmlxsj}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />" name="project.xmlxsj" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%yyyy-%MM-%dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" missingMessage="请选择项目立项时间！" />&nbsp;</td>				
		<td>
			<div class="Validform_checktip"></div>
		</td>
		
		<td class="need">*</td>
		<td>是否进场：</td>		
			<td>
				<select name="project.sfjc00" class="easyui-validatebox" data-options="required:true">
					<c:forEach items="${util:dictionaryTree('YES_NO',false)}" var="item">
						<option value="${item.itemCode}">${item.itemName}</option>
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
		<td><input name="project.contacts" value="${CURRENT_USER_SESSION_INFO.userName}" class="inputxt easyui-validatebox" datatype="*" nullmsg="请输入联系人！" errormsg="请输入联系人！" data-options="required:true" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need">*</td>
		<td>联系方式：</td>
		<td><input name="project.phones" value="${CURRENT_USER_SESSION_INFO.phone}" class="inputxt easyui-validatebox" datatype="*" nullmsg="请输入联系方式！" errormsg="请输入联系方式！" data-options="required:true,validType:'MobileOrPhone'" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	
		
	<!-- 以下是招标项目，需要重新做一个页面 -->
	<tr>
		<td class="need">*</td>
		<td>招标项目名称：</td>
		<td colspan="5"><input name="zbxmmc" value="${zbxmmc}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入招标项目名称！" data-options="required:true" style="width: 672px" /></td>
		<td>
			<div class="Validform_checktip"></div>
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
				<option value="A01">工程建设项目招标投标-房屋建筑</option>
				<option value="A02">工程建设项目招标投标-市政</option>
				<option value="A03">工程建设项目招标投标-公路</option>
				<option value="A04">工程建设项目招标投标-铁路</option>
				<option value="A05">工程建设项目招标投标-民航</option>
				<option value="A06">工程建设项目招标投标-水运</option>
				<option value="A07">工程建设项目招标投标-水利</option>
				<option value="A08">工程建设项目招标投标-能源</option>
				<option value="A09">工程建设项目招标投标-邮电通信</option>
				<option value="A99">工程建设项目招标投标-其他</option>
				
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
		<td><input name="zbzrr0" value="${zbzrr0}" class="inputxt easyui-validatebox" datatype="*1-50" errormsg="申报责任人！" data-options="required:true" /></td>
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
					<option value="${item.itemCode}">${item.itemName}</option>
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
		<td>招标内容与范围:</td>
		<td colspan='5'><textarea name="nryfw0" data-options="required:true" style="width:672px;height:100px" class="inputxt easyui-validatebox" data-options="required:true">${nryfw0}</textarea></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need">*</td>
		<td>审核部门名称：</td>
		<td> <input name="shbmmc" value="${shbmmc}" class="inputxt easyui-validatebox" data-options="required:true" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		
		<td class="need"></td>
		<td>审核部门代码：</td>
		<td> <input name="shbmdm" path="shbmdm" value="${shbmdm}" class="inputxt easyui-validatebox" errormsg="请输入监督部门统一社会信用代码或组织机构代码！" data-options="missingMessage:'请输入组织机构代码  或 统一社会信用代码',validType:'shbmdm'" /></td>
		<td>
			<div class="Validform_checktip">
				<form:errors path="shbmdm" cssClass="Validform_wrong" />
			</div>
		</td>
	</tr>
	
	<tr>
		<td class="need">*</td>
		<td>监督部门名称：</td>
		<td> <input name="jdbmmc" value="${jdbmmc}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入监督部门名称！" data-options="required:true" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>监督部门代码：</td>
		<td><input name="jdbmdm" path="jdbmdm" value="${jdbmdm}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入监督部门统一社会信用代码或组织机构代码！" data-options="missingMessage:'请输入组织机构代码  或 统一社会信用代码',validType:'jdbmdm'" /></td>
		<td>
			<div class="Validform_checktip">
				<form:errors path="jdbmdm" cssClass="Validform_wrong" />
			</div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>监督部门负责人：</td>
		<td> <input name="jdbmfzr" value="${jdbmfzr}" class="inputxt easyui-validatebox" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>监督部门电话：</td>
		<td><input name="jdbmdh" value="${jdbmdh}" class="inputxt easyui-validatebox"  errormsg="请输入监督部门电话！"  datatype="s1-100"  data-options="missingMessage:'请输入固定联系电话！格式(xxxx-xxxxxxx)',validType:'regPhone'" /></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
</table>