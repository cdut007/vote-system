
$(function() {

	function loadAcquireTemplateList(projectInstanceId,projectItemId){
		$.ajax({
			url:ctx+"/notice/acquireTemplateList?t="+new Date().getTime()+"&projectItemId="+projectItemId,
			type:"post",
			dataType:"json",
			data:{
				projectInstanceId : projectInstanceId
			},
			success:function(data){
				if(data=="NO"){
					$("#zbwj").html("<option  value='000' selected='selected'>===暂无===</option>");
				}else{
					var data2=eval(data);
					var data3;
					$(data2).each(function(i){
						data3+="<option value="+this.id+" selected='selected'>"+this.documentName+"</option>";
					});
					$("#zbwj").html(data3);
				}
			}
		});
	}

	/**
	 * 保存
	 */
	$("#attachmentUpload").datagrid({
		title:"附件列表",
		rownumbers:true,
		striped:true,
		collapsible:true,
		url:ctx+"/attachment/listAttachment",
		idField:"fjid00",
		queryParams:{"fjsszt":$("#attachmentSsztId").val()==""?"-1":$("#attachmentSsztId").val()},
		height:200,
		columns:[[
		  {title:"附件名称",field:"fjmc00",width:300},
		  {title:"上传时间",field:"uploadTime",width:120},
		  {title:"附件大小",field:"length",width:80,align:"right",formatter:function(value){
			  return castSize(value);
		  }},
		  {title:"附件类型",field:"fjgslx",width:120}
		]]
	});

	loadAcquireTemplateList($("#projectInstanceId").val(),$("#projectItemId").val());
});