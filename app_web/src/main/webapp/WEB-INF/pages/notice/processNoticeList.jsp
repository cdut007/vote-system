<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		$("#processnotice-datagrid").datagrid({
			title : "未读消息列表",
			idField : "id",
			fitColumns : true,
			singleSelect:true,
			striped : true,
			rownumbers:true,
			pagination:true,
			height : 400,
			url : "${pageContext.request.contextPath}/notice/processNoticeListData",
			columns : [ [ {
				hidden : false,
				field : "msg",
				title : "消息",
				align : "left",
				width : "550px"
			}, {
				hidden : false,
				field : "createDate",
				title : "创建时间",
				align : "center",
				width : "120px" 
			}, {
				title : "操作",
				field : "effective",
				formatter : function(effective, row) {
					if (effective) {
						return "<a class='button red small' href=\"javascript:setProcessNoticeState('"+row.id+"', false)\">置为已读</a>";
					} else {
						return "<a class='button red small' href=\"javascript:setProcessNoticeState('"+row.id+"', true)\">置为未读</a>";
					}
				}
			} ] ],
			toolbar : [{
				text : "全部置为已读",
				iconCls : "myicon-email_open",
				handler : function() {
// 					document.location.href="${pageContext.request.contextPath}/notice/setAllProcessNoticeState";

					$.get("${pageContext.request.contextPath}/notice/setAllProcessNoticeState", 
						function(data){
							$("#processnotice-datagrid").datagrid('reload');
						}
					);
				}
			}]
		});
	});
	
	function setProcessNoticeState(processNoticeId, effective) {
		$.get("${pageContext.request.contextPath}/notice/setProcessNoticeState", { id: processNoticeId, effective: effective, t: new Date()},
			function(data){
				$("#processnotice-datagrid").datagrid('reload');
			}
		);
	}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>未读消息列表
			</div>
			<div class="blank10"></div>
			<table id="processnotice-datagrid"></table>
			<div class="blank10"></div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>