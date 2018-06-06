<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply" />
<c:set value="${expertApply.projectInstance}" var="projectInstance" />
<c:set value="${expertApply.projectInstanceId}" var="projectId" />
<c:set value="${bidFileService.find(processBusinessKey)}" var="tenderFileList" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标保证金缴纳情况</title>
<sys:link easyui="true"/>
<!--ready事件-->
<script type="text/javascript">
	$(function() {
		$('#sub').click(function() {
			if (confirm('确定提交吗？')) {
				$('#form1').submit();
			}
		});
		$("#bidDeposit-datagrid").datagrid({
			title : "投标保证金缴纳情况",
			url : ctx + "/bidFile/bidDepositList",
			pagination : true,
			rownumbers : true,
			striped : true,
			fit : true,
			method : "post",
			queryParams : {
				processBusinessKey : "${processBusinessKey}",
				projectItemId : "${projectItemId}"
			
			},
			columns : [[ 
				{field : 'organBName',title : "投标单位",width:160}, 
				{field : 'bdmc00',title : "标段名称",width:70}, 
				{field : 'yingjiao',title : "应缴保证金(元)",width:100}, 
				{field : 'amt',title : "实缴保证金(元)",width:100},
				{field : 'complement',title : "是否足额",width:100,formatter:function(value,row,index){
					if(value > 0){
						return "余额不足";
					}else{
						return "余额充足";
					}
				}},  
				{field : 'fjmc00',title : "附件名称",width:115}, 
				{field : "fpath",title : "保证金凭证",width:130,formatter : function(value, row, index) {
					var img1 = '<a href="'+ctx+'/attachment/download/'+value+'"><img style="width:150px;height:80px; border:1px solid #D1D1D1" src="'+ctx+'/attachment/download/'+value+'" /><a/>';
					return img1;
				}}, 
				{field : 'isDeposit',title : "是否确认",width:70,formatter : function(value, row, index) {
					if ("1" == value) {
						return "已缴费";
					} else if ("2" == value) {
						return "未缴费";
					} else {
						return "待确认";
					}
				}}, 
				{field : 'depositReason',title : "备注",width:150} 
			]]
		});
	});

</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标保证金缴纳情况
		</div>
		<form action="${pageContext.request.contextPath}/workflow/completeForm" id="form1">
			<input type="hidden" name="taskId" value="${taskId}" />
		</form>
		<div class="blank10"></div>
		<!-- <div style="border:1px solid #e4e4e4;width:20%;height:400px;float:left;margin-right:5px;text-align:center">
			<div class="video" id="CuPlayer"><b><img src="/resources/player/images/loading.gif"  /> 网页视频播放器加载中，请稍后...</b></div>
			<script type="text/javascript">
				var so = new SWFObject("/resources/player/player.swf","ply","200","200","9","#000000");
				so.addParam("allowfullscreen","true");
				so.addParam("allowscriptaccess","always");
				so.addParam("wmode","opaque");
				so.addParam("quality","high");
				so.addParam("salign","lt");
				//播放器设置文件-----------------------------
				so.addVariable("JcScpFile","/resources/player/CuSunV2set.xml");
				//视频文件及略缩图--------------------------
				so.addVariable("JcScpServer","rtmp://172.29.135.27:1935/live");
				so.addVariable("JcScpVideoPath","${processBusinessKey}"); 
				so.addVariable("JcScpImg","images/startpic.jpg"); 
				//so.addVariable("JcScpSharetitle","极酷阳光播放器(CuSunPlayerV2.5)版使用官方演示实例"); 
				so.write("CuPlayer");
			</script>
		</div> -->
		<div style="width:100%;height:400px;">
			<table id="bidDeposit-datagrid"></table>
		</div>
	</div>
	<div class="tc"></div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>