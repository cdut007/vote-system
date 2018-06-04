<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript" src="/resources/ca/Loadwebsign.js"></script>
<script type="text/javascript" src="/resources/ca/main1.js"></script>
<script type="text/javascript">
	function ignoreQuestion(id) {
		$.messager.confirm('系统提示', '确认忽略吗?', function(ok) {
			if (ok) {
				$.ajax({
					type : 'post',
					dataType : 'json',
					data : {
						id : id
					},
					url : ctx + "/question/ignoreQuestion",
					success : function(data) {
						if (data.success) {
							$('#recruitfilequestion-datagrid').datagrid('reload');
							// $('#recruitfilequestion-datagrid').datagrid('unselectAll');
						}
					},
					error : function(e, s1, s2) {
						$.messager.alert('系统提示', '忽略失败！');
					}
				});
			}
		});
	}
	function submitQuestion(id) {
		$.messager.confirm('系统提示', '确认提交给招标人吗?', function(ok) {
			if (ok) {
				$.ajax({
					type : 'post',
					dataType : 'json',
					data : {
						id : id
					},
					url : ctx + "/question/submitQuestion",
					success : function(data) {
						if (data.success) {
							$('#recruitfilequestion-datagrid').datagrid('reload');
							// $('#recruitfilequestion-datagrid').datagrid('unselectAll');
						}
					},
					error : function(e, s1, s2) {
						$.messager.alert('系统提示', '提交失败！');
					}
				});
			}
		});
	}
	$(function() {
		sectionList();
	});
	
	/** 有问题的标段列表 */
	function sectionList() {
		$("#recruitfilequestion-datagrid").datagrid({
			fit : true,
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			title : "需要澄清的问题列表",
			region : "center",
			url : "${pageContext.request.contextPath}/question/pagingRecruitFileQuestionData",
			idField : "id",
			columns : [ [ {
				field : "projectItem.projectInstance.zbxmmc",
				title : "所属招标项目",
				align : "left",
				width:"35%"
			}, {
				field : "projectItem.bdmc00",
				title : "所属招标标段",
				align : "left",
				width:"35%"
			}, {
				title : "操作",
				field : "projectItem.id",
				width:"30%",
				formatter : function(value, rowData) {
					return "<a class='button red small' onclick=\"questionList('"+value+"')\">问题列表</a> \
					<a class='button red small' onclick=\"qrList('"+value+"','"+rowData.recruitFileId+"')\">确认情况</a>";
				}
			} ] ],
			toolbar : []
		});
	}

	function detailRecruitFileQuestion(rowData){
			var dialog=undefined;
			var buttons=[];		
			buttons.push({text:"关闭",handler:function(){
			    	dialog.dialog("destroy");
			}});
			dialog=$("<div/>").css({"padding":5,"overflow":"hidden"}).appendTo($("body")).dialog({
				title:"招标文件质疑",
				content:"<table class='mytableStyle'>\
							<tr><th style='width:60px;'>投标单位</th><td>"+rowData["organBName"]+"</td></tr>\
							<tr><th>质疑内容</th><td><textarea style='width:100%;height:234px;' readonly='readonly'>"+rowData["questionContent"]+"</textarea></td></tr>\
							<tr><th>质疑时间</th><td>"+rowData["questionDate"]+"</td></tr>\
						</table>",
				width:600,
				height:400,
				buttons:buttons
			});
		}
	
	/** 标段内的澄清确认 */
	function qrList(projectItemId, recruitFileId) {
		$("#recruitfilequestion-datagrid").datagrid({
			/* title : "澄清确认情况", */
			height : 400,
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			url : "${pageContext.request.contextPath}/question/qrListData?projectItemId=" + projectItemId,
			columns : [ [ {
				field : "projectInstance.project.organ.ztmc00",
				title : "招标人",
				width : 250
			}, {
				field : "organ.ztmc00",
				title : "投标单位",
				width :250
			}, {
				field : "reconSignatureDataId",
				title : "是否确认",
				width : "100%",
				formatter : function(value, rowData) {
					if (value == null || $.trim(value) == '') {
						return "未确认";
					} else {
						return "已确认";
// 						return "<a class='button red small' onclick=\"lookReceipt('"+rowData.id+"','"+rowData.projectItemId+"')\">查看回执</a>";
					}
				}
			} ] ],
			toolbar : [{
				text : "返回",
				iconCls : "myicon-arrow_redo",
				handler : function() {
					sectionList();
				}
			}/* ,{
				text : "查看回执",
				iconCls : "myicon-eye",
				handler : function() {
					lookClarifyFile(recruitFileId);
				}
			} */]
		});
		
		/* var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 500,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "澄清确认列表",
			href : "${pageContext.request.contextPath}/question/qrList?projectItemId="+projectItemId,
			onClose : function() {
				$("#" + id).dialog("destroy");
			}
		}); */
	}
	
	function lookClarifyFile(recruitFileId) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='"+ id + "'></div>");
		$("#" + id).dialog({
			width : 800,
			height : 450,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "查看招标文件澄清答疑及回执",
			href : "${pageContext.request.contextPath}/question/lookClarifyFile?id=" + recruitFileId,
			onClose : function() {
				$("#" + id).dialog("destroy");
				location.reload();
			}
		});
	}
	
	
	function lookReceipt(tenderItemId, projectItemId) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='"+ id + "'></div>");
		$("#" + id).dialog(
						{
							width : 800,
							height : 300,
							closed : false,
							modal : true,
							loadingMessage : '正在加载...',
							title : "回执查看",
							href : "${pageContext.request.contextPath}/question/form2?tenderItemId=" + tenderItemId + "&projectItemId=" + projectItemId,
							onClose : function() {
								$("#" + id).dialog("destroy");
								location.reload();
							},
							buttons : [],
							onLoad : function() {}
						});
	}
	
	/** 标段内的问题列表 */
	function questionList(projectItemId) {
		$("#recruitfilequestion-datagrid").datagrid({
			fit : true,
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			title : "标段中需要澄清的问题列表",
			region : "center",
			url : "${pageContext.request.contextPath}/question/questionListData?projectItemId="+projectItemId,
			idField : "id",
			onOpen:function(){
				$(this).on("click","a.detail",function(){
					var rowIndex=parseInt($(this).attr("datagrid-row-index"));
					detailRecruitFileQuestion($("#recruitfilequestion-datagrid").datagrid("getRows")[rowIndex]);
				});
			},
			columns : [ [ {
				field : "projectInstance.zbxmmc",
				title : "所属招标项目",
				align : "left"/*,width:1*/
			}, {
				field : "projectItem.bdmc00",
				title : "所属招标标段",
				align : "left"/*,width:1*/
			}, {
				 hidden : false,
				field : "organName",
				title : "投标单位",
				align : "center"
			}, {
				hidden : false,
				field : "questionContent",
				title : "问题内容",
				align : "left",
				width : 510
			}, {
				hidden : true,
				field : "questionDate",
				title : "创建时间",
				align : "center"
			}, {
				hidden : false,
				field : "replied",
				title : "状态",
				align : "center"
			}, {
				title : "操作",
				field : "id",
				formatter : function(value, rowData, rowIndex) {
					// return "<a class='button red small' onclick=\"ignoreQuestion('" + value + "')\" "+(rowData.replied=="已忽略"?"style=\"display:none\"":"")+">忽略</a>";
					if (rowData.replied=="未处理") {
						return "<a class='button red small' onclick=\"ignoreQuestion('"+value+"')\">忽略</a> \
						<a class='button red small' onclick=\"submitQuestion('"+value+"')\">提交给招标人</a><a class='button red small detail' datagrid-row-index='"+rowIndex+"'>查看</a>";
					} else {
						return "<a class='button red small detail' datagrid-row-index='"+rowIndex+"'>查看</a>";
					}
				}
			} ] ],
			toolbar : [{
				text : "返回",
				iconCls : "myicon-arrow_redo",
				handler : function() {
					sectionList();
				}
			}]
		});
	}
	
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	
	<div class="block ">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
	
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				招标文件/资格预审文件
				<code>&gt;</code>
				招标文件
			</div>
			<div class="block">
				<div class="usBox">
					<div class="clearfix" style="height:600px">
						<table id="recruitfilequestion-datagrid" class="easyui-datagird"></table>
					</div>
				</div>
			</div>
		</div>
		
	</div>
		
		
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
