<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Describe:招标公告与资格预审公告信息
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<style type="text/css">
.queryDiv {
	width: 1002px;
	height: 120px;
	border: 1px solid #ccc;
}

.queryHead {
	width: 96%;
	height: 23px;
	border-bottom: 1px solid #ccc;
	font-size: 13px;
	font-weight: bold;
	padding-top: 5px;
}

.queryHead em {
	color: red;
	font-weight: bold;
}

.p_div {
	display: block;
	float: left;
	width: 230px;
	height: 40px;
	margin-left: 20px;
	margin-top: 5px;
}

.div_order {
	display: inline-block;
	*display: inline;
	*zoom: 1;
	margin-left: 20px;
	width: 96%;
	height: 28px;
	border: 1px solid #ccc;
}

.div_order span {
	display: inline-block;
	*display: inline;
	*zoom: 1;
	margin-left: 8px;
	margin-top: 4px;
}

#infoList {
	width: 1002px;
	border: 1px solid #ccc;
	float: left;
	margin-top: 1px;
}

.info_item {
	margin: 13px;
	border: 1px solid #ccc;
}

.info_item div {
	margin-left: 10px;
	line-height: 21px;
}

.info_item span {
	line-height: 38px;
}
</style>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		laypage({
			cont : $('#pagingBar'), //容器。值支持id名、原生dom对象，jquery对象,
			pages : ${page.pages}, //总页数
			skip : true, //是否开启跳页
			skin : '#AF0000',
			groups : 3,
			jump : function(e, first) {
				if (!first) { //一定要加此判断，否则初始时会无限刷新
					location.href = ctx + "/notice/noticeList?page=" + e.curr;
				}
			}
			//连续显示分页数
		});
	});
	$(function() {
		$(window).load(function() {
			var $keyword = $("#noticeTitle").val();
			if ($keyword != "") {
				setHeightKeyWord('infoList', $keyword, 'Red', true);
			}
		});
	});
	function setHeightKeyWord(id, keyword, color, bold) {
		if (keyword == "")
			return;
		var tempHTML = $("#" + id).html();
		var htmlReg = new RegExp("\<.*?\>", "i");
		var arrA = new Array();
		for (var i = 0; true; i++) {
			var m = htmlReg.exec(tempHTML);
			if (m) {
				arrA[i] = m;
			} else {
				break;
			}
			tempHTML = tempHTML.replace(m, "[[[[" + i + "]]]]");
		}
		var replaceText;
		if (bold)
			replaceText = "<b style='color:" + color + ";'>$1</b>";
		else
			replaceText = "<font style='color:" + color + ";'>$1</font>";
		var arrayWord = keyword.split(',');
		for (var w = 0; w < arrayWord.length; w++) {
			var r = new RegExp("(" + arrayWord[w].replace(/[(){}.+*?^$|\\\[\]]/g, "\\$&") + ")", "ig");
			tempHTML = tempHTML.replace(r, replaceText);
		}
		for (var i = 0; i < arrA.length; i++) {
			tempHTML = tempHTML.replace("[[[[" + i + "]]]]", arrA[i]);
		}
		$("#" + id).html(tempHTML);
	}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block" id="centerDiv">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			中标候选人公示 
		</div>
		<div class="blank10"></div>
		<div class='queryDiv'>
			<div class='queryHead'>
				搜索（共计<em>${page.total}</em>条）
			</div>
			<form action='${pageContext.request.contextPath}/candidatePublicity/candidatePublicityList' method='post'>
				<div>
					<span class="p_div">标题关键字：
						<input type='text' name='publicityTitle' id='publicityTitle' value="${publicityTitle}" style='width:100px' class="inputxt" />
					</span> 
					<span class="p_div">公示类型：
						<select name="gglxdm" style='width:100px'>
							<c:forEach items="${util:dictionaryTree('GSLXDM',false)}" var="item">
								<option value="${item.itemCode}">${item.itemName}</option>
							</c:forEach>
						</select>
					</span> 
					<span class="p_div">
						<a class="easyui-linkbutton" data-options="iconCls:'myicon-magnifier'" onclick="$(this).parents('form:first').submit();">搜索</a>
					</span>
				</div>
				<div class="div_order">
					<span>按时间排序：</span> <span><a href="">最近一周</a></span> <span><a href="">最近一月</a></span>
				</div>
			</form>
		</div>

		<div id="infoList">
			<form:form id="candidatePublicity_list" action="${pageContext.request.contextPath}/candidatePublicity/candidatePublicityList" method="post" commandName="candidatePublicity">
				<c:forEach items="${page.rows}" var="candidatePublicity" varStatus="status">
					<div class="info_item" style="padding:10px;">
						<b>${(page.page-1)*page.pageSize+status.count} [${util:dictionary('GSLXDM',candidatePublicity.gslx)}]</b>
						 <a href="${pageContext.request.contextPath}/candidatePublicity/candidatePublicityDetail?id=${candidatePublicity.id}"target='_blank' title="详细"> 
							 <c:choose>
									<c:when test="${fn:length(candidatePublicity.publicityTitle)>50}">
										${fn:substring(candidatePublicity.publicityTitle,0,50)}......
									</c:when>
									<c:otherwise>
										${candidatePublicity.publicityTitle}
									</c:otherwise>
							</c:choose>
						</a> 
						&nbsp;
						&nbsp;
						&nbsp;
						<span>公示类型：${util:dictionary('GSLXDM',candidatePublicity.gslx)}</span> 
						&nbsp;
						&nbsp;
						&nbsp;
						<span>结束时间： <fmt:formatDate value="${candidatePublicity.gsjssj}" type="both" dateStyle="default" timeStyle="default" /></span>
						&nbsp;
						&nbsp;
						&nbsp;
						<span class="f_r"> 发布时间： <fmt:formatDate value="${candidatePublicity.gskssj}" pattern="yyyy-MM-dd"/></span> 
					</div>
				</c:forEach>
				<div class="blank10"></div>
				<div id="pagingBar" style="text-align:right"></div>
			</form:form>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
