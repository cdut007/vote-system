<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script type="text/javascript">
	function formSubmit(submitType){
		$.ajax({
			url: "${pageContext.request.contextPath}/notice/saveReconnaissanceNotice", 
			data: $("#noticeForm").serialize(),
			dataType: "json", 
			type: "POST",
			success: function(data){
				$.messager.alert('提示',data.msg);
				if (data.success) {
					alertMsg(data.msg);
				}
				
			}
		});
	}
</script>
	
<div class="usBox">
	<h4 style='border-bottom: #666 1px solid;'>踏勘通知</h4>
		<table width="100%" style="table-layout:fixed;">
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td style="width:20%">招标项目名称：</td>
				<td colspan="6">${projectItem.projectInstance }</td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td style="vertical-align:middle;">标段（包）：</td>
				<td style="padding-left:3px;"  colspan='5'>${projectItem.bdmc00 }</td>
				<td style="width:2px"></td>
			</tr>
			<tr>
				<td class="need"></td>
				<td style="vertical-align:middle">踏勘通知：</td>
				<td colspan='5'>
					<textarea style="width:99%;height:120px;" readonly="readonly">${projectItem.reconnaissanceNotice.ktnr }</textarea>
				</td>
				<td style="width:2px">
					<div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div>
				</td>
			</tr>
		</table>
	<form:form id="noticeForm" class="registerform" method="post" action='${pageContext.request.contextPath}/apply'>
		<input type="hidden" name="id" value="${tenderItem.id }">
		<table width="100%" style="table-layout:fixed;">
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td style="width:20%">负责人姓名：</td> 
				<td colspan="6">
					<input type="text" name="tkfzrName"  datatype="*" nullmsg="请输入负责人姓名！" class="inputxt" >
				</td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td style="vertical-align:middle;">负责人电话：</td>
				<td style="padding-left:3px;"  colspan='5'> 
					<input type="text" name="tkfzrPhone"  datatype="*" nullmsg="请输入负责人电话！" class="inputxt" >
				</td>
				<td style="width:2px"></td>
			</tr>
			<tr>
				<td class="need"></td>
				<td style="vertical-align:middle">参加踏勘人数：</td>
				<td colspan='5'> 
					<input type="text" name="tkrs"  datatype="*" nullmsg="请输入踏勘人数！" class="inputxt" >
				</td>
				<td style="width:2px"></td>
			</tr>
		<!-- <tr>
			<td class="need"></td>
			<td></td>
			<td colspan="3" style="padding:10px 0 18px 0;">
				<input type="button" class="button red" value="报名" onclick="formSubmit()"/>
				<input type="button" class="button red" value="返回" onclick="history.go(-1)"/>
			</td>
		</tr> -->
		</table>
	</form:form>
</div>
