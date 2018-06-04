<%@page pageEncoding="utf-8" import="java.util.*,com.mhb.evaluation.entity.IExpertVote,com.mhb.expert.entity.IExpert"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="expertGroup" value="${expertGroupService.loadGroupInfo(processBusinessKey)}" />
<c:set var="expertGroupList" value="${expertGroupService.listExpertsByGroup(expertGroup.getId())}" />
<c:set var="groupNamesList" value="${expertGroupService.loadScoreGroupNames(processBusinessKey)}" />
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
	
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			评标委员会详细评审任务分配
		</div>
		<form id='form1' action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
			<input type="hidden" name="taskId" value="${taskId}"/>
			<div class="tableTitle">评标委员会详细评审任务分配</div>
			
			<div id="tender_tabs" class="easyui-tabs" data-options="fit:false,border:false" >
				<c:forEach items="${expertGroupList}" var="ep"  varStatus="epstatus">
					<div data-options="title:'${ep.expert.userName}'" >
						<c:forEach items="${groupNamesList}" var="groupNames" varStatus="status1">
							<c:forEach items="${groupNames}" var="groupName" varStatus="status2">
								
								<c:if test="${status2.count==1}">
									<h2 style="margin-top:20px;">${groupName[3]}</h2>
								</c:if>			
								
								<div style="margin-top:10px;">	
									<input type="checkbox" name="group_task" checked="checked" value="${ep.groupId}___${ep.expertId}___${groupName[4]}___${groupName[1]}${groupName[0]}"></input>
									${groupName[1]} (${groupName[2]=="first"?"第一信封":"第二信封"})
								</div>		
							</c:forEach>
						</c:forEach>
					</div>
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
		$("#submit_button").click(function(){
			var value = "";
			$($("input:checked")).each(function(){
				console.log(this.value);
				value+=this.value +'#####';
			});
			//遍历被选中CheckBox元素的集合 得到Value值

			$.ajax({ 
				url:ctx+"/expertGroup/save_task",
				data:{taskData:value},
				dataType:"json",
				type:"post",
				success:function(data){
					if(data.success){
						$("#form1").submit();
					}
					$.messager.alert("系统提示",data.msg);
				}
			});
			
	
		console.log(value);
			//$("#form1").submit();
		});
	</script>
</body>
</html>
