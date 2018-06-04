<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply" />
<c:set value="${expertApply.projectInstance}" var="projectInstance" />
<c:set value="${tenderItemService.retrieveTenderItemWithTenderTotalScore(processBusinessKey,projectItemId,CURRENT_USER_SESSION_INFO.id,reviewType)}" var="tenderItemWitTenderTotalScoreList" />
<c:set value="${tenderItemService.retrieveTenderItemWithTenderTotalPassResutl(processBusinessKey,projectItemId,CURRENT_USER_SESSION_INFO.id,reviewType)}" var="tenderItemWitTenderPassScoreMap" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>详细评审</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.mytableStyle {
	margin-top: 5px;
	font-size: 12px;
	width: 100%;
	border-collapse: collapse;
	border: #ccc 1px solid;
	border-width: 1px 0 0 1px;
}

.mytableStyle th {
	height: 30px;
	border: 1px #ccc solid;
	background-color: #eee;
	text-align: center;
}

.mytableStyle td {
	border: #ccc 1px solid;
	border-width: 0 1px 1px 0;
	height: 30px;
}

.bottom_table {
	padding: 4px 6px 4px 0px;
	margin: 3px auto 3px auto;
	color: #313031;
	TEXT-ALIGN: center;
}

.content {
	font-size: 12px;
	BORDER-RIGHT: #e6e6e6 1px solid;
	MARGIN-TOP: 10px;
	BORDER-LEFT: #e6e6e6 1px solid;
	WIDTH: 1000px;
	BORDER-BOTTOM: #e6e6e6 1px solid;
	margin: 0 auto;
}

.btn {
	float: right;
}
</style>
<!--ready事件-->
<script type="text/javascript">
	$(function() {
		if ($(":input[name='message']").val() != '') {
			$.jGrowl($(":input[name='message']").val());
		}
		$("#sub").click(function() {
			
			/* 暂时没搞明白这个needCheckScore是搞什么的！！ */
			if(/* needCheckScore &&  */tenderWithScoreSize < tenderSize){
				$.messager.alert("提示","请先对所有的投标人进行评分");
			}else{
				$.messager.confirm("系统提示", "确定要提交您的评分结果吗？", function(y) {
					if (y) {
						$("#workflowForm").submit();
					}
				});
			}
		});
	});
	$(function() {
		$("#score,#clarify").hover(function() {
			$(this).css({
				"opacity" : 1
			});
		}, function() {
			$(this).css({
				"opacity" : 0.4
			});
		});
		$(":input[value='打开评分']").toggle(function() {
			this.value = "关闭评分";
			$(this).siblings().attr("disabled", true);
			$("#score").css({
				"position" : "fixed",
				"bottom" : "90",
				"height" : "400",
				"left" : "10%",
				"width" : "80%",
				"opacity" : 1,
				"border-radius" : "5px",
				"border" : "2px solid #aaaaff",
				"background-color" : "#fafafa"
			}).show();
		}, function() {
			this.value = "打开评分";
			$(this).siblings().attr("disabled", false);
			$("#score").hide();
		});
		$(":input[value='打开澄清']").toggle(function() {
			this.value = "关闭澄清";
			$(this).siblings().attr("disabled", true);
			$("#clarify").css({
				"position" : "fixed",
				"bottom" : "90",
				"height" : "400",
				"left" : "10%",
				"width" : "80%",
				"opacity" : 1,
				"border-radius" : "5px",
				"border" : "2px solid #aaaaff",
				"background-color" : "#fafafa"
			}).show();
		}, function() {
			this.value = "打开澄清";
			$(this).siblings().attr("disabled", false);
			$("#clarify").hide();
		});
		$("#save").click(function() {
			$.ajax({
				url : $("#score form").attr("action"),
				type : "post",
				data : $("#score form").serialize(),
				dataType : "json",
				beforeSend : function() {
					$("#score").hide();
				},
				success : function(data) {
				}
			});
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			详细评审
		</div>
		<div class="usBox">
			<div style="text-align: center;">
				<font style="font-size: 14pt; font-weight: bold;">${projectInstance}详细评审</font>
			</div>
			<div class="blank10"></div>
			<script>
			
				var tenderSize = ${tenderItemWitTenderTotalScoreList.size()}; var tenderWithScoreSize=0;
				var needCheckScore = ${tenderItemService.checkHasOtherScoreItem(projectItemId)};

			</script>
			<c:forEach items="${tenderItemWitTenderTotalScoreList}" var="item" varStatus="status">
				<c:set value="${item[0]}" var="tenderItem" />
				<c:set value="${item[1]}" var="tenderTotalScore" />
				<c:if test="${tenderItem.projectItem==null||tenderItem.projectItem!=projectItem}">
					<c:if test="${status.index!=0}"><%="</div>"%></c:if>
					<c:set value="${tenderItem.projectItem}" var="projectItem" />
					<div class='red' style='color:yellow;padding:5px;weight:900;width:100%;display:block;'>${projectItem.bdbh00}-${projectItem.bdmc00}</div>
					<div class="blank10"></div>
					<%="<div class='clearfix'>"%>
				</c:if>
				<c:if test="${not empty tenderItem.organ.logoId}">
					<c:set var="background" value="background:url('${pageContext.request.contextPath}/attachment/zoom/${tenderItem.organ.logo.path}?width=180&height=255')"/>
				</c:if>
				<div index="${status.index}" style="width:180px;height:255px;text-align:center;border:1px solid #efefef;float:left;margin-right:2px;margin-bottom:2px;${background}">
					<br /> <br /> <br /> 
					<a title="${tenderItem.organ}" href="${pageContext.request.contextPath}/evaluation/evaluationTenderItemDetail?id=${tenderItem.id}&processBusinessKey=${processBusinessKey}&taskId=${taskId}">
						<p class="product_list1brief">${tenderItem.organ}</p>
					</a> 
					<br />
					<c:if test="${not empty tenderTotalScore.scoreValue}">
						<script>tenderWithScoreSize++</script>
						<div style="filter:alpha(opacity=80);-moz-opacity:0.8;opacity:0.8;padding:10px;background:#000;color:#fff;font-size:18px;weight:900;">总分：<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" value="${tenderTotalScore.scoreValue}"></fmt:formatNumber></div>
					</c:if>
					<c:if test="${not empty tenderItemWitTenderPassScoreMap[tenderItem.id]}">
						<script>tenderWithScoreSize++</script>
						<div style="filter:alpha(opacity=80);-moz-opacity:0.8;opacity:0.8;padding:10px;background:#000;color:#fff;font-size:18px;weight:900;">
							<c:if test="${tenderItemWitTenderPassScoreMap[tenderItem.id]=='0'}">
								<script>tenderWithScoreSize++</script>
							合格
							</c:if>
							<c:if test="${tenderItemWitTenderPassScoreMap[tenderItem.id]=='1'}">
								<script>tenderWithScoreSize++</script>
							不合格
							</c:if>
						</div>
					</c:if>
					<br /> <br /> <br /> <br /> <br />
				</div>
			</c:forEach>
		
			<div class="blank10"></div>
			<form id="workflowForm" action='${pageContext.request.contextPath}/workflow/completeForm' method='post'>
				<input type="hidden" name="message" value="${message}" /> <input type="hidden" name="taskId" value="${taskId}" /> <input type='button' id="sub" class="button red" value='提交我的全部评标结果' />
			</form>
		</div>
	</div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
