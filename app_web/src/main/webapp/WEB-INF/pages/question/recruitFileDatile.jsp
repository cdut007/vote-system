<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function(){
		$("#recruitfile-datagrid").datagrid({
			fit:true,
			singliSelect:true,
			rownumbers:true,
			fitColumns:true,
			striped:true,
			pagination:true,
			title:"澄清文件列表",
			region:"center",
			url:"${pageContext.request.contextPath}/question/pageRecruitFileDatile",
			idfield:"recruitFileId",
			columns:[ [
				{field:"projectInstanceName",title : "招标项目",align : "left",width:200},
				{field:"createTime",title : "澄清时间",align : "left",width:200},
				{field:"organAName",title : "代理机构",align : "center",width:200},
				{title : "操作",field : "id",formatter : function(value, rowData) {
					return "<a class='button red small' href='" + ctx + "/question/createRecruitFileDatile?recruitFileId="+value+"' target='_blank'>查看文件详情</a>"
					+ "<a class='button red small' href='" + ctx + "/question/createRecepit?recruitFileId="+value+"' target='_blank'>查看回执详情</a>";
				}}
			] ]
		});
	});
</script>
</head>
  <body>
    <jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				澄清与答疑
				<code>&gt;</code>
				澄清文件详情
			</div>
			<div class="block">
				<div class="usBox">
					<div class="clearfix" style="height:400px">
						<table id="recruitfile-datagrid" class="easyui-datagird"></table>
						<input type="hidden" id="recruitFileId"/>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
  </body>
</html>
