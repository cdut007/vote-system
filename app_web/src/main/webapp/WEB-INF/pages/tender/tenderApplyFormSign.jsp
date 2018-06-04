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
		    OpenFile("${pageScope.basePath}/attachment/download/${tender.pdfAttachment.fjid00}");
		    //document.all.HWPostil1.ForceSignType=7;
		}
        var sealNum=0;
		$(function(){
			
			//alert("${tender.pdfAttachment.fjid00}");

	        $("#sign").click(function(){
	    		SearchText("申请单位名称",0,0);
		        if(AutoSeal(0,1,"申请单位名称")=="-200"){
		            ShowMessage("请插入有效的USBKey！");
				}
			});

			$("#pass").click(function() {
				
				if (sealNum==0) {
					alert("请先盖章！");
					return false;
				}	

                var paramsArray = {"tenderId":"${tender.id}"};
                var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/tenderApply/tenderApplyStartFlow");
	            if ("OK" == returnValue) {
	                ShowMessage("报名成功！");
	                window.location.href="/home";
	            } else {
	                ShowMessage("报名失败！");
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
			报名申请
		</div>
	</div>
<div class="block">
		
		<div class="usBox main" style="padding: 3px;height:660px;" id="">
			<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
			<script src="/resources/aip/LoadAip.js"></script>
			<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
		</div>
		
		<input type="button" class="button red" value="电子印章" id="sign"/>
		<input type="button" class="button red" value="提 交" id="pass" />
</div>
</body>