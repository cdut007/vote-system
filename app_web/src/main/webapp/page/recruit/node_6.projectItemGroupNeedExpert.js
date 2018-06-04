$(function(){
	/*****
	 * 需要抽取专家的标段
	 */
	$("#projectitemgroupneedexpert-datagrid").datagrid({
		title:"待抽取专家列表",
		singleSelect : true,
		rownumbers : true,
		fitColumns : true,
		striped : true,
		pagination : true,
		collapsible:true,
		height:300,
		url : ctx+"/projectItem/listProjectItemGroupNeedExpertData",
		queryParams:{projectInstanceId:$(":input[name='id']").val()},
		idField:"projectItemId",
		columns : [ [ 
		    {field : "projectInstanceNumber",title : "项目编号",align : "left",width:100,hidden:true}, 
 		    {field : "projectInstanceName",title : "项目名称",align : "left",width:100,hidden:true}, 
 		    {field : "projectItemNumber",title : "标段编号",align : "left",hidden:true,width:100}, 
 		    {field : "projectItemName",title : "标段名称",align : "left",width:200}, 
 		    {field : "bidOpenDate",title : "开标时间",align : "left",width:180}, 
 		    {field : "bidOpenPlace",title : "开标地点",align : "left",width:200}, 
 		    {field : "expertNum",title : "专家人数",align : "left",width:80,formatter:function(value,rowData,rowIndex){
 		    	return rowData["juryExpertNum"]+rowData["juryTUserNum"]+"人";
 		    }}, 
 		   {field : "reviewStatus",title : "状态",align : "left",width:200,formatter:function(value,rowData,rowIndex){
		    	if(rowData["auditStatus"]!=null&&rowData["auditStatus"]!='') {
		    		return rowData["auditStatus"];
		    	}
		    	if(rowData["reviewStatus"]!=null) return rowData["reviewStatus"];
		    	if(rowData["expertApplyId"]=="") return "待抽取";
		    	if(rowData["reviewStatus"]=="0") return "待抽取";
		    	if(rowData["reviewStatus"]=="1") return "待审核";
		    	if(rowData["reviewStatus"]=="2") return "已完成";
		    	if(rowData["reviewStatus"]=="3") return "未通过";
		    	return "";
		    }}, 
 			{title : "操作",field : "projectItemId",width:150,formatter : function(value, rowData) {
 				var taskId = $("input[name='taskId']").val();
 				taskId = "&forRefreshTaskId="+taskId;
 				//if(rowData["expertApplyId"]=="") return "<a class='small button red' href='"+ctx+"/expertApplication/expertApplyForm?"+$.param(rowData)+"'>抽取申请</a>";
 				//if(rowData["reviewStatus"]=="0") return "<a class='small button red' href='"+ctx+"/expertApplication/expertApplyForm?"+$.param(rowData)+"'>编辑</a>";
 				//if(rowData["reviewStatus"]=="2"||rowData["reviewStatus"]=="1") return "<a class='small button red' href='"+ctx+"/expertApplication/expertApplyView?"+$.param(rowData)+"'>查看</a>";//"已完成";
 				//if(rowData["reviewStatus"]=="3") return "<a class='small button red' href='"+ctx+"/expertApplication/expertApplyForm?"+$.param(rowData)+"'>重新抽取</a>";
 				return "<a class='small button red' href='"+ctx+"/expertApplication/expertApplyForm?"+$.param(rowData)+taskId+"'>抽取申请</a>";
 			}} 
 		] ]
	});
});
