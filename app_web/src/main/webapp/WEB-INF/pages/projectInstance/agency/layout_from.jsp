<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" jgrowl="true"/>
<script type="text/javascript">
//导出数据
function myexport(){
	var projectInstanceId = "${projectInstanceId}";
	var url = "${pageContext.request.contextPath}/projectInstance/Export?projectInstanceId="+projectInstanceId;
	window.location.href=url; 
}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			代理招标管理
			<code>&gt;</code>
			标段详情
		</div>
	</div>
	<div class="block">
		<a href="javascript:myexport();">
           <span class="easyui-linkbutton" data-options="iconCls:'myicon-page_excel'">导出数据</span>
        </a>
		<table class="mytableStyle"  data-options="title:'标段详情',striped:true">
			<thead>
				<tr>
					<th data-options="title:'项目名称',field:'projectItemName'">项目名称</th>
					<th data-options="title:'标段名称',field:'projectItemName'">标段名称</th>
					<th data-options="title:'投标人',field:'organBName'">投标人</th>
					<th data-options="title:'投标人',field:'pay_status'">标书费用</th>
					<th data-options="title:'投标人',field:'fjid00'">投标文件</th>
					<th data-options="title:'投标人',field:'fjid00'">保证金情况</th>
					<th data-options="title:'投标人',field:'fjid00'">保证金凭证</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="item">
					<tr>
						<c:if test="${item[2]==1}">
							<td rowspan="${item[1] gt 0?item[1]:1}">${item[0]}</td>
						</c:if>
						<c:if test="${item[5]==1}">
							<td rowspan="${item[4] gt 0?item[4]:1}">${item[3]}</td>
						</c:if>
						<td>${item[6]}</td>
						<td>${item[7]}</td>
						<td>${item[8]}</td>
						<td>${item[14]}</td>
						<td>${item[9]}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="blank10"></div>
	<%-- <jsp:include page="/common/bottom.jsp"/> --%>
</body>
</html>