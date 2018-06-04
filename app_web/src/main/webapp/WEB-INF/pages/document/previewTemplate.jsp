<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" plupload="true" spectrum="true" jgrowl="true" webedit="true"/>

<script type="text/javascript">
var editable = true;
<c:if test="${editable == false}">
	editable = false;
</c:if>

	$(function() {
		//var a = "${path}";
		//alert(a);
		$("body").webEditor({
			user : {
				id : "${CURRENT_USER_SESSION_INFO.id}",
				name : "${CURRENT_USER_SESSION_INFO.userName}"
			},
			zoomPercent : 80,
			href : ctx+"/attachment/download/${path}",
			uploadURL : ctx+"/document/imageUpload",
			editable : editable,
			reviewable : true,
			onOpen : function() {
				var id = new Date().getTime();
				$("body").append("<div style='padding:10px' id='" + id + "'></div>");
				$("#" + id).dialog({
					width : 800,
					height : 600,
					closed : false,
					modal : true,
					loadingMessage : '正在加载...',
					title : "打开模板",
					href : ctx+"/document/templateDialog",
					onClose : function() {
						$("#" + id).dialog("destroy");
					},
					buttons : [ {
						text : "打开",
						color : "red",
						handler : function() {
							var data = $("#template-datagrid").datagrid("getSelected");
							if (data == null) {
								$.messager.alert("系统提示", "请选择一个模板");
							} else {
								window.location.href=ctx+"/document/editTemplate?templateId="+data.id
							}
						}
					}, {
						text : "取消",
						color : "red",
						handler : function() {
							$("#" + id).dialog("close");
						}
					} ]
				});
			},
			onSave : function(paramArray) {
				var options = this;
				//paramArray.push({name:"id",value:templateId});
				$.ajax({
					url :ctx+"/document/updateTemplate",
					type : "post",
					dataType : "json",
					data :paramArray,
					success : function(data) {
						if (data.success) {
							options.app.webEditor("refreshDocument",ctx+"/document/preview?id=" + templateId);
						} else {
							$.messager.alert("系统消息", data.msg);
						}
					}
				});
			},
			onSaveAs : function(paramArray) {
				var options = this;
				paramArray.push({name:"id",value:templateId});
				var id = new Date().getTime();
				$("body").append("<div style='padding:10px' id='" + id + "'></div>");
				$("#" + id).dialog({
					width : 600,
					height : 260,
					closed : false,
					modal : true,
					loadingMessage : '正在加载...',
					title : "模板另存为",
					href : ctx+"/document/createTemplateForm?id=" + templateId,
					onClose : function() {
						$("#" + id).dialog("destroy");
					},
					buttons : [ {
						text : "保存",
						color : "red",
						handler : function() {
							$.ajax({
								type:"post",
								url:ctx+"/document/createTemplate",
								data:$("#" + id + " form").serializeArray().concat(paramArray),
								dataType:"json",
								beforeSend:function(){
									return $("#" + id + " form").form("validate");
								},
								success:function(data){
									if (data.success) {
										templateId = data.data.id;
										options.app.webEditor("refreshDocument", [ ctx+"/document/preview?id=" + templateId ]);
										$("#" + id).dialog("close");
									}
									$.jGrowl(data.msg);
								}
							});
						}
					}, {
						text : "取消",
						color : "red",
						handler : function() {
							$("#" + id).dialog("close");
						}
					} ]
				});
			}
		});
		/* $("iframe").load(function(){
			var iframe=this;
			window.setTimeout(function(){
				$(".tree").tree({
					checkbox:false,
					data:$(iframe).contents().find("body .jckj-div").filter(function(index){
						var jckjSpan=$(this).children(".jckj-span");
						if(jckjSpan.length==0){
							return false;
						}
						for(var i=0,l=jckjSpan.length;i<l;i++){
							if($(jckjSpan[i]).css("fontWeight")<=400){
								return false;
							}
						}
						if($.trim($(this).text())==""){
							return false;
						}
						$(this).attr("id","node-"+index);
						return true;
					}).map(function(i){
						return {iconCls:"myicon-tag_blue",text:$.trim($(this).text()),id:$(this).attr("id"),toString:function(){
							return this.text;
						}};
					}).get(),
					onClick:function(node){
						$($(iframe).contents().get()).scrollTop($(iframe).contents().find("#"+node.id).offset().top);
					}
				});
			},500);
		}); */
	});
</script>
</head>
<body>

</body>
</html>