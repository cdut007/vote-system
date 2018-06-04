<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%--
添加修改用户信息
 --%>
<div class="usBox">
	<div class="clearfix">
		<form:form id="aptitudeForm" method="post" action="${pageContext.request.contextPath}/common/updateAptitude" modelAttribute="aptitude">
			<form:hidden path="id" id="id" name="id" />
			<table width="100%" style="table-layout:fixed;">
				<tr>
					<td class="need">*</td>
					<td style="width:100px;">资质名称：</td>
					<td>
						<form:input path="zzname" cssClass="inputxt  easyui-validatebox" data-options="required:true" />
					</td>
					<td class="need">*</td>
					<td style="width:100px;">资质证书编号：</td>
					<td>
						<form:input path="zzzsbh" cssClass="inputxt easyui-validatebox" data-options="required:true" />
					</td>
				</tr>
				<tr>
					<td class="need">*</td>
					<td>资质序列：</td>
					<td>
						<form:select path="zzsequence" datatype="*" nullmsg="请选择政治面貌！">
							<form:option value="1">请选择</form:option>
							<form:options items="${util:dictionaryTree('ZZSEQUENCE',false)}" itemLabel="itemName" itemValue="itemCode" />
						</form:select>
					</td>
					<td class="need">*</td>
					<td>资质行业：</td>
					<td>
						<form:select path="zzindustry" datatype="*" nullmsg="请选择政治面貌！">
							<form:option value="1">请选择</form:option>
							<form:options items="${util:dictionaryTree('ZZINDUSTRY',false)}" itemLabel="itemName" itemValue="itemCode" />
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="need">*</td>
					<td>专业类别：</td>
					<td>
						<form:select path="zzprofessional" datatype="*" nullmsg="请选择政治面貌！">
							<form:option value="1">请选择</form:option>
							<form:options items="${util:dictionaryTree('ZZPROFESSIONAL',false)}" itemLabel="itemName" itemValue="itemCode" />
						</form:select>
					</td>
					<td class="need">*</td>
					<td>资质等级：</td>
					<td>
						<form:select path="zzdj00" datatype="*" nullmsg="请选择政治面貌！">
							<form:option value="1">请选择</form:option>
							<form:options items="${util:dictionaryTree('ZZDJDM',false)}" itemLabel="itemName" itemValue="itemCode" />
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="need">*</td>
					<td>起始时间：</td>
					<td>
						<form:input path="startTime" class="inputxt Wdate easyui-validatebox" data-options="required:true" validType="ltDate['#endTime','起始时间不能大于结束时间']" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" nullmsg="请选择资质起始时间时间！" />
					</td>
					<td class="need">*</td>
					<td>结束时间：</td>
					<td>
						<form:input path="endTime" class="inputxt Wdate	 easyui-validatebox" data-options="required:true" validType="gtDate['#startTime','结束时间不能小于起始时间']" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" nullmsg="请重新选择资质结束时间！" />
					</td>
				</tr>
				<tr valign="top">
					<td class="need">*</td>
					<td>资质附件：</td>
					<td>
						<div id="aptitudeList">
							<c:forEach items="${aptitude.attachmentList}" var="fileItem" varStatus="s">
								<div id="img${s.count}">
									<img style="width:150px;height:80px; border:1px solid #D1D1D1" src="${pageContext.request.contextPath}/attachment/download/${fileItem.fjid00}" id="${fileItem.fjid00}" /><a href="javascript:;" onclick="deleteaptitudepic('${fileItem.fjid00}',this)" class="button red small">删除</a>
								</div>
							</c:forEach>
						</div>
					</td>
					<td class="need">*</td>
					<td colspan="2">
						<div id="aptitudediv" style="display: none;"></div>
						<br /> <a id="qualificationFiles">添加附件</a>
					</td>
				</tr>
			</table>
		</form:form>
	</div>
</div>
<script type="text/javascript">
	var uploader = undefined;
	$(function() {//上传资质
		uploader = new plupload.Uploader({
			runtimes : 'html5,flash,silverlight,html4',
			browse_button : 'qualificationFiles',
			//container : document.getElementById('container'),
			url : ctx + '/login/imageUploadBase64',
			flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
			silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
			multi_selection : true,
			multipart_params : {
				fjgslx : "25"
			},
			file_data_name : "image",
			filters : {
				mime_types : [ //只允许上传图片和zip文件
				{
					title : "Image files",
					extensions : "jpg,gif,png,bmp"
				}, ],
				prevent_duplicates : true,
				max_file_size : '200mb'
			},
			init : {
				PostInit : function() {
				},
				FilesAdded : function(up, files) {
					for ( var index in files) {
						var file = files[index];
						var $input = $("<input/>").attr({
							id : file.id,
							type : "hidden",
							name : "attachmentBase64"
						});
						$("#aptitudeForm").append($input);
					}
					up.start();
				},
				UploadProgress : function(up, file) {

				},
				FileUploaded : function(up, file, result) {
					file.base64 = result.response;
					$("#" + file.id).val(file.base64);
				},
				UploadComplete : function(uploader, files) {
					$("#aptitudediv").empty();
					$("#aptitudediv").show();
					for ( var index in files) {
						var file = files[index];
						var $div = $("<div/>").append($("<input/>").attr("type", "hidden").attr("name", "filename1").val(file.name)).append($("<img/>").css({
							width : 150,
							height : 80,
							border : "1px solid #D1D1D1"
						}).attr("id", "image-" + file.id).attr('src', "data:" + file.type + ";base64," + file.base64)).append("<a class=\"button red small\" onclick=\"deletequalificationpic('" + file.id + "',this);\">删除</a></br>");
						$("#aptitudediv").append($div);
					}
				},
				Error : function(up, err) {

				}
			}
		});
		uploader.init();
	});

	function deletequalificationpic(picid) {
		if (confirm('确认要删除该附件吗？')) {
			uploader.removeFile(picid);
			$("#" + picid).remove();
			$("#image-" + picid).parent().remove();
		} else {
			return;
		}
	};
</script>