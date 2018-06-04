<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Describe:招标公示与资格预审公示信息
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<style type="text/css">
</style>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function() {
	function deleteNotice(noticeId){
		$.messager.confirm('系统提示', '确认删除吗?', function(ok) {
			if (ok) {
				$.ajax({
					type : 'post',
					dataType : 'html',
					data : $(noticeId).map(function(){return "id="+noticeId;}).get().join("&"),
					url : ctx + "/candidatePublicity/deletePublicity",
					success : function(data) {
						$('#publicity-datagrid').datagrid('reload');
						$('#publicity-datagrid').datagrid('unselectAll');
					},
					error : function(e, s1, s2) {
						$.messager.alert('系统提示', '删除公示失败!');
					}
				});
			}
		});
	}
	$("#publicity-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		fitColumns : true,
		pagination : true,
		title:"中标候选人公示列表",
		url : "${pageContext.request.contextPath}/candidatePublicity/publicityList",
		idField : "id",
		toolbar:[{
			text : "新建中标候选人公示",
			iconCls : "myicon-application_add",
			handler : function() {
				window.location.href=ctx+"/candidatePublicity/addOrEditPublicity?gslx=1";
			}
		},{
			text : "修改公示",
			iconCls : "myicon-application_edit",
			handler : function() {
				var row=$("#publicity-datagrid").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示","请选择公示!");
					return;
				}
				if(row.gszt == "待审核"){
					$.messager.alert("系统提示","该公示处于待审核状态，不能修改");
					return;
				}else if(row.gszt == "审核通过"){
					$.messager.alert("系统提示","该公示处于审核通过状态，不能修改");
					return;
				}
				window.location = "${pageContext.request.contextPath}/candidatePublicity/addOrEditPublicity?id="+row.id;
			}
		},{
			text : "删除公示",
			iconCls : "myicon-application_delete",
			handler : function() {
				var row=$("#publicity-datagrid").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示","请选择公示!");
					return;
				}
				if(row["gszt"]!="草稿"){
					$.messager.alert("系统提示","公示已经提交!");
					return;
				}
				deleteNotice([row["id"]]);
			}
		}],
		columns : [[{field:"publicityTitle",title:"公示标题",align:"left",width:50},
		            {field:"gskssj",title:"公示开始时间",align:"center",width:50},
					{field:"gsjssj",title:"公示结束时间",align:"center",width:50},
		            {field:"gslx",title:"公示类型",align:"center",width:30},
					{field:"gszt",title:"公示状态",align:"center",width:30},
					{field:"id",title:"操作",align:"left",width:50,formatter : function(value,row,index) {
						var returnValue="<a class='button red small' href=\"javascript:showPublicityNotice('"+row.id+"');\">查看</a>";
						if(row["gslx"]=="正常公示"){
							if(row["gszt"]=="草稿" || row["gszt"]=="待审核" || row["gszt"]=="代理机构审核未通过" || row["gszt"]=="招标人审核未通过" || row["gszt"]=="公告服务平台审核未通过" || row["gszt"]=="项目经理审核未通过"){
								
							}else{
						   		returnValue+="<a class='button red small' href=\""+ctx+"/candidatePublicity/addOrEditPublicity?projectInstanceId="+row["projectInstanceId"]+"&gslx=2&candidatePublicityId="+row["id"]+"\">变更</a>";
						   		returnValue+="<a class='button red small' href=\""+ctx+"/candidatePublicity/addOrEditPublicity?projectInstanceId="+row["projectInstanceId"]+"&gslx=3&candidatePublicityId="+row["id"]+"\">撤销</a>";
							}
					   }
		        	   return returnValue;
				}}]]
		           
	});
});
	
	function addOrEditPublicity(id,gszt){
		if(gszt == "待审核"){
			$.messager.alert("系统提示","该公示处于待审核状态，不能修改");
			return;
		}else if(gszt == "审核通过"){
			$.messager.alert("系统提示","该公示处于审核通过状态，不能修改");
			return;
		}
		window.location = "${pageContext.request.contextPath}/candidatePublicity/addOrEditPublicity?id="+id;
	}
	function showPublicityNotice(id){

		window.location = "${pageContext.request.contextPath}/candidatePublicity/showPublicityNotice?id="+id;
	}
	function deletePublicity(id,gszt){
		if(gszt == "待审核"){
			$.messager.alert("系统提示","该公示处于待审核状态，不能删除");
			return;
		}else if(gszt == "审核通过"){
			$.messager.alert("系统提示","该公示处于审核通过状态，不能删除");
			return;
		}
		$.messager.confirm("系统提示","您确定要删除吗?", function(ok){
			if(ok){
				window.location = "${pageContext.request.contextPath}/candidatePublicity/deletePublicity?id="+id;
			}
		});	
	}
	
	function queryPublicity() {
		$("#publicity-datagrid").datagrid("reload", {
			publicityTitle : $("[name='publicityTitle']").val(),
			gslx : $("[name='gslx']").val(),
			gskssj : $("[name='gskssj']").val(),
			gsjssj : $("[name='gsjssj']").val(),
			gszt : $("[name='gszt']").val()
		});
	}
</script>
	</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			公示管理
			<code>&gt;</code>
			中标候选人公示管理
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
<%-- 				<input type="button" class="button red" value="添加公示" onclick="window.location='${pageContext.request.contextPath}/candidatePublicity/addOrEditPublicity'" /> --%>
				<table>
				    <tr>
						<td>公示标题:</td>
						<td> 
							<input name="publicityTitle" class="inputxt" />
						</td>
						<td>公示类型:</td>
						<td>
							<select name="gslx">
								<option value="">---==请选择==---</option>
								<c:forEach items="${util:dictionaryTree('GSLXDM',false)}" var="item">
									<option value="${item.itemCode}" ${item.itemCode==notice.ggxzdm?"selected='selected'":""}>${item.itemName}</option>
								</c:forEach>
							</select>
						</td>
						<td>公示状态：</td>
						<td>
							<select name="gszt">
								<option value="">---==请选择==---</option>
								<c:forEach items="${util:dictionaryTree('GGZT',false)}" var="item">
									<option value="${item.itemCode}" ${item.itemCode==notice.ggxzdm?"selected='selected'":""}>${item.itemName}</option>
								</c:forEach>
							</select>
						</td>
						<td><a class="button red" onclick="queryPublicity();">查 询</a></td>
					</tr>
					<tr>
						<td>公示时间从：</td>
						<td>
							<input type="text" id="gskssj" name="gskssj" class="inputxt Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						</td>
						<td>到：</td>
						<td>
							<input type="text" id="gsjssj" name="gsjssj" class="inputxt Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						</td>
					</tr>
				</table> 
				<div class="blank10"></div>
				<table id="publicity-datagrid"></table>
			</div>
		</div>
	</div>
</body>
</body>
</html>
