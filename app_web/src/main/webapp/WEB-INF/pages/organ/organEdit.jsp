<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Constants.PLATFORM_NAME%></title>
<jsp:include page="/common/link.jsp" />
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
			机构信息维护信息维护
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<form:form method="post" action="${pageContext.request.contextPath}/organ/saveOrUpdateOrgan" commandName="organ">
					<form:hidden path="id" />
					<table width="100%" style="table-layout:fixed;">
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">单位名称：</td>
							<td style="width:220px;"><form:input path="ztmc00" cssClass="inputxt" datatype="s1-100" errormsg="单位名称最多50个中文字符！" /></td>
							<td style="width:180px;"><span class="Validform_checktip"><form:errors path="ztmc00" cssClass="Validform_wrong" /></span></td>
							<td class="need">*</td>
							<td style="width:100px;">行政区划：</td>
							<td style="width:220px;">${organ.region}<form:input path="region" cssClass="inputxt easyui-combotree" datatype="s1-100" errormsg="请选择项目所属行政区划！"
									data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=REGION&fetchItemCode=${organ.region}&includeRoot=false'" /></td>
							<td style="width:180px;"><div class="Validform_checktip">
									<form:errors path="region" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>组织机构代码：</td>
							<td><form:input path="ztdm00" cssClass="inputxt" datatype="s1-100" nullmsg="请输入组织机构代码！" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="ztdm00" cssClass="Validform_wrong" />
								</div></td>
							<td class="need">*</td>
							<td>负责人：</td>
							<td>${organ.principal.userName}</td>
							<td><div class="Validform_checktip"></div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>联系电话：</td>
							<td><form:input path="phone" cssClass="inputxt" datatype="s1-100" nullmsg="请输入联系电话！" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="phone" cssClass="Validform_wrong" />
								</div></td>
							<td class="need">*</td>
							<td>联系地址：</td>
							<td><form:input path="address" cssClass="inputxt" datatype="s" errormsg="请输入联系地址！" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="address" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>国别地区：</td>
							<td><form:select path="gbdq00" cssClass="inputxt" datatype="s1-100" nullmsg="请输入国别地区！">
									<form:option value="" label="请选择" />
									<form:options items="${util:dictionaryTree('COUNTRY',false)}" itemValue="itemCode" itemLabel="itemName" />
								</form:select></td>
							<td><div class="Validform_checktip">
									<form:errors path="gbdq00" cssClass="Validform_wrong" />
								</div></td>
							<td class="need">*</td>
							<td>单位性质：</td>
							<td><form:input path="dwxz00" datatype="*" nullmsg="请选择单位性质！" cssClass="inputxt easyui-combotree" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=OWNERSHIP&fetchItemCode=${organ.dwxz00}&includeRoot=false'" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="dwxz00" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>营业执照号码：</td>
							<td><form:input path="yyzzhm" cssClass="inputxt" datatype="s" errormsg="请输入营业执照号码！" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="yyzzhm" cssClass="Validform_wrong" />
								</div></td>
							<td class="need">*</td>
							<td>税务登记号：</td>
							<td><form:input path="swdjh0" cssClass="inputxt" datatype="s" errormsg="请输入税务登记号！" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="swdjh0" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>行业类型：</td>
							<td><form:input path="industry" cssClass="inputxt easyui-combotree" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=INDUSTRY&fetchItemCode=${organ.industry}&includeRoot=false'" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="industry" cssClass="Validform_wrong" />
								</div></td>
							<td class="need">*</td>
							<td><!-- 资信等级： --></td>
							<td><%-- <form:select path="zxdj00" datatype="*" nullmsg="请选择资信等级！">
									<form:option value="1">请选择</form:option>
								</form:select> --%></td>
							<td><div class="Validform_checktip">
									<%-- <form:errors path="zxdj00" cssClass="Validform_wrong" /> --%>
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>开户银行：</td>
							<td><form:input path="khyh00" cssClass="inputxt" datatype="s" errormsg="请输入开户银行！" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="khyh00" cssClass="Validform_wrong" />
								</div></td>
							<td class="need">*</td>
							<td>基本账户账号：</td>
							<td><form:input path="jbzhzh" cssClass="inputxt" datatype="s" errormsg="请输入基本账户账号！" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="jbzhzh" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>注册资本：</td>
							<td><form:input path="zczb00" cssClass="inputxt" datatype="n" errormsg="请输入注册资本！" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="zczb00" cssClass="Validform_wrong" />
								</div></td>
							<td class="need">*</td>
							<td>注册资本币种：</td>
							<td><form:select path="zczbbz" datatype="*" nullmsg="请选择注册资本币种！">
									<form:option value="1">请选择</form:option>
									<form:options items="${util:dictionaryTree('CURRENCY',false)}" itemLabel="itemName" itemValue="itemCode" />
								</form:select></td>
							<td><div class="Validform_checktip">
									<form:errors path="zczbbz" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>注册资本单位：</td>
							<td><form:select path="zczbdw" datatype="*" nullmsg="请选择注册资本单位！">
									<form:option value="1">请选择</form:option>
									<form:options items="${util:dictionaryTree('JEDWDM',false)}" itemLabel="itemName" itemValue="itemCode" />
								</form:select></td>
							<td><div class="Validform_checktip">
									<form:errors path="zczbdw" cssClass="Validform_wrong" />
								</div></td>
							<td class="need">*</td>
							<td>机构类型：</td>
							<td><form:select path="organRoleList" multiple="false" datatype="*" nullmsg="请选择机构类型！">
									<option value="">请选择</option>
									<form:options items="${organRoleService.retrieveOrganRole()}"></form:options>
								</form:select></td>
							<td><div class="Validform_checktip">
									<form:errors path="organRoleList" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>邮政编码：</td>
							<td><form:input path="zipCode" cssClass="inputxt" datatype="p" nullmsg="请输入邮政编码！" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="zipCode" cssClass="Validform_wrong" />
								</div></td>
							<td class="need">*</td>
							<td>企业邮箱：</td>
							<td><form:input path="email" cssClass="inputxt" datatype="e" errormsg="请输入电子邮箱！" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="email" cssClass="Validform_wrong" />
								</div></td>
						</tr>
					</table>
					<div class="blank10"></div>
					<input type="submit" class="button orange" value="保存" />
					<input type="button" class="button blue" value="返回" onclick="window.location='${pageContext.request.contextPath}/organ/user_list'" />
				</form:form>
			</div>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>