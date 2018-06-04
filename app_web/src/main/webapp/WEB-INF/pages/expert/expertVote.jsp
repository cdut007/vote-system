<%@page pageEncoding="utf-8" import="java.util.*,com.mhb.evaluation.entity.IExpertVote,com.mhb.expert.entity.IExpert"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="expertList" value="${userService.retrieveExpertSign(processBusinessKey)}" />
<c:set var="expertApply" value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" />
<c:set var="expertGroup" value="${expertApply.expertGroup}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>选举</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.bottom_table {
	padding: 4px 6px 4px 0px;
	margin: 3px auto 3px auto;
	color: #313031;
	TEXT-ALIGN: center;
}

.content {
	font-size: 14px;
	color: #3f3f3f;
	BORDER-RIGHT: #e6e6e6 1px solid;
	BORDER-TOP: #e6e6e6 1px solid;
	BORDER-LEFT: #e6e6e6 1px solid;
	WIDTH: 1000px;
	BORDER-BOTTOM: #e6e6e6 1px solid;
	margin: 0 auto;
}

em {
	color: #f00;
	font-weight: bold;
	margin-left: 5px;
	margin-right: 5px;
	font-size: 14px;
}

.hover {
	background-color: #eee;
	font-weight: bold;
	cursor: pointer;
}

.selected {
	background-color: #EA0000;
	font-weight: bold;
	color: #F9F900;
}

.table td {
	height: 30px;
	margin: 5px;
	padding-top: 10px;
}

.voteBox {
	height: 40px;
	border: 1px solid #ccc;
	margin: 5px;
	background-color: #eee;
	text-align: center;
	float: left;
}

#tp span {
	color: orange;
	font-size: 14px;
}
</style>
<script type="text/javascript">
	var interval;
	$(function() {
		//初始化按钮不可用
		$("#sub").attr("disabled", true).removeClass("red").addClass("gray");
		$("#sub").click(function() {
			$.messager.confirm("系统提示", "确定提交推选结果吗？", function(ok) {
				if (ok) {
					$("#form1").attr("action", "${pageContext.request.contextPath}/workflow/completeForm");
					$("#form1").attr("method", "post");
					$("#form1").submit();
				}
			});
		});
		//投票
		$("#vote").click(function() {
			var id = $("input[name=tjzz00]:checked").val();
			if (id == undefined) {
				$.messager.alert("系统提示", "请选择您要投票的专家！");
				return false;
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/expertVote/saveOrUpdate",
				type : "post",
				data : {
					"projectInstanceId" : "${expertApply.projectInstance.id}",
					"expertGroupId" : "${expertGroup.id}",
					"tjzz00" : $("input[name=tjzz00]:checked").val(),
					"tplx00" : "2"
				},
				dataType : "json",
				success : function(data) {
					if(data.success){
						$.messager.alert("系统提示", data.msg);
						$("#zz").html("您已投票给<em>" + $("input[name=tjzz00]:checked").next("span").text() + "</em>");
						$("#e_" + id).width($("#e_" + id).width() + 30);
						$("#vote").attr("disabled", "disabled").removeClass("red").addClass("gray").attr("value", "已投票");
					}else{
						$.messager.alert("系统提示", data.msg);
					}
				}
			});
			$("#p_" + $("input[name=tjzz00]:checked").val()).append("+1");
		});

		interval = window.setInterval(queryVote, 5000);
		//页面初始化首次查询
		queryVote();
	});

	function queryVote() {
		//return;
		$.ajax({
			url : "${pageContext.request.contextPath}/expertVote/list",
			type : "post",
			data : {
				"expertGroupId" : "${expertGroup.id}"
			},
			dataType : "json",
			success : function(data) {
				var max = 0;
				var maxId=undefined;
				for ( var key in data) {
					if (key != "end" && key != "myVote") {
						$("#p_" + key).html(data[key] + "票");
						$("#e_" + key).width(data[key] * 30 + 5); //5是0票的长度
						max = max > data[key] ? max : data[key];
						maxId = max > data[key] ? maxId : key;
					}
				}
				if (data["end"] == true) {//投票结果
					$("#vote").attr("disabled", "disabled").removeClass("red").addClass("gray").attr("value", "已投票");
					$.messager.alert("系统提示", "投票已结束！");
					$("#result").html("恭喜<em>" + $("input[name=tjzz00][value=" + maxId + "]").next("span").text() + "</em> 获选为组长！");
					window.clearInterval(interval);
					//保存组长
					if ("${expertGroup.zzzj00}" == null || "${expertGroup.zzzj00}" == "") {
						$.ajax({
							url : "${pageContext.request.contextPath}/expertGroup/saveHeader",
							type : "post",
							data : {
								"id" : "${expertGroup.id}",
								"zzzj00" : maxId
							},
							dataType : "json",
							success : function() {
							}
						});
					}
					$("#sub").attr("disabled", false).removeClass("gray").addClass("red");
				}
				if (data["myVote"] != undefined) { //我的投票
					$("#zz").html("您已投票给<em>" + $("input[name=tjzz00][value=" + data["myVote"] + "]").next("span").text() + "</em>");
					$("#vote").attr("disabled", "disabled").removeClass("red").addClass("gray").attr("value", "已投票");
				}
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			选举评标委员会组长
		</div>
		<form id='form1' action="${pageContext.request.contextPath}/flow/completeTask" method="post">
			<input type="hidden" name="taskId" value="${taskId}"/>
			<input type='hidden' name='tplx00' value='2' />
			<!-- 评标委员会 选组长 -->
			<div class="tableTitle">评标委员会成员</div>

			<div style="width:1004px;">
				<table style="width:90%;" id="tp">
					<c:forEach items="${expertList}" var="expert">
						<tr>
							<td width="80px;">
								<input type='radio' name='tjzz00' value='${expert.id}' /><span>${expert.userName}</span>
							</td>
							<td>
								<div class="voteBox" id="e_${expert.id}" style="width:5px;" />
							</td>
							<td>
								<span id="p_${expert.id}">0票</span>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="blank10"></div>
			<div class="tc">
				<input type="button" class='button red' id="vote" value="投票" /> <input type="button" id='sub' class='button red' value="进入评标" />
			</div>
		</form>

		<div class="usBox">
			<div class="tableTitle2">我的投票</div>
			<table class="mytableStyle">
				<tr>
					<td>
						<span id="zz">您还未投票！</span>
					</td>
				</tr>
			</table>
			<div class="blank10"></div>
			<div class="tableTitle2">最终推选结果</div>
			<table class="mytableStyle">
				<tr>
					<td>
						<span id="result">投票进行中...</span>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="blank10"></div>
</body>
</html>
