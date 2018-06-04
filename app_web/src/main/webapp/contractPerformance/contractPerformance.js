$(function() {
	$("#save,#complete").click(function() {
		var paramArray = $("#contractForm").serializeArray();
		
		var isComplete = $(this).attr("id") == "complete" ? 1 : 0;
		paramArray.push({name:"contractStatus",value:isComplete});
		if (isComplete) {
			$.messager.confirm("系统提示", "提交后将不可修改，确认要提交合同履约信息吗？", function(r) {
				if (r) {
					postContractPerformace(paramArray);
				}
			});
		} else {
			postContractPerformace(paramArray);
		}
	});

	
	function postContractPerformace(paramArray){
		$.ajax({
			url : ctx + "/contract/saveOrUpdateContractPerformance",
			type : "post",
			beforeSend : function() {
				var validate = $("#contractForm").form("validate");
				if (validate == true) {
					$.messager.progress({
						title : "系统提示",
						msg : "正在提交数据"
					});
					$("#save,#complete").prop("disabled", true);
				}
				return validate;
			},
			data : paramArray,
			dataType : "json",
			success : function(data) {
				$(":input[name='id']").val(data.data);
				if(data.success){
					history.go(-1);
				}else{
					$.jGrowl(data.msg);
				}
				
			},
			complete : function() {
				$.messager.progress("close");
				$("#save,#complete").prop("disabled", false);
			}
		});
	}
});