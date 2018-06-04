<%@page pageEncoding="utf-8" import="com.mhb.common.Constants " language="java" contentType="text/html; charset=utf-8 "%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:useBean id="principal" class="com.mhb.base.entity.TBUser"/>
<jsp:setProperty property="gender" name="principal" value="1"/>
<jsp:setProperty property="principal" name="organ" value="${principal}"/>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
机构注册
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" plupload="true"></sys:link> 
<script type="text/javascript" src="/resources/page/regist.js"></script>
<script type="text/javascript">
$(function(){
/* 	$("#tyshxydm").val("");
	$("#tyshxydm").prop("disabled",true);
	$("#tyshxydm").validatebox("disableValidation"); */
	
	$("[name='organRoleList']:checked").change();
	
	
/* 	$("#sanZheng").change(function(){
		if($("#sanZheng").is(":checked")){
			$("#yyzzhm").val("");
			$("#yyzzhm").prop("disabled",true);
			$("#yyzzhm").validatebox("disableValidation");
			
			$("#ztdm00").val("");
			$("#ztdm00").prop("disabled",true);
			$("#ztdm00").validatebox("disableValidation");
			
			$("#swdjh0").val("");
			$("#swdjh0").prop("disabled",true);
			$("#swdjh0").validatebox("disableValidation");
			
			
			
			$("#tyshxydm").prop("disabled",false);
			$("#tyshxydm").validatebox("enableValidation");
		}else{
			$("#yyzzhm").prop("disabled",false);
			$("#yyzzhm").validatebox("enableValidation");
			$("#ztdm00").prop("disabled",false);
			$("#ztdm00").validatebox("enableValidation");
			$("#swdjh0").prop("disabled",false);
			$("#swdjh0").validatebox("enableValidation");
			
			$("#tyshxydm").val("");
			$("#tyshxydm").prop("disabled",true);
			$("#tyshxydm").validatebox("disableValidation");
		}
	}); */
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank"></div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<form:form id="registerForm" method="post" action="${pageContext.request.contextPath}/regist" modelAttribute="organ" onsubmit="return $(this).form('validate');">
					<h3 class="tableTitle">
						<span>机构信息</span>
					</h3>
					<table style="table-layout:fixed;margin:0 auto;">
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">单位名称：</td>
							<td style="width:220px;">
								<form:input path="ztmc00" id="ztmc00" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'所填企业名称必须与营业执照一致',validType:['length[0,25]','noUseOrganName[&quot;&quot;]'],required:true" />
							</td>							
							<td style="width:180px;">
								<span class="Validform_checktip"><form:errors path="ztmc00" cssClass="Validform_wrong" /></span>
							</td>							
							<td class="need">*</td>
							<td style="width:100px;">行业类型：</td>
							<td style="width:220px;">
								<form:input path="industry" cssClass="inputxt easyui-combotree" data-options="missingMessage:'请选择行业类别',required:true,url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=INDUSTRY&fetchItemCode=${organ.industry}&includeRoot=false'" />
							</td>
							
							<td style="width:180px;">
								<div class="Validform_checktip">
									<form:errors path="industry" cssClass="Validform_wrong" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>国别地区：</td>
							<td>
								<form:select path="gbdq00" cssClass="inputxt" datatype="s1-100" nullmsg="请输入国别地区！">
									<form:option value="" label="请选择" />
									<form:options items="${util:dictionaryTree('COUNTRY',false)}" itemValue="itemCode" itemLabel="itemName" />
								</form:select>
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="gbdq00" cssClass="Validform_wrong" />
								</div>
							</td>
							<td class="need">*</td>
							<td>单位性质：</td>
							<td>
								<form:input path="dwxz00" cssClass="inputxt easyui-combotree" data-options="missingMessage:'请选择单位性质',required:true,url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=OWNERSHIP&fetchItemCode=${organ.dwxz00}&includeRoot=false'" />
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="dwxz00" cssClass="Validform_wrong" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td >行政区划：</td>
							<td >
								<form:input path="region" cssClass="inputxt easyui-combotree" data-options="missingMessage:'请选择行政区划,本公司所在的省份',required:true,url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=REGION&fetchItemCode=${organ.region}&includeRoot=false'" />
							</td>
							<td >
								<div class="Validform_checktip">
									<form:errors path="region" cssClass="Validform_wrong" />
								</div>
							</td>
							<td class="need">*</td>
							<td>主体库联系人：</td>
							<td>
								<form:input id="ztklxr" path="ztklxr" cssClass="inputxt easyui-validatebox" datatype="s1-100" data-options="missingMessage:'请输入责任人的姓名',required:true" />
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="ztklxr" cssClass="Validform_wrong" />
								</div>
							</td>
						</tr>						
						<tr>
							<td class="need">*</td>
							<td >营业执照号码：</td>
							<td >
								<form:input id="yyzzhm" path="yyzzhm" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请输入营业执照号码  或 统一社会信用代码',validType:['noUseLicenseNo[&quot;&quot;]'],required:true" />
							</td>
							<td >
								<div class="Validform_checktip">
									<form:errors path="yyzzhm" cssClass="Validform_wrong" />
								</div>
							</td>
							<td class="need">*</td>
							<td>主体库联系<br/>电话：</td>
							<td>
								<form:input id="ztklxdh" path="ztklxdh" cssClass="inputxt  easyui-validatebox" datatype="s1-100"  data-options="missingMessage:'请输入联系电话！',required:true,validType:'MobileOrPhone'" />
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="ztklxdh" cssClass="Validform_wrong" />
								</div>
							</td>
						</tr>
						<tr>
							<td  class="need">*</td>
							<td >组织机构代码：</td>
							<td >
								<form:input path="ztdm00" id="ztdm00" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请输入组织机构代码 或 统一社会信息代码',validType:['noUseOrganNo[&quot;&quot;]'],required:true" />
							</td>
							<td >
								<div class="Validform_checktip">
									<form:errors path="ztdm00" cssClass="Validform_wrong" />
								</div>
							</td>	
							<td class="need">*</td>
							<td>主体库注册<br/>时间：</td>
							<td>
								<%-- <form:input path="address" cssClass="inputxt easyui-validatebox" datatype="s"  data-options="missingMessage:'请输入本单位所在地的地址',required:true" /> --%>
								<input type="text" id="ztkzcsj" value="<fmt:formatDate value="${ztkzcsj}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />" name="ztkzcsj" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" />
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="ztkzcsj" cssClass="Validform_wrong" />
								</div>
							</td>
						</tr>
						<tr >
							<td class="need">*</td>
							<td >税务登记号：</td>
							<td >
								<form:input id="swdjh0" path="swdjh0" cssClass="inputxt  easyui-validatebox" data-options="missingMessage:'请输入税务登记号 或 统一社会信用代码',validType:['noUseTaxNo[&quot;&quot;]'],required:true" />
							</td>
							<td >
								<div class="Validform_checktip">
									<form:errors path="swdjh0" cssClass="Validform_wrong" />
								</div>
							</td>
							<td class="need"></td>
							<td>邮政编码：</td>
							<td>
								<form:input path="zipCode" cssClass="inputxt easyui-validatebox" data-options="required:false,validType:'zipCode'" />
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="zipCode" cssClass="Validform_wrong" />
								</div>
							</td>						
						</tr>						
						<tr>
							<%-- <td class="need">*</td>
							<td >法人代码：</td>
							<td>
								<form:input id="FRDM" path="frdm" cssClass="inputxt easyui-validatebox" data-options="validType:'legalNo', missingMessage:'三证合一请输入统一社会信用代码；否则请输入组织机构代码',required:true" />
							</td>
							<td >
								<div class="Validform_checktip">
									<form:errors path="" cssClass="Validform_wrong" />
								</div>
							</td> --%>
							<td class="need">*</td>
							<td>企业邮箱：</td>
							<td>
								<form:input path="email" cssClass="inputxt  easyui-validatebox" datatype="e" errormsg="请输入电子邮箱！" data-options="missingMessage:'请输入本单位的电子邮箱',required:true,validType:'email'" />
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="email" cssClass="Validform_wrong" />
								</div>
							</td>
							<td class="need">*</td>
							<td>注册类型：</td>
							<td >
								<form:checkboxes path="organRoleList" items="${organRoleService.retrieveOrganRole()}" itemValue="id" itemLabel="roleName"/>
								<input type="text" class="easyui-validatebox for-validate" data-options="missingMessage:'请选择注册类型',required:true" style="width:0;border:none;" unselectable="on"/>
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="organRoleList" cssClass="Validform_wrong"/>
								</div>
							</td>
						</tr>
						
						<%-- <tr>
							<td class="need">*</td>
							<td>注册资本：</td>
							<td>
								<form:input path="zczb00" id="zczb00" cssClass="inputxt easyui-numberbox" data-options="missingMessage:'请输入注册资本',required:true" style="width:130px " />

								<form:select id="DW" path="zczbdw" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请输入注册单位',required:true" style="width:60px">
									<form:options items="${util:dictionaryTree('JEDWDM',false)}" itemLabel="itemName" itemValue="itemCode" />
								</form:select>
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="zczb00" cssClass="Validform_wrong" />
								</div>
							</td>							
							<td class="need">*</td>
							<td>注册资本币种：</td>
							<td>
								<form:select path="zczbbz" cssClass="easyui-validatebox" data-options="missingMessage:'请选择注册资本币种',required:true">
									<form:option value="">--请选择--</form:option>
									<form:options items="${util:dictionaryTree('CURRENCY',false)}" itemLabel="itemName" itemValue="itemCode" />
								</form:select>
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="zczbbz" cssClass="Validform_wrong" />
								</div>
							</td>							
						</tr> --%>
						<%-- <tr>
							<td class="need">*</td>
							<td>开户银行：</td>
							<td>
								<form:select path="khyh00" id="khyh00" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请选择开户银行',required:true">
									<form:option value="">--请选择--</form:option>
									<form:options items="${util:dictionaryTree('BANK',false)}" itemLabel="itemName" itemValue="itemCode"/>
								</form:select>
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="khyh00" cssClass="Validform_wrong" />
								</div>
							</td>
							<td class="need">*</td>
							<td>基本账户账号：</td>
							<td>
								<form:input path="jbzhzh" id="jbzhzh" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请输入本单位的基本账户帐号',required:true" />
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="jbzhzh" cssClass="Validform_wrong" />
								</div>
							</td>
						</tr> --%>
						<tr>
							<td class="need"></td>
							<td></td>
							<td colspan="6" style="padding:10px 0 18px 0;">
								<input type="button" class="button orange" value="验 证" onclick="verifyMain()"/>
							</td>
						</tr>
					</table>
					<div class="blank10"></div>
					<!-- <table id="aptitude-datagrid"></table>
					<div class="blank10"></div> -->
					<h3 class="tableTitle">
						<span>联系人信息</span>
					</h3>
					<table  style="table-layout:fixed;">
						<tr>
							<td class="need">*</td>
							<td style="width:100px">姓名：</td>
							<td style="width:220px">
								<form:input path="principal.userName" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请输入负责人的姓名',required:true" />
							</td>
							<td style="width:180px">
								<div class="Validform_checktip">
									<form:errors path="principal.userName" cssClass="Validform_wrong" />
								</div>
							</td>
							<td class="need">*</td>
							<td style="width:100px">性别：</td>
							<td style="width:220px">
								<form:radiobuttons path="principal.gender" items="${util:dictionaryTree('GENDER',false)}" itemValue="itemCode" itemLabel="itemName" />
							</td>
							<td style="width:180px">
								<div class="Validform_checktip">
									<form:errors path="principal.gender" cssClass="Validform_wrong" />
								</div>
							</td>	
						</tr>
						<tr>
							<td class="need">*</td>
							<td>联系电话：</td>
							<td>
								<form:input path="principal.phone" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请输入联系电话',required:true,validType:'mobileOrTelephone'" />
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="principal.phone" cssClass="Validform_wrong" />
								</div>
							</td>
							<td class="need">*</td>
							<td>身份证号：</td>
							<td>
								<form:input path="principal.identityNo" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请输入身份证号',required:true,validType:['idcardNo','noUseIdcardNo[&quot;&quot;]']"/>
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="principal.identityNo" cssClass="Validform_wrong" />
								</div>
							</td>							
						</tr>
						<tr>
							<td class="need">*</td>
							<td>登录帐号：</td>
							<td>
								<form:input path="principal.loginName" cssClass="inputxt easyui-validatebox" id="loginName" data-options="missingMessage:'请输入注册帐号',required:true,validType:['regUserName','noUseLoginName']"/>
							</td>
							<td>
								<div class="Validform_checktip" id="valid_dlzh">
									<form:errors path="principal.loginName" cssClass="Validform_wrong" />
								</div>
							</td>
							<td class="need">*</td>
							<td>邮箱地址：</td>
							<td>
								<form:input path="principal.email" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请输入个人邮箱',required:true,validType:['email','remote[&quot;${pageContext.request.contextPath}/common/validateEmail&quot;,&quot;email&quot;]']"/>
							</td>
							<td>
								<div class="Validform_checktip" id="valid_yxdz">
									<form:errors path="principal.email" cssClass="Validform_wrong" />
								</div>
							</td>							
						</tr>
						<tr>
							<td class="need">*</td>
							<td>登录密码：</td>
							<td>
								<form:password id="password" path="principal.password" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请输入注册密码',required:true,validType:['regPassword','length[8,20]']" />
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="principal.password" cssClass="Validform_wrong" />
								</div>
							</td>
							<td class="need"></td>
							<td>QQ：</td>
							<td>
								<form:input path="principal.qq0000" cssClass="inputxt  easyui-validatebox" id="validateQQ" data-options="required:false,validType:'QQ'" />
							</td>
							<td>
								<div class="Validform_checktip">
									<form:errors path="principal.qq0000" cssClass="Validform_wrong" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>确认密码：</td>
							<td>
								<form:password id="passwordRepeat" path="principal.passwordRepeat" cssClass="inputxt  easyui-validatebox" data-options="missingMessage:'请再次输入注册密码',required:true,validType:['length[8,20]','regPassword','equals[&quot;#password&quot;,&quot;登录密码&quot;,&quot;确认密码&quot;]']"/>
							</td>
							<td>
								<div class="Validform_checktip" id="valid_passwordRepeat">
									<form:errors path="principal.passwordRepeat" cssClass="Validform_wrong" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td></td>
							<td><input type="checkbox" id="check" checked="checked" onclick="isAgree()"/>
								我同意<a href="${pageContext.request.contextPath}/agreement" target="_blank" >《用户使用协议》</a>
							</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td></td>
							<td colspan="6" style="padding:10px 0 18px 0;">
								<input type="submit" class="button orange" value="提 交" id="subm"/> 
								<input type="reset" class="button orange" value="重 置" />
							</td>
						</tr>
					</table>
					<c:forEach items="${organ.aptitudeId}" var="aptitudeId">
						<input type="hidden" value="${aptitudeId}" name="aptitudeId"/>
					</c:forEach>
				</form:form>
			</div>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
	<!-- <script type="text/javascript" src="/resources/player1/jquery172.js"></script> -->
	<script>
		function isAgree(){
			var is = document.getElementById("check");
			var bt = document.getElementById("subm");
			if(!is.checked){
				$.messager.alert('系统提示', '请同意《用户使用协议》!');
				bt.disabled=true;
			}else{
				bt.disabled=false;
			}
		}
		
		function verifyMain(){
			/* var ztdm = $("#ztdm00").val(); */
			/* var khyh = $("#khyh00").val(); */ 
			/* var jbzhzh = $("#jbzhzh").val();  */
			/* var zczb = $("#zczb00").val(); */ 
			/* var frdm = $("#FRDM").val(); */
			var ztmc = $("#ztmc00").val();
			var yyzzhm = $("#yyzzhm").val();
			var ztdm00 = $("#ztdm00").val();
			var swdjh0 = $("#swdjh0").val();			
			var ztklxr = $("#ztklxr").val();
			var ztklxdh = $("#ztklxdh").val();
			var ztkzcsj = $("#ztkzcsj").val();
			if(ztmc=="" || yyzzhm=="" || ztdm00=="" || swdjh0=="" || ztklxr=="" || ztklxdh=="" || ztkzcsj==""){
				$.messager.alert("系统提示","请输入完整信息！");
			}else{
			
				$.ajax({
					//async : true,
					url : ctx + "/common/checkMain",
					type : "post",
					dataType:"json",
					data : {
						/* ztdm : ztdm, */
						ztmc : encodeURI(ztmc),	/* 中文字符传到后台之前要先处理 */
						ztklxr : encodeURI(ztklxr),
						yyzzhm : yyzzhm,
						ztdm00 : ztdm00,
						swdjh0 : swdjh0,
						ztklxdh : ztklxdh,
						ztkzcsj : ztkzcsj,				
						},
					success : function(data){
						//alert(data.msg);	
						if(data.msg == "linkFail"){
							$.messager.alert("系统提示","连接主体库失败！");
						}/* else if(data.msg == "noztdm"){
							$.messager.alert("系统提示","组织机构代码不存在！");
						} */else if(data.msg == "nofrdm"){
							$.messager.alert("系统提示","未查询到企业信息！");
						}else if(data.msg == "noztmc"){
							$.messager.alert("系统提示","企业名称与主体代码不符！");
						}/* else if(data.msg == "nokhyh"){
							$.messager.alert("系统提示","开户银行不正确！");
						}*/else if(data.msg == "noztklxdh"){
							$.messager.alert("系统提示","主体库联系人电话不正确！");
						}else if(data.msg == "noztklxr"){
							$.messager.alert("系统提示","主体库联系人不匹配！");
						} else if(data.msg == "verifysuccess"){
							$.messager.alert("系统提示","验证通过！");							
						} 
					}
				});
			}
			
		}
		
		/* $(document).ready(function(){			
			$("#DW").change(function(){
				if($(this).children("option:selected").val() != 2){
					$(this).prop('selectedIndex', 1);
				}
			});
		}); */
		
		
	</script>
	<script type="text/javascript" src="/resources/player1/action.js"></script>
	<div class="helpbar" style="position:fixed;top:300px;left:20px;width:280px;height:305px;border:1px solid #c00000;">
		<div><h1 style="background:#c70000;color:#fff;font-size: 14px;">平台使用视频教程<a style="color:#fff;float:right" href="#" onclick="$(this).parents('.helpbar:first').remove();">关闭</a></h1></div>
		<div class="video" id="CuPlayer" style="margin-left:2px;">
			<% String videopath=(String)request.getParameter("videopath");if(videopath==null||"".equals(videopath)){videopath="/resources/video/firstRegister.mp4";}%>
			<SCRIPT LANGUAGE=JavaScript>
			//<!--
			/*
			* 跨平台方案X1（基于普通HTTP协议）=============
			* @param {Object} vID        ID
			* @param {Object} vWidth     播放器宽度设置
			* @param {Object} vHeight    播放器高度设置
			* @param {Object} vFile      播放器配置文件
			* @param {Object} vPlayer    播放器文件
			* @param {Object} vPic       视频缩略图
			* @param {Object} vCssurl    移动端CSS应用文件
			* @param {Object} vMp4url    视频文件地址
			
			* 跨平台方案说明=============================
			* 本实例请在IIS/Apache等网站环境下测试
			* 本实例实现HTTP协议下的跨平台
			* 本实例要求[视频文件地址]为mp4格式
			*/
			var vID        = ""; 
			var vWidth     = 278;            //播放器宽度设置
			var vHeight    = 200;               //播放器高度设置
			var vFile      = "/resources/player1/CuSunV2set.xml";  //播放器配置文件
			var vPlayer    = "/resources/player1/player.swf?v=2.5";//播放器文件
			var vPic       = "/resources/player/images/start.jpg";//视频缩略图
			var vCssurl    = "/resources/player/images/mini.css"; //移动端CSS应用文件
			
			//适配PC,安卓,iOS请用mp4文件
			var vMp4url    = "<%=videopath%>";  //视频文件地址
			//-->
			</SCRIPT> 
			<script class="CuPlayerVideo" data-mce-role="CuPlayerVideo" type="text/javascript" src="/resources/player1/CuSunX1.min.js"></script>
		</div>
		<div style="overflow: auto;height:68px;background:#000;color:#fff;font-weight:bold;padding:5px;border-top:1px solid #c00000;">
			<ul>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/firstRegister.mp4">首次注册</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/projectAndAgencySigned.mp4">委托方新建项目和委托合同的签订</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/theAgency.mp4">代理机构的使用</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/tenderingUnits.mp4">投标单位的使用</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/expertsUse.mp4">专家的使用</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/keyBindingUnbundling.mp4">数字证书的绑定和解除</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/tenderFeePayments.mp4">标书费用支付</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/winningCandidatePublic.mp4">中标候选人公示</a></li>
			</ul>
		</div>
	</div>
	<div class="helpbar" style="position:fixed;top:300px;right:20px;width:200px;height:200px; display:none;">
		<div style="position:relative;width:100%;">
			<img src="/resources/images/callcenter.png" style="width:100%;"/>
			<div style="position:absolute;top:235px;color:#fff;margin-left:70px;font-weight: bold;"><a style="color:#fff;" href="http://wpa.qq.com/msgrd?v=3&uin=907121461&site=qq&menu=yes">907121461</a></div>
			<div style="position:absolute;top:270px;color:#fff;margin-left:70px;font-weight: bold;"><a style="color:#fff;" href="http://wpa.qq.com/msgrd?v=3&uin=384580575&site=qq&menu=yes">384580575</a></div>
			<div style="position:absolute;top:330px;color:#fff;margin-left:70px;font-weight: bold;">0351-5288092 </div>
		</div>
	</div>
</body>
</html>