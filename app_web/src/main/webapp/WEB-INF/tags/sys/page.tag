<%@tag pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@attribute name="page" type="com.mhb.common.model.Page" required="true" description="分页对象"%>
<%@attribute name="href" type="java.lang.String" required="true" description="分页地址"%>
<c:if test="${page.pages gt 1}">
	<c:set value="${page.page-3}" var="begin"/>
	<c:set value="${begin lt 2?2:begin}" var="begin"/>
	<c:set value="${page.page+3}" var="end"/>
	<c:set value="${end lt 6?6:end}" var="end"/>
	<c:set value="${end gt page.pages-1?page.pages-1:end}" var="end"/>
	<div class="pageNum">
		<a href="javascript:$('#searchModel').attr('action','${href}/${page.page==1?1:page.page-1}').submit();">上一页</a>
		<span>
			<a href="javascript:$('#searchModel').attr('action','${href}/1').submit();" ${page.page==1?"class='inNum'":""}>1</a>
			<c:if test="${begin gt 2}">· · ·</c:if> 
			<c:forEach begin="${begin}" end="${end}" varStatus="status">
				<a href="javascript:$('#searchModel').attr('action','${href}/${status.index}').submit();" ${page.page==status.index?"class='inNum'":""}>${status.index}</a> 
			</c:forEach>
			<c:if test="${end lt page.pages-1}">· · ·</c:if> 
			<a href="javascript:$('#searchModel').attr('action','${href}/${page.pages}').submit();" ${page.page==page.pages?"class='inNum'":""}>${page.pages}</a> 
		</span>
		<a href="javascript:$('#searchModel').attr('action','${href}/${page.page==page.pages?page.pages:page.page+1}').submit();">下一页</a>
	</div>
</c:if>