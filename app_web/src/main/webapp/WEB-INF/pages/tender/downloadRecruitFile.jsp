﻿<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>下载标书/投标</title>
<jsp:include page="/common/link.jsp" />
<!-- 代码部分  -->
<c:catch var="exception">
	<jsp:useBean id="nowDate" class="java.util.Date" />
	<c:set value="${tenderItemService.createTenderItemQuery().tenderItemId(processBusinessKey).singleResult()}" var="tenderItem"></c:set>
	<c:set value="${tenderItem.projectItem}" var="projectItem"></c:set>
	
	<c:set value="${projectItemService.getProjectPackageHavePrice(projectItem.id)}" var="projectPackage"></c:set>
	<!-- 标书售价 -->
	<c:set value="${projectPackage.price}" var="tenderDocumentPrice"></c:set>
	<!-- 平台费 -->
	<c:set value='${projectItem.platformPrice}' var="platformUsePrice"></c:set>
	<c:set value="${tenderItem.tender}" var="tender"></c:set>
	<c:set value="${tender.projectInstance}" var="projectInstance"></c:set>
	
	<!-- 查找招标文件 -->
	<c:set value="${recruitFileService.findRecruitFile(projectItem.id)}" var="recruitFile"></c:set>
	<!-- 保证金凭证 -->
	<c:set value="${attachmentService.createAttachmentQuery().referenceObjectId(processBusinessKey).attachmentUserType('24').list()}" var="sendBidDepositAttachment" />
	
	<!-- 查找招标文件对应的澄清文件附件 -->
	<c:set value="${recruitFileService.findRecruitFileOfModify(projectItem.id)}" var="modifyAttachmentId"></c:set>
	
	<!-- 标书费用到账检查 -->
	<c:set value="${virtualAccountService.getUniqueVirtualAccount(tenderItem.organId,'','',projectPackage.id,'B')}" var="virtuallAccountBNo" />
	<c:set value="${bankTransactionDetailService.retrieveTransactionDetailTotalAmount(virtuallAccountBNo.accountNumber,tender.createDate,nowDate)<tenderDocumentPrice}" var="isNotSendB" />
	<!-- 平台使用费到账检查 -->
	<c:set value="${virtualAccountService.getUniqueVirtualAccount(tenderItem.organId,'','',tenderItem.projectItemId,'D')}" var="virtuallAccountDNo" />
	<c:set value="${bankTransactionDetailService.retrieveTransactionDetailTotalAmount(virtuallAccountDNo.accountNumber,tender.createDate,nowDate)<platformUsePrice}" var="isNotSendD" />
	<!-- 获取保证金虚拟账户 -->
	<c:set value="${virtualAccountService.getUniqueVirtualAccount(tenderItem.organId,'','',tenderItem.projectItemId,'C')}" var="virtualAccountCNo" />
	<!-- 获取保证金虚拟账户 -->
	<c:set value="${bankTransactionDetailService.retrieveTransactionDetailTotalAmount(virtualAccountCNo.accountNumber,tender.createDate,nowDate)}" var="totalDepositAmt" />
	<c:set value="${totalDepositAmt==0}" var="isNotSendC" />
	<c:set value="${depositRecordService.retrieveUniqueDepositRecord('',tenderItem.organId,'',tenderItem.projectItemId)}" var="depositRecord" />
</c:catch>

<style type="text/css">
pre {
	white-space: pre-wrap; /* CSS-3 */
	white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
	white-space: -pre-wrap; /* Opera 4-6 */
	white-space: -o-pre-wrap; /* Opera 7 */
	Word-wrap: break-word; /* Internet Explorer 5.5+ */
}
</style>
<script type="text/javascript">

    var envelopeTypeOrder = "first";
    var bidFileUploader = null;
    
	function setEnvelopeTypeOrder(){
    	envelopeTypeOrder = $("#envelopeTypeOrder").val();
    	bidFileUploader.settings.multipart_params.envelopeTypeOrder = envelopeTypeOrder;
    }
	var percent = "<div class=\"progressbar easyui-fluid\" style=\"width: 127px; height: 20px;\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div><div class=\"progressbar-value\" style=\"width: 100%; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div></div></div>";
	function initPLUpload(datagridType, id, url, type, param, callback) {
		var uploader =  new plupload.Uploader({
			runtimes : 'html5,silverlight,html4',
			browse_button : id,
			//container : document.getElementById('container'),
			url : url,
			flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
			silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
			multi_selection : false,
			multipart_params : param,
			
			//file_data_name:"Filedata",
			//drop_element : 'drop_area',
			filters : {
				mime_types : type,
				prevent_duplicates : true,//不允许选取重复文件
				max_file_size : '5000mb'//最大只能上传400kb的文件
			},
			init : {
				PostInit : function() {
				},
				FilesAdded : function(up, files) {
					up.start();
					$("#" + datagridType).datagrid(
							"appendRow",
							{
								fjid00 : files[0].id,
								fjmc00 : files[0].name,
								status : "<div class='" + files[0].id
										+ "' style='width:100%;'></div>",
								uploadTime : new Date()
										.format("yyyy-MM-dd HH:mm:ss"),
								length : files[0].size,
								fjgslx : ""
							});
					/* $("<div id=\"dialog-"+files.id+"\">").css("padding",5).appendTo($("body")).window({
						title:"上传进度",
						width:250,
						height:80,
						content:"<div class='" + files[0].id + "' style='width:100%;'></div>"
					}); */
					$("div." + files[0].id).progressbar({});
				},
				UploadProgress : function(up, file) {
					$("div." + file.id).progressbar("setValue",
							file.percent);
				},
				FileUploaded : function(up, file, result) {
					callback(up, file, result);
					/* $("div."+files.id).progressbar("destory"); */
				},
				UploadComplete : function(uploader, files) {

				},
				Error : function(up, err) {
					$.jGrowl(err);
				},
				FilesRemoved : function(up, files) {

				}
			}
		});
		uploader.init();
		if(id[0].id=="bidFileAttachment"){
			bidFileUploader = uploader;
		}
		return uploader;
	}
	

    
    function intialBidFileuploader(){
    	
    	//上传加密文件初始化功能
		initPLUpload('bidFile-datagrid', $("#bidFileAttachment").get(), ctx + '/uploadBidFile', [ {
			title : "投标文件",
			extensions : "ebid"
		},{
			title : "投标文件",
			extensions : "tbt"
		}, {
			title : "Zip files",
			extensions : "zip"
		} ], {
			fjsszt : $("#tenderItemId").val(),
			tenderItemId : $("#tenderItemId").val(),
			fjgslx : "10",
			envelopeTypeOrder : envelopeTypeOrder,
			unique : true
		}, function(up, file, result) {
			console.log(result);
			if(result.status!='200'){
				$.messager.alert("上传失败","网络错误，请检测网络后重新上传！");
			}
			var data = $.parseJSON(result.response);
			$.jGrowl(data.msg);
			$("#bidFile-datagrid").datagrid("reload");
			up.removeFile(file);
		});
    	
    }
	$(document).ready(function(){
		$("#updateTransaction").click(function(){
			//TODO
			var accountNo=$(this).attr("accountNo");
			$.ajax({
				url:ctx+"/banks/updateTransactionDetail",
				data:{accountNo:accountNo},
				type:"post",
				dataType:"json"
			});
			//alert(accountNo);
		});
		$("#depositBalance").click(function() {
			$.ajax({
				url : ctx + "/depositBalance",
				data : {
					projectItemId : "${tenderItem.projectItemId}"
				},
				dataType : "json",
				type : "post",
				success : function(data) {
					$.messager.alert("系统提示", data.msg,"info",function(){
						if(data.success){
							window.location.reload();
						}
					});
				}
			});
		});
		

		window.setTimeout(function() {
			//上传保证金功能初始化
			/* upload.bind('FilesAdded',function(up, files){
    			$.each(files,function(i,file){
        			if(up.files.length > 1){
            			up.removeFile(file);
        			}
    			});
    		}); */
			
			<c:if test="${projectItem.currentBidStage =='2'}">
			initPLUpload('sendBidDepositAttachment-datagrid', $(
					"#sendBidDeposit-1").get(), ctx
					+ '/attachment/uploadAttachment', [ {
				title : "Image files",
				extensions : "jpg,gif,png,bmp"
			} ], {
				fjsszt : $("#tenderItemId").val(),
				fjgslx : "24",
				unique : false
			}, function(up, file, result) {
				var data = $.parseJSON(result.response);
				$("#sendBidDepositAttachment").append(
						$("<img/>").attr("src",
								ctx + "/attachment/download/" + data.data.path)
								.css("width", "100%"));
				$("#sendBidDepositAttachment-datagrid").datagrid("reload");
			});
			</c:if>
			//上传加密文件初始化功能
			intialBidFileuploader();
		}, 1000);

		if ($(":input[name='message']").length == 1 && $(":input[name='message']").val() != '') {
			$.jGrowl($(":input[name='message']").val());
		}
		$('#subBtn').click(function() {
			$.messager.confirm("系统提示","确定要提交投标文件吗？",function(r) {
				if (r) {
					$('#tbForm').attr('action','${pageContext.request.contextPath}/workflow/completeForm');
					$('#tbForm').submit();
				}
			});
		});
		//保证金列表
		$("#sendBidDepositAttachment-datagrid").datagrid({
			title : "保证金凭证",
			rownumbers : true,
			striped : true,
			height : 300,
			url : ctx + "/listMargin",
			idField : "fjid00",
			queryParams : {
				"tenderItemId" : $("#tenderItemId").val()
			},
			onOpen:function(){
				$(this).on("click","a.del",function(){
					var rowIndex=parseInt($(this).parents("tr:first").attr("datagrid-row-index"));
					var rows=$("#sendBidDepositAttachment-datagrid").datagrid("getRows");
					var row=rows[rowIndex];
					$.get(ctx+"/attachment/deleteAttachment?id="+row["fjid00"],function(data){
						var json=$.parseJSON(data);
						if(json.success){
							$("#sendBidDepositAttachment-datagrid").datagrid("reload");
							$($("#sendBidDepositAttachment").find("img").get()[rowIndex]).remove();
						}
					});
				});
			},
			columns : [[
					{
						title : "附件名称",
						field : "fjmc00",
						width : 300
					},
					{
						title : "上传时间",
						field : "uploadTime",
						width : 150
					},
					{
						title : "附件大小",
						field : "length",
						width : 150,
						align : "right",
						formatter : function(value) {
							return castSize(value);
						}
					},
					{
						title : "进度",
						field : "status",
						width : 150,
						align : "center",
						formatter : function(value) {
							return value ? value : percent;
						}
					},
					{
						title : "附件类型",
						field : "fjgslx",
						width : 150
					},
					{
						title : "操作",
						field : "fjid00",
						width : 150,
						align : 'center',
						formatter : function(value, row, index) {
							return "<a class='button red small' target=\"_blank\" href=\""+ctx+"/attachment/download/"+row["path"]+"\">下载</a><a class='button red small del'>删除</a>";
						}
					} 
			]]
		});
		//投标文件列表
		$("#bidFile-datagrid").datagrid({
			title : "投标文件",
			rownumbers : true,
			striped : true,
			height : 300,
			url : ctx + "/listBidFile",
			idField : "fjid00",
			queryParams : {
				"tenderItemId" : $("#tenderItemId").val()
			},
			columns : [ [
				{title : "附件名称",field : "fjmc00",width : 300},
				{title : "上传时间",field : "uploadTime",width : 130},
				{title : "附件大小",field : "length",width : 70,align : "right",formatter : function(value) {
					return castSize(value);
				}},
				{title : "进度",field : "status",width : 150,align : "center",formatter : function(value) {
							return value ? value : percent;
				}},
				{title : "附件类型",field : "fjgslx",width : 100},
				{title : "信封顺序",field : "envelopeTypeOrder",width : 100},
				{title : "操作",field : "fjid00",width : 150,align : 'center',formatter : function(value, row, index) {
					return "<a target=\"_blank\" class='button red small' href=\""+ctx+"/attachment/download/"+row["path"]+"\">下载</a><a class='button red small del' onclick=\"removeAttachment('"+row["fjid00"]+"');\" >删除</a>";
				}} 
			] ]
		});
	
	

		if($("#statusJudge").text().indexOf("招标文件还在编制审核中") > 0){
			/* $("#ZXYL").attr("disabled","true"); */
			
			$("#ZXYL").removeAttr('href');
			$("#DJXZ").removeAttr('href');
			$("#CQXZ").removeAttr('href');
			$("#ZXYL").click(function(){
				$.messager.confirm("系统提示","招标文件审核中，暂时无法查看");
			});
			$("#DJXZ").click(function(){
				$.messager.confirm("系统提示","招标文件审核中，暂时无法下载");
			});
			$("#CQXZ").click(function(){
				$.messager.confirm("系统提示","招标文件审核中，暂时无法下载");
			});
		}
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标文件上传
		</div>
		<div class="blank10"></div>
		<div class='tableTitle' style="cursor:pointer;">项目：${projectInstance.zbxmmc}（单击隐藏）</div>
		<table class='mytableStyle'>
			<tr>
				<th>招标项目编号:</th>
				<td>${projectInstance.zbxmbh}</td>
				<th>招标项目名称:</th>
				<td>${projectInstance.zbxmmc}</td>
			</tr>
			<tr>
				<th width="120px">招标人</th>
				<td>${projectInstance.organTName}</td>
				<th width="120px">代理机构</th>
				<td>${projectInstance.organAName}</td>
			</tr>
			<tr>
				<th width="120px">招标方式</th>
				<td>${dictionaryService.retrieveCacheDictionary("ZBFS00",projectInstance.zbfs00)}</td>
				<th width="120px">组织形式</th>
				<td>${dictionaryService.retrieveCacheDictionary("ZBZZXS",projectInstance.zbzzxs)}</td>
			</tr>
			<tr>
				<th width="120px">招标内容与范围</th>
				<td colspan='3'><pre>${projectInstance.nryfw0}</pre></td>
			</tr>
			<tr>
				<th width="120px">招标文件下载预览</th>
				<td colspan='3' id="statusJudge">
						<c:if test="${empty recruitFile}">
							招标文件还在编制审核中
						</c:if>
						<c:if test="${false}">
						<table class="mytableStyle">
							<col width="200"/>
							<col />
							<col width="150"/>
							<tr>
								<th>平台使用费账户名称</th>
								<td colspan="2">${virtuallAccountDNo.accountName}</td>
							</tr>
							<tr>
								<th>开户银行</th>
								<td>${virtuallAccountDNo.bankName}</td>
							</tr>
							<tr>
								<th>联行行号</th>
								<td>${virtuallAccountDNo.unionBankNo}</td>
							</tr>
							<tr>
								<th>账户帐号</th>
								<td colspan="2">${virtuallAccountDNo.accountNumber}</td>
							</tr>
							<tr>
								<th>金额</th>
								<td colspan="2">${platformUsePrice}元</td>
							</tr>
							<tr>
								<th>重要说明</th>
								<td colspan="2"><span style="color:red;">打款请备注单位名称、项目编号、标段名称、开票信息</span></td>
							</tr>
							<tr>
								<th>支付状态</th>
								<td colspan="2"><span style="color:red;">
								<c:choose>
								<c:when test="${isNotSendD}">未支付</c:when><c:otherwise>已支付</c:otherwise>
								</c:choose>
								</span></td>
							</tr>
						</table>
						</c:if>
						<table class="mytableStyle">
							<col width="200"/>
							<col />
							<col width="150"/>
							<tr>
								<th>标书费账户名称</th>
								<td colspan="2">${virtuallAccountBNo.accountName}</td>
							</tr>
							<tr>
								<th>开户银行</th>
								<td>${virtuallAccountBNo.bankName}</td>
							</tr>
							<tr>
								<th>联行行号</th>
								<td>${virtuallAccountBNo.unionBankNo}</td>
							</tr>
							<tr>
								<th>账户帐号</th>
								<td colspan="2">${virtuallAccountBNo.accountNumber}</td>
							</tr>
							<tr>
								<th>金额</th>
								<td colspan="2">${tenderDocumentPrice}元</td>
							</tr>
							<tr>
								<th>重要说明</th>
								<td colspan="2"><span style="color:red;">打款请备注单位名称、项目编号、标段名称、开票信息</span></td>
							</tr>
							<tr>
								<th>支付状态</th>
								<td colspan="2"><span style="color:red;">
								<c:choose>
								<c:when test="${isNotSendB}">未支付</c:when><c:otherwise>已支付</c:otherwise>
								</c:choose>
								</span></td>
							</tr>
						</table>
						
						<c:if test="${not empty recruitFile}">
						<%-- <c:if test="${!isNotSendB && !isNotSendD}"> --%> <!-- ${!isNotSendB && !isNotSendD} -->
							
							<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-attach'" href="${pageContext.request.contextPath}/attachment/recruitfile/dow?fileId=${recruitFile.wordAttachment.fjid00}&recruitFileId=${recruitFile.id}&tenderItemId=${tenderItem.id}" target="_blank" title="点击下载招标文件" id="DJXZ">招标文件.zip</a><%--${recruitFile.wordAttachment.fjmc00} --%>
							<%-- <p><a href="${pageContext.request.contextPath}/attachment/download/${recruitFile.pdfAttachment.fjid00}" target="_blank">${recruitFile.pdfAttachment.fjmc00}</a></p> --%>
							&nbsp;<a class="easyui-linkbutton orange" href="${pageContext.request.contextPath}/recruitFile/preview_withhistory?recruitFileId=${recruitFile.id}&tenderItemId=${tenderItem.id}" target="_blank" id="ZXYL" >在线预览</a>
							
							<c:if test="${not empty modifyAttachmentId}">
								<br />					
								<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-attach'" href="${pageContext.request.contextPath}/attachment/download/${modifyAttachmentId }" target="_blank" title="点击下载澄清文件" id="CQXZ">澄清文件</a>&nbsp;
							</c:if>
							
						<%-- </c:if> --%>
						</c:if>
				</td>
			</tr>
			<tr>
				<th width="120px">投标文件编辑器下载</th>
				<td colspan='3'>
					<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-attach'" href="/resources/jc_bidEditor.zip" target="_blank" title="点击下载">投标文件编辑器</a>
				</td>
			</tr>
			<!-- <tr>
				<th width="120px">office工具</th>
				<td colspan='3'>
					<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-attach'" href="/resources/Office2007.zip" target="_blank" title="点击下载">Office2007官方安装包</a>
					<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-attach'" href="/resources/uninstall/Office2003Uninstall.msi" target="_blank" title="点击下载">Office2003官方卸载工具</a>
					<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-attach'" href="/resources/uninstall/Office2007Uninstall.msi" target="_blank" title="点击下载">Office2007官方卸载工具</a>
					<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-attach'" href="/resources/uninstall/Office2010Uninstall.msi" target="_blank" title="点击下载">Office2010官方卸载工具</a>
					<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-attach'" href="/resources/uninstall/Office2013Uninstall.diagcab" target="_blank" title="点击下载">Office2013官方卸载工具</a>
				</td>
			</tr> -->
		</table>
		<%-- <div class="blank10"></div>
		<!-- 招标文件 -->
		<div class="tableTitle2">招标文件下载</div>
		<table class='mytableStyle'>
			<tr>
				<td width="100%;">
					<c:choose>
						<c:when test="${empty recruitFile}">
							招标文件还在编制审核中
						</c:when>
						<c:otherwise>
							<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${recruitFile.pdfAttachment.fjid00}">${recruitFile.projectItem.projectInstance}_${recruitFile.projectItem}&nbsp;招标文件(WORD下载)</a>
							<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${recruitFile.pdfAttachment.fjid00}">${recruitFile.projectItem.projectInstance}_${recruitFile.projectItem}&nbsp;招标文件(PDF下载)</a>
						</c:otherwise>
					</c:choose>
					<a class="button red" href="/resources/Bidfile_Edit.exe">下载编辑器</a>
				</td>
			</tr> 
		</table>--%>
		<div class="blank10"></div>
		<%-- <c:if test="${!isNotSendB}"> --%> <!-- !isNotSendB -->
			<c:if test="${recruitFile.envelopeType=='two'}">
			    <select name="envelopeTypeOrder" id="envelopeTypeOrder" onchange="setEnvelopeTypeOrder();">
			    	<option value="first">第一信封</option>
			    	<option value="second">第二信封</option>
			    </select>
		    </c:if>
		    <c:if test="${recruitFile.envelopeType=='one'}">
		    	<input type="hidden" name="envelopeTypeOrder" value="first"/>
		    </c:if>
			<a id="bidFileAttachment" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">上传投标文件(.ebid)</a>
			<div class="usBox">
				<table id="bidFile-datagrid"></table>
			</div>
			<div class="blank10"></div>
			<%-- <p>${tenderItem.organId},${tenderItem.projectItemId }</p> --%>
			<c:if test="${projectItem.currentBidStage =='2'}">
				<a id="sendBidDeposit-1" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">上传保证金递交凭证(.jpg)</a>
				<div class="usBox">
					<table class="mytableStyle">
						<col width="200"/>
						<col />
						<col width="150"/>
						<tr>
							<th>保证金账户名称</th>
							<td colspan="2">${virtualAccountCNo.accountName}</td>
						</tr>
						<tr>
							<th>开户银行</th>
							<td>${virtualAccountCNo.bankName}</td>
						</tr>
						<tr>
							<th>联行行号</th>
							<td>${virtualAccountCNo.unionBankNo}</td>
						</tr>
						<tr>
							<th>保证金账户帐号</th>
							<td colspan="2">${virtualAccountCNo.accountNumber}</td>
						</tr>
						<c:if test="${!isNotSendC}">
							<tr>
								<th>保证金账户总金额</th>
								<td>${totalDepositAmt}元</td>
								<td style="text-align:center"><a class="button small red" href="${pageContext.request.contextPath}/depositPartitionPage?projectInstanceId=${tenderItem.projectInstanceId}">重新划分</a></td>
							</tr>
							<tr>
								<th>未划分保证金金额</th>
								<td>${totalDepositAmt-depositRecordService.retrieveDepositRecordTotalAmt('',tenderItem.organId,tenderItem.projectInstanceId,'')}元</td>
								<td style="text-align:center"><a class="button small red" id="depositBalance">全部划入此标段</a></td>
							</tr>
							<tr>
								<th>本标段保证金金额</th>
								<td colspan="2">${empty depositRecord?0:depositRecord.amt}元</td>
							</tr>
						</c:if>
						<tr>
							<th>重要说明</th>
							<td colspan="2" style="color:red;">打款请备注单位名称、项目编号、标段名称</td>
						</tr>
					</table>
					<br />
					<table id="sendBidDepositAttachment-datagrid"></table>
				</div>
				<div id="sendBidDepositAttachment" class="usBox" style="text-align: center;">
					<c:if test="${not empty sendBidDepositAttachment}">
						<c:forEach var="item" items="${sendBidDepositAttachment}">
							<img src="${pageContext.request.contextPath}/attachment/download/${item.fjid00}" style="width:100%;" />
						</c:forEach>
					</c:if>
				</div>
			</c:if>
			<div class="blank10"></div>
			<form method="post" id="tbForm" action="${pageContext.request.contextPath}/workflow/completeForm">
				<input id="tenderItemId" type="hidden" name="tenderItemId" value="${processBusinessKey}" /> <input type="hidden" value="${taskId}" name="taskId" /> <input type="hidden" name="message" value="${message}" />
				<%-- <c:if test="${not empty taskId}">
					<input type='button' id="subBtn" class='button red' value='提交' />
				</c:if> --%>
				<input type='button' class='button red' value='返回' onclick='window.history.go(-1)' />
			</form>
		<%-- </c:if> --%>
	</div>
</body>
<script>
//删除附件
function removeAttachment(id){
	var rowIndex=$("#bidFile-datagrid").datagrid("getRowIndex",id)
	var row=$("#bidFile-datagrid").datagrid("getRows")[rowIndex];
	$.messager.confirm('系统提示','确定要删除该附件吗？',function(r){
		if(r){
					$.ajax({
						url : ctx+"/attachment/deleteAttachment",
						data:{"id":id},
						type:"post",
						dataType:"json",
						success : function(data) {
							$.messager.alert("提示",data.msg);
							if(data.success){
								$("bidFile-datagrid").datagrid("clearSelections");
								$("#bidFile-datagrid").datagrid("deleteRow",rowIndex);
							}
						}
					});
		}
	});
}
</script>
</html>
