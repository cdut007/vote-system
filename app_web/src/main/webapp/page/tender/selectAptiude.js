$(function(){
	$("#aptitude-datagrid").datagrid({
		title:"资质列表",
		fit:true,
		url:ctx+"/aptitude/pagingApptitudeOwnData",
		pagination:true,
		rownumbers:true,
		striped:true,
		method:"post",
		queryParams:{isAudits:"2"},
		columns:[[
		    {field:'id',checkbox:true},
		    {title:"主体代码",field:'ztdm00',align:"center",width:100},
		    {title:"资质等级",field:'zzdj00',width:80},
		    {title:"证书编号",field:'zzzsbh',width:80},
		    {title:"资质名称",field:'zzname',width:100},
		    {title:"信息申报责任人",field:'xxsbr0',width:80},		    
		    /*{title:"审核状态",field:'isAudits',width:60},*/
		    {title:"创建时间",field:'createDate',width:120},
		    {title:"审核时间",field:'auditsTime',width:120},
		    {title:"资质状态",field:'state',align:"center",width:80}
		]]
	});
});