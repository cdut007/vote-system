<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function(){
	function createOrUpdate${entityTemplate.simpleEntityName}(<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>){
		var dialogId=new Date().getTime();
		$("<div/>").attr("id",dialogId).appendTo($("body")).dialog({
			width : <#if width??>${width}<#else>600</#if>,
			height :<#if height??>${height}<#else>400</#if>,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "添加<#if entityTemplate.comment??>${entityTemplate.comment}<#else>${entityTemplate.entityName}</#if>",
			href : ctx + "/${entityTemplate.entityInstanceName}/${entityTemplate.entityInstanceName}Edit",
			queryParams:{<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>:<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>},
			onLoad:function(){
				//do Nothing
			},
			onClose : function() {
				$("#" + dialogId).dialog("destroy");
			},
			buttons : [ {
				text : "确认",
				color : "red",
				handler : function() {
					$("#" + dialogId + " form").ajaxSubmit({
						beforeSend : function() {
							return $("#" + dialogId + " form").form("validate");
						},
						dataType : "json",
						success : function(data) {
							if (data.success) {
								$('#' + dialogId).dialog('close');
								$('#${entityTemplate.entityInstanceName}-datagrid').datagrid('reload');
							}
							$.jGrowl(data.msg);
						}
					});
				}
			}, {
				text : "取消",
				color : "red",
				handler : function() {
					$("#" + dialogId).dialog("destroy");
				}
			} ]
		});
	}
	function delete${entityTemplate.simpleEntityName}(<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>){
		$.messager.confirm("系统提示","确认删除吗?",function(ok){
			if(ok){
				$.ajax({
					url:ctx+"/${entityTemplate.entityInstanceName}/delete${entityTemplate.simpleEntityName}",
					type:"post",
					dataType:"json",
					data:$(<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>).map(function(){ return "<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>="+this;}).get().join("&"),
					success:function(data){
						if(data.success){
							$("#${entityTemplate.entityInstanceName}-datagrid").datagrid("reload");
						}
						$.jGrowl(data.msg);
					}
				});
			}
		});
	}
	$("#${entityTemplate.entityInstanceName}-datagrid").datagrid({
		title:"<#if entityTemplate.comment??>${entityTemplate.comment}<#else>${entityTemplate.tableName}</#if>列表",
		url:ctx+"/${entityTemplate.entityInstanceName}/paging${entityTemplate.simpleEntityName}Data",
		pagination:true,
		rownumbers:true,
		striped:true,
		method:"post",
		<#if entityTemplate.primaryFieldWithMappingSize gt 1>
		idField:"${entityTemplate.entityInstanceName}Id",
		<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>
		idField:"${entityTemplate.primaryFieldWithMappingList[0].fieldName}",
		</#if>
		toolbar:[
			{text:"添加",handler:function(){
				createOrUpdate${entityTemplate.simpleEntityName}();
			}},
			{text:"编辑",handler:function(){
				var rows=$("#${entityTemplate.entityInstanceName}-datagrid").datagrid("getChecked");
				if(rows.length!=1){
					$.jGrowl("请选择一条要编辑的数据!");
					return;
				}
				createOrUpdate${entityTemplate.simpleEntityName}(rows[0]["<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>"]);
			}},
			{text:"删除",handler:function(){
				var rows=$("#${entityTemplate.entityInstanceName}-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选要删除的数据!");
					return;
				}
				delete${entityTemplate.simpleEntityName}($(rows).map(function(){return this["<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>"];}).get());
			}}
		],
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				createOrUpdate${entityTemplate.simpleEntityName}($(this).parent().parent().parent().children("td:first").find(":checkbox").val());
			});
			$(this).on("click","a.delete",function(){
				delete${entityTemplate.simpleEntityName}([$(this).parent().parent().parent().children("td:first").find(":checkbox").val()]);
			});
		},
		columns:[[
			<#if entityTemplate.primaryFieldWithMappingSize gt 0>
			{field:"${entityTemplate.entityInstanceName}Id",checkbox:true},
			<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>
			{field:"${entityTemplate.primaryFieldWithMappingList[0].fieldName}",checkbox:true},
			</#if>
			<#list entityTemplate.fieldWithMappingList as fieldWithMapping>
			<#if !fieldWithMapping.primary>
			{title:"<#if fieldWithMapping.comment??>${fieldWithMapping.comment}<#else>${fieldWithMapping.fieldName}</#if>",field:'${fieldWithMapping.fieldName}',align:"left"/*,width:100*/},<#--<#if fieldWithMapping_index!=entityTemplate.fieldWithMappingList?size-1>,</#if>-->
			</#if>
			</#list>
			{title:"操作",field:"opt",width:120,formatter:function(value,rowData,rowIndex){
				return "<a class=\"button orange small edit\">编辑</a><a class=\"button red small delete\">删除</a>";
			}}
		]]
	});
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here"> 
			当前位置: <a href="${r'${pageContext.request.contextPath}'}/">首页</a>
			<code>&gt;</code>
			企业管理
			<code>&gt;</code>
			<#if entityTemplate.comment??>${entityTemplate.comment}<#else>${entityTemplate.entityName}</#if>管理
		</div>
	</div>
	<div class="block">
		<table id="${entityTemplate.entityInstanceName}-datagrid"></table>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>