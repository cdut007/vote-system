<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<sys:link easyui="true" uedit="true"></sys:link>
<script type="text/javascript">
	$(function() {
		UE.getEditor('benchmarkDescription', {
			toolbars : [ [ 'source', 'fullscreen', '|', 'undo', 'redo', '|',
					'bold', 'italic', 'underline', '|', 'forecolor',
					'backcolor', 'selectall', 'cleardoc', '|', 'customstyle',
					'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft',
					'justifycenter', 'justifyright', 'justifyjustify', '|',
					'inserttable', 'deletetable', 'insertparagraphbeforetable',
					'insertrow', 'deleterow', 'insertcol', 'deletecol',
					'mergecells', 'mergeright', 'mergedown', 'splittocells',
					'splittorows', 'splittocols' ] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			评标办法管理
			<code>&gt;</code>
			${empty benchmark.id?"添加":"编辑"}评标基准价算法
		</div>
		<div class="blank10"></div>
		<div class="uBox">
			<form:form modelAttribute="benchmark" action="${pageContext.request.contextPath}/benchmark/createOrUpdateBenchmarkMethod" method="post">
				<form:hidden path="id" />
				<table style="width:100%;">
					<tbody>
						<tr>
							<td class="need"></td>
							<td style="width:100px;">说明</td>
							<td>juel和groovy为空的表示开标后才进行抽取</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">评标基准价名称</td>
							<td><form:input path="benchmarkName" cssClass="inputxt" style="width:100%;" /></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>评标基准价描述</td>
							<td><form:textarea path="benchmarkDescription" style="width:100%;height:200px;" /></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td><nobr>计算表达式(juel)</nobr></td>
							<td><form:textarea path="benchmarkExpression" style="width:100%;height:100px;" /></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td><nobr>计算脚本(groovy)</nobr></td>
							<td><form:textarea path="benchmarkScript" style="width:100%;height:100px;" /></td>
						</tr>
						
						<tr>
							<td class="need">*</td>
							<td><nobr>计算唯一ID</nobr></td>
							<td><form:textarea path="uniqueMethodId" style="width:100%;height:50px;" /></td>
						</tr>
						
					</tbody>
				</table>
				<div class="blank10"></div>
				<button class="button red">保存</button>
				<input class="button red" type="button" value="返回" onclick="window.location.href=ctx+'/benchmark/pagingBenchmark'"/>
			</form:form>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>