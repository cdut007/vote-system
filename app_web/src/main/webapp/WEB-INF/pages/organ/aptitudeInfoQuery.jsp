<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%--
添加修改用户信息
 --%>
 <div class="usBox">
 <div class="clearfix">
<form:form method="post" action="" commandName="aptitude">
	<form:hidden path="id" />
	
	<table width="100%" style="table-layout:fixed;">
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">企业名称：</td>
			<td> ${aptitude.organ.ztmc00}</td>
			<td class="need">*</td>
			<td style="width:100px;">信息申报人：</td>
			<td>${aptitude.xxsbr0}</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">资质序列：</td>
			<td>${util:dictionary('ZZSEQUENCE',aptitude.zzsequence)}</td>
			<td class="need">*</td>
			<td style="width:100px;">资质行业：</td>
			<td>${util:dictionary('ZZINDUSTRY',aptitude.zzindustry)}</td>
		</tr>
		<tr>
		<td class="need">*</td>
			<td style="width:100px;">专业类别：</td>
			<td>${util:dictionary('ZZPROFESSIONAL',aptitude.zzprofessional)}</td>
			<td class="need">*</td>
			<td style="width:100px;">资质等级：</td>
			<td>${util:dictionary('ZZDJDM',aptitude.zzdj00)}</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">资质名称：</td>
			<td>${aptitude.zzname}</td>
			<td class="need">*</td>
			<td style="width:100px;">资质证书编号：</td>
			<td>${aptitude.zzzsbh}</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">起始时间：</td>
			<td>${aptitude.startTime}</td>
			<td class="need">*</td>
			<td style="width:100px;">结束时间：</td>
			<td>${aptitude.endTime}</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>资质附件：</td>
			<td	colspan="4"><div id="aptitudediv" style="display: none;">
					<c:forEach items="${aptitude.attachmentList}" var="fileItem" varStatus="s">
						<img style="width:150px;height:80px; border:1px solid #D1D1D1" src="${pageContext.request.contextPath}/aptitude/showpic?id=${fileItem.fjid00}" id="aptitudeImg" />
					</c:forEach>
				</div> <br /> 
		    </td>
		</tr>
		
	</table>
</form:form>
</div>
</div>

<script type="text/javascript">
	$(function() {//上传资质
		if ("${aptitude.id}") {
			$("#aptitudediv").show();
		}	
	});
</script>