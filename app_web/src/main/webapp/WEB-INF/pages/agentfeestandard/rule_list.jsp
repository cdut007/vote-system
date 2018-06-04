<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<html>
	<head>
		<jsp:include page="/common/link.jsp" />
		<script type="text/javascript">
			$(function() {			
				$("#AgentRuleList").datagrid({
				title : "招标代理服务收费标准",
				height : 500,
				singleSelect :true,
				rownumbers : true,
				pagination : true,
				idField : "id",
				striped : true,
				modal:true,
				animate : false,
				url : ctx + "/agentfeestandard/agent_rule_detail",
				columns : [[
					{field:"id",checkbox:true},
			    	{field : "rule_name",title:"招标代理服务收费标准",width:150},
			    	{field : "create_time",title:"创建日期",width:150},
			    	{field : "create_user_name",title:"创建人",width:100},
			    	{field : "create_organ_name",title:"机构名称",width:150},
			    	{title:"操作",field:'opt',align:"center",width:170,formatter:function(value,rowData,rowIndex){
		    		return "<a class='button orange small edit' rowIndex='"+rowIndex+"'>详情</a><a class='button orange small dele' rowIndex='"+rowIndex+"'>删除</a>"
		    				+"<a class='button orange small update' rowIndex='"+rowIndex+"'>计算</a>";
		    		}}
				]],
				toolbar:[
					{text:"新增",iconCls:'icon-add',handler:function(){
						window.location="${pageContext.request.contextPath}/agentfeestandard/addAgentRule_form";
					}},
					{text:"刷新",iconCls:'myicon-arrow_refresh',handler:function(){
			 			$("#AgentRuleList").datagrid("reload");
					}},
					/*  {text:"计算",iconCls:'icon-sum',handler:function(){
			 			
					}} */
				],
				onOpen:function(){
					$(this).on("click","a.edit",function(){
						var rowIndex=parseInt($(this).attr("rowIndex"));
						var rowData=$("#AgentRuleList").datagrid("getRows")[rowIndex];
						//alert(rowData.id);
					 	var dialog=$("<div/>")/* .css("padding",10) */.appendTo($("body")).dialog({
					 		title:rowData["rule_name"],
					 		top:200,
					 		modal:true,
					 		width:610,
					 		height:350,
					 		onClose:function(){
					 			dialog.dialog("destroy");
					 		},
					 		content:"<table></table>",
					 		onOpen:function(){
					 			$(this).find("table:first").datagrid({
							 		fit:true,
							 		url:ctx+"/agentfeestandard/agent_charge_detail",
							 		height : 700,
									singleSelect : true,
									closed : false,
									modal : true,
									rownumbers : true,
									pagination : true,
									idField : "id",
									striped : true,
									animate : false,
									queryParams:{"id":rowData.id},
									columns : [[
					    				{field : "scope",title:"中标金额",width:200},
					   	 				{field : "workRate",title : "工程费率",align:"center",width : 120,formatter:function(value,row,index){
					   	 					return (value*100).toFixed(2)+"%";
					   	 					}},
					   	 				{field : "goodaRate",title : "货物费率",align:"center",width : 120,formatter:function(value,row,index){
					   	 					return (value*100).toFixed(2)+"%";
					   	 					}},
					   	 				{field : "serveRate",title : "服务费率",align:"center",width : 120,formatter:function(value,row,index){
					   	 					return (value*100).toFixed(2)+"%";
					   	 					}},
									]],
							 	});
					 		}					 		
					 	});
					});//详情
					$(this).on("click","a.dele",function(){
						if(confirm("您确定要删除吗？")==true){
							var rowIndex=parseInt($(this).attr("rowIndex"));
							var rowData=$("#AgentRuleList").datagrid("getRows")[rowIndex];
							//alert(rowData.id);
							var id=rowData.id;
							$.ajax({
								url:"${pageContext.request.contextPath}/agentfeestandard/deleteAgentRule",
								type:"post",
								data:{"id":id},
								dataType:"json",
								success:function(result){
									var flag=result.success;
									if(flag=true){
										alert(result.msg);
										$("#AgentRuleList").datagrid("reload");
									}
									if(flag=false){
										alert(result.msg);
									}
								},
								error:function(){
								alert("删除失败");
								}
							});
						}
					});//删除
					$(this).on("click","a.update",function(){
						var rowIndex=parseInt($(this).attr("rowIndex"));
						var rowData=$("#AgentRuleList").datagrid("getRows")[rowIndex];
						//alert(rowData.id);
						var id=rowData.id;
						window.location="${pageContext.request.contextPath}/agentfeestandard/countAgentCharge_form?id="+id;
					});//更新
				}
			});
			
		});
		</script>
		<script type="text/javascript">			
				
		</script>
	</head>
	<body>
		<jsp:include page="/common/top.jsp"/>
		<div class="blank10"></div>
		<div class="block ">
			<div class="AreaL">
				<%@include file="/common/left.jsp"%>
			</div>
			<div class="block">			
			</div>
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				招标代理服务收费标准
			</div>
			<!-- <div class="block ">
				<input type="button" value="服务费计算"/>
			</div> -->
			<div class="block">
				<div class="usBox">
					<table id="AgentRuleList"></table>
				</div>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	</body>
</html>