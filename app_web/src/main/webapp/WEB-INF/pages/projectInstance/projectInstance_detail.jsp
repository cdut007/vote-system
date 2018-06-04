<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>项目详细信息</title>
<jsp:include page="/common/link.jsp" />
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			项目详细信息
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class="tableTitle2">招标项目详细信息</div>
			<form id="projectInstance_form_detail" method="post">
				<table class="mytableStyle" style="width:100%;">
					<tr>
						<th width="120px">招标项目名称</th>
						<td colspan='3'>${projectInstance.zbxmmc}</td>
					</tr>
					<tr>
						<th width="120px">所属项目</th>
						<td width='300px;'>${projectInstance.project.xmmc00}</td>
						<th width="120px">招标项目编号</th>
						<td>${projectInstance.zbxmbh}</td>
					</tr>
					<tr>
						<th width="120px">招标人</th>
						<td></td>
						<th width="120px">代理机构</th>
						<td>${projectInstance.organ.ztmc00}</td>
					</tr>
					<tr>
						<th width="120px">招标方式</th>
						<td>${projectInstance.zbfs00}</td>
						<th width="120px">组织形式</th>
						<td>${projectInstance.zbzzxs}</td>
					</tr>
					<tr>
						<th width="120px">监督部门名称</th>
						<td>${projectInstance.jdbmmc}</td>
						<th width="120px">监督部门代码</th>
						<td>${projectInstance.jdbmdm}</td>
					</tr>
					<tr>
						<th width="120px">审核部门名称</th>
						<td>${projectInstance.shbmmc}</td>
						<th width="120px">审核部门代码</th>
						<td>${projectInstance.shbmdm}</td>
					</tr>
					<tr>
						<th width="120px">公共服务平台标识</th>
						<td>${projectInstance.ggfwbs}</td>
						<th width="120px">申报责任人</th>
						<td>${projectInstance.zbzrr0}</td>
					</tr>
					<tr>
						<th width="120px">招标内容与范围</th>
						<td colspan='3' style="line-height:30px;">${projectInstance.nryfw0}</td>
					</tr>
				</table>
			</form>
			<div class="blank10"></div>
			<div class="tableTitle2">项目标段列表</div>
			<table class="mytableStyle">
				<c:forEach items="${projectInstance.projectItemList}" var="item" varStatus="status">
					<tr>
						<td width='30px'>标段${status.count}</td>
						<td>
							标段编号：${item.bdbh00} 标段名称：${item.bdmc00}<br /> 标段分类代码：${item.bdfldm} 标段合同估算价：${item.bdbh00}
							<%--标段状态：${item.bdzt00}--%>
							${item.bdbh00}<br /> 标段内容：${item.bdnr00}<br /> 投标资格条件：${item.tbzgtj}
						</td>
					</tr>
				</c:forEach>
				<c:if test="${projectInstance.projectItemList==null}">
					<tr>
						<td colspan='2'>暂无标段！</td>
					</tr>
				</c:if>
			</table>
			<br />
			<div style="text-align: right">
				<input type='button' class="button red" value='关 闭' onclick='window.close()' />
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
