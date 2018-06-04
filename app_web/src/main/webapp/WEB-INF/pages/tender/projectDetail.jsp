<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.yjbm {
	font-weight: bold;
	color: orange;
	font-size: 12px;
}
</style>
<script type="text/javascript">
	function tbbm(id, name) {
		$.messager.confirm('系统提示', '确定报名参加 [' + name + '] 标段投标吗？', function(r) {
			if (r) {
				$.ajax({
					url : '${pageContext.request.contextPath}/baomming?id=' + id,
					type : 'post',
					dataType : 'json',
					success : function(data) {
						$('#bm').parent().html("<span class='yjbm'>已报名</span>");
						$.messager.alert('系统提示', data.msg);
					}
				});
			}
		});
	}

	function valid() {
		if ($("input[name='item_ids']:checked").length > 0) {
			return true;
		}
		$.messager.alert("系统提示", "请先选择要投标的标段！");
		return false;
	}

	function checkAll() {
		if ($("input[name='all']:checked").length > 0) {
			$("input[name='item_ids']").each(function() {
				$(this).prop("checked", true);
			});
		} else {
			$("input[name='item_ids']").each(function() {
				$(this).prop("checked", false);
			});
		}
	}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标报名
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class='tableTitle'>招标项目信息</div>
			<form action='${pageContext.request.contextPath}/bmForm' method='post' onsubmit="return valid();">
				<input type='hidden' name='id' value='${projectInstance.id}' />
				<table class='mytableStyle'>
					<tr>
						<th width="120px">所属项目</th>
						<td colspan='3'>${projectInstance.project.xmmc00}</td>
					</tr>
					<tr>
						<th>招标项目编号:</th>
						<td>${projectInstance.zbxmbh}</td>
						<th>招标项目名称:</th>
						<td>${projectInstance.zbxmmc}</td>
					</tr>
					<tr>
						<th width="120px">招标人</th>
						<td>${projectInstance.project.organ.ztmc00}</td>
						<th width="120px">代理机构</th>
						<td>${projectInstance.organ.ztmc00}</td>
					</tr>
					<tr>
						<th>招标方式：</th>
						<td>${util:dictionary('ZBFS00',projectInstance.zbfs00)}</td>
						<th width="120px">招标组织形式：</th>
						<td>${util:dictionary('ZBZZXS',projectInstance.zbzzxs)}</td>
					</tr>
					<tr>
						<th width="120px">招标内容与范围</th>
						<td colspan='3'>${projectInstance.nryfw0}</td>
					</tr>
				</table>
				<div class="blank10"></div>
				<div class='tableTitle'>项目标段列表</div>
				<table class="mytableStyle">
					<thead>
						<tr>
							<th>标段</th>
							<th>申请状态</th>
							<th>标书费用</th>
							<th>投标文件</th>
							<th>投标保证金</th>
							<th>投标状态</th>
							<th>投标截止时间</th>
							<th>开标时间</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${tenderList}" var="item">
							<tr>
								<td>${item[0]}</td>
								<td>${item[7]}</td>
								<td>(<strong class="price">¥<em id="J_SmallTotal">${projectItemService.getProjectPackageHavePrice(item[2]).price}</em></strong>)&nbsp;&nbsp;${item[1]}</td>
								<td><c:choose><c:when test="${item[9]=='进行中'}"><a href="${pageContext.request.contextPath}/bidReuploadEdit?tenderItemId=${item[8]}">${item[3]}</a></c:when><c:otherwise>${item[3]}</c:otherwise></c:choose></td>
								<td><c:choose><c:when test="${item[9]=='进行中'}"><a href="${pageContext.request.contextPath}/bidReuploadEdit?tenderItemId=${item[8]}">${item[4]}</a></c:when><c:otherwise>${item[4]}</c:otherwise></c:choose></td>
								<td>${item[9]}</td>
								<td>${item[5]}</td>
								<td>${item[6]}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="blank10"></div>
				<input type='button' class="button red" onclick='window.history.go(-1)' value='返回' />
			</form>
		</div>
	</div>
</body>
</html>
