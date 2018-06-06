<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<sys:link easyui="true" jgrowl="true" uedit="true" datepicker="true" plupload="true" ztree="true"/>
<script type="text/javascript" src="/resources/page/article/articleEdit.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			网站管理
			<code>&gt;</code>
			${empty article.id?"添加":"编辑"}行业资讯
		</div>
	</div>
	<div class="block">
		<form:form id="articleForm" method="post" action="${pageContext.request.contextPath}/article/createOrUpdateArticle" modelAttribute="article">
			<form:hidden path="id" />
			<table style="width:100%;">
				<col style="width:80px;" />
				<col />
				<col style="width:80px;" />
				<col />
				<tbody>
					<tr>
						<td>文章标题</td>
						<td colspan="3">
							<form:input path="articleTitle" cssClass="inputxt easyui-validatebox" style="width:80%" data-options="required:true"/>&nbsp;&nbsp;<a id="pickfile" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">导入文章</a>
						</td>
					</tr>
					<tr id="industryTr" style="${article.articleType=='news'?'':'display:none;'}">
						<td>行业类别</td>
						<td colspan="3">
							<sys:treeselect title="请选择项目行业类型" includeRoot="false" name="industry" value="${article.industry}" id="industry" cssClass="inputxt easyui-validatebox" dataOptions="required:false" typeCode="INDUSTRY" maxLevelNo="3"/>
						</td>
					</tr>
					<tr>
						<td>文章来源</td>
						<td>
							<form:input path="articleSource" cssClass="inputxt" />
						</td>
						<td>文章作者</td>
						<td>
							<form:input path="articleAuthor" cssClass="inputxt" />
						</td>
					</tr>
					<tr>
						<td>发布时间</td>
						<td>
							<form:input path="publishTime" cssClass="inputxt easyui-validatebox" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" data-options="required:true"/>
						</td>
						<td>文章类别</td>
						<td>
							<form:select path="articleType" onchange="$('#industryTr').toggle(this.value=='news');if(this.value!='news'){$('#industry').val('');$('#show-industry').val('');}">
								<c:forEach items="${catalogueService.retrieveCatalogue()}" var="item">
									<c:if test="${item.allowAddContent}">
										<form:option value="${item.catalogueFlag}" label="${item.catalogueName}"/>
									</c:if>
								</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th><nobr>文章内容&nbsp;&nbsp;</nobr></th>
						<td colspan="3">
							<form:textarea path="articleContent" style="height:400px;"/>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="blank10"></div>
			<a class="button red" id="saveBtn"> 保存</a>
			<a class="button red" href="${pageContext.request.contextPath}/article/pagingArticle">返回</a>
		</form:form>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>