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
			企业管理
			<code>&gt;</code>
			角色管理
			<code>&gt;</code>
			添加角色
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<form:form  method="post" action="${pageContext.request.contextPath}/organ/saveOrUpdateQualification" commandName="organZzForm" enctype="multipart/form-data">
					<table width="100%" style="table-layout:fixed;">
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">资质等级：</td>
							<td><form:input path="zzdj00" cssClass="inputxt" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="zzzsbh" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>资质证书编号：</td>
							<td><form:input path="zzzsbh" cssClass="inputxt" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="zzzsbh" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>资质文件：</td>
							<td><input type="file" name="zzfile" class="inputxt" /></td>
							<td><div class="Validform_checktip">
									
								</div></td>
						</tr>
					</table>
					<form:errors path="zzfile" cssClass="Validform_wrong" />
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