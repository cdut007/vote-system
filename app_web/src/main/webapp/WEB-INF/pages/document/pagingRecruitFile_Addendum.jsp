<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		$("#recruitfile-datagrid").datagrid({
			fit : true,
			singleSelect : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			rownumbers : true,
			title : "招标文件列表",
			region : "center",
			url : "${pageContext.request.contextPath}/recruitFile/pagingRecruitFileData",
			idField : "id",
			queryParams:{includeEmpty:"true"},
			columns : [ [ 
				{field : "projectInstanceName",title : "所属招标项目",align : "left"},
				{field : "projectItemName",title : "所属标段",align : "left"/*,width:1*/}, 
				{hidden : false,field : "organTName",title : "招标单位",align : "center"/*,width:510*/}, 
				{hidden : false,field : "authorName",title : "编制人",align : "center"/*,width:510*/}, 
				{hidden : true,field : "organAName",title : "代理机构",align : "center"/*,width:510*/}, 
				{hidden : false,field : "createTime",title : "创建时间",align : "center"/*,width:510*/}, 
				{hidden : true,field : "editTime",title : "修改时间",align : "center"/*,width:510*/}, 
				{hidden : false,field : "reviewStatus",title : "文件状态",align : "center"/*,width:510*/, formatter: function(value, rowData){
					   return value=='1'?'待审核':value=='2'?'代理机构审核未通过':value=='19'?'经理审核未通过':value=='0'?'草稿':value=='9'?'审核通过':value=='3'?'招标人审核未通过':
						   value=='5'?'代理机构审核':value=='6'?'招标人审核':value=='99'?'已发布':value=='4'?'公共服务平台审核未通过':value=='91'?'已作废':'公共服务平台审核';
				   }}, 
				{title : "操作",field : "id",formatter : function(value, rowData) {
					return "<a class='button red small' href='" + ctx + "/recruitFile/preview?recruitFileId="+value+"' target='_blank'>预览</a>"+
							"<button class='button red small' onclick=\"addendum('" + rowData.projectItemId + "');\">补遗</button>";
				}}
			] ]
		});
	});
	
	function addendum(projectItemId){
		$.messager.confirm("系统提示","本系统暂不支持评标办法修改！",function(ok){
			if(ok){
				window.location.href = ctx + "/recruitFile/pagingRecruitFile_AddendumPage?projectItemId="+projectItemId;
				
				
				
				
			}
		});
	}
</script>

</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标文件/资格预审文件
			<code>&gt;</code>
			招标文件补遗
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix" style="height:500px">
				<table id="recruitfile-datagrid" class="easyui-datagird" style="width:1200px;"></table>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
