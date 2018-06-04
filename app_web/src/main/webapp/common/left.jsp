<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="category">
	<h3 style=" BACKGROUND: #C70000;">
		<span style="font-size:14px; color:#FFF; font-family:'微软雅黑';">用户操作</span>
	</h3>
	<div class="cagegoryCon clearfix">
		<c:forEach items="${root.children}" var="item">
			<dl>
				<dt>
					<c:choose>
						<c:when test="${fn:startsWith(item.url,'/')}">
							<%-- <a href="${item.url}">${item.text}</a> --%>
							<a href="#">${item.text}</a>
						</c:when>
						<c:when test="${fn:startsWith(item.url,'http')}">
							<%-- <a href="${item.url}">${item.text}</a> --%>
							<a href="#">${item.text}</a>
						</c:when>
						<c:otherwise>
							<%-- <a href="${pageContext.request.contextPath}/${item.url}">${item.text}</a> --%>
							<a href="#">${item.text}</a>
						</c:otherwise>
					</c:choose>
				</dt>
				<dd class="clearfix">
					<c:forEach items="${item.children}" var="c">
						<p onmouseover="this.className='itemsbg'" onmouseout="this.className=''">
							<c:choose>
								<c:when test="${fn:startsWith(c.url,'/')}">
									<a class="txtdot" href="${c.url}" target="_blank">${c.text}</a>
								</c:when>
								<c:when test="${fn:startsWith(c.url,'http')}">
									<a href="${c.url}">${c.text}</a>
								</c:when>
								<c:otherwise>
									<a class="txtdot" href="${pageContext.request.contextPath}/${c.url}" target="_blank">${c.text}</a>
								</c:otherwise>
							</c:choose>
						</p>
					</c:forEach>
				</dd>
			</dl>
		</c:forEach>
	</div>
</div>