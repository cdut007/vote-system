<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新建澄清文件</title>
<sys:link uedit="true" jgrowl="true" easyui="true" ca="true"/>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyAfterAction(lActionType,lType,strName,strValue)>
        HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue);
	</SCRIPT>
<script type="text/javascript">
    var sealNum=0;
	$(function() {
	    $("#sign").click(function(){
	        if(AddSeal(0)=="-200"){
	            ShowMessage("请插入有效的USBKey！");
			}
		});
		
		$("#sub").click(function() {
            if (sealNum<=0) {
                alert("请先盖章！");
                sealNum=0;
                return false;
            }
            var r = ShowMessageOkCancel("确认提交吗?");
			if(r==1){
                var paramsArray = {"bidEndingQuestion":"${bidEndingQuestion}", "id":"${bidEndingQuestion.id}"};
                var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/question/bidEndingQuestionAnswerSign");
                if ("OK" == returnValue) {
                    ShowMessage("文件上传成功");
                    window.location.href="/home";
                } else {
                	ShowMessage("文件上传失败");
                }
			}
		});
	});

	function HWPostil1_NotifyCtrlReady() {
        document.all.HWPostil1.HideMenuItem(30);
        OpenFile("${pageScope.basePath}/attachment/download/${bidEndingQuestion.pdfAttachment.fjid00}");
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
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			新建澄清文件
		</div>
		
		<div class="usBox main" style="padding: 3px;height:660px;" id="ht_content">
			
			<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
			<script src="/resources/aip/LoadAip.js"></script>
			<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
			
			<span style="float:right"> 
				<a class="button red" id='sign'>电子印章</a>
				<a class="button red" id='sub'>提交澄清</a>
			</span>
		</div>
	</div>
</body>
</html>
