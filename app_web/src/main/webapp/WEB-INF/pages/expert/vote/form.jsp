<%@page pageEncoding="utf-8" import="java.util.*,com.mhb.evaluation.entity.IExpertVote,com.mhb.expert.entity.IExpert"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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

#zz {
 color: #f00;
 font-weight: bold;
 margin-left: 5px;
 margin-right: 5px;
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
.table td{
	height:30px;margin:5px;padding-top:10px;
}
.voteBox{
	height:40px;border:1px solid #ccc;margin:5px;background-color:#eee;text-align:center;float:left;
}

#ticket span{color:orange;font-size:14px;font-weight:bold}
</style>

</head>
<body>
	<jsp:include page="/common/top.jsp"/>

	<script type="text/javascript">
		var interval;
		$(function() {
		//初始化按钮不可用
		$("#sub").attr("disabled", true);

		$("#sub").click(function() {
			if (confirm("确定提交推选结果吗？")) {
				$("#form1").attr("action", "${pageContext.request.contextPath}/flow/completeTask");
				$("#form1").attr("method", "post");
				$("#form1").submit();
			}
		});

		$("#hx_tr>td").mouseover(function() {
			$(this).addClass("hover");
		});

		$("#hx_tr>td").mouseout(function() {
			$(this).removeClass("hover");
		});
		$("#hx_tr>td").click(function() {
			if (!$(this).hasClass("selected")) {
				$(this).siblings().each(function(){
					$(this).removeClass("selected");
				});
				$(this).addClass("selected").children(":input").click();
				$("#zz").text($(this).text());
				$("#sub").attr("disabled", false);
			}
		});
		
		$("#vote").click(function(){
			var id = $("input[name=tjzz00]:checked").val();
			if(id==undefined){
				$.messager.alert("系统提示","请选择您要投票的专家！");
				return false;
			}else{
				$("#zz").html($("input[name=tjzz00]:checked").next("span").text());
				$("#e"+id).width($("#e"+id).width()+30);
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/expertVote/saveOrUpdate",
				type:"post",
				data:{"tbxmzj":"0001","tjzz00":$("input[name=tjzz00]:checked").val(),"tplx00":"2"},
				dataType:"json",
				success:function(data){
					$.messager.alert("系统提示",data.msg);
				}
			});
			$("#p"+$("input[name=tjzz00]:checked").val()).append("+1");
		});
		
		interval = setInterval(queryVote,10000);
	});
	
	function queryVote(){
		$.ajax({
			url:"${pageContext.request.contextPath}/expertVote/list",
			type:"post",
			data:{"tbxmzj":"0001"},
			dataType:"json",
			success:function(data){
				for(var i=1;i<=4;i++){
					$("#p"+i).html(data[i]+"票");
					$("#e"+i).width(data[i]*30);
				}
				if(data["end"]==1){ 
					window.clearInterval(interval); 
				}
			}
		});
	}
	</script>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			选举评标委员会组长
		</div>
		<form id='form1' action="${pageContext.request.contextPath}/flow/completeTask" method="post">
		<input type='hidden' name='tplx00' value='2'/> <!-- 评标委员会 选组长 -->
		<div class="tableTitle">评标委员会成员</div>
		
		<div style="width:1004px;">
		
			<table style="width:90%;" id="ticket">
				<tr>
					<td width="80px;"><input type='radio' name='tjzz00' value='1'/><span>专家1</span></td>
					<td><div class="voteBox" id="e1" style="width:10px;"/></td>
					<td><span id="p1">0票</span></td>
				</tr>
				<tr>
					<td><input type='radio' name='tjzz00' value='2'/><span>专家2</span></td>
					<td><div class="voteBox" id="e2" style="width:10px;"/></td>
					<td><span id="p2">0票</span></td>
				</tr>
				<tr>
					<td><input type='radio' name='tjzz00' value='3'/><span>专家3</span></td>
					<td><div class="voteBox" id="e3" style="width:10px;"/></td>
					<td><span id="p3">0票</span></td>
				</tr>
				<tr>
					<td><input type='radio' name='tjzz00' value='4'/><span>专家4</span></td>
					<td><div class="voteBox" id="e4" style="width:10px;"/></td>
					<td><span id="p4">0票</span></td>
				</tr>
			</table>
		</div>
		<div class="blank10"></div>
		<div class="tc">
			<input type="button" class='button red' id="vote" value="投票" />
			<input type="button" id='sub' class='button red' value="进入评标" /> 
		</div>
		</form>
		
		<div class="usBox">
			<div class="tableTitle2">我的投票</div>
			<table class="mytableStyle">
				<tr>
					<td>您已投票给<span id="zz"></span></td>
				</tr>
			</table>
			<div class="blank10"></div>
			<div class="tableTitle2">推选结果</div>
			<table class="mytableStyle">
				<tr>
					<td><c:forEach items="${experts}" var="e">
							<c:forEach items="${expertVote}" var="vote">
							</c:forEach>
							${e.userName} : 1票 &nbsp;&nbsp;&nbsp;&nbsp;
						</c:forEach>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="blank10"></div>
</body>
</html>
