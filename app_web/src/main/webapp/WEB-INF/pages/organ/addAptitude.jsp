<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Constants.PLATFORM_NAME%></title>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	var uploader = undefined;
	$(function() {//上传资质
		if ("${aptitude.id}") {
			$("#aptitudediv").show();
		}
		uploader = new plupload.Uploader({
			runtimes : 'html5,flash,silverlight,html4',
			browse_button : 'qualificationFiles',
			//container : document.getElementById('container'),
			url : ctx + '/attachment/uploadAttachment',
			flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
			silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
			multi_selection : false,
			multipart_params : {
				fjgslx : "25"
			},
			filters : {
				mime_types  : [ //TODO 上传图片格式，其他格式没有预览感觉没用！
					{title:"*",extensions : "jpg,gif,png,bmp"}
				],
				prevent_duplicates : true,
				max_file_size : '50000mb'
			},
			init : {
				PostInit : function() {
				},
				FilesAdded : function(up, files) {
					up.start();
				},
				UploadProgress : function(up, file) {

				},
				FileUploaded : function(up, file, result) {
					var data = $.parseJSON(result.response);
					file.id = data.data.fjid00;
					$("#aptitudediv").show();
					var $div = $("<div/>").append($("<input/>").attr("type", "hidden").attr("name", "filename1").val(file.name)).append($("<img/>").css({
						width : 195,
						height : 85,
						border : "1px solid #D1D1D1"
					}).attr("id", file.id).attr('src', ctx + '/attachment/download/' + data.data.path)).append("<a class=\"button red small\" onclick=\"deletequalificationpic('" + data.data.fjid00 + "',this);\">删除</a></br>");
					$("#aptitudediv").append($div);
					$("#filename").val(file.name);
					$("#aptitude").append($("<input/>").attr("type", "hidden").val(data.data.fjid00).attr("id", "input-" + data.data.fjid00).attr("name","attachmentList"));
				},
				UploadComplete : function(uploader, files) {
					/* $("#aptitudediv").empty();
					$("#aptitudediv").show();
					 for(var ss in files){
						//alert(JSON.stringify(files[ss]));
						
					 } */
				},
				Error : function(up, err) {

				}
			}
		});
		uploader.init();
	});

	function deletequalificationpic(picid) {
		if (confirm('确认要删除该附件吗？')) {
			$.ajax({
				type : 'get',
				dataType : 'json',
				data : {},
				url : ctx + "/attachment/deleteAttchment?fjid00=" + picid,
				success : function(data) {
					if (data.success) {
						$("#" + picid).parent().remove();
						uploader.removeFile(picid);
						$("#input-" + picid).remove();
					}
					$.jGrowl(data.msg);
				},
				error : function(e, s1, s2) {
				}
			});
		}
	}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			企业管理
			<code>&gt;</code>
			角色管理
			<code>&gt;</code>
			添加资质
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<form:form id="aptitude" method="post" action="${pageContext.request.contextPath}/aptitude/addAptitude" commandName="aptitude" enctype="multipart/form-data" onsubmit="return $(this).form('validate');">
					<!-- <input type="hidden" id="filename" name="filename"/> -->
					<input type="hidden" id="id" name="id" />
					<form:hidden path="organId" />
					<table width="100%" style="table-layout:fixed;">
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">企业名称：</td>
							<td style="width:220px;">${aptitude.organName}</td>
							<td style="width:180px;"></td>
							<td class="need">*</td>
							<td style="width:100px;">信息申报人：</td>
							<td style="width:220px;">
								<form:input path="xxsbr0" cssClass="inputxt easyui-validatebox" data-options="required:true" />
							</td>
							<td style="width:180px;"></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">资质名称：</td>
							<td style="width:220px;">
								<form:input path="zzname" cssClass="inputxt easyui-validatebox" data-options="required:true" />
							</td>
							<td style="width:180px;"></td>
							<td class="need">*</td>
							<td style="width:100px;">资质证书编号：</td>
							<td style="width:220px;">
								<form:input path="zzzsbh" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[6,16]'" />
							</td>
							<td style="width:180px;"></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">资质序列：</td>
							<td style="width:220px;">
								<form:select path="zzsequence" datatype="*">
									<form:option value="1">请选择</form:option>
									<form:options items="${util:dictionaryTree('ZZSEQUENCE',false)}" itemLabel="itemName" itemValue="itemCode"/>
								</form:select>
							</td>
							<td style="width:180px;"></td>
							<td class="need">*</td>
							<td style="width:100px;">资质行业：</td>
							<td style="width:220px;">
								<form:select path="zzindustry" datatype="*">
									<form:option value="1">请选择</form:option>
									<form:options items="${util:dictionaryTree('ZZINDUSTRY',false)}" itemLabel="itemName" itemValue="itemCode" />
								</form:select>
							</td>
							<td style="width:180px;"></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>资质专业：</td>
							<td>
								<form:select path="zzprofessional" datatype="*">
									<form:option value="1">请选择</form:option>
									<form:options items="${util:dictionaryTree('ZZPROFESSIONAL',false)}" itemLabel="itemName" itemValue="itemCode" />
								</form:select>
							</td>
							<td style="width:180px;"></td>
							<td class="need">*</td>
							<td>资质等级：</td>
							<td>
								<form:select path="zzdj00" datatype="*">
									<form:option value="1">请选择</form:option>
									<form:options items="${util:dictionaryTree('ZZDJDM',false)}" itemLabel="itemName" itemValue="itemCode" />
								</form:select>
							</td>
							<td style="width:180px;"></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>起始时间：</td>
							<td>
								<form:input path="startTime" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true" validType="ltDate['#endTime','起始时间不能大于结束时间']" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" nullmsg="请选择资质起始时间时间！" />
							</td>
							<td style="width:180px;"></td>
							<td class="need">*</td>
							<td>结束时间：</td>
							<td>
								<form:input path="endTime" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true" validType="gtDate['#startTime','结束时间不能小于起始时间']" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							</td>
							<td style="width:180px;"></td>
						</tr>
						<tr valign=“top”>
							<td class="need">*</td>
							<td>资质附件：</td>
							<td>
								<div id="aptitudediv" style="display: none;">
									<%-- <img style="width:150px;height:80px; border:1px solid #D1D1D1" src="${pageContext.request.contextPath}/aptitude/showpic?id=${aptitude.id}" id="aptitudeImg" /> --%>
								</div>
								<br /> <a id="qualificationFiles" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">选择附件</a><i>可以上传 .jpg .gif .png .bmp</i>
							</td>
							<td style="width:180px;"></td>
							<td class="need">*</td>
							<td>文件名称：</td>
							<td>
								<form:input path="filename" cssClass="inputxt easyui-validatebox" data-options="required:true" id="filename" readonly="true" />
							</td>
							<td style="width:180px;"></td>
						</tr>
					</table>
					<div class="blank10"></div>
					<input type="submit" class="button orange" value="保存" />
					<input type="button" class="button blue" value="返回" onclick="window.location='/aptitude/aptitudeOwnList'" />
				</form:form>
			</div>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>