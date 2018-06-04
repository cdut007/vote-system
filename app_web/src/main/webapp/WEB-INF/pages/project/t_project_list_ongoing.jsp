<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>
<script type="text/javascript">

function showZBXM(){
	if(event.srcElement.tagName=="TD"){
       objrow=event.srcElement.parentNode;
	   objrad=objrow.cells[0].childNodes[0];//若嵌套结构有变化此处需要调整
	  objrad.checked=true;
    }
	ajax({
		url:"${pageContext.request.contextPath}/projectInstance/ajaxlist",
		data:"xmbh00="+$('input[name=project_id]:checked').val(),
		type:"post",
		dataType:"json", 
		success:function(data){
			var tbody="";
			if(data.list==""){
				tbody = "<tr><td colspan='7' align=\"center\">暂无记录!</td></tr>";
			}else{
				$.each(data.list,function(index,row){
					var tr = "";
					tr = "<tr><td>"+(index+1) +"</td><td>"
					   +data.list[index].zbxmbh+"</td><td>"+
						data.list[index].zbxmmc+"</td><td>"+
						data.list[index].zbr000+"</td><td>"+
						data.list[index].zbfs00+"</td><td>"+
						data.list[index].lxsj00+"</td><td>"+
						"<a class='easyui-linkbutton' data-options=\"iconCls:'icon-add'\" onclick=\"alert('正在建设中...');\">项目进度</a>" +
						"</td></tr>";
					tbody = tbody+tr;			
				});
			}
			$('#zbxm_body').html(tbody);
		}
	});
}
</script>
</head>
<body>
	
	<div class="easyui-layout" style="width:100%;height:100%;padding-bottom:1px;padding-top:1px;">
		<div data-options="region:'west',split:true" title="项目列表" style='width:350px;padding-left:1px;padding-right:1px;padding-top:1px'>
			<div style="float:left">
				<form:form id="project_list" action="${pageContext.request.contextPath}/project/list_ongoing" method="post" commandName="project">
				<table class="mytable">
					<thead>
						<tr>
							<th width="20px"></th>
							<th>项目名称</th>
							<th>联系人</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.rows}" var="project" varStatus="status">
						<tr onclick="showZBXM();">
							<td><input name="project_id" type="radio" value="${project.xmbh00 }" /></td>
							<td>${project.xmmc00}</td>
							<td>${project.lxr000}</td>
						</tr>
					</c:forEach>
					<c:forEach begin="${fn:length(page.rows)+1}" end="15" varStatus="status">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				
				</form:form>
			</div>
		</div>
		<div data-options="region:'center',title:'招标项目列表'" style="background:#fafafa;overflow:hidden;width:74%;padding-top:1px;">
			<div style="float:right;margin-left:1px">
			<table class="mytable">
				<thead>
					<tr>
						<th width="20px"></th>
						<th>招标项目编号</th>
						<th>招标项目名称</th>
						<th>招标人</th>
						<th>招标方式</th>
						<th>立项时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="zbxm_body">
					<tr>
						<td colspan='7' align="center">暂无记录!</td>
					</tr>
				</tbody>
			</table>
		
		<div id="operation">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add();">新增</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="edit();">修改</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="del();">删除</a>
		</div>
		</div>
		</div>
	</div>
	
</body>
</html>
