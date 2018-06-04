<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function(){
	function showWinBidNotice(id){
		window.location = "${pageContext.request.contextPath}/winBidNotice/showWinBidNoticeEdit?id="+id;
	}
	function createOrUpdateWinBidNotice(id){
		if(id&&$($('#winBidNotice-datagrid').datagrid("getRows")).filter(function(){
				return this["id"]==id;
			})[0]["reviewStatus"]!="草稿"){
			$.jGrowl("当前公告已经提交，不可编辑！");
			return;
		}
		window.open(ctx + "/winBidNotice/winBidNoticeEdit"+(id?"?id="+id:""));
		return;
		var dialogId=new Date().getTime();
		$("<div/>").attr("id",dialogId).appendTo($("body")).dialog({
			width : 600,
			height :400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			singleSelect:true,
			title : "添加中标公告",
			href : ctx + "/winBidNotice/winBidNoticeEdit",
			queryParams:{id:id},
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
								$('#winBidNotice-datagrid').datagrid('reload');
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
	function deleteWinBidNotice(id){
		if($($('#winBidNotice-datagrid').datagrid("getRows")).filter(function(){
			return this["id"]==id[0];
		})[0]["reviewStatus"]!="草稿"){
			$.jGrowl("当前公告已经提交,不可删除！");
			return;
		}
		$.messager.confirm("系统提示","确认删除吗?",function(ok){
			if(ok){
				$.ajax({
					url:ctx+"/winBidNotice/deleteWinBidNotice",
					type:"post",
					dataType:"json",
					data:$(id).map(function(){ return "id="+this;}).get().join("&"),
					success:function(data){
						if(data.success){
							$("#winBidNotice-datagrid").datagrid("reload");
						}
						$.jGrowl(data.msg);
					}
				});
			}
		});
	}
	$("#winBidNotice-datagrid").datagrid({
		title:"中标公告列表",
		url:ctx+"/winBidNotice/pagingWinBidNoticeData",
		pagination:true,
		rownumbers:true,
		striped:true,
		method:"post",
		idField:"id",
		toolbar:[
			{text:"添加",handler:function(){
				createOrUpdateWinBidNotice();
			}},
			{text:"编辑",handler:function(){
				var rows=$("#winBidNotice-datagrid").datagrid("getChecked");
				if(rows.length!=1){
					$.jGrowl("请选择一条要编辑的数据!");
					return;
				}
				createOrUpdateWinBidNotice(rows[0]["id"]);
			}},
			{text:"删除",handler:function(){
				var rows=$("#winBidNotice-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选要删除的数据!");
					return;
				}
				deleteWinBidNotice($(rows).map(function(){return this["id"];}).get());
			}}
		],
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				createOrUpdateWinBidNotice($(this).parent().parent().parent().children("td").find(":checkbox").val());
			});
			$(this).on("click","a.delete",function(){
				deleteWinBidNotice([$(this).parent().parent().parent().children("td").find(":checkbox").val()]);
			});
			$(this).on("click","a.show",function(){
				showWinBidNotice($(this).parent().parent().parent().children("td").find(":checkbox").val());
			});
		},
		columns:[[
			{field:"id",checkbox:true},
			{title:"招标项目",field:'projectInstanceName',width:290},
			{title:"标段",field:'projectItemNames',width:80},
			/* {title:"中标单位",field:'organBName',width:150}, */
			/* {title:"中标价格",field:'price',width:160,formatter:function(value,rowData,rowIndex){
				return value+rowData["priceUnit"].substring(1)+rowData["currency"];
			}}, */
			{title:"公告状态",field:'reviewStatus',width:100},
			{title:"公告发布时间",field:'publishDate',width:100},
			{title:"操作",field:"opt",width:170,formatter:function(value,rowData,rowIndex){
				return "<a class=\"button red small show\">查看</a><a class=\"button red small edit\">编辑</a><a class=\"button red small delete\">删除</a>";
			}}
		]]
	});
	var $searchForm=$("<form class='searchForm' style='padding:5px;'></form>");
	$("#winBidNotice-datagrid").datagrid("getPanel").find(".datagrid-toolbar").prepend($searchForm);
	$searchForm.append("关键字:<input name='keywords' class='inputxt'/>");
	$searchForm.append("&nbsp;&nbsp;<a class='button searchBtn red medium' style='float:right'\">查询</a>");
	//查询事件
	var queryParams=$("#winBidNotice-datagrid").datagrid("options").queryParams;
	$searchForm.on("blur",":input:not(.Wdate)",function(){
		queryParams[this.name]=this.value;
	}).on("focus",".Wdate",function(){
		WdatePicker({
			dateFmt:"yyyy-MM-dd",
			minDate:this.name=="minDate"?undefined:($(".Wdate[name='minDate']").val()==""?undefined:$(".Wdate[name='minDate']").val()),
			maxDate:this.name=="maxDate"?undefined:($(".Wdate[name='maxDate']").val()==""?undefined:$(".Wdate[name='maxDate']").val()),
			onpicked:function(){
				queryParams[this.name]=this.value;
			}
		});
	}).on("keydown",":input",function(){
		if(event.keyCode==13){
			$(this).blur();
			$("#winBidNotice-datagrid").datagrid('reload');
			return false;
		}
	}).on("click",".searchBtn",function(){
		$("#winBidNotice-datagrid").datagrid('reload');
	});
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here"> 
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			企业管理
			<code>&gt;</code>
			中标公告管理
		</div>
	</div>
	<div class="block">
		<table id="winBidNotice-datagrid"></table>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>