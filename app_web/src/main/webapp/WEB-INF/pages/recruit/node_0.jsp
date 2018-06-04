<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--项目信息确认 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新建项目信息</title>
<%-- <sys:link easyui="true" ztree="true"/> --%>
<sys:link easyui="true" jgrowl="true" plupload="true" ztree="true" uedit="true"/>
<script type="text/javascript">
$(function(){
	//验证复选框
	$.extend($.fn.validatebox.defaults.rules, {
        requireRadio: {  
            validator: function(value, param){ 
                return $("[name='"+param[0]+"']:checked").length>0;
            },  
            message: '请选择招标项目分类' 
        }  
    });

	$("[name='project.zjly00']").change(function(){
		$("[name='funding']").val($("[name='project.zjly00']:checked").map(function(){
			return $("[for='"+$(this).attr("id")+"']").text();
		}).get().join(","));
	}).change();
	var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : "approvalfile",
		url : ctx + '/attachment/uploadAttachment',
		flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
		silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
		multi_selection : false,
		multipart_params : {
			fjgslx : "30",
			unique : true
		},
		filters : {
			mime_types  : [ //只允许上传图片和zip文件
				{title:"*",extensions : "jpg"}
			],
			prevent_duplicates : true,
			max_file_size : '200mb'
		},
		init : {
			PostInit : function() {
				//alert(1);
			},
			FilesAdded : function(up, files) {
				up.start();
			},
			UploadProgress : function(up, file) {

			},
			FileUploaded : function(up, file, result) {
				var ajax=$.parseJSON(result.response);
				if(ajax.success){
					$.messager.alert("系统提示","上传成功！");
					var attachmentId=ajax.data.fjid00;
					//alert(attachmentId);
					$("#attachmentId").val(attachmentId);
					$("#attachmentId").next("a").remove();
					$("#container").html("<a href=\""+ctx+"/attachment/download/"+ajax.data.path+"\" target='_blank'>"+file.name+"<a>");
					//$("#attach").val(att);
				}
			},
			UploadComplete : function(uploader, files) {

			},
			Error : function(up, err) {

			}
		}
	}).init();
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			新建项目
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class="clearfix">
				<form method="post" action="${pageContext.request.contextPath}/workflow/start" onsubmit="return $(this).form('validate');">
					<c:set value="${CURRENT_USER_SESSION_INFO.organId}" var="organTId" scope="request"/>
					<c:set value="${CURRENT_USER_SESSION_INFO.organ.ztmc00}" var="organTName" scope="request"/>
					<c:set value="${CURRENT_USER_SESSION_INFO.id}" var="ownerId" scope="request"/>
					<input type="hidden" name="token" value="${token}" /> 
					<input type="hidden" id="processDefinitionId" name="processDefinitionId" value="${processDefinitionId}" />
					<input type="hidden" name="project.organId" value="${organTId}" /> 
					<input type="hidden" name="project.organTName" value="${organTName}" /> 
					<input type="hidden" name="ownerId" value="${ownerId}" /> 
					<%-- <table width="98%" style="table-layout:fixed;margin:0 auto;">
						<tr>
							<td class="need"></td>
							<td style="width:100px;">招标人：</td>
							<td>
								<b>${CURRENT_USER_SESSION_INFO.organ}</b>
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
							<td class="need"></td>
							<td style="width:100px;"></td>
							<td></td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>项目名称：</td>
							<td colspan="5">
								<input name="project.xmmc00" class="inputxt easyui-validatebox" datatype="*1-100" nullmsg="项目名称不能为空！" errormsg="项目名称最多100个字符！" data-options="required:true" style="width: 672px" />
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>项目行政区划：</td>
							<td style="width:210px;">
								<sys:treeselect title="请选择行政区划" includeRoot="false" name="project.region" value="${CURRENT_USER_SESSION_INFO.organ.region}" id="project_region" cssClass="inputxt easyui-validatebox" dataOptions="required:true" typeCode="REGION" maxLevelNo="3"/>
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>项目地址：</td>
							<td colspan="5">
								<input name="project.xmdz00" value="${project.xmdz00}" class="inputxt easyui-validatebox" datatype="*1-100" nullmsg="请输入项目地址！" errormsg="请输入项目地址！" data-options="required:true" style="width: 672px" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>项目法人：</td>
							<td>
								<input name="project.xmfr00" class="inputxt easyui-validatebox" datatype="*" nullmsg="请输入项目法人！" errormsg="请输入项目法人！" data-options="required:true" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>联系人：</td>
							<td>
								<input name="project.contacts" value="${CURRENT_USER_SESSION_INFO.userName}" class="inputxt easyui-validatebox" datatype="*" errormsg="请输入联系人！" data-options="required:true" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
							<td class="need">*</td>
							<td>联系方式：</td>
							<td>
								<input name="project.phones" value="${CURRENT_USER_SESSION_INFO.phone}" class="inputxt" datatype="*" errormsg="请输入联系方式！" data-options="required:true,validType:'MobileOrPhone'" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>项目批文名称：</td>
							<td colspan="5">
								<input name="project.approvalName" value="${project.approvalName}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入项目批文名称！" data-options="required:true" style="width: 672px" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>	
							<td>批准文号：</td>
							<td>
								<input name="project.pzwh00" value="${project.pzwh00}" class="inputxt easyui-validatebox" datatype="*" errormsg="请输入批准文号！" data-options="required:true" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>项目批文单位：</td>
							<td>
								<input name="project.approvalAuthority" value="${project.approvalAuthority}" class="inputxt easyui-validatebox" datatype="*" errormsg="请输入项目批文单位！" data-options="required:true" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>资金来源：</td>
							<td>
								<input type="hidden" name="funding"/>
								<c:forEach items="${util:dictionaryTree('ZJLYDM',false)}" var="item">
									<div>
										<input id="ZJLYDM-${item.id}" name="project.zjly00" type="checkbox" value="${item.itemCode}" ${item.itemName=='自筹资金'?"checked='checked'":""}/> <label for="ZJLYDM-${item.id}">${item.itemName}</label>
									</div>
								</c:forEach>
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
							<td class="need">*</td>
							<td>是否依法招标：</td>
							<td>
								<c:forEach items="${util:dictionaryTree('ACCORDING_TO_LAW',false)}" var="item">
									<div>
										<input id="ACCORDING_LAW-${item.id}" name="project.accordingToLaw" type="radio" value="${item.itemCode}" ${item.itemCode=='0'?"checked='checked'":""}/> <label for="ACCORDING_LAW-${item.id}">${item.itemName}</label>
									</div>
								</c:forEach>
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>招标项目名称：</td>
							<td colspan="5">
								<input name="zbxmmc" value="${zbxmmc}" class="inputxt easyui-validatebox" datatype="*1-100" errormsg="请输入招标项目名称！" data-options="required:true" style="width: 672px" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>招标项目分类：</td>
							<td colspan="5">
								<c:forEach items="${util:dictionaryTree('PROJECT_ITEM_TYPE',false)}" var="item">
									<input name="tenderProjectClassifyCode" id="PROJECT_ITEM_TYPE-${item.id}" type="radio" value="${item.itemCode}"  />
									<label for="PROJECT_ITEM_TYPE-${item.id}">${item.itemName}</label>&nbsp;
								</c:forEach>
								                                                                                                                                                                                                  <!-- 取消光标 -->
                              	<input type="text" id="tenderProjectClassifyCode" class="easyui-validatebox for-validate" data-options="required:true,missingMessage:'请选择招标项目分类'" style="width:0;border:none;background: #fff" onfocus="$(this).blur();" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>招标项目分类：</td>
							<td>
								<c:forEach items="${util:dictionaryTree('PROJECT_ITEM_TYPE',false)}" var="item">
									<div><input class="easyui-validatebox" name="tenderProjectClassifyCode" id="PROJECT_ITEM_TYPE-${item.id}" type="radio" value="${item.itemCode}" data-options="validType:'requireRadio[&quot;tenderProjectClassifyCode&quot;]'"/>
									<label for="PROJECT_ITEM_TYPE-${item.id}">${item.itemName}</label></div>
								</c:forEach>
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>申报责任人：</td>
							<td>
								<input name="zbzrr0" value="${zbzrr0}" class="inputxt" datatype="*1-50" errormsg="申报责任人！" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
							<td class="need">*</td>
							<td>组织形式：</td>
							<td>
								<select name="zbzzxs">
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
							<td>招标方式：</td>
							<td>
								<select name="zbfs00" class="easyui-validatebox" data-options="required:true">
									<c:forEach items="${util:dictionaryTree('ZBFS00',false)}" var="item">
										<option value="${item.itemCode}">${item.itemName}</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
							<td class="need">*</td>
							<td>投资金额：</td>
							<td>
								<input name="project.investmentAmount" value="${project.investmentAmount}" class="easyui-numberbox" errormsg="请输入投资金额！" required data-options="onChange: function(value){$('#vv').text(value);}" style="width:165px"/>
							</td>
							<td>
								<select name="project.priceUnit" class="easyui-validatebox" data-options="required:true" style="width:60px">	
									<c:forEach items="${util:dictionaryTree('JEDWDM',false)}" var="item">
											<option value="${item.itemCode}" ${item.itemCode=='2'?"selected":""}> ${item.itemName}</option>	
									</c:forEach>
								</select>
							</td>	
						</tr>
						<tr>
							<td class="need">*</td>
							<td>投资金额币种：</td>
							<td>
								<sys:treeselect title="请选择金额币种" includeRoot="false" name="project.currencyCode" value="${156}" id="project_currencyCode" cssClass="inputxt easyui-validatebox" dataOptions="required:true" typeCode="CURRENCY" maxLevelNo="3"/>
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>申报责任人：</td>
							<td>
								<input name="zbzrr0" value="${zbzrr0}" class="inputxt" datatype="*1-50" errormsg="申报责任人！" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>审核部门名称：</td>
							<td>
								<input type="hidden" name="shbmdm" value="${shbmdm}" /> <input name="shbmmc" value="${shbmmc}" class="inputxt" datatype="*1-100" errormsg="请输入审核部门名称！" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
							<td class="need">*</td>
							<td>监督部门名称：</td>
							<td>
								<input type="hidden" name="jdbmdm" value="${jdbmdm}" /> <input name="jdbmmc" value="${jdbmmc}" class="inputxt" datatype="*1-100" errormsg="请输入监督部门名称！" />
							</td>
							<td>
								<div class="Validform_checktip"></div>
							</td>
						</tr>
					</table> --%>
					<jsp:include page="createProject.jsp" />
					<div class="blank10"></div>
					<input type="submit" class='button red' value="保 存" /> <input type="reset" class='button red' value="重 置" />
				</form>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	<div id="zbOrgan">
		<table id="zbrTable"></table>
	</div>
</body>
</html>
