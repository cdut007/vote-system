<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">  
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">       
<META HTTP-EQUIV="Expires" CONTENT="0">  
<head>
<style type="text/css">
.mytableStyle{
	font-size:12px;
	width:100%;
	border:#ccc 1px solid;
	border-width:1px 0 0 1px;
}

.mytableStyle th,td{
	height:27px;
	border:#ccc 1px solid;
	border-width:0 1px 1px 0;
}

.tableTitle{
	background-color: #eee;
	border-top:#bbb 1px solid;
	border-left:#bbb 1px solid;
	border-right:#bbb 1px solid;
	padding:5px 5px 5px 5px;
	font-weight:bold;
}

.bottom_table {
	padding:4px 6px 4px 0px;
	margin:3px auto 3px auto;
	color:#313031;
	TEXT-ALIGN: center;
	
}

.buttonDiv{
	TEXT-ALIGN: center;
}

.btn{color:#484848;font:12px/1.5 arial;padding-top:8px;padding-bottom:8px;align:center}

</style>
<script src="plug-in/easyui/jquery-1.8.2.min.js" type="text/javascript"></script>

<script type="text/javascript">
function addItem(){
	//window.open("projectItem/addOrMod","${pageContext.request.contextPath}/新增标段");  //选项卡
	var win = window.showModalDialog("projectItem/addOrMod","新增标段（包）","dialogWidth:900px;dialogHeight:550px");  //弹出窗口
	if(win==2){
		$("#infoDiv").load('${pageContext.request.contextPath}/projectItem/list',{date:new Date()});
	}
	
}
function editItem(){
	var inputs = $(":input[name='projectItem_id']:checked");
	if (inputs.length != 1) {
		alert("请选择一条记录!");
		return;
	}
 	var win = window.showModalDialog("${pageContext.request.contextPath}/projectItem/addOrMod?id="+inputs[0].value.split(":")[0],"修改标段（包）","dialogWidth:900px;dialogHeight:550px;");  //弹出窗口
	if(win==2){
		$("#infoDiv").load('${pageContext.request.contextPath}/projectItem/list',{date:new Date()});
	}
}
function delItem(){
	var inputs = $(":input[name='projectItem_id']:checked");
	if (inputs.length == 0) {
		alert("请选择要删除的记录!");
		return;
	}
	if(confirm('确认要删除该记录吗？')){
		$.ajax({
			url:"${pageContext.request.contextPath}/projectItem/del",
			data:$("#projectItem_list").serialize(),
			success:function(data){
				$("#infoDiv").load('${pageContext.request.contextPath}/projectItem/list',{date:new Date()});
			}
		});
	}
}
</script>
</head>
<body>
<div class="main">
    <div class="wraper">
    <div class="blank10"></div>
        <form action="${pageContext.request.contextPath}/projectItem/list" id="projectItem_list" method="post">
			<div class="tableTitle">标段（包）管理</div>
			<table class='mytableStyle' cellspacing="0">
				<thead>
					<tr>
						<th style="width:20px;"><nobr>序号</nobr></th>
						<th style="width:20px;"><input type="checkbox" /></th>
						<th style="width:20%;">标段（包）编号</th>
						<th style="width:40%;">标段（包）名称</th>
						<th style="width:20%;">标段分类代码</th>
						<th style="width:20%;">标段合同估算价</th>
					</tr>
				</thead> 
				<tbody>
					<c:forEach items="${list}" var="item" varStatus="status">
						<tr>
							<th>${status.count}</th>
							<td align="center"><input name="projectItem_id" type="checkbox" value="${item.id}" /></td>
							<td align="center">${item.bdbh00}</td>
							<td align="center">${item.bdmc00}</td>
							<td align="center">${item.bdfldm}</td>
							<td align="center">${item.bdhtgj}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="blank10"></div> 
				<input type="button" class="btn" onclick="addItem()" value="新 增" />
				<input type="button" class="btn" onclick="editItem()" value="修 改" />
				<input type="button" class="btn"onclick="delItem()" value="删  除" />
	</form>
</div>
</div>
</body>
</html>