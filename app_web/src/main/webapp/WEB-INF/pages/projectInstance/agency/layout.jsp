<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.plan{
	position: absolute;
	background-color:#fff;
	z-index:1000;
	border:2px #D40000 solid;
	left:200px;
	top:200px;
	width:850px;
	height:470px;
	display:none;
}


.black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: black;
	z-index: 100;
	-moz-opacity: 0.2;
	opacity: .20;
	filter: alpha(opacity = 20);
}

</style>
<script>
	function bindFormEvent() {
		$("#zbplanBox").find(".registerform").Validform({
			ajaxPost : true,
			callback : function(data) {
				if (data.success) {
					//window.location.href = "${pageContext.request.contextPath}/node_6/biz_list";
					alert(data.msg);
				}
			},
			tiptype : function(msg, o, cssctl) {
				if (!o.obj.is("form")) {
					var objtip = o.obj.parents("td").next().find(".Validform_checktip");
					cssctl(objtip, o.type);
					objtip.text(msg);
					var infoObj = o.obj.parents("td").next().find(".infostyle");
					if (o.type == 2) {
						infoObj.fadeOut(200);
					} else {
						if (infoObj.is(":visible")) {
							return;
						}
						var left = o.obj.offset().left, top = o.obj.offset().top;
						infoObj.css({
							left : left + 170,
							top : top - 45
						}).show().animate({
							top : top - 35
						}, 200);
					}
				}
			}
		});
	}

	function zb_plan(id){
		$("#overlay").css({ display: "block", width:$(document).width(),height: $(document).height()});
		$('#zbplanBox').show().load("${pageContext.request.contextPath}/projectPlan/form?projectInstanceId="+id, {
				date : new Date()
			}, function() {
				bindFormEvent();
			});
	}
	function zb_detail(id){
		window.location.href="${pageContext.request.contextPath}/projectInstance/projectInstanceDetail?id="+id;
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
			招标项目管理
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<table class="mytableStyle">
					<thead>
						<tr>
							<th>序号</th>
							<th>招标项目编号</th>
							<th>招标项目名称</th>
							<th>招标人</th>
							<th>代理机构</th>
							<th>招标方式</th>
							<th>组织形式</th>
							<th data-options="field:'lxsj00'">立项时间</th>
							<th data-options="field:'id'">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.rows}" var="projectInstance_item" varStatus="status">
							<tr>
								<th>${status.count}</th>
								<td>${projectInstance_item.zbxmbh}</td>
								<td>${projectInstance_item.zbxmmc}</td>
								<td>${projectInstance_item.zbr000}</td>
								<td>${projectInstance_item.dljgmc}</td>
								<td>${util:dictionary('ZBFS00',projectInstance_item.zbfs00)}</td>
								<td>${util:dictionary('ZBZZXS',projectInstance_item.zbzzxs)}</td>
								<td><fmt:formatDate value="${projectInstance_item.lxsj00}" type="both" dateStyle="default" timeStyle="default" /></td>
								<td>
								    <input type='button' value='招标计划' onclick="zb_plan('${projectInstance_item.id }')" />
								    <input type='button' value='招标详细' onclick="zb_detail('${projectInstance_item.id }')" /></td>
							</tr>
						</c:forEach>
						<c:forEach begin="${fn:length(page.rows)+1}" end="${page.pageSize}" varStatus="status">
							<tr>
								<th>${fn:length(page.rows)+(page.page-1)*page.pageSize+status.count}</th>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
	
				
			<div id="operation">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add();">新增</a> <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="edit();">修改</a> <a class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="del();">删除</a>
				</div>
			</div>
		</div>
		
		<div id="zbplanBox" class="plan">			
		</div>
	</div>
	
	<div id='overlay' class='black_overlay'></div>
</body>
</html>
