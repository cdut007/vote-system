<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script>
	function selectProjectInstance(obj){
		$.ajax({
			type:"post",
            cache: false,
            url:"${pageContext.request.contextPath}/notice/findProjectItemList",
            async: false,
            data:"projectInstanceId="+$(obj).val(),
            success: function(data) {
				if(data!=""){
					data = eval("("+data+")"); 
					var checkboxHtml = "";
					for(var i = 0;i<data.length;i++){
						checkboxHtml +="<input type='checkbox' name='projectItemIdArray' value='"+data[i].id+"' onclick=selectProjectItem(this)>"+data[i].bdmc00+"</input>";
					}
					$("#bdjh").html(checkboxHtml);
				}else{
					$.messager.alert("提示信息","未查询到标段，请重新选择招标项目！");
				}
            }
        }); 
	}

	function formSubmit(submitType){
		// $("#noticeForm").attr("action","${pageContext.request.contextPath}/notice/saveReconnaissanceNotice");
		// $("#noticeForm").submit();
		
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
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				踏勘通知
			</div>
				<div class="usBox">
					<h4 style='border-bottom: #666 1px solid;'>踏勘通知</h4>
					<form:form id="noticeForm" class="registerform" method="post" action='${pageContext.request.contextPath}/notice/saveReconnaissanceNotice'>
						<table width="100%" style="table-layout:fixed;">
							<tr>
								<td class="need" style="width:10px;">*</td>
								<td style="width:15%">招标项目名称：</td>
								<td colspan="6">
									<select name="projectInstanceId" onchange="selectProjectInstance(this)">
										<option value="">---==请选择==---</option>
										<c:forEach items="${projectInstanceList}" var="projectInstance">
											<option value="${projectInstance.id}">${projectInstance.zbxmmc }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td class="need">*</td>
								<td style="vertical-align:middle;">标段（包）:</td>
								<td style="padding-left:3px;"  colspan='5'>
									<div id='bdjh' style="margin-left: 10px"></div>
								</td>
								<td style="width:2px"></td>
							</tr>
							<tr>
								<td class="need"></td>
								<td style="vertical-align:middle">踏勘通知:</td>
								<td colspan='5'>
									<textarea name="ktnr" nullmsg="请输入踏勘通知！" datatype="*" style="width:99%;height:120px;"></textarea>
								</td>
								<td style="width:2px">
									<!-- <div class="infostyle">
										<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
									</div> -->
								</td>
							</tr>
						<tr>
							<td class="need"></td>
							<td></td>
							<td colspan="3" style="padding:10px 0 18px 0;">
								<input type="button" class="button red" value="发送" onclick="formSubmit()"/>
								<!-- <input type="button" class="button red" value="返回" onclick="history.go(-1)"/> -->
							</td>
						</tr>
						</table>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>