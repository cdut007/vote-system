<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标报名申请审核</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.queryDiv{width:1002px;border:1px solid #ccc;line-height:22px;}
.queryHead{width:997height:23px;border-bottom:1px solid #ccc;font-size:13px;font-weight:bold;padding-left:5px;padding-top:5px;}
</style>
<script type="text/javascript">
	function SetValue_onclick(){
		document.all.DWebSignSeal.SetStoreData("${tender.sealSignData}"); 
		document.all.DWebSignSeal.ShowWebSeals();
		document.all.DWebSignSeal.SetSealSignData("sqbsign",$("#content").val());
	}
	
	window.onload = SetValue_onclick;
	
	$(function() {
		//页面初始化时，如果项目所有标段都选中，也将全选checkbox设置选中
		var all = true;
		$("input[name='item_ids']").each(function(){
			if($(this).prop("checked")==true){
			}else{
				all = false;
			}
		});
		if(all)
			$("input[name='all']").prop("checked",true);
		
		

		$("#nopassReason").hide(); //先让div隐藏
		$("#passBtn").click(function() {
			$.messager.confirm("系统提示","确认审核通过该招标信息吗？",function(ok){
				if(ok){
					$("#pass").val(true);
					$("#tenderReviewForm").attr("action", "${pageContext.request.contextPath}/flow/completeTask");
					$("#tenderReviewForm").submit();
				}
			});
		});
		$("#nopassBtn").click(function() {
			if ($("#reason").val() == "") {
				$.messager.alert("系统提示","请填写审核不通过原因");
				$("#nopassReason").fadeIn("slow");
				$("#reason").focus();
				return false;
			}
			$.messager.confirm("系统提示","确认审核不通过该招标信息吗？",function(ok){
				if(ok){
					$("#pass").val(false);
					$("#tenderReviewForm").attr("action", "${pageContext.request.contextPath}/flow/completeTask");
					$("#tenderReviewForm").submit();
				}
			});
		});
		$("#spanClose").click(function() {
			$("#nopassReason").fadeOut("fast");
		});
	});
</script>
</head>
<body>
<script src="/resources/ca/Loadwebsign.js" type="text/javascript"></script>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标报名申请审核
		</div>
		<div class="blank10"></div>
		<div class="tableTitle2" style="cursor:pointer;" onclick="$('#projectInfo').toggle();">项目信息</div>
		<table class='mytableStyle' id="projectInfo">
					<tr>
						<th width="120px">所属项目</th>
						<td colspan='3'>${projectInstance.project.xmmc00}</td>
					</tr>
					<tr>
						<th>招标项目编号:</th>
						<td>${projectInstance.zbxmbh}</td>
						<th>招标项目名称:</th>
						<td>${projectInstance.zbxmmc}</td>
					</tr>
					<tr>
						<th width="120px">招标人</th>
						<td>${projectInstance.project.organ.ztmc00}</td>
						<th width="120px">代理机构</th>
						<td>${projectInstance.organ.ztmc00}</td>
					</tr>
					<tr>
						<th width="120px">招标方式</th>
						<td></td>
						<th width="120px">组织形式</th>
						<td></td>
					</tr>
					<tr>
						<th width="120px">招标内容与范围</th>
						<td colspan='3'><pre>${projectInstance.nryfw0}</pre></td>
					</tr>
				</table>

			<div class='tableTitle'>申请标段列表</div>
			<table class='mytableStyle'>
				<tr>
					<th width='40px'><input type='checkbox' name='all' onclick="checkAll()" disabled="disabled"/></th>
					<th width='40px'>序号</th>
					<th>标段编号</th>
					<th>标段名称</th>
					<th>状态</th>
				</tr>
				<c:forEach items="${tender.tenderItem}" var="tenderItem" varStatus="status">
					<c:forEach items="${projectInstance.projectItems}" var="item">
						<c:if test="${tenderItem.projectItem.id==item.id}" >
							<tr>
								<td><input type='checkbox' name='item_ids' onclick="check()" value="${item.id}"  disabled="disabled" checked="checked" /></td>
								<td style='text-align: center'>${status.count}</td>
								<td>${item.bdbh00}</td>
								<td class="itemName">${item.bdmc00}</td>
								<td style='text-align:center;'>
									</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:forEach>
				<c:if test="${empty projectInstance.projectItems}">
					<tr>
						<td colspan='5'>标段为空！</td>
					</tr>
				</c:if>
			</table>
		<div class="blank10"></div>
			<div class="tableTitle2">投标要求</div>
		<div class="queryDiv">
			<div id="tender_application" style="width:650px;border:1px solid #ccc;line-height:30px;padding:70px;margin:10px 100px;">
				${tender.content}
			</div>
			<div id="ht_end"></div>
		</div>
		<div class="blank10"></div>
		<div class="tableTitle2">投标附件</div>
		<table class='mytableStyle'>
					<thead>
						<tr>
							<th width="20px"></th>
							<th width="20px"><input type="checkbox" /></th>
							<th>附件名称</th>
							<th>上传时间</th>
							<th>附件大小（K）</th>
							<th>附件归属</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${tenderFileList}" var="fileItem" varStatus="status">
							<tr>
								<th>${status.count}</th>
								<td><input name="t_fj_id" type="checkbox" value="${fileItem.fjid00 }" /></td>
								<td>${fileItem.fjmc00}</td>
								<td>${fileItem.uploadTime}</td>
								<td><fmt:formatNumber value="${fileItem.length/(1024)}" pattern="#,###.##" /></td>
								<td>${util:dictionary('FJGSLX',fileItem.fjgslx)}</td>
								<td align="center"><a href="${pageContext.request.contextPath}/attachment/download/${fileItem.fjid00}">下载</a> &nbsp;&nbsp; <a href="${pageContext.request.contextPath}/attachment/viewfile?id=${fileItem.fjid00}" target="_blank">预览</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
		
		<form:form commandName="tender">
			<form:textarea id="content" path="content" cssClass="none"/>
		</form:form>
		
		<div class="blank10"></div>
		<form id="tenderReviewForm" method="post" action="${pageContext.request.contextPath}/flow/completeTask">
			<input type='hidden' name="taskId" value="${task.id}" />
			<input type='hidden' name="id" value="${tender.id}" />
			
			<input type='hidden' id="pass" name="pass" />
			<div id="nopassReason">
				<h4 style="background-color: #eee;color:#79a605!important;">审核不通过原因：</h4>
				<textarea rows="13" cols="150" id="reason" name="reason" style="width:685px;height:120px;"></textarea>
				<span id="spanClose">关 闭</span>
			</div>
		</form>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		
		<div style="text-align:right;position:fixed;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:999;border: #ccc 1px solid;">
		<input type='button' class='button red' value="审核通过" id="passBtn" /> <input type='button' class='button red' value="审核不通过" id="nopassBtn" />
	</div>
	</div>
</body>
</html>
