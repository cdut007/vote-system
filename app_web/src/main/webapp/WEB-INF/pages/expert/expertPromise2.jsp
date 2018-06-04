<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>

<head>
<sys:link ca="true" uedit="true" easyui="true" />
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyAfterAction(lActionType,lType,strName,strValue)>
        HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue);
	</SCRIPT>

	<script type="text/javascript">
		function HWPostil1_NotifyCtrlReady() {
		    document.all.HWPostil1.HideMenuItem(30);
		    OpenFile("${pageScope.basePath}/attachment/download/${expertPromise.pdfAttachmentAvoid.fjid00}");
		    //document.all.HWPostil1.ForceSignType=7;
		}
        var sealNum=0;
		$(function(){
	        $("#sign").click(function(){
	    		SearchText("签章",0,0);
		        if(AutoSeal(0,1,"签章")=="-200"){
		            ShowMessage("请插入有效的USBKey！");
				}
			});

			$("#pass").click(function() {
				
				if (sealNum==0) {
					alert("请先盖章！");
					return false;
				}	
				
	            //var m = new Map();	            
	            //m.set("DocumentID","${expertPromise.id}");
	            //m.set("projectInstanceId","${expertApply.projectInstanceId}");
	            //m.set("projectInstanceName","${projectInstance}");
	            //m.set("userType","1");
	            //m.set("id","${expertPromise.id}");
	            //m.set("expertApplyId","${expertApplyId}");
	            //m.set("taskId","${taskId}");	            
	            //var returnValue = SaveDoc(m,"${pageScope.basePath}/expertPromise/expertPromiseAvoidSave");
	            
	            var paramsArray = {"taskId":"${taskId}", "id":"${expertPromise.id}","DocumentID":"${expertPromise.id}","projectInstanceId":"${expertApply.projectInstanceId}","projectInstanceName":"${projectInstance}","userType":"1","expertApplyId":"${expertApplyId}"};
                var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/expertPromise/expertPromiseAvoidSave");
	            if ("OK" == returnValue) {
	                ShowMessage("签到成功！");
	                window.location.href="/home";
	            } else {
	            	if("workflow/taskNotFound"==returnValue){
	                	ShowMessage("任务不存在或已被处理");
	                	window.location.href="/home";
	                }else{
	                	ShowMessage("签到失败！");
	                }
	            }
			});
		});
        function  HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue) {
            if(lActionType==3 && lType==3){
                sealNum--;
                sealNum = sealNum <=0 ?0:sealNum;
            }else if(lActionType==5 && lType==0){
                sealNum++;
            }
        }
	</script>
	
</head>

<body>
<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			专家签到
			<code>&gt;</code>
			评标专家回避承诺书
		</div>
	</div>
<div class="block">
	<form:form modelAttribute="expertPromise">
		<input id="DocumentID" type="hidden" name="DocumentID" value="${expertPromise.id}" />
		<%-- <form:hidden path="content" /> --%>
		
		<%-- <div style="font-size:18px;line-height:40px;margin:0 auto;width:40%;">
			${expertPromise.content}
		</div> --%>
		
		<div class="usBox main" style="padding: 3px;height:560px;" id="">
			<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
			<script src="/resources/aip/LoadAip.js"></script>
			<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
		</div>
		
		<input type="button" class="button red" value="电子印章" id="sign"/>
		<input type="button" class="button red" value="提 交" id="pass" />
	</form:form>
</div>
</body>