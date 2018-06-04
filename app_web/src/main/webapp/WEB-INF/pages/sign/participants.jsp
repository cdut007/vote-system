<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply" />
<c:set value="${expertApply.projectInstance}" var="projectInstance" />
<c:set var="jt_benchmarkList" value="${benchmarkService.findAllChooseTBBenchmarks_jt()}"></c:set>
<c:set var="fwsz_benchmarkList" value="${benchmarkService.findAllChooseTBBenchmarks_fwsz()}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" jgrowl="true"/>
<style type="text/css">
.centerss {
 /* height: 150px; */
 width: 1000px;
 margin: auto;
 text-align: center;
 line-height:40px;
}
</style>
<!-- <script src="/resources/print/jquery.PrintArea.js"/> -->
<script type="text/javascript">

	function exdetail(id)
	{
		var dialog=undefined;
		dialog=$("<div/>").css("padding",10).appendTo($("body")).dialog({
			title : "异常报告详情",
			//closed : true,
			width : 600,
			height : 450,
			href:ctx+"/evaluation/exceptionDetail?id="+ id,
			buttons : [
				{
					text : "关闭",
					handler : function() {
						dialog.dialog("destroy");
					}
				} ]
		});
	};
	function reloadBidOpenList(projectItemId){
		if(projectItemId==undefined||projectItemId==null){
			$(".bidOpen-datagrid").each(function(){
				$(this).datagrid("reload");
			});
		}else{
			$("#"+projectItemId).datagrid("reload");
		}
		$(".allBidOpen-datagrid").datagrid("reload");
	};
	function reloadSignList(){
		$("#sign-datagrid").datagrid("reload");
	};
	function hidedate(value, row, index) {
		if (row["isConfirm"] == "已确认") {
			return value;
		} else {
			//if ("${CURRENT_USER_SESSION_INFO.organId}" == row["organId"]) {
				return value;
			//}
			//return "******";
		}
	};
	$(function() {
		dwr.engine.setActiveReverseAjax(true); // 激活反转 重要
		function castPriceScore(expertApplyId,projectItemId){
			$.ajax({
				url:ctx+"/evaluation/castPriceScore",
				type:"post",
				data:{expertApplyId:expertApplyId,projectItemId:projectItemId},
				dataType:"json",
				success:function(data){
					$.messager.alert("系统提示",data.msg);
				}
			});
		};
		
		
		$(".allBidOpenUserTask").datagrid({
			/* title : "开标人员待办任务列表", */
			url : ctx + "/bidOpen/listBidOpenUserTask",
			striped : true,
			rownumbers : true,
			collapsible : true,
			method : "post",
			height : 400,
			idField : "taskId",
			queryParams : {
				expertApplyId : $(":input[name='expertApplyId']").val()
			},
			onLoadSuccess:function(){
				var datagrid=$(this);
				window.setTimeout(function(){
					datagrid.datagrid("reload");
				},15000);
			},
			columns : [ [ 
				{title : "机构名称",field : 'organName'}, 
				{title : "姓名",field : 'userName'}, 
				{title : "联系电话",field : 'phone'}, 
				{title : "电子邮箱",field : 'email'}, 
				{title : "任务名称",field : 'taskName'}, 
				{title : "任务描述",field : 'description'}, 
				{title : "任务时间",field : 'createTime'} 
			] ],
			toolbar : [ {
				text : "刷新",
				iconCls : 'myicon-arrow_refresh',
				handler : function() {
					$(".allBidOpenUserTask").datagrid("reload");
				}
			} ]
		});
		
		$(".bidOpenUserTask").each(function(){
			var idValue=$(this).attr("id");
			$(this).datagrid({
				/* title : "开标人员待办任务列表", */
				url : ctx + "/bidOpen/listBidOpenUserTask",
				striped : true,
				rownumbers : true,
				collapsible : true,
				method : "post",
				height : 400,
				idField : "taskId",
				queryParams : {
					expertApplyId : $(":input[name='expertApplyId']").val(),
					projectItemId : idValue
				},
				onLoadSuccess:function(){
					var datagrid=$(this);
					window.setTimeout(function(){
						datagrid.datagrid("reload");
					},15000);
				},
				columns : [ [ 
					{title : "机构名称",field : 'organName'}, 
					{title : "姓名",field : 'userName'}, 
					{title : "联系电话",field : 'phone'}, 
					{title : "电子邮箱",field : 'email'}, 
					{title : "任务名称",field : 'taskName'}, 
					{title : "任务描述",field : 'description'}, 
					{title : "任务时间",field : 'createTime'} 
				] ],
				toolbar : [{
					text : "刷新",
					iconCls : 'myicon-arrow_refresh',
					handler : function() {
						$("#"+idValue).datagrid("reload");
					}
				} ]
			});
		});

		$(".bidOpen-datagrid").each(function(){
			var projectItemId=$(this).attr("id");
			$(this).datagrid({
				//title : "开标一览表",
				url : ctx + "/bidFile/list",
				//pagination : true,
				sortName:"tbbjje",
		 		sortOrder:"asc",
				rownumbers : true,
				striped : true,
				//height : 400,
				fit:true,
				method : "post",
				sortName: "envelopeTypeOrder",
				queryParams : {
					expertApplyId : $(":input[name='expertApplyId']").val(),
					projectItemId:projectItemId
				},
				onLoadSuccess:function(){
					/* var datagrid=$(this);
					window.setTimeout(function(){
						datagrid.datagrid("reload");
					},3000); */
				},
				columns : [ [ 
					{field : 'organProjectItemCode',title : "标段编号",hidden:true}, 
					{field : 'projectItemName',title : "标段名称",hidden:true}, 
					{field : 'organBName',title : "投标单位",width:250,align : "center",formatter : hidedate}, 
					{field : 'tbbjje',title : "投标报价(元)",align : "center",width : 160,sortable:true,order:"asc",formatter:function(value, row, index){
						if (row["isConfirm"] == "已确认") {
						if(value && value!=null){
							if(row.tbbjdw == "2"){
								return value + "(万元)";
							}
							
							return value + "(元)";
						}else{
							return "";
						}
						}else{
							return "";
						}
						
					}},
					{field : 'bidPartPrice',title : "分部分项工程费合价(元)",align : "center",width : 100}, 
					{field : 'bidMeasurePrice',title : "措施项目费合价(元)",align : "center",width : 100}, 
					{field : 'gq0000',title : "工期（交货期、服务周期）",width : 150,formatter:function(value, row, index){
						
						if(row.envelopeTypeOrder=="second"){
							return "";
						}
						
						return value;
	
					}}, 
					{field : 'bidDepositAmount',title : "投标保证金额(元)",width : 160,formatter : hidedate,hidden : true}, 
					{field : 'isContributeDeposit',title : "是否缴纳投标保证金",align : "center",width : 200,formatter : function(value, row, index) {
						if (row["isConfirm"] == "已确认") {
							if ("0" == value) {
								return "待确认";
							} else if ("3" == value) {
								return "未上传";
							} else if ("1" == value) {
								return "已缴费";
							} else if ("2" == value) {
								return "未缴费";
							} else if ("4" == value) {
								return "无需缴纳";
							} else {
								return "未确认";
							}
						} else {
							if ("${CURRENT_USER_SESSION_INFO.organId}" == row["organId"]) {
								return "";
							}
							return "******";
						}
					}}, 
					 /*{field : 'tbsj00',title : "文件递交时间",align : "center",width : 120,formatter : hidedate},*/ 
					{field : 'isConfirm',title : "投标结果是否确认",align : "center",width : 100},
					{field : 'envelopeTypeOrder',title : "信封顺序",align : "center",width : 100,formatter:function(value, row, index){
						
						if(row.envelopeTypeOrder=="second"){
							return "第二信封";
						}
						
						return "第一信封";
	
					}}
				] ],
				toolbar : [ {
					id : "decrypt-btn-"+projectItemId,
					text : "开始解密",
					iconCls : 'myicon-application_add',
					handler : function() {
						$.messager.confirm("系统提示","是否开始解密?",function(r){
							if(r){
								$(".bidOpen-datagrid").datagrid("reload");
								$.ajax({
									url : ctx + "/sign/openDecrypt",
									type : "POST",
									dataType : "json",
									data : {
										expertApplyId : $(":input[name='expertApplyId']").val(),
										projectItemId:projectItemId
									},
									success : function(data) {
										if (data.success) {
											$("#decrypt-btn-"+projectItemId).linkbutton("disable");
									}
										$.jGrowl(data.msg);
									}
									});
									}
									});

					}
				},{
					id:"endDecode-btn-"+projectItemId,
					text:"结束解密",
					iconCls:"myicon-application_add",
					handler:function(){
					  $.messager.confirm("系统提示","是否结束解密?",function(r){
					  	if(r){
						$(".bidOpen-datagrid").datagrid("reload");
						$.ajax({
							url : ctx + "/sign/endDecodeSignal",
							type : "POST",
							dataType : "json",
							data : {
								expertApplyId : $(":input[name='expertApplyId']").val(),
								projectItemId:projectItemId
							},
							success : function(data) {
								if (data.success) {
									$("#endDecode-btn-"+projectItemId).linkbutton("disable");
								}
								$.jGrowl(data.msg);
							}
						});}
						});

					}
				},{
					id:"beginDecode-btn-second-"+projectItemId,
					text:"第二信封解密开始",
					iconCls:"myicon-application_add",
					handler:function(){
					  $.messager.confirm("系统提示","是否开始第二信封解密?",function(r){
					  	if(r){
						$(".bidOpen-datagrid").datagrid("reload");
						$.ajax({
							url : ctx + "/sign/openSecondDecrypt",
							type : "POST",
							dataType : "json",
							data : {
								expertApplyId : $(":input[name='expertApplyId']").val(),
								projectItemId:projectItemId
							},
							success : function(data) {
								if (data.success) {
									$("beginDecode-btn-second-"+projectItemId).linkbutton("disable");
								}
								$.jGrowl(data.msg);
							}
						});}
						});

					}
				},{
					id:"endDecode-btn-second-"+projectItemId,
					text:"第二信封结束解密",
					iconCls:"myicon-application_add",
					handler:function(){
					  $.messager.confirm("系统提示","是否结束第二信封解密?",function(r){
					  	if(r){
						$(".bidOpen-datagrid").datagrid("reload");
						$.ajax({
							url : ctx + "/sign/endScondDecodeSignal",
							type : "POST",
							dataType : "json",
							data : {
								expertApplyId : $(":input[name='expertApplyId']").val(),
								projectItemId:projectItemId
							},
							success : function(data) {
								if (data.success) {
									$("endDecode-btn-second-"+projectItemId).linkbutton("disable");
								}
								$.jGrowl(data.msg);
							}
						});}
						});

					}
				},{
					iconCls:"myicon-calculator",
					text:"重新计算报价分",
					handler:function(){
						castPriceScore($(":input[name='expertApplyId']").val(),projectItemId);
					}
				},{
					//开标时可以多个标段同时开标，投标文件针对标段，所以在标段里面发起
					iconCls:"myicon-calculator",
					text:"发起算术性错误修正表",
					handler:function(){
						
						var url = '/bidFile/bidfile_revise?expertApplyId=' + $(":input[name='expertApplyId']").val() + '&projectItemId=' + projectItemId;
						$("#price_adjust").attr("href", url);
						$("#price_adjust span").click();
						
					}
				},{
					iconCls:"myicon-calculator_error",
					text:"异常报告",
					handler : function() {
						var dialog=$("<div/>").appendTo($("body")).dialog({
							title:"异常报告列表",
							top:400,
							modal:true,
							width:1000,
							height:600,
							onClose:function(){
								dialog.dialog("destroy");
							},
							content:"<table></table>",
							onOpen:function(){
								var id=new Date().getTime();

								$(this).find("table:first").attr("id",id).datagrid({
									fit:true,
									url:ctx+"/evaluation/exceptionList",
									//height : 900,
									multiSort:true,
									sortName:"projectItemNo,tenderOffer",
									sortOrder:"asc,asc",
									singleSelect : true,
									closed : false,
									modal : true,
									rownumbers : true,
									pagination : true,
									idField : "tenderItemId",
									striped : true,
									animate : false,
									queryParams:{
										"expertApplyId":"${processBusinessKey}",
										"projectItemId":projectItemId
									},
									toolbar:[{
										text : "提交异常报告",
										size:"large",
										iconCls : "myicon-qiandao",
										handler : function() {
											var dialog=undefined;

											dialog=$("<div/>").css("padding",10).appendTo($("body")).dialog({
												title : "录入招标异常报告",
												//closed : true,
												width : 600,
												height : 450,
												href:ctx+"/evaluation/exceptionReport?expertApplyId=${processBusinessKey}&projectItemId=" + projectItemId+"&projectInstanceId=${projectInstance.id}&projectId=${projectInstance.project.id}",
												buttons : [ {
													text : "提交",
													handler : function() {
														dialog.children("form").ajaxSubmit({
															type : "POST",
															dataType : 'json',
															data:{

															},
															beforeSend : function() {
																return dialog.children("form").form("validate");
															},
															success : function(data) {
																if (data.success) {
																	//$("#sign-dialog").children("form").find(":input").filter(function(){ return $(this).attr("name")!="expertApplyId";}).val("");
																	dialog.dialog("destroy");
																	$("#xxxx").datagrid("reload");
																	//$("#sign-datagrid").datagrid("reload");
																	$("#" +id).datagrid("reload");
																}
																$.jGrowl(data.msg);
															},
															error : function() {

															}
														});
													}
												}, {
													text : "取消",
													handler : function() {
														dialog.dialog("destroy");
													}
												} ]
											});
											//$("#sign-dialog").dialog("open");
										}
									}],
									columns : [[
										{field : 'expertApplyId',title : "项目名称",align : "center",width :90},
										{field : 'expertApply.projectInstanceName',title : "招标项目",align : "center",width : 90},
										{field : 'projectItem._toString',title : "标段名称",align : "center",width : 120},
										{field : 'exceptionTitle',title : "报告名称",align : "center",width : 120},

										{field : 'status',title : "状态",align : "center",width : 200,formatter : function(value, row, index) {
											if (0 == value) {
												return "新建";
											} else if (2 == value) {
												return "代理机构审核未通过";
											} else if (1 == value) {
												return "待审核";
											}else if (3 == value) {
												return "招标人审核未通过";
											}else if (4 == value) {
												return "公共服务平台审核未通过";
											}else if (9 == value) {
												return "审核通过";
											}else if (-1 == value) {
												return "驳回";
											}
										}},
										{field : 'createTime',title : "创建时间",align : "center",width : 120},
										{field : 'responseTime',title : "操作时间",align : "center",width : 120},
										{field : 'id',title : "操作",align : "center",width : 120,formatter:function(value,rowData,rowIndex){

											var aa = "<a class='button red small' onclick='exdetail(\"" + value + "\")'>详情</a>";
											return aa;

										}}
									]]
								});
							}
						});
					}
				}, {
					text : "刷新",
					iconCls : 'myicon-arrow_refresh',
					handler : function() {
						$("#"+projectItemId).datagrid("reload");
					}
				} ]
			});
		});

		$(".allBidOpen-datagrid").datagrid({
			//title : "开标一览表",
			url : ctx + "/bidFile/list",
			//pagination : true,
			multiSort:true,
	 		sortName:"bdbh00,tbbjje",
	 		sortOrder:"asc,asc",
			rownumbers : true,
			striped : true,
			//height : 400,
			fit:true,
			method : "post",
			sortName: "envelopeTypeOrder",
			queryParams :{
				expertApplyId : $(":input[name='expertApplyId']").val()
			},
			onLoadSuccess:function(){
				/* var datagrid=$(this);
				window.setTimeout(function(){
					datagrid.datagrid("reload");
				},3000); */
			},
			columns : [
				
				[{field : 'bdbh00',title : "标段编号",hidden:true}, 
				{field : 'organProjectItemCode',title : "标段编号"},
				{field : 'projectItemName',title : "标段名称"}, 
				{field : 'organBName',title : "投标单位",width:250,align : "center",formatter : hidedate}, 
				{field : 'tbbjje',title : "投标报价",align : "center",width : 160,formatter : function(value, row, index){
					
					if(value && value!=null){
						if(row.tbbjdw == "2"){
							return value + "(万元)";
						}
						
						return value + "(元)";
					}else{
						return "";
					}
					
				},sortable:true,order:"asc"}, 
				{field : 'gq0000',title : "工期（交货期、服务周期）",width : 150,formatter:function(value, row, index){
					
					if(row.envelopeTypeOrder=="second"){
						return "";
					}
					
					return value;

				}}, 
				{field : 'bidPartPrice',title : "分部分项工程费合价(元)",align : "center",width : 100}, 
				{field : 'bidMeasurePrice',title : "措施项目费合价(元)",align : "center",width : 100}, 
				{field : 'bidDepositAmount',title : "投标保证金额(元)",width : 160,formatter : hidedate,hidden : true}, 
				{field : 'isContributeDeposit',title : "是否缴纳投标保证金",align : "center",width : 200,formatter : function(value, row, index) {
					if (row["isConfirm"] == "已确认") {
						if ("0" == value) {
							return "待确认";
						} else if ("3" == value) {
							return "未上传";
						} else if ("1" == value) {
							return "已缴费";
						} else if ("2" == value) {
							return "未缴费";
						} else if ("4" == value) {
							return "无需缴纳";
						} else {
							return "未确认";
						}
					} else {
						if ("${CURRENT_USER_SESSION_INFO.organId}" == row["organId"]) {
							return "";
						}
						return "******";
					}
				}}, 
				/*{field : 'tbsj00',title : "文件递交时间",align : "center",width : 120,formatter : hidedate},*/ 
				{field : 'isConfirm',title : "投标结果是否确认",align : "center",width : 100},
				{field : 'envelopeTypeOrder',title : "信封顺序",align : "center",width : 100,formatter:function(value, row, index){
					
					if(row.envelopeTypeOrder=="second"){
						return "第二信封";
					}
					
					return "第一信封";

				}}
				/*{field : 'projectItemIds',title : "操作",formatter:function(value,rowData,rowIndex){
					return "<a class=\"button orange small edit\">查看详情</a>";
				}} */
			] ],
			toolbar : [ {
				text:"打印开标一览表",iconCls:"myicon-paste_word",
				handler:function(){
					$(".allBidOpen-datagrid").printEasyUIDataGridArea();
				}
			},{
				text:"导出开标一览表",iconCls:"myicon-page_excel",
				handler:function(){
						 var kbsj="<fmt:formatDate value='${expertApply.bidOpenDate}' pattern='yyyy年MM月dd日HH时mm分ss秒' />";
						 var beforTable=
		 					"<table>" +
				     			 "<thead>" +
				      					"<tr><td style='border:10px solid #000;' colspan='8'>项目名称:${projectInstance.zbxmmc}</td></tr>"+
				      					"<tr><td style='border:10px solid #000;' colspan='8'>项目编号:${expertApply.zbxmbh}</td></tr>"+
				      					"<tr><td style='border:10px solid #000;' colspan='8'>开标时间:"+kbsj+"</td></tr>"+
				      			"<thead>"+
				      			"<tbody></tbody>"+
							"</table>";
							
					$(".allBidOpen-datagrid").exportEasyUIDataGridArea("${projectInstance.zbxmmc}"+"["+"开标一览表"+"]",beforTable);
				}
			},{
				id : "decrypt-btn-all",
				text : "一键全部开始解密",
				iconCls : 'myicon-lock_open',
				handler : function() {
					$.messager.confirm("系统提示","是否一键全部开始解密?",function(r){
					
					if(r){
					$(".allBidOpen-datagrid").datagrid("reload");
					$.ajax({
						url : ctx + "/sign/openDecrypt1",
						type : "POST",
						dataType : "json",
						data :/* param, */ {
							expertApplyId : $(":input[name='expertApplyId']").val()
						},
						success : function(data) {
							if (data.success) {
								$("#decrypt-btn-all").linkbutton("disable");
							}
							$.jGrowl(data.msg);
						}
					});
					
					}						
					});
					
					}

			},{
				id:"endDecode-btn-all",
				text:"一键全部结束解密",
				iconCls:"myicon-lock_break",
				handler:function(){
					$.messager.confirm("系统提示","是否一键全部结束解密?",function(r){
						if(r){
								
								$.ajax({
									url : ctx + "/sign/endDecodeSignal1",
									type : "POST",
									dataType : "json",
									data : {
										expertApplyId : $(":input[name='expertApplyId']").val()
									},
									success : function(data) {
										if (data.success) {
										}
										$("#endDecode-btn-all").linkbutton("disable");
										$.jGrowl(data.msg);
									}
								});
								$(".allBidOpen-datagrid").datagrid("reload");
							}
							});

				}
			},{
				id:"endDecode_time_all",
				text:"解密时长设置",
				iconCls:"myicon-clock_edit",
				handler:function(){
					openDecodeEndTimeWindow();
				}
			},{
				text:"开标结束",
				iconCls:"myicon-clock_edit",
				handler:function(){
					var dialog=$("<div/>").appendTo($("body")).dialog({
				 		title:"开标详细情况预览",
				 		top:400,
				 		modal:true,
				 		width:600,
				 		height:400,
				 		onClose:function(){
				 			dialog.dialog("destroy");
				 		},
				 		content:"<form action='"+ctx+"/bidOpen/bidOpenEnd' method='post'>\
				 					<input name='expertApplyId' type='hidden' value='"+$(":input[name='expertApplyId']").val()+"'/>\
				 					<table class='mytableStyle'>\
					 					<tr><th>评标开始时间</th><td><input name='evaluationBeginTime' class='easyui-datetimebox' data-options=\"required:true\"/></td></tr>\
					 					<tr><th>评标结束时间</th><td><input name='evaluationEndTime' class='easyui-datetimebox' data-options=\"required:true\"/></td></tr>\
					 					<tr><th>提示消息</th><td><textarea name='message' style='height:240px;'>请投标人在评标时间段内密切关注平台信息。</textarea></td></tr>\
				 				 	</table>\
				 				 </form>",
				 		buttons:[{
				 			text:"提交",
				 			handler:function(){
				 				$.messager.confirm("系统提示","确认开标结束吗？",function(ok){
				 					dialog.find("form").ajaxSubmit({
					 					beforeSend:function(){
											return ok&&dialog.find("form").form("validate");
										},
					 					dataType:"json",
					 					success:function(data){
					 						$.messager.alert("系统提示",data.msg);
					 						if(data.success){
					 							dialog.dialog("destroy");
					 						}
					 					}
					 				});
				 				});
				 			}
				 		},{
				 			text:"关闭",
				 			handler:function(){
				 				dialog.dialog("destroy");
				 			}
				 		}]			 		
				 	});
				}
			},{
				text:"评标结束",
				iconCls:"myicon-clock_edit",
				handler:function(){
					$.messager.confirm("系统提示","确认评标结束吗？",function(ok){
						$.ajax({
							beforeSend:function(){
								return ok;
							},
							url:ctx+"/bidOpen/evaluationEnd",
							data:{expertApplyId:$(":input[name='expertApplyId']").val()},
		 					dataType:"json",
		 					success:function(data){
		 						$.messager.alert("系统提示",data.msg);
		 					}
		 				});
					});
					
				}
			},{
				text : "查看详情",
				iconCls : 'icon-save',
				handler : function() {
					var dialog=$("<div/>").appendTo($("body")).dialog({
				 		title:"开标详细情况预览",
				 		top:400,
				 		modal:true,
				 		width:1000,
				 		height:600,
				 		onClose:function(){
				 			dialog.dialog("destroy");
				 		},
				 		content:"<table></table>",
				 		onOpen:function(){
				 			var id=new Date().getTime();
				 			$(this).find("table:first").attr("id",id).datagrid({
						 		fit:true,
						 		url:ctx+"/bidFile/vwBidOpenDetailList",
						 		//height : 900,
						 		multiSort:true,
						 		sortName:"projectItemNo,tenderOffer",
						 		sortOrder:"asc,asc",
								singleSelect : true,
								closed : false,
								modal : true,
								rownumbers : true,
								pagination : true,
								idField : "tenderItemId",
								striped : true,
								animate : false,
								queryParams:{"expertApplyId":"${processBusinessKey}"},
								toolbar:[ {
									text:"打印开标详细表",iconCls:"myicon-paste_word",
									handler:function(){
										$("#"+id).printEasyUIDataGridArea();
									}
								},{
									text:"导出开标详细表",iconCls:"myicon-page_excel",
									handler:function(){
										$("#"+id).exportEasyUIDataGridArea("开标详细表");
									}
								}],
								columns : [[
									{field : 'biddingProject',title : "招标项目",align : "center",width :90},
									{field : 'tenderee',title : "招标人",align : "center",width : 90}, 
									{field : 'projectItemNo',title : "标段编号",align : "center",width : 120,hidden:true},
									{field : 'projectItemName',title : "标段名称",align : "center",width : 120},
									//{field : 'projectItemId',title : "标段id",align : "center",width : 120,formatter : hidedate},
									{field : 'tenderer',title : "投标单位",align : "center",width : 120}, 
									{field : 'reviewStatus',title : "审核状态",align : "center",width : 90},
									{field : 'depositRecordAmt',title : "保证金到账金额",align : "center",width :90},
									{field : 'tenderName',title : "投标人姓名",align : "center",width : 90}, 
									{field : 'signState',title : "签到状态",align : "center",width : 70},
									{field : 'decryptStatus',title : "解密状态",align : "center",width : 70},
									{field : 'tenderOffer',title : "投标报价",align : "right",width : 70,sortable:true,order:"asc"},
									{field : 'tenderPath',title : "操作",align : "center",width : 120,formatter:function(value,rowData,rowIndex){
										return value==null?"":"<a class=\"button orange small edit\" href=\""+value+"\">下载</a>";
									}}
								]]
						 	});
				 		}					 		
				 	});
				}
			}, {
				text : "刷新",
				iconCls : 'myicon-arrow_refresh',
				handler : function() {
					$(".allBidOpen-datagrid").datagrid("reload");
				}
			}]
		});
		$("#sign-datagrid").datagrid({
			fit:true,
			title : "人员签到列表",
			url : ctx + "/sign/pagingParticipantsData",
			//url:ctx+"/bidFile/list",
			//pagination : true,
			rownumbers : true,
			striped : true,
			//collapsible : true,
			//height : 400,
			method : "post",
			queryParams : {
				expertApplyId : "${processBusinessKey}"
			},
			onLoadSuccess:function(){
				/* var datagrid=$(this);
				window.setTimeout(function(){
					datagrid.datagrid("reload");
				},3000); */
			},
			columns : [ [ 
				{hidden : true,field : 'id',checkbox : true}, 
				{title : "参会姓名",field : 'userName',align : "center",width : '10%'}, 
				{title : "身份证号",field : 'userNumber',width : '20%',align : "center"}, 
				{title : "项目名称",field : 'projectInstanceName',hidden:true}, 
				{title : "签到时间",field : 'signtime',width : '20%',align : "center"}, 
				{title : "单位名称",field : 'unitName',align : "center",width : '15%'}, 
				{title : "联系方式",field : 'phoneNumber',align : "center",width : '15%'}, 
				{title : "用户类型",field : 'userType',align : "center"}
			] ],
			toolbar : [ {
				text:"打印签到列表",iconCls:"myicon-paste_word",
				handler:function(){
					$("#sign-datagrid").printEasyUIDataGridArea();
				}
			},{
				text:"导出签到列表",iconCls:"myicon-page_excel",
				handler:function(){
					$("#sign-datagrid").exportEasyUIDataGridArea();
				}
			},{
				text : "添加人员",
				size:"large",
				iconCls : "myicon-qiandao",
				handler : function() {
					var dialog=undefined;
					dialog=$("<div/>").css("padding",10).appendTo($("body")).dialog({
						title : "录入参会人员",
						//closed : true,
						width : 400,
						height : 300,
						href:ctx+"/sign/signEdit",
						buttons : [ {
							text : "保存",
							handler : function() {
								dialog.children("form").ajaxSubmit({
									type : "POST",
									dataType : 'json',
									data:{expertApplyId:$(":input[name='expertApplyId']").val()},
									beforeSend : function() {
										return dialog.children("form").form("validate");
									},
									success : function(data) {
										if (data.success) {
											//$("#sign-dialog").children("form").find(":input").filter(function(){ return $(this).attr("name")!="expertApplyId";}).val("");
											dialog.dialog("destroy");
											//$("#sign-datagrid").datagrid("reload");
										}
										$.jGrowl(data.msg);
									},
									error : function() {

									}
								});
							}
						}, {
							text : "取消",
							handler : function() {
								dialog.dialog("destroy");
							}
						} ]
					});
					//$("#sign-dialog").dialog("open");
				}
			},{
				text:"补抽专家",iconCls:"myicon-building_add",
				handler:function(){					
					$.ajax({
						url:ctx+"/expertApplication/regetexperts",
						type:"post",
						data:{expertApplyId:$(":input[name='expertApplyId']").val()},
						dataType:"json",
						success:function(data){
							if(data.success){
								$.messager.alert("系统提示","补抽新专家成功");
							}else{
								$.messager.alert("系统提示","没有新的补抽专家");
							}
						}
					});
					
				}
			},{
				text:"下载签到表",iconCls:"myicon-paste_word",
				handler:function(){	
					$.ajax({
						url:ctx+"/bidOpen/downloadSignTab",
						type:"post",
						data:{expertApplyId:$(":input[name='expertApplyId']").val()},
						dataType:"json",
						success:function(data){
							if(data.success){
								window.location="${pageContext.request.contextPath}/attachment/download/"+data.data;
							}else{
								$.messager.alert("expertApplyId is null!");
							}
						}
					});
					
				}
			}]
		});
		
				
		//需要澄清的问题列表
		$("#bidOpeningQuestion").datagrid({
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			nowrap : false,	// 自动换行
			//collapsible:true,
			height:300,
			title : "需要澄清的问题列表",
			url : ctx+"/question/pagingBidOpeningQuestionData",
			queryParams: {projectInstanceId:"${expertApply.projectInstanceId}"},
			idField : "id",
			columns : [ [ 
			    {field : "organTName",title : "招标单位",width:100,hidden:true}, 
			    {field : "projectInstanceName",title : "招标项目",width:100,hidden:true}, 
			    {field : "organBName",title : "质疑单位",width:150,hidden:false}, 
			    {field : "questionDate",title : "质疑时间",width:120,hidden:false}, 			    
			    {field : "questionContent",title : "质疑内容",width:500,hidden:false}, 			    
				{field : "id",title : "操作",width:70,align:'center',formatter:function(value, row, index) {
					return '<a class="button red small" href="'+ctx+'/question/bidOpeningQuestionAnswer?id='+row["id"]+'">澄清</a>';
				}} 
			] ],
		});
				
		
		$("#impParticipants").click(function() {
			$.ajax({
				url : ctx + '/sign/impSign',
				type : "POST",
				datatype : "json",
				success : function(data) {
					alert(data);
				}
			});
		});
		$("#sub").click(function() {
			$("#form1").ajaxSubmit({
				type : 'post',
				url : ctx + '/workflow/completeForm',
				success : function(data) {
					alert('参会人员签到完成');
					$("#sign-datagrid").datagrid("reload");

				},
				error : function(XmlHttpRequest, textStatus, errorThrown) {
					alert('签到失败');
					$("#sign-datagrid").datagrid("reload");
				}
			});
		});
		//倒计时
		var openDate=${expertApply.bidOpenDate.time};
		var currentDate=${now.time};
		var lastTime=(openDate-currentDate); 
		if(lastTime>0){
			var i =undefined;
			i=setInterval(function() {
		    		lastTime=lastTime-1000;
		    		var min=Math.floor(lastTime/1000/60);
		    		var second=Math.floor(lastTime/1000%60);
		    		$("#lastTime").html(min+"分"+second+"秒");
		            if (lastTime <=0){
		            	clearInterval(i);
		            }
		    }, 1000);
		}else{
			$("#lastTime").html("已经开标");
		}
		
	
			
			
		$("#decryptAll").click(function(){
			$(".bidOpen-datagrid").each(function(){
				var projectItemId=$(this).attr("id");
				$.ajax({
					url : ctx + "/sign/openDecrypt1",
					type : "POST",
					dataType : "json",
					data : {
						expertApplyId : $(":input[name='expertApplyId']").val(),
						projectItemId:projectItemId
					},
					success : function(data) {
						if (data.success) {
							$("#decrypt-btn-"+projectItemId).linkbutton("disable");
						}
						$.jGrowl(data.msg);
					}
				});
			});
		});
		

		$(".recruitfile_download_history").each(function(){
			var projectItemId=$(this).attr("id");
			$(this).datagrid({
				url : ctx + "/bidOpen/listRecruitFileDownloadHistory",
				pagination : true,
	
				rownumbers : true,
				striped : true,
				fit:true,
				method : "post",
				queryParams : {
					projectItemId:projectItemId
				},
				onLoadSuccess:function(){
			
				},
				columns : [ [ 
					{field : 'projectItemName',width:250,title : "标段名称"}, 
					{field : 'organBName',title : "投标单位",width:250,align : "center"}, 
					
					{field : 'type',title : "事件",width : 160,formatter:function(value,rowData,rowIndex){
						if(rowData.type == 1){
							return "下载";
						}
						return "预览";
					}}, 
					
					{field : 'downloadTime',title : "下载/预览时间",width : 250},

					
				] ]
				
			});
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			<code>&gt;</code>
			开标管理
		</div>
		<div class="centerss">
			<h2>开标项目名称:${projectInstance.zbxmmc}</h2>
			<%-- <h2>开标编号:${processBusinessKey}</h2> --%>
			<h2>开标时间:${expertApply.bidOpenDate}</h2>
			<h2>评标时间:${expertApply.evaluateTime}</h2>
		  	<h2>开标倒计时:<span id="lastTime" ></span></h2>
		  	<h2>文件解密提交倒计时:<span id="lastDecodeEndTime" ></span></h2>
		  	
		</div>
		<div class="blank10"></div>
		<div><a style="display:none;" href="" id="price_adjust" target="_blank"><span>点击</span></a></div>
		<div class="easyui-panel" data-options="title:'开标一览表'">
		 <!--  <span class="easyui-linkbutton" data-options="iconCls:'myicon-lock_open'" id="decryptAll">一键全部开始解密</span> -->
			<div id="projectItem-tabs" class="easyui-tabs" data-options="border:false,height:350">
				<div data-options="title:'所有标段',border:false">
					<table class="allBidOpen-datagrid"></table>
				</div>
				<c:forEach items="${expertApply.projectItemList}" var="projectItem">
					<div data-options="title:'${projectItem.bdmc00}',border:false">
						<table class="bidOpen-datagrid" id="${projectItem.id}"></table>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="blank10"></div>
		<div style="float:left;width:100%;margin-right:5px;text-align:center;height:300px;">
			<form action="${pageContext.request.contextPath}/workflow/completeForm" id="form1">
				<input type="hidden" name="taskId" value="${taskId}"/>
				<input type="hidden" name="projectInstanceId" value="${expertApply.projectInstanceId}"/>
				<input type="hidden" name="projectInstanceName" value="${projectInstance}"/>
				<input type="hidden" name="expertApplyId" value="${processBusinessKey}"/>
				<input type="hidden" name="userType" value="3"/>
			</form>
			<!-- <a class="button red medium" id="sign">签到</a><a id="decrypt" class="button red medium">完全解密</a> <a id="sub" class="button red medium">提交</a> -->
			<table id="sign-datagrid"></table>
		</div>
		<div class="blank10"></div>
		
		<!-- <table id="bidOpenUserTask"></table> -->
		
		<div class="easyui-panel" data-options="title:'开标人员待办任务列表'">
			<div id="projectItem-tabs" class="easyui-tabs" data-options="border:false,height:350">
				<div data-options="title:'所有任务',border:false">
					<table class="allBidOpenUserTask"></table>
				</div>
				<c:forEach items="${expertApply.projectItemList}" var="projectItem" varStatus="status" >
					<div data-options="title:'${projectItem.bdmc00}',border:false">
						<table class="bidOpenUserTask" id="${projectItem.id}-${projectItem.id}"></table>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<div class="blank10"></div>
		<div class="easyui-panel" data-options="title:'招标文件下载历史'">
		 <!--  <span class="easyui-linkbutton" data-options="iconCls:'myicon-lock_open'" id="decryptAll">一键全部开始解密</span> -->
			<div id="recruitfile_download_history" class="easyui-tabs" data-options="border:false,height:350">
			
				<c:forEach items="${expertApply.projectItemList}" var="projectItem">
					<div data-options="title:'标段: ${projectItem.bdmc00}',border:false">
						<table class="recruitfile_download_history" id="${projectItem.id}"></table>
					</div>
				</c:forEach>
			</div>
		</div>
			
		<div class="blank10"></div>
		<div class="easyui-panel">
			<!-- 开标过程中澄清问题列表 -->
			<div id="bidOpeningQuestion" class="easyui-tabs" data-options="border:false,height:350">
				<table class="bidOpeningQuestion"></table>
			</div>
		</div>
		
	</div>
	<div class="blank10"></div>
	
	<div id="time_setting" title="解密时长设置" style="width:400px;height:200px;display:none;"
        data-options="iconCls:'icon-save',resizable:true,modal:true">
        
       <form id="time_setting_form" class="registerform" method="post" action="${pageContext.request.contextPath}/sign/setDecodeTime" >
        	<input type="hidden" name="expertApplyId" value="${expertApply.id}"></input>
        	<br></br>
        	<label>解密提交截至时间: </label>
        	<input type="text" id="decodeEndTime" value="<fmt:formatDate value="${expertApply.decodeSubmitEndTime}" pattern="yyyy-MM-dd HH:mm:ss" type="both" dateStyle="default" timeStyle="default" />" name="decodeEndTime" class="inputxt Wdate easyui-validatebox" data-options="required:true" missingMessage="请填写截止时间！" />
    		<br></br>
    		<input type="button" value="提交" style="margin-left:50px;" onclick="submitDecodeEndTime();"/>
    	</form>
    </div>
    
	<div class="blank10"></div>

	<div class="block">
		<div class="easyui-panel" data-options="title:'评标基准价算法及系数抽取记录表'" style="background-color: #fdf9f9;padding-bottom: 15px">
		<div id="benchmarkTabs" class="easyui-tabs" data-options="border:false,toolbar:'#time_setting'">
			<c:forEach items="${expertApply.projectItemList}" var="projectItem" varStatus="status">
				<div id="benchmark_${status.index}" data-options="title:'${projectItem.bdmc00}',border:false" >
					<c:set value="${projectItem.id}" var="projectItemId"></c:set>
					<c:set var="data" value="${recruitFileService.loadBenchMarkInfo(projectItemId, processBusinessKey)}"></c:set>
					<c:if test="${data.benchmarkInstance.variableList.size() > 0 || data.benchmarkInstance.uniqueMethodId != null}"> 
						<c:set var="uniqueMethodId" value="${evaluationMethodService.checkUniqueMethodId(processBusinessKey,projectItemId)}"></c:set>
							<c:if test="${uniqueMethodId=='JT'}">
								<div style="margin: 10px 10px 0 10px;line-height: 25px;">
									<label style="font-size: 15px;font-weight:1000;color: #c70000;">抽取的评标基准价</label>
									<a id="benchmarkBar_${status.index}" class="button small red" onclick="javascript:;">导出数据</a>
									<table class="" id="" style="border: 1px solid #151515; width: 100%;background-color: #fff;">
										<tr><th colspan="2"  style="text-align: center; display: none;">评标基准价</th></tr>
										<c:forEach var="benchmarkjt" items="${jt_benchmarkList}">
											<tr>
												<td style="text-align: center; width: 25px;">
													<c:if test="${data.benchmark.id==benchmarkjt.id}">
														<input type="checkbox" value="${benchmarkjt.id}" title="${benchmarkjt.benchmarkName}" disabled="disabled" checked="checked"/>
													</c:if>
													<c:if test="${data.benchmark.id!=benchmarkjt.id}">
														<input type="checkbox" value="${benchmarkjt.id}" title="${benchmarkjt.benchmarkName}" disabled="disabled"/>
													</c:if>
													<span style="display: none;">${benchmarkjt.benchmarkName}</span>
												</td>
												<td style="text-align: left;">${benchmarkjt.benchmarkDescription==null?'无评标基准价描述':benchmarkjt.benchmarkDescription}
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
								<div style="margin: 10px 10px 0 10px;line-height: 25px;">
									<label style="font-size: 15px;font-weight:1000;color: #c70000;">抽取的系数</label>
									<table class="mytableStyle" id="">
										<tr><th colspan="8"  style="text-align: center;">抽取的系数</th></tr>
										<tr>
											<th style="text-align: center;">评标基准价</th>
											<th style="text-align: center;">投标人或现场监督随机抽取的算法</th>
											<th style="text-align: center;">抽取系数1</th>
											<th style="text-align: center;">值</th>
											<th style="text-align: center;">抽取系数2</th>
											<th style="text-align: center;">值</th>
											<th style="text-align: center;">抽取系数3</th>
											<th style="text-align: center;">值</th>
										</tr>
										<c:forEach var="benchmarkjt1" items="${jt_benchmarkList}">
											<c:if test="${benchmarkjt1.uniqueMethodId =='JT_SG_BMK_1'}">
												<tr>
													<td style="text-align: center;color:red;">${benchmarkjt1.benchmarkName}</td>
													<td style="text-align: center;"><c:if test="${data.benchmark.id==benchmarkjt1.id}">√</c:if></td>
													<td style="text-align: center;">下浮系数</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.jt_benchmark_1_control_price_ratio}</td>
													<td style="text-align: center;">加权系数</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.jt_benchmark_1_add_right_ratio}</td>
													<td style="text-align: center;">评标基准价系数</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.jt_benchmark_1_benchmark_ratio}</td>
												</tr>
											</c:if>
											<c:if test="${benchmarkjt1.uniqueMethodId !='JT_SG_BMK_1'}">
												<tr>
													<td style="text-align: center;color:red;">${benchmarkjt1.benchmarkName}</td>
													<td style="text-align: center;"><c:if test="${data.benchmark.id==benchmarkjt1.id}">√</c:if></td>
													<td style="text-align: center;">下浮系数</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.jt_benchmark_1_control_price_ratio}</td>
													<td style="text-align: center;">评标基准价下浮系数K</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.jt_benchmark_2_k_ratio}</td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
												</tr>
											</c:if>
										</c:forEach>
									</table>
								</div>
							</c:if>
							<c:if test="${uniqueMethodId=='FW'}">
								<div style="margin: 10px 10px 0 10px;line-height: 25px;">
									<label style="font-size: 15px;font-weight:1000;color: #c70000;">抽取的评标基准价</label>
									<a id="benchmarkBar_${status.index}" class="button small red" onclick="javascript:;">导出数据</a>
									<table class="" style="border: 1px solid #151515; width: 100%;background-color: #fff;">
										<tr><th colspan="2"  style="text-align: center; display: none;">评标基准价</th></tr>
										<c:forEach var="benchmarkfw" items="${fwsz_benchmarkList}">
											<tr>
												<td style="text-align: center; width: 25px;">
													<c:if test="${data.benchmark.id==benchmarkfw.id}">
														<input type="checkbox" value="${benchmarkfw.id}" title="${benchmarkfw.benchmarkName}" disabled="disabled" checked="checked"/>
													</c:if>
													<c:if test="${data.benchmark.id!=benchmarkfw.id}">
														<input type="checkbox" value="${benchmarkfw.id}" title="${benchmarkfw.benchmarkName}" disabled="disabled"/>
													</c:if>
													<span style="display: none;">${benchmarkfw.benchmarkName}</span>
												</td>
												<td style="text-align: left;">
													${benchmarkfw.benchmarkDescription==null?'无评标基准价描述':benchmarkfw.benchmarkDescription}
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
								<div  style="margin: 10px 10px 0 10px;line-height: 25px;">
									<label style="font-size: 15px;font-weight:1000;color: #c70000;">抽取的系数</label>
									<table class="mytableStyle" id="">
										<tr><th colspan="10"  style="text-align: center;">抽取的系数</th></tr>
										<tr>
											<th style="text-align: center;">评标基准价</th>
											<th style="text-align: center;">投标人或现场监督随机抽取的算法</th>
											<th style="text-align: center;">抽取系数1</th>
											<th style="text-align: center;">值</th>
											<th style="text-align: center;">抽取系数2</th>
											<th style="text-align: center;">值</th>
											<th style="text-align: center;">抽取系数3</th>
											<th style="text-align: center;">值</th>
											<th style="text-align: center;">抽取系数4</th>
											<th style="text-align: center;">值</th>
										</tr>
										<c:forEach var="benchmarkfw1" items="${fwsz_benchmarkList}">
											<c:if test="${benchmarkfw1.uniqueMethodId=='FWSZ_BMK_1'}">
												<tr>
													<td style="text-align: center;color:red;">${benchmarkfw1.benchmarkName}</td>
													<td style="text-align: center;"><c:if test="${data.benchmark.id==benchmarkfw1.id}">√</c:if></td>
													<td style="text-align: center;">下浮系数</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO}</td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
												</tr>
											</c:if>
											<c:if test="${benchmarkfw1.uniqueMethodId=='FWSZ_BMK_2'}">
												<tr>
													<td style="text-align: center;color:red;">${benchmarkfw1.benchmarkName}</td>
													<td style="text-align: center;"><c:if test="${data.benchmark.id==benchmarkfw1.id}">√</c:if></td>
													<td style="text-align: center;">下浮系数</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO}</td>
													<td style="text-align: center;">最高投标限价权重</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.FWSZ_BMK_2_CONTROL_PRICE_RIGHT}</td>
													<td style="text-align: center;">有效投标报价的算术平均值权重</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.FWSZ_BMK_2_AVG_PRICE_RIGHT}</td>
													<td style="text-align: center;">投标报价家数</td>
													<td style="text-align: center;">
<%-- 														${data.benchmarkInstanceVariables.FWSZ_BMK_3_TENDERS} --%>
													</td>
												</tr>
											</c:if>
											<c:if test="${benchmarkfw1.uniqueMethodId=='FWSZ_BMK_3'}">
												<tr>
													<td style="text-align: center;color:red;">${benchmarkfw1.benchmarkName}</td>
													<td style="text-align: center;"><c:if test="${data.benchmark.id==benchmarkfw1.id}">√</c:if></td>
													<td style="text-align: center;">下浮系数</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO}</td>
													<td style="text-align: center;">投标报价家数</td>
													<td style="text-align: center;">
<%-- 														${data.benchmarkInstanceVariables.FWSZ_BMK_3_TENDERS} --%>
													</td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
												</tr>
											</c:if>
											<c:if test="${benchmarkfw1.uniqueMethodId=='FWSZ_BMK_4'}">
												<tr>
													<td style="text-align: center;color:red;">${benchmarkfw1.benchmarkName}</td>
													<td style="text-align: center;"><c:if test="${data.benchmark.id==benchmarkfw1.id}">√</c:if></td>
													<td style="text-align: center;">房屋市政勘察权数</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.FWSZ_BMK_4_WEIGHT}</td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
												</tr>
											</c:if>
											<c:if test="${benchmarkfw1.uniqueMethodId=='FWSZ_BMK_5'}">
												<tr>
													<td style="text-align: center;color:red;">${benchmarkfw1.benchmarkName}</td>
													<td style="text-align: center;"><c:if test="${data.benchmark.id==benchmarkfw1.id}">√</c:if></td>
													<td style="text-align: center;">下浮系数</td>
													<td style="text-align: center;">${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO}</td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
													<td style="text-align: center;"></td>
												</tr>
											</c:if>
										</c:forEach>
									</table>
								</div>
							</c:if>
						
					</c:if>
				</div>
			</c:forEach>
		</div>
		</div>
	</div>
	<div class="blank10"><br></br></div>
    <script>
    //导出抽取系数Excel
    $("#benchmarkTabs").tabs({
    	onSelect:function(title,index){
    		console.log("选项卡切换"+index);
			$("#benchmarkBar_"+index).click(function() {
				var form = $("<form/>").attr("action",ctx + "/attachment/expertXLS").attr("method","POST").css("display", "none").appendTo($("body"));
				form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#benchmark_"+index).clone()).html()));
				form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]评标基准价算法及系数抽取记录表.xls"));
				form.submit();
			});
    	}
    });
    
	$("#decodeEndTime").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss'
		});
	});
	
	function submitDecodeEndTime(){
		$("#time_setting_form").ajaxSubmit({
			beforeSend : function() {
				return $("time_setting_form").form("validate");
			},
			dataType : "json",
			success : function(data) {

				 $('#time_setting').dialog('close')
				if (data.success) {
					$.messager.alert('系统提示', "设置成功");
				} else {
					$.messager.alert('系统提示', data.msg);
				}
				
			}
		});
	}
	
	function openDecodeEndTimeWindow(){
		$("#time_setting").show();
		$('#time_setting').dialog({
		    title: '解密提交时间设置',
		    width: 400,
		    height: 200,
		    closed: true,
		    cache: false,
		    modal: true
		});
		
		 $('#time_setting').dialog('open')
	}
	
	
		var lastDecodeTime = 0;
	
		var j = undefined;
		j=setInterval(function() {
			lastDecodeTime=lastDecodeTime-1000;
			var min=Math.floor(lastDecodeTime/1000/60);
			var second=Math.floor(lastDecodeTime/1000%60);
			if (lastDecodeTime>0){		 
				 $("#lastDecodeEndTime").html(min+"分"+second+"秒");
			}
		}, 1000);
		
		setTimeout(function() {
			loadDecodeTime();
		}, 1000);
			
		function loadDecodeTime(){
			$.ajax({
				url:ctx+"/sign/loadEndDecodeTime",
				type:"post",
				data:{"expertApplyId":"${expertApply.id}"},
				success:function(data){
					eval(" var response=" + data);
					if(response.data >0){

						setTimeout(function() {
							loadDecodeTime();
						}, 10000);
					}else{
						setTimeout(function() {
							loadDecodeTime();
						}, 2000);
					}
					lastDecodeTime = response.data;
				}
			
			});
		}
		$(function(){
			if("${projectInstanceType}"!="A01"&&"${projectInstanceType}"!="A02"){
				$(".bidOpen-datagrid").datagrid('hideColumn','bidPartPrice');
				$(".bidOpen-datagrid").datagrid('hideColumn','bidMeasurePrice');
			}
		});
		
    </script>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>