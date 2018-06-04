<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="request" value="${pageContext.request}" />
<c:set var="id" value="${request.getParameter('id')}"></c:set>
<c:set var="organ" value="${organService.createOrganQuery().organId(id).singleResult()}" />
<jsp:useBean id="searchModel" class="com.mhb.common.model.SearchModel"/>
<jsp:setProperty property="organId" name="searchModel" value="${organ.id}"/>
<c:set var="organAptitudeList" value="${aptitudeService.retrieveAptitudeWithAttachment(searchModel)}" />
<c:set value="${organService.getOrganizationCodeCertificate(organ.id)}" var="organizationCodeCertificate"></c:set>
<c:set value="${organService.getBusinessLicense(organ.id)}" var="businessLicense"></c:set>
<c:set value="${organService.getTaxCertificate(organ.id)}" var="taxCertificate"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
pre {
	white-space: pre; /* CSS2 */
	white-space: -moz-pre-wrap; /* Mozilla */
	white-space: -hp-pre-wrap; /* HP printers */
	white-space: -o-pre-wrap; /* Opera 7 */
	white-space: -pre-wrap; /* Opera 4-6 */
	white-space: pre-wrap; /* CSS 2.1 */
	white-space: pre-line; /* CSS 3 (and 2.1 as well, actually) */
	word-wrap: break-word; /* IE */
}
</style>
<script type="text/javascript">
	$(function() {
		laypage({
			cont : $('#pagingBar'), //容器。值支持id名、原生dom对象，jquery对象,
			pages : ${t_zbwtdl_page.pages}, //总页数
			curr : ${t_zbwtdl_page.page}, //初始化当前页
			skip : true, //是否开启跳页
			skin : '#AF0000',
			groups : 3,
			jump : function(e, first) {
				if (!first) { //一定要加此判断，否则初始时会无限刷新
					location.href = ctx + "/organ/organizationADetail?id=${organ.id}&page=" + e.curr + "&taskId=${taskId}";
				}
			}//连续显示分页数
		});
	});
</script>
<script>
	$(function() {
		$('#wtzbSubmit').click(function() {
			$.messager.confirm("系统提示", "确认由[${organ.ztmc00}]代理招标吗？", function(r) {
				if (r) {
					$('#wtdlForm').attr('action', '${pageContext.request.contextPath}/workflow/completeForm');
					$('#wtdlForm').submit();
				}
			});
		});
		$('#goback').click(function() {
			window.history.go(-1);
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${pageContext.request.contextPath}/">首页</a>
			<code>&gt;</code>
			委托代理机构
		</div>
		<div class="usBox">
			<div class="easyui-panel" data-options="title:'基本信息'" style="padding:10px;">
				<table class="mytable" style="width:100%;font-size:12px;line-height:30px;padding-left:5px">
					<tr>
						<td width="80px">公司名称</td>
						<td width="150px">
							<h1>${organ.ztmc00}</h1>
						</td>
						<td rowspan="2" colspan="2">
							<img src="${pageContext.request.contextPath}/attachment/download/${organ.logo.path}" style="width:80px;height:80px;float:left;" onerror="this.src='/resources/portal/yc-images/logo_no.jpg'" />
						</td>
					</tr>
					<tr>
						<td width="80px">负责人</td>
						<td width="40%">${organ.principal.userName}</td>
					</tr>
					<tr>
						<td width="80px">组织机构代码</td>
						<td width="40%"><a href="${pageContext.request.contextPath}/attachment/download/${organizationCodeCertificate.path}" target="_blank">${organ.ztdm00}</a></td>
					</tr>
					<tr>
						<td>国别/地区</td>
						<td>${util:dictionary('COUNTRY',organ.gbdq00)}</td>
						<td>单位性质</td>
						<td>${util:dictionary('OWNERSHIP',organ.dwxz00)}</td>
					</tr>
					<tr>
						<td>行业</td>
						<td>${util:dictionary('INDUSTRY',organ.industry)}</td>
						<td>行政区域</td>
						<td>${util:dictionaryPath('REGION',organ.region)}</td>
					</tr>
					<tr>
						<td>营业执照号码</td>
						<td><a href="${pageContext.request.contextPath}/attachment/download/${businessLicense.path}" target="_blank">${organ.yyzzhm}</a></td>
						<td>税务登记号</td>
						<td><a href="${pageContext.request.contextPath}/attachment/download/${taxCertificate.path}"  target="_blank">${organ.swdjh0}</a></td>
					</tr>
					<tr>
						<td><!-- 资信等级 --></td>
						<td><%-- ${organ.zxdj00} --%></td>
						<td>注册资本</td>
						<td>${organ.zczb00}</td>
					</tr>
					<tr>
						<td>联系电话</td>
						<td>${organ.phone}</td>
						<td>联系地址</td>
						<td>${organ.address}</td>
					</tr>
					<tr>
						<td>邮政编码</td>
						<td>${organ.zipCode}</td>
						<td>电子邮箱</td>
						<td>${organ.email}</td>
					</tr>
				</table>
			</div>
			<c:if test="${not empty organ.description}">
				<div class="blank10"></div>
				<div class="easyui-panel" data-options="title:'企业简介'" style="padding:10px;">${organ.description}</div>
			</c:if>
			<c:if test="${not empty organ.businessScope}">
				<div class="blank10"></div>
				<div class="easyui-panel" data-options="title:'业务范围'" style="padding:10px;">${organ.businessScope}</div>
			</c:if>
			<c:if test="${not empty organAptitudeList}">
				<div class="blank10"></div>
				<div class="easyui-panel" data-options="title:'资质证书'" style="padding:10px;">
					<c:forEach items="${organAptitudeList}" var="item">
						<img title="${item}" src="${pageContext.request.contextPath}/attachment/download/${item.attachmentList[0].path}" style="width:225px;height:186px;" />
					</c:forEach>
				</div>
			</c:if>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>