<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Describe:招标公告与资格预审公告信息
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
					url : ctx + "/notice/deleteBidNotice",
					success : function(data) {
						$('#bidNotice-datagrid').datagrid('reload');
						$('#bidNotice-datagrid').datagrid('unselectAll');
					},
					error : function(e, s1, s2) {
						$.messager.alert('系统提示', '删除公告失败!');
					}
				});
			}
		});
	}
	$("#bidNotice-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		//fitColumns : true,
		//sortName:"ggfbsj",
		//sortOrder:"desc", 
		pagination : true,
		title:"招标公告列表",
		url : ctx+"/notice/bidNoticeList",
		idField : "id",
		toolbar:[{
			text : "新建招标公告",
			iconCls : "myicon-application_add",
			handler : function() {
				window.location.href=ctx+"/notice/addOrEditBidNotice?ggxzdm=1&gglxdm=1";				
			}
		},{
			text : "新建资格预审公告",
			iconCls : "myicon-application_add",
			handler : function() {
				window.location.href=ctx+"/notice/addOrEditBidNotice?ggxzdm=1&gglxdm=2";				
			}
		},{
			text : "编辑公告",
			iconCls : "myicon-application_edit",
			handler : function() {
				var row=$("#bidNotice-datagrid").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示","请选择公告!");
					return;
				}
				if(row.ggzt == "待审核"||row.ggzt == "审核通过"||row.ggzt == "代理机构审核"||row.ggzt=="招标人审核"||row.ggzt=="公共服务平台审核"){
					$.messager.alert("系统提示","该公告处于"+row.ggzt+"状态，不能修改!");
					return;
				}
				window.location.href=ctx+"/notice/addOrEditBidNotice?id="+row.id;
			}
		},{
			text : "删除公告",
			iconCls : "myicon-application_delete",
			handler : function() {
				var row=$("#bidNotice-datagrid").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示","请选择公告!");
					return;
				}
				if(row["ggzt"]!="草稿"){
					$.messager.alert("系统提示","公告已经提交!");
					return;
				}
				deleteNotice([row["id"]]);
			}
		}],
		idField : "id",
		columns : [[
           {field:"noticeTitle",title:"公告标题",align:"left",width:250},
           {field:"gglxdm",title:"公告类型",align:"center",width:60},
           {field:"ggxzdm",title:"公告性质",align:"center",width:60},
           {field:"ggfbsj",title:"公告发布时间",align:"center",width:120},
           {field:"ggjssj",title:"公告结束日期",align:"center",width:50,hidden:true},
           {field:"ggzt",title:"公告状态",align:"center",width:80},
           {field:"opt",title:"操作",align:"left",width:380,formatter : function(value,row,index) {
        	   var returnValue="<a class='button red small' href=\""+ctx+"/notice/showBidNotice?id="+row["id"]+"\">查看</a>";
        	   $.ajax({
					url:ctx+"/notice/HasCancelledOrAgainNotice",
					async:false,
					type:"post",
					data:{noticeId:row['id']},
					dataType:"json",
					success:function(shuju){
						var bidOpen = shuju.data.bidOpenDate.replace(/\-/g, "/");
						var bidOpenDate = new Date(bidOpen);
						if(!shuju.data.hasCancelledNotice&&new Date()<=new Date(bidOpenDate)){
							   if(row["ggxzdm"]=="正常公告"){
											if(shuju.data.hasAgainNotice||row["ggzt"]=="草稿" || row["ggzt"]=="待审核" || row["ggzt"]=="代理机构审核未通过" || row["ggzt"]=="招标人审核未通过" || row["ggzt"]=="公共服务平台审核未通过" || row["ggzt"]=="代理机构审核" || row["ggzt"]=="招标人审核" || row["ggzt"]=="公共服务平台审核"|| row["ggzt"]=="项目经理审核未通过"){
												   
											   }else{
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=5&referenceNoticeId="+row["id"]+"\">再次</a>";
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=6&referenceNoticeId="+row["id"]+"\">控制价</a>";
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=4&referenceNoticeId="+row["id"]+"\">延期</a>";
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=2&referenceNoticeId="+row["id"]+"\">变更</a>";
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=7&referenceNoticeId="+row["id"]+"\">补充</a>";
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=3&referenceNoticeId="+row["id"]+"\">撤销</a>";
											   }
								}
							   if(row["ggzt"]=="审核通过"){
								   if(row["ggxzdm"]=="再次公告"){
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=5&referenceNoticeId="+row["id"]+"\">再次</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=6&referenceNoticeId="+row["id"]+"\">控制价</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=4&referenceNoticeId="+row["id"]+"\">延期</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=2&referenceNoticeId="+row["id"]+"\">变更</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=7&referenceNoticeId="+row["id"]+"\">补充</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=3&referenceNoticeId="+row["id"]+"\">撤销</a>"; 
								   }
								   if(row["ggxzdm"]=="控制价"){
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=2&referenceNoticeId="+row["id"]+"\">变更</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=3&referenceNoticeId="+row["id"]+"\">撤销</a>"; 
								   }
							   }
								
						  }
						}
				});
        	   return returnValue; 
		}}]]
		           
	});
});
	
	function addOrEditBidNotice(id,ggzt){
		if(ggzt == "待审核"||ggzt == "代理机构审核"||ggzt=="招标人审核"||ggzt=='公共服务平台审核'){
			$.messager.alert("系统提示","该公告处于待审核状态，不能修改");
			return;
		}else if(ggzt == "审核通过"){
			$.messager.alert("系统提示","该公告处于审核通过状态，不能修改");
			return;
		}
		window.location = "${pageContext.request.contextPath}/notice/addOrEditBidNotice?id="+id;
	}
	//查看公告（王玉杰）
	function showBidNotice(id){
		  
		window.location = "${pageContext.request.contextPath}/notice/showBidNotice?id="+id;
	}
	
	function deleteBidNotice(id,ggzt){
		if(ggzt == "待审核"||ggzt == "代理机构审核"||ggzt=="招标人审核"||ggzt=='公共服务平台审核'){
			$.messager.alert("系统提示","该公告处于待审核状态，不能删除");
			return;
		}else if(ggzt == "审核通过"){
			$.messager.alert("系统提示","该公告处于审核通过状态，不能删除");
			return;
		}
		$.messager.confirm("系统提示","您确定要删除吗?", function(ok){
			if(ok){
				window.location = "${pageContext.request.contextPath}/notice/deleteBidNotice?id="+id;
			}
		});	
	}
	
	function queryBidNotice() {
		$("#bidNotice-datagrid").datagrid("reload", {
			noticeTitleLike : $("[name='noticeTitle']").val(),
			ggxzdm : $("[name='ggxzdm']").val(),
			gglxdm : $("[name='gglxdm']").val(),
			ggfbsjAfter : $("[name='ggfbsjMin']").val(),
			ggfbsjBefore : $("[name='ggfbsjMax']").val(),
			ggzt : $("[name='ggzt']").val()
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
			公告管理
			<code>&gt;</code>
			招标/资格预审公告管理
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<%-- <input type="button" class="button red" value="添加公告" onclick="window.location='${pageContext.request.contextPath}/notice/addOrEditBidNotice'" />  --%>
			<table style="width:100%;">
			    <tr>
					<td>公告标题:</td>
					<td> 
						<input name="noticeTitle" class="inputxt" />
					</td>
					<td>公告性质:</td>
					<td>
						<select name="ggxzdm">
							<option value="">---==请选择==---</option>
							<c:forEach items="${util:dictionaryTree('GGXZDM',false)}" var="item">
								<option value="${item.itemCode}" ${item.itemCode==notice.ggxzdm?"selected='selected'":""}>${item.itemName}</option>
							</c:forEach>
						</select>
					</td>
					<td>公告类型:</td>
					<td>
						<select name="gglxdm">
							<option value="">---==请选择==---</option>
							<c:forEach items="${util:dictionaryTree('GGLXDM',false)}" var="item">
								<option value="${item.itemCode}" ${item.itemCode==notice.ggxzdm?"selected='selected'":""}>${item.itemName}</option>
							</c:forEach>
						</select>
					</td>
					<td style="text-align:right;"><a class="button red" onclick="queryBidNotice();">查 询</a></td>
				</tr>
				<tr>
					<td>发布时间从：</td>
					<td>
						<input type="text" id="ggfbsjMin" name="ggfbsjMin" class="inputxt Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
					</td>
					<td>到：</td>
					<td>
						<input type="text" id="ggfbsjMax" name="ggfbsjMax" class="inputxt Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
					</td>
					<td>公告状态:</td>
					<td>
						<select name="ggzt">
							<option value="">---==请选择==---</option>
							<c:forEach items="${util:dictionaryTree('GGZT',false)}" var="item">
								<option value="${item.itemCode}" ${item.itemCode==notice.ggxzdm?"selected='selected'":""}>${item.itemName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>
		</div>
		<div class="clearfix">
			<div class="blank10"></div>
			<table id="bidNotice-datagrid"></table>
<%-- 				<sys:page href="${pageContext.request.contextPath}/notice/pagingNotice" page="${page}"/>
 --%>			</div>
	</div>
</body>
</body>
</html>
