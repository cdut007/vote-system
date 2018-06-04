<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${projectInstanceService.createProjectInstanceQuery().projectInstanceId(processBusinessKey).singleResult()}" var="projectInstance"/>
<c:set value="${commissionContractService.retrieveCommissionContractByProjectInstanceId(processBusinessKey)}" var="commissionContract" scope="request"/>
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<sys:link easyui="true"/>
	<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
	<!--在执行以下操作的时候触发此事件（打印；删除页面；删除节点；删除印章；添加印章；用户登录）。-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyAfterAction(lActionType,lType,strName,strValue)>
        HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue);
	</SCRIPT>
<script type="text/javascript">
    var sealNum=0;
	$(function() {
        $("#sign").click(function(){
            SearchText("受托人（盖章）",0,0);
            if(AutoSeal(0,1,"受托人（盖章）")=="-200"){
                ShowMessage("请插入有效的USBKey！");
			}
		});
		$("#passBtn").click(function(){
			if (sealNum<=0) {
				alert("请先盖章！");
				sealNum=0;
				return false;			
			}
            var r = ShowMessageOkCancel("确认委托代理合同有效吗?");
			if(r==1){
			    //IE11以下不支持map ，废弃该方法
                /*var m = new Map();
                m.set("taskId","${taskId}");
                m.set("commissionContractId","${commissionContract.id}");
                m.set("DocumentID","${commissionContract.id}");
                m.set("pass","true");*/
                var paramsArray = {"taskId":"${taskId}", "commissionContractId":"${commissionContract.id}", "DocumentID":"${commissionContract.id}","pass":"true"};
                var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/commissionContract/completeFormEntrustA");
                if ("OK" == returnValue) {
                    ShowMessage("文件上传成功");
                    window.location.href="/home";
                } else {
                	if("workflow/taskNotFound"==returnValue){
                    	ShowMessage("任务不存在或已被处理");
                		window.location.href="/home";
                	}else{
                		ShowMessage("文件上传失败");
                	}
                }
			}
		});
		$("#nopassReason").dialog({
			open : false,
			title : '异议内容',
			closed:true,
			modal:true,
			width:600,
			height:400,
			buttons:[
				{text:"提交",handler:function(){
					if($("#reason").val()===""){
						ShowMessageOkCancel("请填写异议内容！");
						return;
					}
					var r=ShowMessageOkCancel("确认提交异议？") ;
						if (r) {
							$("#qdhtForm").attr("action", "${pageScope.basePath}/commissionContract/completeFormEntrustB");
							$("#reasonText").text($("#reason").val());
							$("#pass").val("false");
							$("#qdhtForm").submit();
						}
				}},
				{text:"关闭",handler:function(){
					$('#nopassReason').dialog('close');
				}}
			]
		});
		//不通过按钮确认
		$("#noBtn").click(function(event) {
			$(document).scrollTop(0);
			$("#nopassReason").dialog("open");
			$("#reason").focus();
		});
	});
    function HWPostil1_NotifyCtrlReady() {
        document.all.HWPostil1.HideMenuItem(30);
        OpenFile("${pageScope.basePath}/attachment/download/${commissionContract.attachment.fjid00}");
        //document.all.HWPostil1.ForceSignType=7;
    }
    function  HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue) {
        if(lActionType==3 && lType==3){
            sealNum--;
            sealNum = sealNum <=0 ?0:sealNum;
		}else if(lActionType==5 && lType==0){
            sealNum++;
		}
    }



</script>
<style type="text/css">
h3 {
	text-align: left;
	border: 0;
}

#spanClose:hover {
	background-color: #eee;
	font-weight: bold;
	cursor: pointer;
}

form {
	margin: 0;
}

.user_write {
	font-weight: 500;
	text-decoration: underline;
	font-family: 楷体;
	font-size: 15px;
	font-style: italic;
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			签订合同
		</div>
		<div class="blank10"></div>
		<div class="usBox main" style="padding: 3px;height:660px;" id="ht_content">
			<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
			<script src="/resources/aip/LoadAip.js"></script>
			<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
			<div id="ht_end"></div>
			<div class="blank10"></div>
			<div id="nopassReason">
				<textarea id="reason" name="reason" style="position:absolute;width:560px;height:340px;"></textarea>
				<iframe frameborder=0 scrolling=no style="background-color:transparent; position: absolute; z-index: -1; width: 100%; height: 100%; top: 0;left:0;"></iframe>
			</div>
			<div style="text-align:right;">
				<form:form id="qdhtForm" method="post" action="${pageContext.request.contextPath}/workflow/completeForm" modelAttribute="commissionContract">
					<input type='hidden' id="taskId" name='taskId' value="${taskId}" />
					<input type='hidden' id="commissionContractId" name='commissionContractId' value="${commissionContract.id}"/>
					<input type="hidden" name="DocumentID" value="${commissionContract.id}"/>
					<input type='hidden' id="pass" name="pass" value="true" />
					<input type="button" class='button red' id="sign" value="电子印章"/>
					<input type="button" class='button red' id="passBtn" value="确认有效"/>
					<input type="button" class='button red' id="noBtn" value="有异议" />
				</form:form>
				<!--<iframe frameborder=0 scrolling=no style="background-color:transparent; position: absolute; z-index: 99; width: 100%; height: 100%; top: 0;left:0;"></iframe-->
				<!--<iframe style="position:absolute; visibility:inherit; top:0px; left:0px; width:100%; height:100%; z-index:9999; filter='Alpha(style=0,opacity=0)';"></iframe-->
			</div>
			<div class="blank10"></div>
		</div>
	</div>
	<%--<jsp:include page="/common/bottom.jsp"/>--%>
</body>
</html>
