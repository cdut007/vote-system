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
		if (confirm('确定报名参加 [' + name + '] 标段投标吗？')) {
			$.ajax({
				url : '${pageContext.request.contextPath}/baomming?id=' + id,
				type : 'post',
				success : function(data) {
					$('#bm').parent().html("<span class='yjbm'>已报名</span>");
					alert(data.msg);
				}
			});
		}
	}
	
	$(function() {
		$('#zbwjFileListDiv').load('attachment/fileListForSH',{"random":Math.random(),"uploadUserId":'${loginUser.id}',"fjsszt":'${projectInstance.id}',"fjgslx":'${pageContext.request.contextPath}/08'});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标项目详细信息
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class='tableTitle'>招标项目信息</div>
			<form action='${pageContext.request.contextPath}/paybank' method='post'>
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
						<td>${projectInstance.zbr000}</td>
						<th width="120px">代理机构</th>
						<td>${projectInstance.dljgmc}</td>
					</tr>
					<tr>
						<th width="120px">招标方式</th>
						<td></td>
						<th width="120px">组织形式</th>
						<td></td>
					</tr>
					<tr>
						<th width="120px">招标内容与范围</th>
						<td colspan='3'>${projectInstance.nryfw0}</td>
					</tr>
				</table>
				<div class="blank10"></div>
			</form>

				<c:forEach items="${projectInstance.projectItems}" var="item" varStatus="status">
					<div class='tableTitle'>
						标段编号:${item.bdbh00}&nbsp;&nbsp;
						标段名称:${item.bdmc00}
					</div>
					<table class='mytableStyle'>
						<tr>
							<th width="120px">标段分类代码：</th>
							<td>${item.bdfldm}</td>
							<th width="120px">标段合同估算价：</th>
							<td>${item.bdhtgj}</td>
						</tr>
						<tr>
							<th width="120px">标段内容：</th>
							<td colspan='3'>${item.bdnr00}</td>
						</tr>
					</table>
					
					<div class="blank10"></div>
				</c:forEach>
				<c:if test="${empty projectInstance.projectItems}">
					<tr>
						<td colspan='4'>标段为空！</td>
					</tr>
				</c:if>
			<div class="blank10"></div>
			<h4 class="green">招标文件附件</h4>
			<div id='zbwjFileListDiv' style='text-align: center'>
				<img src='/include/img/loading/loaderc.gif'/>
			</div>
			<div class='blank10'></div>
			<h4 class="green">招标文件文件澄清与修改文件附件</h4>
			<y:uploadify fjsszt="${projectInstance.id}" fjgslx="23" />
			<input type='button' class="button red" onclick='window.history.go(-1)' value='返回' />
		</div>
	</div>
</body>
</html>
