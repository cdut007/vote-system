<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Describe:招标项目信息
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<style type="text/css">
.queryDiv {
	width: 100%;
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

.btn {
	color: #484848;
	font: 12px/1.5 arial;
	padding-top: 2px;
	padding-bottom: 2px;
	align: center
}

#infoList {
	width: 800px;
	border: 1px solid #ccc;
	float: left;
	margin-top: 1px;
}

.info_item {
	height: 120px;
	margin: 13px;
	border-bottom: 1px solid #ccc;
}

.info_item p {
	margin-left: 10px;
	line-height: 21px;
}

.info_item span {
	line-height: 38px;
}

.info_item a {
	font-size: 14px;
}

.span_margin {
	margin-right: 70px;
}

.small_div {
	width: 200px;
	height: 250px;
	border: 1px solid #CCC;
	margin-top: 2px;
}

.small_div h4 {
	width: 198px;
	height: 25px;
	background-color: #C70000;
	border-bottom: 1px solid #FFF;
	color: #fff;
	padding-left: 3px;
	padding-top: 3px;
}

.small_div ul li {
	float: left;
	padding: 5px;
}

.small_div div {
	width: 100%;
	line-height: 30px;
	padding-left: 5px;
}
</style>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		$(window).load(function() {
			var $keyword = $("#noticeTitle").val();
			if ($keyword != "") {
				setHeightKeyWord('infoList', $keyword, 'Red', true);
			}
		});
		laypage({
			cont : $('#pagingBar'), //容器。值支持id名、原生dom对象，jquery对象,
			pages : ${page.pages}, //总页数
			skip : true, //是否开启跳页
			skin : '#AF0000',
			curr:${page.page}, //总页数
			groups : 3,
			jump : function(e, first) {
				if (!first) { //一定要加此判断，否则初始时会无限刷新
					location.href = ctx + "/projectInstance/trp_list?page=" + e.curr;
				}
			}//连续显示分页数
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
		var replaceText=undefined;
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
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标项目信息 
		</div>
		<div class="blank10"></div>
		<div class='queryDiv'>
			<div class='queryHead'>
				搜索（共计<em>${page.total}</em>条）
			</div>
			<form action='${pageContext.request.contextPath}/projectInstance/trp_list' method='post'>
				<div>
					<span class="p_div">项目关键字：
						<input type='text' name='zbxmmc' class="inputxt" id='zbxmmc' value="${zbxmmc}" style='width:100px' />
					</span> 
					<span class="p_div">招标方式：
						<select name="zbfs00" style='width:100px'>
							<option value="">请选择</option>
							<c:forEach items="${util:dictionaryTree('ZBFS00',false)}" var="item">
								<option value="${item.itemCode}">${item.itemName}</option>
							</c:forEach>
						</select>
					</span>
					<span class="p_div">
						<a class='easyui-linkbutton' data-options="iconCls:'myicon-magnifier'">搜索</a>
					</span>
				</div>
				<div class="div_order">
					<span>按时间排序：</span> <span><a href="">最近一周</a></span> <span><a href="">最近一月</a></span>
				</div>
			</form>
		</div>

		<div id="infoList">
			<form:form id="projectInstance_list" action="${pageContext.request.contextPath}/projectInstance/trp_list" method="post" commandName="projectInstance">
				<c:forEach items="${page.rows}" var="projectInstance_item" varStatus="status">
					<div class="info_item">
						<p>
							<b>${(page.page-1)*page.pageSize+status.count}、</b> <a href="${pageContext.request.contextPath}/projectInstance/detailForFlow1?id=${projectInstance_item.id}" target='_blank' title="详细"> <c:choose>
									<c:when test="${fn:length(projectInstance_item.zbxmmc)>50}">
										${fn:substring(projectInstance_item.zbxmmc,0,50)}......
									</c:when>
									<c:otherwise>
										${projectInstance_item.zbxmmc}
									</c:otherwise>
								</c:choose>
							</a> <span class="f_r"> 发布时间： <fmt:formatDate value="${projectInstance_item.lxsj00}" type="both" dateStyle="default" timeStyle="default" />
							</span>
						</p>
						<p>
							<span class='span_margin'>招标组织形式： ${util:dictionary('ZBZZXS',projectInstance_item.zbzzxs)}</span>
						</p>
						<p>
							<c:choose>
								<c:when test="${fn:length(projectInstance_item.nryfw0)>100}">
									${fn:substring(projectInstance_item.nryfw0,0,100)}......
								</c:when>
								<c:otherwise>
									${projectInstance_item.nryfw0}
								</c:otherwise>
							</c:choose>
						</p>
						<p>
							<span class="span_margin">所属行业： ${util:dictionary('INDUSTRY',projectInstance_item.project.industry)} </span> 
							<span class="span_margin">所属地区： ${util:dictionaryPath('REGION',projectInstance_item.project.region)} </span>
						</p>
					</div>
					<div class='line_div'></div>
				</c:forEach>
				<div id="pagingBar" style="text-align:right"></div>
			</form:form>
		</div>

		<div class="f_r" style='width:200px;'>
			<div class='small_div'>
				<h4>热门行业</h4>
				<ul>
					<li>通讯</li>

					<li>电力</li>

					<li>化工</li>

					<li>办公</li>

					<li>包装</li>

					<li>纸业</li>

					<li>餐饮</li>

					<li>房产</li>

					<li>电子</li>

					<li>电气</li>

					<li>医药制造</li>

					<li>设备制造</li>

					<li>计算机</li>

					<li>建筑安装</li>

					<li>原料加工</li>
				</ul>
			</div>
			<div class='small_div'>
				<h4>热门搜索</h4>
			</div>
			<div class='small_div'>
				<h4>项目进度查询</h4>
				<div>
					<a>公告及发标阶段</a>
				</div>
				<div>
					<a>投标阶段</a>
				</div>
				<div>
					<a>开评标阶段</a>
				</div>
				<div>
					<a>中标结果公示阶段</a>
				</div>
				<div>
					<a>中标公告阶段</a>
				</div>
				<div>
					<a>历史项目查询</a>
				</div>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
