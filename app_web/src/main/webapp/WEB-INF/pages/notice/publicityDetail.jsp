<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<style type="text/css">
p {
 margin: 1px;
 paddding: 1px;
}

pre {
 white-space: pre-wrap; /* css-3 */
 white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
 white-space: -pre-wrap; /* Opera 4-6 */
 white-space: -o-pre-wrap; /* Opera 7 */
 word-wrap: break-word; /* Internet Explorer 5.5+ */
}
</style>
<jsp:include page="/common/link.jsp" />
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			中标候选人公示详细 
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<form id="noticeZhaob_form_detail" action="${pageContext.request.contextPath}/notice/saveOrUpdate" method="post">
				<table style="width:100%;">
					<tr height="100px">
						<td colspan='4' align='center'><h2>${candidatePublicity.publicityTitle}</h2></td>
					</tr>
					<tr>
						<td colspan='4'>
							<div class="my_word_document">
								<div class="my_word_west">&nbsp;</div>
								<div class="my_word_center">
									<div class="my_word_north"></div>
									<div class="my_word_body"><pre>${candidatePublicity.gsnr}</pre></div>
									<div class="my_word_south"></div>
								</div>
								<div class="my_word_east">&nbsp;</div>
							</div>
						</td>
					</tr>
				</table>
			</form>
			<div class="blank10"></div>
			<div style="text-align: center">
				<input type='button' class="button red" value='关 闭' onclick='window.close()' />
			</div>
		</div>
	</div>
</body>
</html>