<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--项目信息确认 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新建项目信息</title>
<%-- <sys:link easyui="true" ztree="true"/> --%>
<sys:link easyui="true" jgrowl="true" plupload="true" ztree="true" uedit="true"/>
<script type="text/javascript">
$(function(){
	//验证复选框
	$.extend($.fn.validatebox.defaults.rules, {
        requireRadio: {  
            validator: function(value, param){ 
                return $("[name='"+param[0]+"']:checked").length>0;
            },  
            message: '请选择招标项目分类' 
        }  
    });

	$("[name='zjly00']").change(function(){
		$("[name='funding']").val($("[name='zjly00']:checked").map(function(){
			return $("[for='"+$(this).attr("id")+"']").text();
		}).get().join(","));
	}).change();
	var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : "approvalfile",
		url : ctx + '/attachment/uploadAttachment',
		flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
		silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
		multi_selection : false,
		multipart_params : {
			fjgslx : "30",
			unique : true
		},
		filters : {
			mime_types  : [ //允许上传图片、PDF和zip文件
                { title : "Image files", extensions : "jpg,png" },
                { title : "Pdf files", extensions : "pdf" },
                { title : "Compressed files", extensions : "zip,rar" }
			],
			prevent_duplicates : true,
			max_file_size : '200mb'
		},
		init : {
			PostInit : function() {
				//alert(1);
			},
			FilesAdded : function(up, files) {
				up.start();
			},
			UploadProgress : function(up, file) {

			},
			FileUploaded : function(up, file, result) {
				var ajax=$.parseJSON(result.response);
				if(ajax.success){
					alert("上传成功！");
					var attachmentId=ajax.data.fjid00;
					//alert(attachmentId);
					$("#attachmentId").val(attachmentId);
					$("#attachmentId").next("a").remove();
					$("#container").html("<a href=\""+ctx+"/attachment/download/"+ajax.data.path+"\" target='_blank'>预览<a>");
					//$("#attach").val(att);
				}
			},
			UploadComplete : function(uploader, files) {

			},
			Error : function(up, err) {

			}
		}
	}).init();
});

$(function(){
	$("#save_button").click(function(){
		
		$("#project_form").ajaxSubmit({
			url:"${pageContext.request.contextPath}/project/saveAProject",
			type:"post",
			dataType:"json",
			beforeSend:function(){
				var valid =  $("#project_form").form("validate");
				if(valid==true){
					$.messager.progress({
						title : "系统提示",
						msg : "正在提交数据"
					});
					$("#save_button").attr("disabled","disabled");
				}else{
					return false;
				}
			},
			
			success:function(result){
				if(result.success){
					$.messager.progress("close"); 
					$.messager.alert("系统提示",result.msg);
					window.location="${pageContext.request.contextPath}/project/view_list_a";
				}else{
					$.messager.progress("close"); 
					$.messager.alert("系统提示",result.msg,"error");
					$("#save_button").removeAttr("disabled");
				}
			},
			error:function(){
				alert("存取数据失败");
			}
		});	
	});
});




</script>

<script type="text/javascript">
	$(function(){
		$("#xuanze,#shuru-text").click(function(){
			//$("#text").value(null);
			var dialog=$("<div/>").appendTo($("body")).dialog({
				title:"招标人选取",
		 		top:200,
		 		modal:true,
		 		width:700,
		 		height:450,
		 		onClose:function(){
		 			dialog.dialog("destroy");
		 		},
		 		content:"<div id='organSelectDialogToolbar' style='width:100%;'>\
		 					<table style='width:100%'>\
		 						<tr>\
		 							<td>\
			 							单位名称：<input type=\"text\" id='shuru' class='inputxt' placeholder=\"请输入查询关键字\"/>\
			 						</td>\
			 						<td>\
			 							<a id='searchBtn' class='easyui-linkbutton' style='float:right;' data-options=\"iconCls:'icon-search'\">搜索</a>&nbsp;\
			 						</td>\
			 					</tr>\
		 					</table>\
		 				</div>\
		 				<table id='showTenderee'></table>",
		 		buttons:[{text:"确认",handler:function(){
		 			dialog.dialog("destroy");
		 		}}],
		 		onOpen:function(){
		 			$(this).find("#showTenderee").datagrid({
				 		fit:true,
				 		url:ctx+"/workflow/showTenderee",
				 		height :400,
				 		weigth:500,
						singleSelect : true,
						closed : false,
						modal : true,
						rownumbers : true,
						pagination : true,
						striped : true,
						animate : false,
						columns : [[
							{field : "ztmc00",title:"招标人",width:250},
							{field : "address",title:"地址",width:250},
							{field : "phone",title:"电话",width:150},
						]],
						onSelect:function(rowIndex,rowData){
							$("#shuru-text").val(rowData.ztmc00);
							$("#shuru-value").val(rowData.id);
						},
						toolbar:"#organSelectDialogToolbar"/* [
							{text:'<input type="text" id="shuru"/>'},
							{text: '搜索',iconCls:'icon-search',handler:function(){
								var ztmc00=$("#shuru").val();//获得输入框的值
								$("#showTenderee").datagrid("reload",{ztmc00:ztmc00});
							}} 
						]*/
					});	
					$("#searchBtn").click(function(){
						var ztmc00=$("#shuru").val();//获得输入框的值
						$("#showTenderee").datagrid("reload",{ztmc00:ztmc00});
					});	
					/* $("#shuru").keyup(function(){
						var ztmc00=$("#shuru").val();//获得输入框的值
						$("#showTenderee").datagrid("reload",{ztmc00:ztmc00});
					}); */
					$("#shuru").keydown(function(e){
						if(e.keyCode==13){
							var ztmc00=$("#shuru").val();//获得输入框的值
							$("#showTenderee").datagrid("reload",{ztmc00:ztmc00});
						}
					});
		 		}
			});		
		});
	});
	

	$(document).ready(function(){
		var pid="${project.id}";
		if(pid && pid!="" && pid!="null"){
			$("#container").html("<a href=\"/attachment/download/${project.approveFileAttachment.path}\" target='_blank'>预览</a>");
		}
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			新建项目
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class="clearfix">
				<form method="post" id="project_form" action="${pageContext.request.contextPath}/project/saveAProject" onsubmit="return $(this).form('validate');">
			
					<input type="hidden" name="token" value="${token}" /> 
					<input type="hidden" name="id" value="${project.id}" /> 
					<jsp:include page="createProject.jsp" />
					<div class="blank10"></div>
					<input type="button" class='button red' value="保 存"  id="save_button" /> <input type="reset" class='button red' value="重 置" />
				</form>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	<div id="zbOrgan">
		<table id="zbrTable"></table>
	</div>
</body>
</html>
