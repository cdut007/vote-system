<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
	});
    function HWPostil1_NotifyCtrlReady() {
        document.all.HWPostil1.HideMenuItem(30);
        OpenFile("${pageScope.basePath}/attachment/download/${monitorAttach}");
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
			后台查询附件信息
		</div>
		<div class="blank10"></div>
		<div class="usBox main" style="padding: 3px;height:660px;" id="ht_content">
			<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
			<script src="/resources/aip/LoadAip.js"></script>
			<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
			<div id="ht_end"></div>
			<div class="blank10"></div>
			<div id="nopassReason">
				<input type="hidden" id="monitorAttach" name="monitorAttach" />
			</div>
			<div class="blank10"></div>
		</div>
	</div>
	<%--<jsp:include page="/common/bottom.jsp"/>--%>
</body>
</html>
