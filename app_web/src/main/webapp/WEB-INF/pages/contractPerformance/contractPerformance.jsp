<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<style type="text/css">
</style>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function() {
	$("#contractPerformance_datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		fitColumns : true,
		pagination : true,
		title:"合同和履约列表",
		url : "${pageContext.request.contextPath}/contract/pagingContractPerformanceList?projectInstanceId=${projectInstanceId}",
		idField : "id",
		toolbar:[{
			text : "添加",
			iconCls : "myicon-application_add",
			handler : function() {
				window.location.href=ctx+"/contract/addContractPerformance?projectInstanceId=${projectInstanceId}";
			}
		}],
		columns : [[
		            {field:"projectInstance.zbxmmc",title:"招标项目名称",align:"left",width:120,hidden:true},
					{field:"projectItem.bdmc00",title:"标段（包）名称",align:"center",width:120},
					{field:"organW.ztmc00",title:"中标人名称",align:"center",width:150},
					{field:"contractPrice",title:"合同金额",align:"center",width:100},
					{field:"finishTime",title:"合同完成时间",align:"center",width:110},
					{field:"contractSignTime",title:"合同签署时间",align:"center",width:110},
					{field:"opt",title:"操作",align:"center",width:100,formatter : function(value,row,index) {
						return "<a class='button red small' href=\""+ctx+"/contract/showContractPerformance?id="+row["id"]+"\">查看</a>";
						/* "<a class='button red small' href=\""+ctx+"/contract/loadContractPerformance?id="+row["id"]+"\">修改</a>"; */
					}}
				]]		           
	});
});

</script>
	</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			合同与履约管理
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<table id="contractPerformance_datagrid"></table>
			</div>
		</div>
	</div>
</body>
</body>
</html>
