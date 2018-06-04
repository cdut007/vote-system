<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" import="java.math.BigDecimal"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<style type="text/css">
</style>
<jsp:include page="/common/link.jsp" />
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			企业账户查询
		</div>
		<c:choose>
			<c:when test="${empty mainAccountInfo}">
				您未签约交通银行管理账户！
			</c:when>
			<c:otherwise>
				<table class="mytableStyle">
					<tr>
						<th width="150px">户名</th>
						<td>${mainAccountInfo.accountName}</td>
					</tr>
					<tr>
						<th>账号</th>
						<td>${mainAccountInfo.accountNumber}</td>
					</tr>
					<tr>
						<th>币种</th>
						<td>${mainAccountInfo.currency}</td>
					</tr>
					<tr>
						<th>余额</th>
						<td>${mainAccountInfo.sjAmt}</td>
					</tr>
					<tr>
						<th>可用余额</th>
						<td>${mainAccountInfo.kyAmt}</td>
					</tr>
					<tr>
						<th>创建时间</th>
						<td>${mainAccountInfo.openAccountDate}</td>
					</tr>
					<tr>
						<th>开户行</th>
						<td>${mainAccountInfo.openBankName}</td>
					</tr>
				</table>
			</c:otherwise>
		</c:choose>

	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>
