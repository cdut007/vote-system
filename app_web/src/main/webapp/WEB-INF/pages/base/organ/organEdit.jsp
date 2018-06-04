<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${util:property('business.platformName')}电子交易平台</title>
<sys:link easyui="true" plupload="true" uedit="true"  ca="true"/>
<script type="text/javascript">
	$(function() {
		// 审核不通过，清空部分文本
		if("${organ.isAudits}" == "-1"){
			$("#description").val('');
			$("#businessScope").val('');
			$("#portal").val('');
			$("#zipCode").val('');
			$("#faxNo").val('');
			$("#ztklxr").val('');
			$("#ztklxdh").val('');
		}
		
		$("#bind").click(function(){
			var randomStr = "${pageContext.request.session.id}";
			JITDSignOcx.Initialize(InitParam);
			JITDSignOcx.SetCertChooseType(1);
			//调用JITDSignOcx的选择证书
//			JITDSignOcx.SetCert("SC", "", "", "", "CN=ShanXi Digital Certificate Authority,O=ShanXi Digital Certificate Authority,L=TaiYuan,S=ShanXi,C=CN", "");
			JITDSignOcx.SetCert("SC", "", "", "", "", "");
			if (JITDSignOcx.GetErrorCode() != 0) {
				alert("错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
				JITDSignOcx.Finalize();
				return false;
			}
			//带原文的数字签名
			var signStr = JITDSignOcx.AttachSignStr("", randomStr);
			if (JITDSignOcx.GetErrorCode() != 0) {
				alert("错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
				JITDSignOcx.Finalize();
				return false;
			}
			JITDSignOcx.Finalize();

			$.ajax({
				url:ctx+"/organ/bindCertInfo",
				type:"post",
				data:{signvalue:signStr},
				dataType:"json",
				success:function(data){
					$.messager.alert("系统提示",data.msg);
				}
			});
		});
		$("#unbind").click(function(){
			$.messager.confirm("系统提示","确认解绑吗?",function(ok){
				if(ok){
					var randomStr = "${pageContext.request.session.id}";
					JITDSignOcx.Initialize(InitParam);
					JITDSignOcx.SetCertChooseType(1);
					//调用JITDSignOcx的选择证书
//			JITDSignOcx.SetCert("SC", "", "", "", "CN=ShanXi Digital Certificate Authority,O=ShanXi Digital Certificate Authority,L=TaiYuan,S=ShanXi,C=CN", "");
					JITDSignOcx.SetCert("SC", "", "", "", "", "");
					if (JITDSignOcx.GetErrorCode() != 0) {
						alert("错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
						JITDSignOcx.Finalize();
						return false;
					}
					//带原文的数字签名
					var signStr = JITDSignOcx.AttachSignStr("", randomStr);
					if (JITDSignOcx.GetErrorCode() != 0) {
						alert("错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
						JITDSignOcx.Finalize();
						return false;
					}
					JITDSignOcx.Finalize();

					$.ajax({
						url:ctx+"/organ/unbindCertInfo",
						type:"post",
						data:{signvalue:signStr},
						dataType:"json",
						success:function(data){
							$.messager.alert("系统提示",data.msg);
						}
					});
				}
			});
		});
		var ue1 = UE.getEditor('description', {
			toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|', 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols' ] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		});
		var ue2 = UE.getEditor('businessScope', {
			toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|', 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols' ] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		});
		var uploader = new plupload.Uploader({
			runtimes : 'html5,flash,silverlight,html4',
			browse_button : 'pickfile',
			//container : document.getElementById('container'),
			url : ctx + '/attachment/uploadAttachment',
			flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
			silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
			multi_selection : false,
			multipart_params : {
				fjsszt : "${organ.id}",
				fjgslx : "26",
				unique : false
			},
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
					up.start();
					$.messager.progress({title:"系统提示",msg:"正在上传中..."}); 
				},
				UploadProgress : function(up, file) {

				},
				FileUploaded : function(up, file, result) {
					var data = $.parseJSON(result.response);
					$("#logo").html($("<img/>").css({
						"width" : "140px",
						"height" : "140px"
					}).attr("src", "${pageContext.request.contextPath}/attachment/download/" + data.data.path));
					$("#logoId").val(data.data.fjid00);
				},
				UploadComplete : function(uploader, files) {
					$.messager.progress("close"); 
				},
				Error : function(up, err) {

				}
			}
		});

		/*****
		 * 组织机构代码证上传
		 *
		 ******/
		var uploader2 = new plupload.Uploader({
			runtimes : 'html5,flash,silverlight,html4',
			browse_button : 'organizationCodeCertificate',
			//container : document.getElementById('container'),
			url : ctx + '/attachment/uploadAttachment',
			flash_swf_url :'/resources/plupload-2.1.2/js/Moxie.swf',
			silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
			multi_selection : false,
			multipart_params : {
				fjsszt : "${organ.id}",
				fjgslx : "27",
				unique : true
			},
			//file_data_name:"Filedata",
			//drop_element : 'drop_area',
			filters : {
				mime_types : [ //只允许上传图片和zip文件
				{
					title : "Image files",
					extensions : "jpg,gif,png,bmp"
				} ],
				prevent_duplicates : true,//不允许选取重复文件
				max_file_size : '5000mb'//最大只能上传400kb的文件
			},
			init : {
				PostInit : function() {
				},
				FilesAdded : function(up, files) {
					up.start();
					$.messager.progress({title:"系统提示",msg:"正在上传中..."}); 
				},
				UploadProgress : function(up, file) {
				},
				FileUploaded : function(up, file, result) {
					var data = $.parseJSON(result.response);
					$("#organizationCodeCertificateAttachment").html($("<img/>").attr("src", ctx + "/attachment/download/" + data.data.path).css("width", "100%"));
				},
				UploadComplete : function(uploader, files) {
					$.messager.progress("close"); 
				},
				Error : function(up, err) {
					$.messager.alert(err);
				},
				FilesRemoved : function(up, files) {

				}
			}
		});

		/*****
		 * 营业执照
		 *
		 ******/
		var uploader3 = new plupload.Uploader({
			runtimes : 'html5,flash,silverlight,html4',
			browse_button : 'businessLicense',
			//container : document.getElementById('container'),
			url : ctx + '/attachment/uploadAttachment',
			flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
			silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
			multi_selection : false,
			multipart_params : {
				fjsszt : "${organ.id}",
				fjgslx : "28",
				unique : true
			},
			//file_data_name:"Filedata",
			//drop_element : 'drop_area',
			filters : {
				mime_types : [ //只允许上传图片和zip文件
				{
					title : "Image files",
					extensions : "jpg,gif,png,bmp"
				} ],
				prevent_duplicates : true,//不允许选取重复文件
				max_file_size : '5000mb'//最大只能上传400kb的文件
			},
			init : {
				PostInit : function() {
				},
				FilesAdded : function(up, files) {
					up.start();
					$.messager.progress({title:"系统提示",msg:"正在上传中..."}); 
				},
				UploadProgress : function(up, file) {
				},
				FileUploaded : function(up, file, result) {
					var data = $.parseJSON(result.response);
					$("#businessLicenseAttachment").html($("<img/>").attr("src", ctx + "/attachment/download/" + data.data.path).css("width", "100%"));
				},
				UploadComplete : function(uploader, files) {
					$.messager.progress("close"); 
				},
				Error : function(up, err) {
					$.messager.alert(err);
				},
				FilesRemoved : function(up, files) {

				}
			}
		});
		/*****
		 * 税务登记证
		 *
		 ******/
		var uploader4 = new plupload.Uploader({
			runtimes : 'html5,flash,silverlight,html4',
			browse_button : 'taxCertificate',
			//container : document.getElementById('container'),
			url : ctx + '/attachment/uploadAttachment',
			flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
			silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
			multi_selection : false,
			multipart_params : {
				fjsszt : "${organ.id}",
				fjgslx : "29",
				unique : true
			},
			//file_data_name:"Filedata",
			//drop_element : 'drop_area',
			filters : {
				mime_types : [ //只允许上传图片和zip文件
				{
					title : "Image files",
					extensions : "jpg,gif,png,bmp"
				} ],
				prevent_duplicates : true,//不允许选取重复文件
				max_file_size : '5000mb'//最大只能上传400kb的文件
			},
			init : {
				PostInit : function() {
				},
				FilesAdded : function(up, files) {
					up.start();
					$.messager.progress({title:"系统提示",msg:"正在上传中..."}); 
				},
				UploadProgress : function(up, file) {
				},
				FileUploaded : function(up, file, result) {
					var data = $.parseJSON(result.response);
					$("#taxCertificateAttachment").html($("<img/>").attr("src", ctx + "/attachment/download/" + data.data.fjid00).css("width", "100%"));
				},
				UploadComplete : function(uploader, files) {
					$.messager.progress("close"); 
				},
				Error : function(up, err) {
					$.messager.alert(err);
				},
				FilesRemoved : function(up, files) {

				}
			}
		});
		uploader.init();
		uploader2.init();
		uploader3.init();
		uploader4.init();
		$("#submitBtn").click(function(){
			$("#isAudits").val("1");	//再次提交信息审核是否考虑保持原来的审核状态？貌似不好操作！！
			$("#organForm").submit();
		});
		$("#saveBtn").click(function(){
			$("#isAudits").val("0");
			$("#organForm").submit();
		});
		
		$("#edit").click(function(){
			//alert("${organ.isAudits}");
			if("${organ.isAudits}" == '2'){
				$.messager.confirm("系统提示","企业信息审核阶段，不允许进行业务操作！确认要修改信息并提交审核吗?",function(ok){
					if(ok){
						window.location.href="/organ/organEditAgain";
					}
				});
			}else{
				window.location.href="/organ/organEditAgain";
			}			
		});
		
		// 机构扩展信息查询
		$("#check_KZ").click(function(){
			var organId = "${organ.id}";
			/* if("${organ.isAudits}" == "0"){
				$.messager.alert("系统提示","请先提交信息审核！");
				return;
			}else{ */
				window.location.href="/organ/check_KZ?organId="+organId;				
			/* } */
			/* $.ajax({
				url:ctx + "/organ/check_KZ",	
				type:"post",
				data:{organId:organId},
				dataType:"json",
				success:function(data){
					data.data[0].key;
					$.messager.alert("系统提示",data.msg);
				}
			}); */
		});
	});	
</script>

</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			会员管理
			<code>&gt;</code>
			机构信息维护
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<c:choose>
					<c:when test="${organ.isAudits=='1'}">
						<h1>您的信息正在审核中！</h1>
						<div class="blank10"></div>
						<div class="easyui-panel" data-options="title:'基本信息'" style="overflow:hidden;padding:10px;">
							<table style="table-layout:auto;width:100%;">
								<col style="width:10px" />
								<col style="width:100px" />
								<col style="width:100px" />
								<col style="width:10px" />
								<col style="width:100px" />
								<col style="width:100px" />
								<tbody>
									<tr>
										<td class="need"></td>
										<td>单位名称：</td>
										<td style="width:220px;">
											${organ.ztmc00}
										</td>
										<td colspan="2" rowspan="6">
											<div>
												<div id="logo" style="width:140px;height:140px;border:1px solid #ddd">
													<c:if test="${not empty organ.logoId}">
														<img src="${pageContext.request.contextPath}/attachment/download/${organ.logo.path}" style="width:140px;height:140px;" />
													</c:if>
												</div>
											</div>
										</td>
									</tr>								
									<tr>
										<td class="need"></td>
										<td style="width:100px;">行政区划：</td>
										<td style="width:220px;">
											${util:dictionary("REGION",organ.region)}
										</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人代码：</td>
										<td>${organ.frdm}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人代表：</td>
										<td>${organ.frdbxm}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人类别：</td>
										<td>
											${util:dictionary("FRLB",organ.frlb00)}
										</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人机构类别：</td>
										<td>
											${util:dictionary("FRJGLB",organ.frjglb)}
										</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人角色：</td>
										<td>
											${organ.frjs00}
										</td>
										<td class="need"></td>
										<td style="width:100px">行业类别：</td>
										<td style="width:220px">
											${util:dictionary('INDUSTRY',organ.industry)}
										</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>注册地（省）：</td>
										<td>${util:dictionary('REGION',organ.zcdp00)}</td>
										<td class="need"></td>
										<td>注册地（市）：</td>
										<td>${util:dictionary('REGION',organ.zcdc00)}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>国别地区：</td>
										<td>
											${util:dictionary('COUNTRY',organ.gbdq00)}
										</td>
										<td class="need"></td>
										<td>单位性质：</td>
										<td>
											${util:dictionary('OWNERSHIP',organ.dwxz00)}
										</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>营业执照号码：</td>
										<td>${organ.yyzzhm}</td>
										<td class="need"></td>
										<td>营业执照失效日期：</td>
										<td>${organ.yyzzsxrq}</td>
									</tr>									
									<tr>
										<td class="need"></td>
										<td>组织机构代码：</td>
										<td>${organ.ztdm00}</td>
										<td class="need"></td>
										<td>组织机构代码失效日期：</td>
										<td>${organ.ztdmsxrq}</td>
										</tr>
									<tr>
										<td class="need"></td>
										<td>国家税务登记号：</td>
										<td>${organ.swdjh0}</td>
										<td class="need"></td>
										<td>国家税务登记号失效日期：</td>
										<td>${organ.swdjhsxrq}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>地方税务登记号：</td>
										<td>${organ.dswdjh}</td>
										<td class="need"></td>
										<td>地方税务登记号失效日期：</td>
										<td>${organ.dswdjhsxrq}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>开户银行：</td>
										<td>${organ.khyh00}</td>
										<td class="need"></td>
										<td>开户银行支行号：</td>
										<td>${organ.khyhzh}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>基本账号名称：</td>
										<td>${organ.accountName}</td>
										<td class="need"></td>
										<td>基本账户账号：</td>
										<td>${organ.jbzhzh}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>注册资本：</td>
										<td>
											${organ.zczb00} ${util:dictionary('JEDWDM',organ.zczbdw)} ${util:dictionary('CURRENCY',organ.zczbbz)}	
										</td>
										<td class="need"></td>
										<td>邮政编码：</td>
										<td>${organ.zipCode}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>单位联系人：</td>
										<td>${organ.ztklxr}</td>
										<td class="need"></td>
										<td>单位联系电话：</td>
										<td>${organ.ztklxdh}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>申报责任人：</td>
										<td>${organ.principal.userName}</td>
										<td class="need"></td>
										<td>申报责任人联系电话：</td>
										<td>${organ.principal.phone}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>申报责任人邮箱：</td>
										<td>${organ.principal.email}</td>
										<td class="need"></td>
										<td>传真：</td>
										<td>${organ.faxNo}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人业务状态：</td>
										<td>
											${util:dictionary('FRYWZT',organ.frywzt)}
										</td>
										<td></td>
										<td>门户网站</td>
										<td >${organ.portal}</td>
									</tr>								
								</tbody>
							</table>
							<div class="blank10"></div>
							<c:set value="${organService.getOrganizationCodeCertificate(organ.id)}" var="organizationCodeCertificate"></c:set>
							<c:set value="${organService.getBusinessLicense(organ.id)}" var="businessLicense"></c:set>
							<c:set value="${organService.getTaxCertificate(organ.id)}" var="taxCertificate"></c:set>
							<table class="mytableStyle" style="width:100%;">
								<thead>
									<tr>
										<th style="width:34%">组织机构代码证</th>
										<th style="width:33%">企业营业执照</th>
										<th style="width:33%">税务登记证</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<div id="organizationCodeCertificateAttachment">
												<c:if test="${not empty organizationCodeCertificate}">
													<img src="${pageContext.request.contextPath}/attachment/download/${organizationCodeCertificate.fjid00}" style="width:100%"></img>
												</c:if>
											</div>
										</td>
										<td>
											<div id="businessLicenseAttachment">
												<c:if test="${not empty businessLicense}">
													<img src="${pageContext.request.contextPath}/attachment/download/${businessLicense.fjid00}" style="width:100%"></img>
												</c:if>
											</div>
										</td>
										<td>
											<div id="taxCertificateAttachment">
												<c:if test="${not empty taxCertificate}">
													<img src="${pageContext.request.contextPath}/attachment/download/${taxCertificate.fjid00}" style="width:100%"></img>
												</c:if>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="blank10"></div>
						<div class="easyui-panel" data-options="title:'企业简介',height:100" style="overflow:hidden;">
							${organ.description_tmp}
						</div>
						<div class="blank10"></div>
						<div class="easyui-panel" data-options="title:'业务范围',height:100" style="overflow:hidden;">
							${organ.businessScope_tmp}
						</div>
					</c:when>
					<c:when test="${organ.isAudits=='-1' || organ.isAudits=='2'}">
						
							<table class="mytableStyle">
								<tr>
									<th width="150px;">审核结果：</th>
									<td>
										<span class="f1">${util:dictionary('JGSHZT',organ.isAudits)}</span>
									</td>
								</tr>
								<tr>
									<th>审核意见：</th>
									<td>${organ.backReason}</td>
								</tr>
							</table>

						<div class="blank10"></div>
						<input type="button" value="修 改" class="button red" id="edit"/>
						<div class="blank10"></div>
						
						<div class="easyui-panel" data-options="title:'基本信息'" style="overflow:hidden;padding:10px;">
							<table style="table-layout:auto;width:100%;">
								<col style="width:10px" />
								<col style="width:100px" />
								<col style="width:100px" />
								<col style="width:10px" />
								<col style="width:100px" />
								<col style="width:100px" />
								<tbody>
									<tr>
										<td class="need"></td>
										<td>单位名称：</td>
										<td style="width:220px;">
											${organ.ztmc00}
										</td>
										<td colspan="2" rowspan="6">
											<div>
												<div id="logo" style="width:140px;height:140px;border:1px solid #ddd">
													<c:if test="${not empty organ.logoId}">
														<img src="${pageContext.request.contextPath}/attachment/download/${organ.logo.path}" style="width:140px;height:140px;" />
													</c:if>
												</div>
											</div>
										</td>
									</tr>								
									<tr>
										<td class="need"></td>
										<td style="width:100px;">行政区划：</td>
										<td style="width:220px;">
											${util:dictionary("REGION",organ.region)}
										</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人代码：</td>
										<td>${organ.frdm}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人代表：</td>
										<td>${organ.frdbxm}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人类别：</td>
										<td>
											${util:dictionary("FRLB",organ.frlb00)}
										</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人机构类别：</td>
										<td>
											${util:dictionary("FRJGLB",organ.frjglb)}
										</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人角色：</td>
										<td>
											${organ.frjs00}
										</td>
										<td class="need"></td>
										<td style="width:100px">行业类别：</td>
										<td style="width:220px">
											${util:dictionary('INDUSTRY',organ.industry)}
										</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>注册地（省）：</td>
										<td>${util:dictionary('REGION',organ.zcdp00)}</td>
										<td class="need"></td>
										<td>注册地（市）：</td>
										<td>${util:dictionary('REGION',organ.zcdc00)}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>国别地区：</td>
										<td>
											${util:dictionary('COUNTRY',organ.gbdq00)}
										</td>
										<td class="need"></td>
										<td>单位性质：</td>
										<td>
											${util:dictionary('OWNERSHIP',organ.dwxz00)}
										</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>营业执照号码：</td>
										<td>${organ.yyzzhm}</td>
										<td class="need"></td>
										<td>营业执照失效日期：</td>
										<td>${organ.yyzzsxrq}</td>
									</tr>									
									<tr>
										<td class="need"></td>
										<td>组织机构代码：</td>
										<td>${organ.ztdm00}</td>
										<td class="need"></td>
										<td>组织机构代码失效日期：</td>
										<td>${organ.ztdmsxrq}</td>
										</tr>
									<tr>
										<td class="need"></td>
										<td>国家税务登记号：</td>
										<td>${organ.swdjh0}</td>
										<td class="need"></td>
										<td>国家税务登记号失效日期：</td>
										<td>${organ.swdjhsxrq}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>地方税务登记号：</td>
										<td>${organ.dswdjh}</td>
										<td class="need"></td>
										<td>地方税务登记号失效日期：</td>
										<td>${organ.dswdjhsxrq}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>开户银行：</td>
										<td>${organ.khyh00}</td>
										<td class="need"></td>
										<td>开户银行支行号：</td>
										<td>${organ.khyhzh}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>基本账号名称：</td>
										<td>${organ.accountName}</td>
										<td class="need"></td>
										<td>基本账户账号：</td>
										<td>${organ.jbzhzh}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>注册资本：</td>
										<td>
											${organ.zczb00} ${util:dictionary('JEDWDM',organ.zczbdw)} ${util:dictionary('CURRENCY',organ.zczbbz)}	
										</td>
										<td class="need"></td>
										<td>邮政编码：</td>
										<td>${organ.zipCode}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>单位联系人：</td>
										<td>${organ.ztklxr}</td>
										<td class="need"></td>
										<td>单位联系电话：</td>
										<td>${organ.ztklxdh}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>申报责任人：</td>
										<td>${organ.principal.userName}</td>
										<td class="need"></td>
										<td>申报责任人联系电话：</td>
										<td>${organ.principal.phone}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>申报责任人邮箱：</td>
										<td>${organ.principal.email}</td>
										<td class="need"></td>
										<td>传真：</td>
										<td>${organ.faxNo}</td>
									</tr>
									<tr>
										<td class="need"></td>
										<td>法人业务状态：</td>
										<td>
											${util:dictionary('FRYWZT',organ.frywzt)}
										</td>
										<td></td>
										<td>门户网站</td>
										<td >${organ.portal}</td>
									</tr>								
								</tbody>
							</table>
							<div class="blank10"></div>
							<c:set value="${organService.getOrganizationCodeCertificate(organ.id)}" var="organizationCodeCertificate"></c:set>
							<c:set value="${organService.getBusinessLicense(organ.id)}" var="businessLicense"></c:set>
							<c:set value="${organService.getTaxCertificate(organ.id)}" var="taxCertificate"></c:set>
							<table class="mytableStyle" style="width:100%;">
								<thead>
									<tr>
										<th style="width:34%">组织机构代码证</th>
										<th style="width:33%">企业营业执照</th>
										<th style="width:33%">税务登记证</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<div id="organizationCodeCertificateAttachment">
												<c:if test="${not empty organizationCodeCertificate}">
													<img src="${pageContext.request.contextPath}/attachment/download/${organizationCodeCertificate.fjid00}" style="width:100%"></img>
												</c:if>
											</div>
										</td>
										<td>
											<div id="businessLicenseAttachment">
												<c:if test="${not empty businessLicense}">
													<img src="${pageContext.request.contextPath}/attachment/download/${businessLicense.fjid00}" style="width:100%"></img>
												</c:if>
											</div>
										</td>
										<td>
											<div id="taxCertificateAttachment">
												<c:if test="${not empty taxCertificate}">
													<img src="${pageContext.request.contextPath}/attachment/download/${taxCertificate.fjid00}" style="width:100%"></img>
												</c:if>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="blank10"></div>
						<div class="easyui-panel" data-options="title:'企业简介',height:100" style="overflow:hidden;">
							${organ.description}
						</div>
						<div class="blank10"></div>
						<div class="easyui-panel" data-options="title:'业务范围',height:100" style="overflow:hidden;">
							${organ.businessScope}
						</div>
					</c:when>
					<c:otherwise>
						<%-- <c:if test="${organ.isAudits=='-1'}">
							<table class="mytableStyle">
								<tr>
									<th width="150px;">审核结果：</th>
									<td>
										<span class="f1">${util:dictionary('JGSHZT',organ.isAudits)}</span>
									</td>
								</tr>
								<tr>
									<th>审核不通过原因</th>
									<td>${organ.backReason}</td>
								</tr>
							</table>
						</c:if>
						<div class="blank10"></div> --%>
						<form:form id="organForm" method="post" action="${pageContext.request.contextPath}/organ/UpdateOrgan" modelAttribute="organ" onsubmit="return $(this).form('validate');">
							<form:hidden path="cazsbh"/>
							<form:hidden path="isAudits" />
							<form:hidden path="id" />
							<form:hidden path="principalName" />
							<form:hidden path="logoId" />
							<form:hidden path="principalId" />
							<div class="easyui-panel" data-options="title:'基本信息'" style="overflow:hidden;padding:10px;">
								<table style="table-layout:auto;width:100%;">
									<col style="width:10px" />
									<col style="width:100px" />
									<col style="width:100px" />
									<col style="width:10px" />
									<col style="width:100px" />
									<col style="width:100px" />
									<tbody>
										<tr>
											<td class="need">*</td>
											<td>单位名称：</td>
											<td style="width:220px;">
												<form:input path="ztmc00" readonly="true" cssClass="inputxt easyui-validatebox" datatype="s1-100" errormsg="单位名称最多50个中文字符！" data-options="required:true" />
											</td>
											<td colspan="2" rowspan="6">
												<div>
													<div id="logo" style="width:140px;height:140px;border:1px solid #ddd">
														<c:if test="${not empty organ.logoId}">
															<img src="${pageContext.request.contextPath}/attachment/download/${organ.logo.path}" style="width:140px;height:140px;" />
														</c:if>
													</div>
													<a id="pickfile" class="easyui-linkbutton" style="width:142px;">选择LOGO(.jpg)</a>
												</div>
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td style="width:100px;">行政区划：</td>
											<td style="width:220px;">
												<form:input path="region" readonly="true" cssClass="inputxt easyui-combotree" datatype="s1-100" errormsg="请选择项目所属行政区划！" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=REGION&fetchItemCode=${organ.region}&includeRoot=false'" />
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>法人代码：</td>
											<td>
												<form:input path="frdm" readonly="true" cssClass="inputxt easyui-validatebox" datatype="s1-100" nullmsg="请输入法人代码！" data-options="required:true,validType:'length[6,20]'" />
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>法人代表：</td>
											<td>${organ.frdbxm}</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>法人类别：</td>
											<td>
												<%-- <form:input path="frlb00" readonly="true" cssClass="inputxt easyui-validatebox" datatype="s1-100" nullmsg="请输入法人类别！" data-options="required:true" /> --%>
												<form:input path="frlb00" readonly="true" cssClass="inputxt easyui-combotree" datatype="s1-100" errormsg="请选择法人类别！" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=FRLB&fetchItemCode=${organ.frlb00}&includeRoot=false'" />
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>法人机构类别：</td>
											<td>
												<form:input path="frjglb" readonly="true" cssClass="inputxt easyui-combotree" datatype="s1-100" errormsg="请选择法人机构类别！" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=FRJGLB&fetchItemCode=${organ.frjglb}&includeRoot=false'" />
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>法人角色：</td>
											<td>
												<form:input path="frjs00" readonly="true" cssClass="inputxt easyui-validatebox" datatype="s" />										
											</td>
											<td class="need">*</td>
											<td style="width:100px;">行业类别：</td>
											<td style="width:220px;">
												<form:input path="industry" readonly="true" cssClass="inputxt easyui-combotree" datatype="s1-100" errormsg="请选择行业类别！" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=INDUSTRY&fetchItemCode=${organ.industry}&includeRoot=false'" />
											</td>
										</tr>
										<tr>
											<td class="need"></td>
											<td>注册地（省）：</td>
											<td>
												<form:input path="zcdp00" readonly="true" cssClass="inputxt easyui-combotree" datatype="s1-100" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=REGION&fetchItemCode=${organ.zcdp00}&includeRoot=false'" />
											</td>
											<td class="need"></td>
											<td>注册地（市）：</td>
											<td>
												<form:input path="zcdc00" readonly="true" cssClass="inputxt easyui-combotree" datatype="s1-100" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=REGION&fetchItemCode=${organ.zcdc00}&includeRoot=false'" />
											</td>
										</tr>
										<tr>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>国别地区：</td>
											<td>
												<form:select path="gbdq00" readonly="true" cssClass="inputxt" nullmsg="请输入国别地区！">
													<form:option value="" label="请选择" />
													<form:options items="${util:dictionaryTree('COUNTRY',false)}" itemValue="itemCode" itemLabel="itemName" />
												</form:select>
											</td>
											<td class="need">*</td>
											<td>单位性质：</td>
											<td>
												<form:input path="dwxz00" readonly="true" datatype="*" nullmsg="请选择单位性质！" cssClass="inputxt easyui-combotree" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=OWNERSHIP&fetchItemCode=${organ.dwxz00}&includeRoot=false'" />
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>营业执照号码：</td>
											<td>
												<form:input path="yyzzhm" readonly="true" cssClass="inputxt easyui-validatebox" datatype="s" errormsg="请输入营业执照号码！" data-options="required:true,validType:'length[6,20]'" />
											</td>
											<td class="need">*</td>
											<td>营业执照失效日期：</td>
											<td>
												<form:input path="yyzzsxrq" readonly="true" cssClass="inputxt easyui-validatebox" datatype="s" errormsg="请输入营业执照号码失效日期！" data-options="required:true" />
											</td>
										</tr>									
										<tr>
											<td class="need"></td>
											<td>组织机构代码：</td>
											<td>
												<form:input path="ztdm00" readonly="true" cssClass="inputxt easyui-validatebox" datatype="s1-100" nullmsg="请输入组织机构代码！" data-options="validType:'length[6,20]'" />
											</td>
											<td class="need"></td>
											<td>组织机构代码失效日期：</td>
											<td>
												<form:input path="ztdmsxrq" readonly="true" cssClass="inputxt easyui-validatebox" datatype="s1-100" nullmsg="请输入组织机构代码失效日期！"  />
											</td>
										</tr>
										
										<tr>
											<td class="need"></td>
											<td>国家税务登记号：</td>
											<td>
												<form:input path="swdjh0" readonly="true" cssClass="inputxt  easyui-validatebox" datatype="s" errormsg="请输入国家税务登记号！" data-options="required:true,validType:'length[6,20]'" />
											</td>
											<td class="need"></td>
											<td>国家税务登记号失效日期：</td>
											<td>
												<form:input path="swdjhsxrq" readonly="true" cssClass="inputxt  easyui-validatebox" datatype="s" errormsg="请输入国家税务登记号失效日期！" data-options="required:true" />
											</td>
										</tr>
										<tr>
											<td class="need"></td>
											<td>地方税务登记号：</td>
											<td>
												<form:input path="dswdjh" readonly="true" cssClass="inputxt  easyui-validatebox" datatype="s" errormsg="请输入地方税务登记号！" data-options="validType:'length[6,20]'" />
											</td>
											<td class="need"></td>
											<td>地方税务登记号失效日期：</td>
											<td>
												<form:input path="dswdjhsxrq" readonly="true" cssClass="inputxt  easyui-validatebox" datatype="s" errormsg="请输入地方税务登记号失效日期！" />
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>开户银行：</td>
											<td>
												<form:input path="khyh00" readonly="true" cssClass="inputxt easyui-validatebox" errormsg="请输入开户银行！" data-options="required:true" />
											</td>
											<td class="need">*</td>
											<td>开户银行支行号：</td>
											<td>
												<form:input path="khyhzh" readonly="true" cssClass="inputxt easyui-validatebox" errormsg="请输入开户银行支行号！" data-options="required:true" />
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>基本账号名称：</td>
											<td>
												<form:input path="accountName" readonly="true" cssClass="inputxt easyui-validatebox" errormsg="请输入基本账号名称！" data-options="required:true" />
											</td>
											<td class="need">*</td>
											<td>基本账户账号：</td>
											<td>
												<form:input path="jbzhzh" readonly="true" cssClass="inputxt easyui-validatebox" errormsg="请输入基本账户账号！" data-options="required:true" />
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>申报责任人：</td>
											<td>
												<form:input path="principal.userName" readonly="true" cssClass="inputxt easyui-validatebox"  data-options="required:true" />
												<form:hidden path="principal.gender" />
											</td>
											<td class="need">*</td>
											<td>申报责任人联系电话：</td>
											<td>
												<form:input path="principal.phone" readonly="true" cssClass="inputxt easyui-validatebox" data-options="required:true" />
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>注册资本：</td>
											<td>
												<form:input path="zczb00" readonly="true" cssClass="inputxt" datatype="n" errormsg="请输入注册资本！"/>
											</td>
											<td class="need">*</td>
											<td>申报责任人邮箱：</td>
											<td>
												<form:input path="principal.email" readonly="true" cssClass="inputxt easyui-validatebox" errormsg="请输入申报责任人电子邮箱！" data-options="required:true,validType:'email'" />
											</td>
											
										</tr>
										<tr>
											<td class="need">*</td>
											<td>注册资本单位：</td>
											<td>
												<form:select path="zczbdw" readonly="true" datatype="*" nullmsg="请选择注册资本单位！">
													<form:option value="1">请选择</form:option>
													<form:options items="${util:dictionaryTree('JEDWDM',false)}" itemLabel="itemName" itemValue="itemCode" />
												</form:select>
											</td>
											<td class="need">*</td>
											<td>注册资本币种：</td>
											<td>
												<form:select path="zczbbz" readonly="true" datatype="*" nullmsg="请选择注册资本币种！">
													<form:option value="1">请选择</form:option>
													<form:options items="${util:dictionaryTree('CURRENCY',false)}" itemLabel="itemName" itemValue="itemCode" />
												</form:select>
											</td>
											
										</tr>
										<tr>
											<td class="need">*</td>
											<td>单位联系人：</td>
											<td>
												<form:input id="ztklxr" readonly="true" path="ztklxr" cssClass="inputxt easyui-validatebox" nullmsg="请输入单位联系人！" data-options="required:true" />
											</td>
											<td class="need">*</td>
											<td>单位联系电话：</td>
											<td>
												<form:input id="ztklxdh" readonly="true" path="ztklxdh" cssClass="inputxt easyui-validatebox" errormsg="请输入单位联系人电话！" data-options="required:true" />
											</td>
										</tr>										
										<tr>
											<td class="need"></td>
											<td>邮政编码：</td>
											<td>
												<form:input id="zipCode" readonly="true" path="zipCode" cssClass="inputxt easyui-validatebox" nullmsg="请输入邮政编码！" data-options="validType:'zipCode'" />
											</td>
											<td class="need"></td>
											<td>传真：</td>
											<td>
												<form:input id="faxNo" readonly="true" path="faxNo" cssClass="inputxt easyui-validatebox" errormsg="请输入传真号码！" />
											</td>
										</tr>
										<tr>
											<td class="need"></td>
											<td>法人业务状态：</td>
											<td>
												<form:input path="frywzt" readonly="true" cssClass="inputxt easyui-combotree" datatype="s1-100" errormsg="请选择法人类别！" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=FRYWZT&fetchItemCode=${organ.frywzt}&includeRoot=false'" />
											</td>
											<td></td>
											<td>门户网站</td>
											<td><form:input id="portal" readonly="true" path="portal" cssClass="inputxt"/></td>
										</tr>
										<tr>
											<td class="need"></td>
											<td><input type="button" value="扩展信息查看" class="button red" id="check_KZ"/></td>
										</tr>
									</tbody>
								</table>
								<div class="blank10"></div>
								<c:set value="${organService.getOrganizationCodeCertificate(organ.id)}" var="organizationCodeCertificate"></c:set>
								<c:set value="${organService.getBusinessLicense(organ.id)}" var="businessLicense"></c:set>
								<c:set value="${organService.getTaxCertificate(organ.id)}" var="taxCertificate"></c:set>
								<table class="mytableStyle" style="width:100%;">
									<thead>
										<tr>
											<th style="width:34%"><a id="1organizationCodeCertificate" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">上传组织机构代码证</a></th>
											<th style="width:33%"><a id="1businessLicense" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">上传企业营业执照</a></th>
											<th style="width:33%"><a id="1taxCertificate" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">上传税务登记证</a></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<div id="organizationCodeCertificateAttachment">
													<c:if test="${not empty organizationCodeCertificate}">
														<img src="${pageContext.request.contextPath}/attachment/download/${organizationCodeCertificate.fjid00}" style="width:100%"></img>
													</c:if>
												</div>
											</td>
											<td>
												<div id="businessLicenseAttachment">
													<c:if test="${not empty businessLicense}">
														<img src="${pageContext.request.contextPath}/attachment/download/${businessLicense.fjid00}" style="width:100%"></img>
													</c:if>
												</div>
											</td>
											<td>
												<div id="taxCertificateAttachment">
													<c:if test="${not empty taxCertificate}">
														<img src="${pageContext.request.contextPath}/attachment/download/${taxCertificate.fjid00}" style="width:100%"></img>
													</c:if>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								<span></span><i>请上传jpg,gif,png,bmp格式图片</i>
							</div>
							<div class="blank10"></div>
							<div class="easyui-panel" data-options="title:'企业简介'" style="overflow:hidden;">
								<form:textarea id="description" path="description_tmp" cssStyle="width:100%;height:200px;" />
								<form:hidden path="description" />
							</div>
							<div class="blank10"></div>
							<div class="easyui-panel" data-options="title:'业务范围'" style="overflow:hidden;">
								<form:textarea id="businessScope" path="businessScope_tmp" cssStyle="width:100%;height:100px;" />
								<form:hidden path="businessScope" />
							</div>
							<div class="blank10"></div>
							<input type="button" id="saveBtn" class="button red" value="保存信息" />
							<input type="button" id="bind" class="button red" value="绑定USBKey" />
							<input type="button" id="unbind" class="button red" value="解绑USBKey" />
							<input type="button" id="submitBtn" class="button red" value="提交审核" />
						</form:form>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>