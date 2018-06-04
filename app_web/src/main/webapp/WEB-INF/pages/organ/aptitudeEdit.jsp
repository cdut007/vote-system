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
<form:form method="post" id="aptitudeForm"
	action="${pageContext.request.contextPath}/aptitude/updateAptitude"
	commandName="aptitude">
	<form:hidden path="id" id="id" name="id"/>
	<input type="hidden" id="filename" name="filename" />
	<table width="100%" style="table-layout:fixed;">
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">企业名称：</td>
			<td> ${aptitude.organ.ztmc00}</td>
			<td class="need">*</td>
			<td	style="width:100px;">信息申报人：</td>
			<td><form:input path="xxsbr0" cssClass="inputxt easyui-validatebox"  data-options="required:true"/></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>资质名称：</td>
			<td><form:input path="zzname" cssClass="inputxt  easyui-validatebox" data-options="required:true"/></td>
			<td class="need">*</td>
			<td>资质证书编号：</td>
			<td><form:input path="zzzsbh" cssClass="inputxt easyui-validatebox" data-options="required:true"/></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>资质序列：</td>
			<td><form:select path="zzsequence" datatype="*"
					nullmsg="请选择政治面貌！">
					<form:option value="1">请选择</form:option>
					<form:options items="${util:dictionaryTree('ZZSEQUENCE',false)}" itemLabel="itemName"
						itemValue="itemCode" />
				</form:select>
			</td>
			<td class="need">*</td>
			<td>资质行业：</td>
			<td><form:select path="zzindustry" datatype="*"
					nullmsg="请选择政治面貌！">
					<form:option value="1">请选择</form:option>
					<form:options items="${util:dictionaryTree('ZZINDUSTRY',false)}" itemLabel="itemName"
						itemValue="itemCode" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>专业类别：</td>
			<td><form:select path="zzprofessional" datatype="*"
					nullmsg="请选择政治面貌！">
					<form:option value="1">请选择</form:option>
					<form:options items="${util:dictionaryTree('ZZPROFESSIONAL',false)}" itemLabel="itemName"
						itemValue="itemCode" />
				</form:select>
			</td>
			<td class="need">*</td>
			<td>资质等级：</td>
			<td><form:select path="zzdj00" datatype="*" nullmsg="请选择政治面貌！">
					<form:option value="1">请选择</form:option>
					<form:options items="${util:dictionaryTree('ZZDJDM',false)}" itemLabel="itemName"
						itemValue="itemCode" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>起始时间：</td>
			<td><form:input path="startTime" class="inputxt Wdate easyui-validatebox"
					data-options="required:true" validType="ltDate['#endTime','起始时间不能大于结束时间']" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
					nullmsg="请选择资质起始时间时间！"  />
			</td>
			<td class="need">*</td>
			<td>结束时间：</td>
			<td><form:input path="endTime" class="inputxt Wdate	 easyui-validatebox"
					data-options="required:true" validType="gtDate['#startTime','结束时间不能小于起始时间']" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
					nullmsg="请重新选择资质结束时间！" />
			</td>
		</tr>
		<tr	valign="top">
		    <td class="need">*</td>
			<td>资质附件：</td>
			<td>
			    <div id="aptitudeList">
			    <c:forEach items="${aptitude.attachmentList}" var="fileItem" varStatus="s">
			         <div id="img${s.count}" ><img style="width:150px;height:80px; border:1px solid #D1D1D1" src="${pageContext.request.contextPath}/aptitude/showpic?id=${fileItem.fjid00}" id="${fileItem.fjid00}" /><a href="javascript:;"  onclick="deleteaptitudepic('${fileItem.fjid00}',this)"  class="button red small">删除</a></div>
			    </c:forEach>
			    </div>
		    </td>
		    <td class="need">*</td>
		    <td	colspan="2"> <div id="aptitudediv" style="display: none;"></div>
			    <br /> <a id="qualificationFiles" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">添加附件</a><i>可以上传 .jpg .gif .png .bmp</i></td>
		</tr>
	</table>
</form:form>
</div>
</div>
<script type="text/javascript">
	var uploader=undefined;
	$(function() {//上传资质
		if ("${aptitude.id}") {
			$("#aptitudediv").show();
		}
		uploader= new plupload.Uploader({
			runtimes : 'html5,flash,silverlight,html4',
			browse_button : 'qualificationFiles',
			//container : document.getElementById('container'),
			url : ctx + '/attachment/uploadAttachment',
			flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
			silverlight_xap_url : ctx
					+ '/resources/plupload-2.1.2/js/Moxie.xap',
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
					file.id = data.data;
					$("#aptitudediv").show();
					var $div = $("<div/>").append($("<input/>").attr("type", "hidden").attr("name", "filename1").val(file.name)).append($("<img/>").css({
						width : 195,
						height : 85,
						border : "1px solid #D1D1D1"
					}).attr("id", file.id).attr('src', ctx + '/attachment/download/' + data.data.path)).append("<a class=\"button red small\" onclick=\"deletequalificationpic('" + data.data.id + "',this);\">删除</a></br>");
					$("#aptitudediv").append($div);
					$("#filename").val(file.name);
					$("#aptitude").append($("<input/>").attr("type", "hidden").val(data.data.fjid00).attr("id", "input-" + data.data.fjid00).attr("name","attachmentList"));
				},
				UploadComplete : function(uploader, files) {
					/* $("#aptitudediv").empty();
					$("#aptitudediv").show();
					 for(var ss in files){
						//alert(JSON.stringify(files[ss]));
						var $div=$("<div/>").append(
							$("<input/>").attr("type","hidden").attr("name","filename1").val(files[ss].name)
						).append(
							$("<img/>").css({width:150,height:80, border:"1px solid #D1D1D1"}).attr("id",files[ss].id).attr('src',ctx+'/aptitude/showpic?picid=null&fname='+encodeURI(encodeURI(files[ss].name)))
						).append(
							"<a class=\"button red small\" onclick=\"deletequalificationpic('"+files[ss].id+"',this);\">删除</a></br>"
						);
						$("#aptitudediv").append($div);
						$("#filename").val(files[ss].name);
					 } */
				},
				Error : function(up, err) {

				}
			}
		});
		uploader.init();
	});
	
	function deletequalificationpic(picid){
		if(confirm('确认要删除该附件吗？')){
			uploader.removeFile(picid);
			$("#"+picid).parent().remove();
		}else{
			return;
		}
	};
	function deleteaptitudepic(picid){
		if(confirm('确认要删除该附件吗？')){
			$.ajax({
			    type :'get',
			    dataType : 'json',
			    data:{},
				url : ctx + "/attachment/deleteAttchment?fjid00="+picid,
				success : function(data) {
					$.jGrowl(data.msg); 
				},
				error : function(e, s1, s2) {
				}
				
			});
			$("#"+picid).parent().remove();
		}else{
			return;
		}
	};
	
	
</script>