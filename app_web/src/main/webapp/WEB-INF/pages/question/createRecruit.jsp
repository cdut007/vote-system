<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" easyui="true"/>
<script type="text/javascript">

</script>
</head>
  <body>
    <jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				澄清与答疑
				<code>&gt;</code>
				澄清文件详情
				<code>&gt;</code>
				查看回执
			</div>
			<div class="block">
			<%-- <div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
				<div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;" id="receiptContentContainer">${receipts.receiptContent}</div>
			</div> --%>
			<table class="mytableStyle" data-options="title:'回执详情',striped:true">
				<thead>
					<tr>
						<th data-options="title:'标段名称',field:'PROJECT_INSTANCE_NAME'">项目名称</th>
						<th data-options="title:'标段名称',field:'PROJECT_INSTANCE_NAME'">标段名称</th>
						<th data-options="title:'标段名称',field:'PROJECT_INSTANCE_NAME'">澄清时间</th>
						<th data-options="title:'投标人',field:'project_item_id'">投标人</th>
						<th data-options="title:'是否回执',field:'isReceipt'">是否回执</th>
						<th data-options="title:'是否回执',field:'isReceipt'">回执时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="item">
						<tr>
							<c:if test="${item[7]==1}">
								<td rowspan="${item[6]>0?item[6]:1}">${item[1]}</td>
								<td rowspan="${item[6]>0?item[6]:1}">${item[3]}</td>
								<td rowspan="${item[6]>0?item[6]:1}"><fmt:formatDate value="${item[5]}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							</c:if>
							<td>${item[9]}</td>
							<td>
								<c:choose>
									<c:when test="${not empty item[10]}">
										<a href="${pageContext.request.contextPath}/question/createRecepit1?id=${item[10]}" target="_blank" style='color:blue;'>${item[11]}</a>
									</c:when>
									<c:otherwise>
										${item[11]}
									</c:otherwise>
								</c:choose>
							</td>
							<td><fmt:formatDate value="${item[12]}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
  </body>
</html>
