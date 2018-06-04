$(function() {
	$("#commissionbidOpening-datagrid").datagrid({
		title:"正在开标项目标段",
		url:ctx+"/bidOpen/pagingBidOpeningData",
		pagination:true,
		rownumbers:true,
		striped:true,
		height:300,
		idField:"id",
		method:"post",
		queryParams:{projectInstanceId:$(":input[name='id']").val()},
		columns:[[
			{field : 'projectInstanceName',title : "项目名称",width:180},
			{field : 'projectItemNames',title : "标段包集合",width:150},
			{field : 'bidOpenDate',title : "开标时间",width:150},
			{field : 'organTName',title : "业主单位",align:"left",width:180},
			{field : 'organAName',title : "代理机构",align:"left",width:180},
			{field : 'id',title : "操作",align:"left",width:150,formatter:function(value,rowData,rowIndex){
				return "<a class=\"button red small\" href=\""+ctx+"/bidOpen/bidOpenManager?expertApplyId="+value+"\" target='_blank'>进入</a>";
			}}
		]]
	});
});