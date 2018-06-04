$(function() {
	$("#end").click(function(){
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "填写关闭原因",
			content:"<form action=\""+ctx+"/projectInstance/closeProjectInstance\" method=\"post\" onsubmit=\"return $('#" + id + " form').form('validate');\"><input type=\"hidden\" name=\"projectInstanceId\" value=\""+$(":input[name='id']").val()+"\"/><textarea name=\"closeReason\" class=\"easyui-validatebox\" data-options=\"required:true\" style=\"width:560px;height:280px;\"></textarea></form>",
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			buttons : [ {
				text : "确认",
				color : "red",
				handler : function() {
					$("#" + id + " form").submit();
					$("#" + id).dialog("close");
				}
			}, {
				text : "取消",
				color : "red",
				handler : function() {
					$("#" + id).dialog("close");
				}
			} ]
		});
	});
	$("[name=nryfw0]").autoTextarea({minHeight:18}).keyup();
	$("#saveBaseInfo").click(function(){
		$("#projectInstanceForm").ajaxSubmit({
			beforeSend:function(){
				return $("#projectInstanceForm").form("validate");
			},
			dataType:"json",
			success:function(data){
				$.jGrowl(data.msg);
			}
		});
	});
});
function changeQuestionState(id, state) {
	$.messager.confirm('系统提示', '确认处理该问题吗?', function(ok) {
		if (ok) {
			$.ajax({
				type : 'post',
				dataType : 'json',
				data : {
					id : id, state : state
				},
				url : ctx + "/question/changeQuestionState",
				success : function(data) {
					if (data.success) {
						$('#recruitfilequestion-datagrid').datagrid('reload');
					}
				},
				error : function(e, s1, s2) {
					$.messager.alert('系统提示', '提交失败！');
				}
			});
		}
	});
}
