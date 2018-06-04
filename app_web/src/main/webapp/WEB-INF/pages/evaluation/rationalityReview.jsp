<%@page pageEncoding="utf-8" import="java.util.*,com.mhb.evaluation.entity.IExpertVote,com.mhb.expert.entity.IExpert"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="tenderItems" value="${tenderItemService.retrieveTenderItems(processBusinessKey,projectItemId,CURRENT_USER_SESSION_INFO.id,reviewType)}" />
<%--<c:set var="expertGroupList" value="${expertGroupService.listExpertsByGroup(expertGroup.getId())}" />
<c:set var="groupNamesList" value="${expertGroupService.loadScoreGroupNames(processBusinessKey)}" /> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>合理性评审</title>
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
	var ids=new Array();
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			合理性评审
		</div>
		<form id='form1' action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
			<input type="hidden" name="taskId" value="${taskId}"/>
			<input type="hidden" id="expertApplyId" value="${processBusinessKey}"></input>
			<input type="hidden" id="projectItemId" value="${projectItemId}"></input>
			<div class="tableTitle">合理性评审</div>
			
			<div id="tender_tabs" class="easyui-tabs" data-options="fit:false,border:false" >
				<c:forEach items="${tenderItems}" var="tenderItem"  varStatus="tistatus">
					<div data-options="title:'${tenderItem.organBName}'" >
						<table class="mytableStyle">
							<tr align="center">
								<td width="80">序号</td>
								<td width="500">合理性评审要求</td>
								<td>评审结果</td>
							</tr>
							<tr>
								<td>1</td>
								<td>分部分项工程项目清单综合单价子目</td>
								<td><select id="${tenderItem.id}_factor1" style="width:100px"><option value="0">合理</option><option value="1">不合理</option></select></td>
							</tr>
							<tr>
								<td>2</td>
								<td>措施项目清单综合单价子目</td>
								<td><select id="${tenderItem.id}_factor2" style="width:100px"><option value="0">合理</option><option value="1">不合理</option></select></td>
							</tr>
							<tr>
								<td>3</td>
								<td>其他项目清单费用（指总费用）</td>
								<td><select id="${tenderItem.id}_factor3" style="width:100px"><option value="0">合理</option><option value="1">不合理</option></select></td>
							</tr>
							<tr>
								<td>4</td>
								<td>主要材料费用</td>
								<td><select id="${tenderItem.id}_factor4" style="width:100px"><option value="0">合理</option><option value="1">不合理</option></select></td>
							</tr>
							<tr>
								<td>5</td>
								<td>规费项目（指计算基数，其中社会保险费指计算基数及计算费率）</td>
								<td><select id="${tenderItem.id}_factor5" style="width:100px"><option value="0">合理</option><option value="1">不合理</option></select></td>
							</tr>
							<tr>
								<td>6</td>
								<td>税金项目（指计算基数）</td>
								<td><select id="${tenderItem.id}_factor6" style="width:100px"><option value="0">合理</option><option value="1">不合理</option></select></td>
							</tr>
						</table>
					</div>
					<script>ids[${tistatus.index}]="${tenderItem.id}";</script>
				</c:forEach>
			</div>

		
			<div class="blank10"></div>
			<div class="tc">
				<input type="button" class='button red' id="submit_button" value="提交" /> 
			</div>
		</form>

	</div>
	<div class="blank10"></div>
	<script>
		var count=${fn:length(tenderItems)};
		$("#submit_button").click(function(){
			var value = "";
			for(var i=0;i<count;i++){
				var id=ids[i];
				value+=id+":";
				for(var j=0;j<6;j++){
					var selItem=id+"_factor"+(j+1);
					value+=$("#"+selItem).val();
					if(j<5) value+="|";
				}
				if(i<count-1) value+="_";
			}
			//alert(value);
			var expertApplyId=$("#expertApplyId").val();//alert(expertApplyId);
			var projectItemId=$("#projectItemId").val();//alert(projectItemId);
			$.ajax({ 
				url:ctx+"/evaluation/saveRationalityReview",
				data:{projectItemId:projectItemId,expertApplyId:expertApplyId,reviewData:value},
				dataType:"json",
				type:"post",
				success:function(data){
					if(data.success){
						window.location.href="/evaluation/tenderRationalitySign?taskId=${taskId}&projectItemId=${projectItemId}&expertApplyId=${processBusinessKey}";
						//$("#form1").submit();
					}
					$.messager.alert("系统提示",data.msg);
				}
			});
		});
	</script>
</body>
</html>
