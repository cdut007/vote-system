<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">

function showWinBidNotice(id){
	window.location = "${pageContext.request.contextPath}/preQualification/view?id="+id;
}
function createOrUpdateNotice(id){
	
	if(id){
	 	if($($('#prequlificationotice-datagrid').datagrid("getRows")).filter(function(){
			return this["id"]==id;
		})[0]["ggzt"]!="草稿"){
			$.jGrowl("当前公告已经提交,不可编辑！");
			return;
		} 
		window.location = ctx + "/preQualification/noticeEdit?id="+id;
	}else{
		window.location = ctx + "/preQualification/noticeEdit";
	}
}

function deleteWinBidNotice(id){
	if($($('#prequlificationotice-datagrid').datagrid("getRows")).filter(function(){
		return this["id"]==id;
	})[0]["ggzt"]!="草稿"){
		$.jGrowl("当前公告已经提交,不可删除！");
		return;
	}
	$.messager.confirm("系统提示","确认删除吗?",function(ok){
		if(ok){
			$.ajax({
				url:ctx+"/preQualification/deleteNotice",
				type:"post",
				dataType:"json",
				data:{id:id},
				success:function(data){
					if(data.success){
						$("#prequlificationotice-datagrid").datagrid("reload");
					}
					$.jGrowl(data.msg);
				}
			});
		}
	});
}

$(function(){

	$("#prequlificationotice-datagrid").datagrid({
		title:"资格预审结果公告列表",
		url:ctx+"/preQualification/listNotice",
		pagination:true,
		rownumbers:true,
		striped:true,
		method:"post",
		idField:"id",
		toolbar:[
			{text:"添加",handler:function(){
				createOrUpdateNotice();
			}}
			/* {text:"编辑",handler:function(){
				var rows=$("#prequlificationotice-datagrid").datagrid("getChecked");
				if(rows.length!=1){
					$.jGrowl("请选择一条要编辑的数据!");
					return;
				}
				createOrUpdateNotice(rows[0]["id"]);
			}},
			{text:"删除",handler:function(){
				var rows=$("#prequlificationotice-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选要删除的数据!");
					return;
				}
				deleteWinBidNotice($(rows).map(function(){return this["id"];}).get());
			}} */
		],
		columns:[[
			{field:"id",checkbox:true},
			{title:"招标项目",field:'projectInstanceName',width:290},
			{title:"标段",field:'projectItemNames',width:250},
			
			{title:"公告状态",field:'ggzt',width:100},
			{title:"公告发布时间",field:'publishDate',width:100},
			{title:"操作",field:"opt",width:170,formatter:function(value,rowData,rowIndex){
				if(rowData.ggzt=="待审核" || rowData.ggzt=="审核通过" ){
					return '<a class="button red small show" onclick=showWinBidNotice("' + rowData.id + '")>查看</a>';
				}else{
					return '<a class="button red small show" onclick=showWinBidNotice("' + rowData.id + '")>查看</a><a class="button red small edit" onclick=createOrUpdateNotice("' + rowData.id + '")>编辑</a><a class="button red small delete" onclick=deleteWinBidNotice("' + rowData.id + '")>删除</a>';

				}
			}}
		]]
	});
	/* var $searchForm=$("<form class='searchForm' style='padding:5px;'></form>");
	$("#prequlificationotice-datagrid").datagrid("getPanel").find(".datagrid-toolbar").prepend($searchForm);
	$searchForm.append("关键字:<input name='keywords' class='inputxt'/>");
	$searchForm.append("&nbsp;&nbsp;<a class='button searchBtn red medium' style='float:right'\">查询</a>");
	//查询事件
	var queryParams=$("#prequlificationotice-datagrid").datagrid("options").queryParams;
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
			$("#prequlificationotice-datagrid").datagrid('reload');
			return false;
		}
	}).on("click",".searchBtn",function(){
		$("#prequlificationotice-datagrid").datagrid('reload');
	}); */
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
			公告、公示管理
			<code>&gt;</code>
			资格预审结果公示管理
		</div>
	</div>
	<div class="block">
		<table id="prequlificationotice-datagrid"></table>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>