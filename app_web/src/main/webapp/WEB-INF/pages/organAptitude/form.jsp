<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:主体资质信息表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/link.jsp"></jsp:include>
</head>
<body>
<div class='block' style='height:40px;'></div>
<div class="block">

<div class="right_top_div">当前位置: 主体资质管理 &gt; 新增</div>
<div class="usBox">
<form:form  action="${pageContext.request.contextPath}/t_organ_zz/saveOrUpdate" method="post" commandName="t_organ_zz">
	<form:hidden path="id" />
	<form:hidden path="organ.id" />
	<table width='100%'>
		<tr>
			<td class="need" style="width:10px;">*</td>
			<th width="120px">主体代码</th>
			<td><form:input path="ztdm00" cssClass="inputxt" datatype="s1-36" nullmsg="主体代码不能为空！" errormsg="主体代码最多36个字符！" /></td>
			<td><div class="infostyle">
				<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
			</div></td>
			<td class="need" style="width:10px;">*</td>
			<th width="130px">资质序列、行业和专业类别</th>
			<td><form:input path="zzxl00" cssClass="inputxt" datatype="s1-6" nullmsg="资质序列、行业和专业类别不能为空！" errormsg="资质序列、行业和专业类别最多6个字符！" /></td>
			<td><div class="infostyle">
				<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
			</div></td>
		</tr>
		<tr>
			<td class="need" style="width:10px;">*</td>
			<th>资质等级</th>
			<td>
			<form:select path="zzdj00">
					<form:option value="">请选择</form:option>
					<form:options items="${util:dictionaryTree('ZZDJDM',false)}"  itemValue="itemCode" itemLabel="itemName"></form:options>
				</form:select></td>
			<td><div class="infostyle">
				<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
			</div></td>
			<td class="need" style="width:10px;">*</td>
			<th>资质证书编号</th>
			<td><form:input path="zzzsbh"  cssClass="inputxt" datatype="s1-6" nullmsg="资质证书编号不能为空！"/></td>
			<td><div class="infostyle">
				<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
			</div></td>
		</tr>
		<tr>
			<td style="width:10px;"></td>
			<th>信息申报责任人</th>
			<td><form:input path="xxsbr0" cssClass="validate[maxSize[3]]" readonly="readonly"/></td>
			<th></th>
			<th></th>
			<th>附件照片</th>
			<td><input type="file" name="fj" /></td>
		</tr>
	</table>
	<div style='width:100%;text-align:center;padding-top:30px;'>
		<input type="submit" class='button red'  value="保存" />
		<input type="button" class='button red' value="返回" onclick="window.location='${pageContext.request.contextPath}/t_organ_zz/list';" />
	</div>
</form:form>
</div>
</div>
</body>
</html>
