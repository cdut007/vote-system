<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply" />
<c:set value="${expertApply.projectInstance}" var="projectInstance" />
<c:set value="${expertApply.projectInstanceId}" var="projectId" />
<c:set value="${bidFileService.find(processBusinessKey)}" var="tenderFileList" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" ca="true"/>
<script type="text/javascript">
	$(function() {
		if ($(":input[name='message']").val() != '') {
			$.jGrowl($(":input[name='message']").val());
		}
		$('#sub').click(function() {
			var $rows=$($("#bidFile-datagird").datagrid("getRows")).filter(function(){
				return this["isDecrypt"]=="未解密";
			});
			if($rows.length==0){
				if (confirm('确定提交吗？')) {
					//$('#form1').attr('action', '${pageContext.request.contextPath}/flow/completeTask');
					//$('#form1').attr('method', 'post');
					$('#form1').submit();
				}
			}else{
				var id = new Date().getTime();
				$("body").append("<div style='padding:10px' id='" + id + "'></div>");
				$("#"+id).dialog({
					open : true,
					title : '未解密原因',
					closed:false,
					modal:true,
					width:600,
					height:400,
					content:"<form action=\""+ctx+"/workflow/completeForm\" method=\"post\"><textarea name=\"noDecryptReason\" style=\"width:560px;height:280px\" class=\"easyui-validatebox\" data-options=\"required:true\"></textarea></form>",
					buttons:[
						{text:"提交",handler:function(){
							if($("#"+id+" form").form("validate")){
								$.messager.confirm("系统提示", "确认提交吗？", function(r) {
									if (r) {
										$("#"+id+" form").ajaxSubmit({
											type:"post",
											//dataType:"json",
											data:{
												taskId:$(":input[name='taskId']").val()
											},
											success:function(data){
												window.location.href=ctx+"/home";
											}
										});
									}
								});
							}
						}},
						{text:"取消",handler:function(){
							$("#"+id).dialog('destroy');
						}}
					]
				});
			}
		});
		$("#bidFile-datagird").datagrid({
			title:"投标文件",
			rownumbers : true,
			striped : true,
			url:ctx+"/listBidFile",
			queryParams : {
				expertApplyId : "${processBusinessKey}"
			},
			idField:"tenderItemId",
			columns:[[
				{field:"bdbh00",title:"标段编号",width:200,hidden:true},
				{field:"projectItemName",title:"标段名称",width:200},
				{field:"attachmentName",title:"附件名称",width:200},
				{field:"length",title:"附件大小",width:120,formatter:function(value,rowData,rowIndex){
					return castSize(value);
				}},
				{field:"uploadTime",title:"上传时间",width:200},
				{field:"isDecrypt",title:"是否解密",width:100},
				{field:"tenderItemId",title:"操作",width:100,formatter:function(value,rowData,rowIndex){
					return /* rowData["isDecrypt"]=="未解密"? */"<input type=\"button\" onclick=\"decrypt1('"+value+"');\" class=\"button red small\" value=\"解密\"/>"/* :"" */;
				}}
			]]
		});
		$("#bidOpen-datagrid").datagrid({
			title : "开标一览表",
			url : ctx + "/bidFile/list",
			pagination : true,
			rownumbers : true,
			striped : true,
			fit : true,
			method : "post",
			queryParams : {
				projectInstanceId : "${expertApply.projectInstanceId}",
				expertApplyId : "${processBusinessKey}"
			},
			columns : [ [ 
				{field : 'organProjectItemCode',title : "标段编号",width : 100,hidden:true},
				{field : 'projectItemName',title : "标段名称",hidden :false,width:150}, 
				{field : 'organBName',title : "投标机构",align : "center",width : 150,formatter : hidedate}, 
				{field : 'tbrdm0',title : "投标机构组织代码",align : "center",formatter : hidedate,hidden : true}, 
				{field : 'tbbjje',title : "投标报价",align : "center",width : 100,formatter : function(value, row, index){
					
					if(row.tbbjdw == "2"){
						return value + "(万元)";
					}
					
					return value + "(元)";
					
				}}, 
				{field : 'gq0000',title : "工期（交货期、服务周期）",width : 80,formatter : hidedate}, 
				{field : 'bidDepositAmount',title : "投标保证金额(元)",width : 90,formatter : hidedate,hidden : true}, 
				{field : 'isContributeDeposit',title : "是否缴纳投标保证金",align : "center",width : 60,formatter : function(value, row, index) {
					if (row["isConfirm"] == "已确认") {
						if ("0" == value) {
							return "待确认";
						} else if ("3" == value) {
							return "未上传";
						} else if ("1" == value) {
							return "已缴费";
						} else if ("2" == value) {
							return "未缴费";
						} else if ("4" == value) {
							return "无需缴纳";
						} else {
							return "未确认";
						}
					} else {
						if ("${CURRENT_USER_SESSION_INFO.organId}" == row["organId"]) {
							return "";
						}
						return "******";
					}
				}}, 
				{field : 'tbsj00',title : "文件递交时间",align : "center",width : 100,formatter : hidedate}, 
				{field : 'isConfirm',title : "是否确认",align : "left",width : 60}, 
				{field : "id",title : "操作",align : "left",formatter : function(value, row, index) {
					if (row["isConfirm"] == "已确认") {
						return "";
					} else {
						return "${CURRENT_USER_SESSION_INFO.organId}" == row["organId"] ? "<input type='button' class='button red small' onclick='detail(\"" + value + "\")' value='确认'/>" : "";
					}
				}} 
			] ]
		});
		//确认页面是否显示数据，原则自己可以看到自己的开标预览表和别人已经确认的开标预览表
		function hidedate(value, row, index) {
			if (row["isConfirm"] == "已确认") {
				return value;
			} else {
				if ("${CURRENT_USER_SESSION_INFO.organId}" == row["organId"]) {
					return value;
				}
				return "******";
			}
		}
		;
		$("#decrypt").click(function() {
			var $rows=$($("#bidFile-datagird").datagrid("getRows")).filter(function(){
				return this["isDecrypt"]=="未解密";
			});
			if($rows.length>0){
				var param=$rows.map(function() {
					return "id=" + this["fjid00"] + "&orig=" + getData(this["qmzsgy"]);
				}).get().join("&");
				$.ajax({
					url : ctx+"/bidFile/decrypt1",
					type : "post",
					data : param,
					dataType : "json",
					beforeSend : function() {
						$.messager.progress({
							title : "请您耐心等待...",
							msg : "正在解密投标文件并验证电子签名中...",
							text : "请稍后..."
						});
					},
					complete : function() {
						$.messager.progress("close");
					},
					success : function(data) {
						$.messager.alert("系统提示", data.msg);
						$("#bidFile-datagird").datagrid("reload");
						$('#bidOpen-datagrid').datagrid("reload");
					}
				});
			}else{
				$.messager.alert("系统提示", "没有未解密的投标文件！");
			}
			/*
			var param = $("#decrypt_list").children("tr").map(function() {
				return "id=" + this["fjid00"] + "&orig=" + getData(this["qmzsgy"]);
			}).get().join("&");
			param += "&processBusinessKey=" + '${processBusinessKey}';
			$.ajax({
				url : "${pageContext.request.contextPath}/bidFile/decrypt1",
				type : "post",
				data : param,
				dataType : "json",
				beforeSend : function() {
					$.messager.progress({
						title : "请您耐心等待...",
						msg : "正在解密投标文件并验证电子签名中...",
						text : "请稍后..."
					});
				},
				complete : function() {
					$.messager.progress("close");
				},
				success : function(data) {
					$.messager.alert("系统提示", data.msg);
					$('#bidOpen-datagrid').datagrid('reload');
				}
			}); */
		});
	});
	function getData(origData) {
		//origData="MIIBpAYJKoZIhvcNAQcDoIIBlTCCAZECAQAxggFFMIIBQQIBADCBqTCBnDELMAkGA1UEBhMCQ04xDzANBgNVBAgMBlNoYW5YaTEQMA4GA1UEBwwHVGFpWXVhbjEtMCsGA1UECgwkU2hhblhpIERpZ2l0YWwgQ2VydGlmaWNhdGUgQXV0aG9yaXR5MQwwCgYDVQQLDANSU0ExLTArBgNVBAMMJFNoYW5YaSBEaWdpdGFsIENlcnRpZmljYXRlIEF1dGhvcml0eQIIGd9uxrzjm1swDQYJKoZIhvcNAQEBBQAEgYCzErVBFkdqWlywu1zQUesJ1RxuDAhxC21UUMgcOimvwWv5rCClZNCzIxPoY3fiRZWBUlNU5E2RTuaL/MD/bBsbQ/Tv6bSUWzlG4ZQv4RcIbm+vi/LUXEH7bDdDDeSQx6wxHHrOsx4Es8eJpZXenY0fdGiqjRdSLGEJzb1sg0rFljBDBgkqhkiG9w0BBwEwFAYIKoZIhvcNAwcECIiTtkX7ftXkgCAgjAJn46z5dr+ZWPCnyL/ETs3uoUiFtg5Vnlz1YBzG/w=="; 
		var temp_DSign_Release_Result = JITDSignOcx.DecryptEnvelop(origData);
		if (JITDSignOcx.GetErrorCode() != 0) {
			alert("错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return;
		}
		var orig = JITDSignOcx.getData();
		/* $("<input/>").appendTo($("body")).val(orig); */
		return orig;
	};

	function detail(id) {
		$.messager.confirm('确认', '请核对您的投标信息，是否正确？', function(ok) {
			if (ok) {
				$.ajax({
					url : "${pageContext.request.contextPath}/bidFile/confirm",
					type : "post",
					data : {
						"id" : id
					},
					dataType : "json",
					beforeSend : function() {
					},
					complete : function() {

					},
					success : function(data) {
						$.messager.alert("系统提示", data.msg);
						$('#bidOpen-datagrid').datagrid('reload');
					}
				});
			}
		});
	};
	function decrypt1(id) {
		$.ajax({
			url:ctx+"/getDigitalEnvelope",
			type:"post",
			data:{"tenderItemId":id},
			success:function(data){
				if(data==""){
					$.messager.alert("系统提示","获取数字信封失败！");
				}
				var orig=getData(data);
				$.ajax({
					url : ctx+"/bidFile/decrypt",
					type : "post",
					data : {
						"orig" : orig,
						"id" : id
					},
					dataType : "json",
					beforeSend : function() {
						$.messager.progress({
							title : "请您耐心等待...",
							msg : "正在解密投标文件并验证电子签名中...",
							text : "请稍后..."
						});
					},
					complete : function() {
						$.messager.progress("close");
					},
					success : function(data) {
						$.messager.alert("系统提示", data.msg);
						$("#bidFile-datagird").datagrid("reload");
						$('#bidOpen-datagrid').datagrid('reload');
					}
				});
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			开标现场
			<%-- ${CURRENT_USER_SESSION_INFO.organ.id} --%>
		</div>
		<div class="blank10"></div>
		<form action="${pageContext.request.contextPath}/workflow/completeForm" id="form1">
			<input type="hidden" name="taskId" value="${taskId}" /> 
			<input type="hidden" name="message" value="${message}" />
		</form>
			<div style="border:1px solid #e4e4e4;width:20%;height:200px;float:left;margin-right:5px;text-align:center">
				<div class="video" id="CuPlayer"><b><img src="/resources/player/images/loading.gif"  /> 网页视频播放器加载中，请稍后...</b></div>
				<script type="text/javascript">
					var so = new SWFObject("/resources/player/player.swf","ply","200","200","9","#000000");
					so.addParam("allowfullscreen","true");
					so.addParam("allowscriptaccess","always");
					so.addParam("wmode","opaque");
					so.addParam("quality","high");
					so.addParam("salign","lt");
					//播放器设置文件-----------------------------
					so.addVariable("JcScpFile","/resources/player/CuSunV2set.xml");
					//视频文件及略缩图--------------------------
					so.addVariable("JcScpServer","rtmp://221.204.249.126:1935/live");
					so.addVariable("JcScpVideoPath","${processBusinessKey}"); 
					so.addVariable("JcScpImg","images/startpic.jpg"); 
					//so.addVariable("JcScpSharetitle","极酷阳光播放器(CuSunPlayerV2.5)版使用官方演示实例"); 
					so.write("CuPlayer");
				</script>
			</div>
			<div style="width:79%;float:right;height:400px;">
				<table id="bidOpen-datagrid"></table>
			</div>
		<div class="blank10"></div>
		<!-- <div class="tableTitle2">我的投标文件</div> -->
		<table id="bidFile-datagird">
			<%-- <thead>
				<tr>
					<td>序号</td>
					<td>文件名称</td>
					<td>是否解密</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="decrypt_list">
				<c:forEach items="${tenderFileList}" var="fileItem" varStatus="s">
					<tr id="${fileItem.fjid00}" key="${fileItem.qmzsgy}">
						<td>${s.count}</td>
						<td>${fileItem.fjmc00}</td>
						<td>${util:dictionary('IS_DECRYPE',fileItem.isDecrypt)}</td>
						<td>
							<a href="javascript:decrypt1('${fileItem.fjid00}','${fileItem.qmzsgy}')" class="button red small">解密</a>
						</td>
					</tr>
				</c:forEach>
			</tbody> --%>
		</table>
		<div class="blank10"></div>
		<a id="decrypt" class="button red">完全解密</a> <a id="sub" class="button red">提交</a>
		<div class="blank10"></div>
		<div class="usBox">
			<p>说明：</p>
			<br />
			<p style="text-indent: 2em;">1、请核对您的投标信息，是否正确。</p>
		</div>
		<div class="blank10"></div>
	</div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>