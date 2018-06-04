<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="organ" value="${organService.createOrganQuery().organId(processBusinessKey).singleResult()}" scope="request"></c:set>
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${util:property('business.platformName')}电子交易平台</title>
<sys:link easyui="true" plupload="true" uedit="true"/>
<!-- <link rel="stylesheet" media="screen" type="text/css" href="/resources/zoomimage/css/layout.css" />
<link rel="stylesheet" media="screen" type="text/css" href="/resources/zoomimage/css/custom.css" />
<link rel="stylesheet" media="screen" type="text/css" href="/resources/zoomimage/css/zoomimage.css" />
<link rel="stylesheet" media="screen" type="text/css" href="/resources/zoomimage/css/zoom.css" /> -->
<!-- <script type="text/javascript" src="/resources/zoomimage/js/eye.js"></script> -->
<!-- <script type="text/javascript" src="/resources/zoomimage/js/layout.js"></script> -->
<!-- <script type="text/javascript" src="/resources/zoomimage/js/utils.js"></script> -->
<!-- <script type="text/javascript" src="/resources/zoomimage/js/zoomimage.js"></script> -->
<!-- <script type="text/javascript" src="/resources/zoomimage/js/zoom.min.js"></script> -->
<script type="text/javascript">
	$(function() {
		var imageIndex=-1;
		var images=$("#picture img");
		images.each(function(i){		
			$(this).click(function(){
				//alert(i);
				imageIndex=i;
				var src=$(this).attr("src");
				var title=$(this).attr("title");
				var realWidth = 800;
				var win=$("<div/>").appendTo($("body")).window({  
					title:title, 
					width:realWidth,    
	   				resizable:false,    
	   				closed: false,    
	   				cache: true,  
					modal: true,
					content:"<div id='prev' style='position:absolute;display:block;top:50%;left:20px;color:red;weight:900;z-index:500;background:url(/resources/zoomimage/images/zoomimage_prev.gif);width:39px;height:29px;'>\
							</div>\
							<div id='next' style='position:absolute;top:50%;right:20px;color:red;weight:900;z-index:500;background:url(/resources/zoomimage/images/zoomimage_next.gif);width:39px;height:29px;'>\
							</div>\
							<img src=\""+src+"\" width=\"100%\"/>",
					onClose:function(){
						$(this).dialog("destory");
					},
					onOpen:function(){
						//获取所有图片
							$("#prev").click(function(){
								imageIndex--;
								if(imageIndex<0){
									imageIndex=0;
								}
								//alert(1);
								win.find("img:last").attr("src",$(images[imageIndex]).attr("src"));
							});
							$("#next").click(function(){
								imageIndex++;
								if(imageIndex<0){
									imageIndex=0;
								}
								//alert(1);
								win.find("img:last").attr("src",$(images[imageIndex]).attr("src"));
							});
							
						
					}
				});	
			});
		});
		$("#pass").click(function(){
			$.messager.confirm("系统提示","确认审核通过吗?",function(ok){
				$("[name='pass']").val(true);
				$("#workFlowForm").submit();
			});
		});
		$("#nopass").click(function(){
			if($.trim($("#nopassReason").val())==""){
				$.messager.alert("系统提示","请输入审核不通过原因");
				return false;
			}
			$.messager.confirm("系统提示","确认审核不通过吗?",function(ok){
				if(ok){
					$("[name='pass']").val(false);
					$("#workFlowForm").submit();
				}
			});
			
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
				<form:form id="workFlowForm" method="post" action="${pageContext.request.contextPath}/workflow/completeForm" modelAttribute="organ" onsubmit="return $(this).form('validate');">
					<input type="hidden" name="taskId" value="${taskId}" /> 
					<input type="hidden" name="pass" value="false" /> 
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
						<table class="mytableStyle" style="width:100%;" id="mytable">
							<thead>
								<tr>
									<th style="width:34%">组织机构代码证</th>
									<th style="width:33%">企业营业执照</th>
									<th style="width:33%">税务登记证</th>
								</tr>
							</thead>
							<tbody id="picture">
								<tr>
									<td>
										<div id="organizationCodeCertificateAttachment">
											<c:if test="${not empty organizationCodeCertificate}">
												<%-- <a href="${pageContext.request.contextPath}/attachment/download/${organizationCodeCertificate.fjid00}"  title="组织机构代码证" class="lightsGal" > --%><img src="${pageContext.request.contextPath}/attachment/download/${organizationCodeCertificate.fjid00}" style="width:100%" title="组织机构代码证"/><!-- </a> -->
											</c:if>
										</div>
									</td>
									<td>
										<div id="businessLicenseAttachment">
											<c:if test="${not empty businessLicense}">
												 <img src="${pageContext.request.contextPath}/attachment/download/${businessLicense.fjid00}" style="width:100%" title="营业执照"/>
											</c:if>
										</div>
									</td>
									<td>
										<div id="taxCertificateAttachment">
											<c:if test="${not empty taxCertificate}">
												<img src="${pageContext.request.contextPath}/attachment/download/${taxCertificate.fjid00}" style="width:100%" title="税务登记证"/>
											</c:if>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="blank10"></div>
					
					<c:choose>
						<c:when test="${organ.description==organ.description_tmp}">
							<div class="easyui-panel" data-options="title:'企业简介',height:100" style="overflow:hidden;">
								${organ.description}
							</div>
						</c:when>
						<c:otherwise>
							<div class="easyui-panel" data-options="title:'企业简介',height:100" style="overflow:hidden;">
								${organ.description_tmp}
							</div>
						</c:otherwise>
					</c:choose>
					<div class="blank10"></div>
					<c:choose>
						<c:when test="${organ.businessScope==organ.businessScope_tmp}">
							<div class="easyui-panel" data-options="title:'业务范围',height:100" style="overflow:hidden;">
								${organ.businessScope}
							</div>
						</c:when>
						<c:otherwise>
							<div class="easyui-panel" data-options="title:'业务范围',height:100" style="overflow:hidden;">
								${organ.businessScope_tmp}
							</div>
						</c:otherwise>
					</c:choose>					
					
					<div class="blank10"></div>
					<div class="easyui-panel" data-options="title:'审核意见',height:100" style="overflow:hidden;">
						<textarea id="nopassReason" name="nopassReason" style="width:100%;height:100%;"></textarea>
					</div>
					<div class="blank10"></div>
					<input type="button" id="pass" class="button orange" value="审核通过" />
					<input type="button" id="nopass" class="button blue" value="审核不通过"/>
				</form:form>
			</div>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>