<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function() {
	$("#preQualificationQuestion-datagrid").datagrid({
		title:"投标单位资格预审结果质疑列表",
		url:ctx+"/question/pagingPreQualificationQuestionListDataByA",
		pagination:true,
		rownumbers:true,
		singleSelect:true,
		striped:true,
		nowrap:false,
		height:450,
		idField:"id",
		method:"post",
		columns:[[
			{field : "organTName",title : "招标单位",width:100,hidden:true}, 
		    {field : "projectInstanceName",title : "招标项目",width:250,hidden:false}, 
		    {field : "organBName",title : "质疑单位",width:100,hidden:false}, 
		    {field : "questionDate",title : "质疑时间",width:100,hidden:false}, 			    
		    {field : "questionContent",title : "质疑内容",width:350,hidden:false},			
		    {field : "id",title : "操作",width:80,align:'center',formatter:function(value, row, index) {
				//return '<a class="button red small" href="'+ctx+'/question/preQualificationQuestionAnswer?id='+row["id"]+'">澄清</a>';
				return "<a class='button red small' onclick=\"chengQing('" + value + "')\">澄清</a>";
			}}
		]],
	});
});

function chengQing(preQualificationQuestionId) {
	
	$.ajax({
		url:ctx+"/question/preQualificationQuestionAnswerTime",
		type:"post",
		data:{preQualificationQuestionId:preQualificationQuestionId},
		dataType:"json",
		success:function(data){
			if(data.success){
				window.location="${pageContext.request.contextPath}/question/preQualificationQuestionAnswer?id="+preQualificationQuestionId;
			}else{
				$.messager.alert("系统提示","澄清时间须在质疑发起之后的3日内！","error");
				return false;
			}
		}
	});
}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		
		<div class="AreaR ">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				<code>&gt;</code>
				投标单位开标结果澄清
			</div>
			<div class="block">
				<div class="usBox">
					<div class="clearfix">
						<table id="preQualificationQuestion-datagrid" class="easyui-datagird"></table>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>