$(function(){
	$("#countData").on("click",function(){
		var maxDate=$("#maxDate").val();
		var minDate=$("#minDate").val();
		$("#terrace-datagrid").datagrid({
			title : "平台访问数量统计表",
			idField : "id",
			showFooter : true,
			nowrap:true,
			striped : true,
			rownumbers:true,
			pagination:true,
			height : 410,
			toolbar:[],
			url : ctx + "/log/terraceCountData?minDate="+minDate+"&maxDate="+maxDate,
			onLoadSuccess:function(data){
				if(data.rows[0]){
					//$('#terrace-datagrid').datagrid('reloadFooter', { shijian: '<b>平均值</b>', Acount: data.rows[0].csCount, Bcount: data.rows[0].ipCount });
					$('#terrace-datagrid').datagrid('appendRow', { shijian: '<b>平均值</b>', Acount: data.rows[0].csCount, Bcount: data.rows[0].ipCount });
				}
			},
			columns : [[
				{title:'日期',field:'shijian',width:450},
				{title:'访问次数',field:'Acount',width:250},
				{title:'访问IP数',field:'Bcount',width:250},
			]],
		});
	});
});