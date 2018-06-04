$(function() {
	var percent="<div class=\"progressbar easyui-fluid\" style=\"width: 127px; height: 20px;\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div><div class=\"progressbar-value\" style=\"width: 100%; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div></div></div>";

	function isNewFile(id){
		var isNewFile=$("div."+id).length==1;
		return isNewFile;
	}
	function isFullPercent(id){
		var isFullPercent=isNewFile(id)&&$("div."+id).progressbar("getValue")==100;
		return isFullPercent;
	}
	function isUploaded(id){
		var isUploaded=isFullPercent(id)&&$(":input."+id).length==1;
		return isUploaded;
	}
	//删除附件
	function removeAttachment(id){
		var rowIndex=$("#attachmentUpload").datagrid("getRowIndex",id)
		var row=$("#attachmentUpload").datagrid("getRows")[rowIndex];
		$.messager.confirm('系统提示','确定要删除该附件吗？',function(r){
			if(r){
				var timer=window.setInterval(function(){
					if(isUploaded(id)||!isNewFile(id)){//完成存储
						$.ajax({
							url : ctx+"/attachment/deleteAttachment",
							data:{"id":(isUploaded(id)?$(":input."+id).val():id)},
							type:"post",
							dataType:"json",
							success : function(data) {
								if(data.success){
									if(isUploaded(id)){
										uploader.removeFile(id);
										$(":input."+id).remove();
										
									}
									
									$("#attachmentUpload").datagrid("clearSelections");
									$("#attachmentUpload").datagrid("deleteRow",rowIndex);
									//loadDefaultNoticeContent();
								}
							}
						});
					}else if(isFullPercent(id)){//完成上传
						return;
					}else if(isNewFile(id)){//正在上传
						uploader.removeFile(id);
						$("#attachmentUpload").datagrid("deleteRow",rowIndex);
					}
					window.clearInterval(timer);
				},500);
			}
		});
	}

	
	//SetValue_onclick();
	$(document).on("click",".del",function(){
		removeAttachment($(this).attr("id"));
	});
	
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
		  {title:"进度",field:"status",width:150,align:"center",formatter:function(value){
			  return value?value:percent;
		  }},
		  {title:"附件类型",field:"fjgslx",width:120},
		  {title:"操作",field:"opt",width:120,align:'center',formatter:function(value,rowData,rowIndex){
			  return (rowData["path"]?"<a id=\""+rowData["fjid00"]+"\" class=\"del\">删除</a>&nbsp;<a target=\"_blank\" href=\""+ctx+"/attachment/download/"+rowData["path"]+"\">下载</a>":"");
		  }}
		]]
	});
	/*$("#attachment").datagrid({
		title:"附件列表",
		rownumbers:true,
		striped:true,
		url:ctx+"/attachment/listAttachment",
		idField:"fjid00",
		queryParams:{"fjsszt":$("#attachmentSsztId").val()==""?"-1":$("#attachmentSsztId").val()},
		height:200,
		columns:[[
		  {title:"附件名称",field:"fjmc00",width:300},
		  {title:"上传时间",field:"uploadTime",width:150},
		  {title:"附件大小",field:"length",width:150,align:"right",formatter:function(value){
			  return castSize(value);
		  }},
		  {title:"附件类型",field:"fjgslx",width:150},
		  {title:"操作",field:"opt",width:150,align:'center',formatter:function(value,rowData,index){
			  return "<a target=\"_blank\" href=\""+ctx+"/attachment/download/"+rowData["path"]+"\">下载</a>";
		  }}
		]]
	});*/

	
	var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : 'addAttachment',
		//container : document.getElementById('container'),
		url : ctx + '/attachment/uploadAttachment',
		flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
		silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
		multi_selection : true,
		multipart_params : {
			fjsszt :$("#attachmentSsztId").val()==""?"-1":$("#attachmentSsztId").val(),
			fjgslx:"33"
		},
		//file_data_name:"Filedata",
		//drop_element : 'drop_area',
		filters : {
			mime_types : [ //只允许上传图片和zip文件
				{ title : "Pdf files", extensions : "pdf" },
				{ title : "Word files", extensions : "doc,docx" }
				//{title : "Picture files", extensions : "jpg,png,bmp,gif"}
			],
			prevent_duplicates : true,//不允许选取重复文件
			max_file_size : '5000mb'//最大只能上传400kb的文件
		},
		init : {
			PostInit : function() {
			},
			FilesAdded : function(up, files) {

				if($("#id").val()==""){
					$("#attachmentUpload").datagrid("options").queryParams["fjsszt"]=$("#id").val();
				}
				for(var i=0;i<files.length;i++){
					var file=files[i];
					$("#attachmentUpload").datagrid("appendRow",{
						 id:file.id,
						 fjid00:file.id,
						 fjmc00:file.name,
						 status:"<div class='" + file.id + "' style='width:100%;'></div>",
						 uploadTime:new Date().format("yyyy-MM-dd HH:mm:ss"),
						 length:file.size,
						 fjgslx:""
					});
					$("div." + file.id).progressbar({});
				}
				up.start();
			},
			UploadProgress : function(up, file) {
				$("div." + file.id).progressbar("setValue", file.percent);
			},
			FileUploaded : function(up, file, result) {
				var data=$.parseJSON(result.response);
				data.data.id=file.id;
				data.data.status=percent;
				
				$($("#attachmentUpload").datagrid("getRows")).each(function(index){
					if(this.id==data.data.id){
						$("#attachmentUpload").datagrid("updateRow",{index:index,row:data.data});
					}
				});
				$("#tenderApplicationForm").append($("<input/>").attr("type","hidden").addClass(file.id).val(data.data.fjid00));
				up.removeFile(file);
				//loadDefaultNoticeContent();
				//$("div."+file.id).find(".progressbar-text").html("完成");
				//$("div."+file.id).find(".progressbar-value,.progressbar-text").css({backgroundColor:'#0095cd'});
			},
			UploadComplete : function(uploader, files) {
			},
			Error : function(up, err) {
			},
			FilesRemoved:function(up,files){
				
			}
		}
	});
	uploader.init();
	//印章验证
	/*if($("#id").val()!=""){
		sealUtil.loadAllSealWithBusinessKey($("#id").val());
	}*/
});