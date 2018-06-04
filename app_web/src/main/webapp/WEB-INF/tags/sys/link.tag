<%@tag pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@attribute name="title" type="java.lang.String" description="title"%>
<%@attribute name="jgrowl" type="java.lang.Boolean" description="jGrowl 消息提醒组件"%>
<%@attribute name="easyui" type="java.lang.Boolean" description="jquery.easyui"%>
<%@attribute name="ztree" type="java.lang.Boolean" description="zTree 树形组件"%>
<%@attribute name="uedit" type="java.lang.Boolean" description="uedit 百度富文本编辑器"%>
<%@attribute name="spectrum" type="java.lang.Boolean" description="spectrum 颜色选择器"%>
<%@attribute name="plupload" type="java.lang.Boolean" description="spectrum 文件上传组件"%>
<%@attribute name="fusioncharts" type="java.lang.Boolean" description="fusionCharts 图表组件"%>
<%@attribute name="webedit" type="java.lang.Boolean" description="webEdit 招投标文件编辑预览组件"%>
<%@attribute name="laypage" type="java.lang.Boolean" description="laypage 分页组件"%>
<%@attribute name="ca" type="java.lang.Boolean" description="ca 签名签章组件"%>
<%@attribute name="datepicker" type="java.lang.Boolean" description="datePicker 日期选择组件"%>
<%@attribute name="chatbtnid" type="java.lang.String" description="chat 即时通讯组件"%>
<title>${util:property('business.platformName')}电子招投标交易平台</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="${util:property('business.platformName')}电子招投标" />
<meta name="description" content="${util:property('business.platformName')}电子招投标" />
<meta name="author" content="${util:property('business.platformName')}电子交易平台" />
<meta name="copyright" content="${util:property('business.platformName')}电子招投标" />
<script type="text/javascript">
	var ctx = "${pageContext.request.contextPath=='/'?'':pageContext.request.contextPath}";
</script>
<link rel="shortcut icon" href="/resources/img/favicon.ico" />
<!-- 平台主样式 -->
<link href="/resources/tender/style.css" rel="stylesheet" type="text/css" />
<link href="/resources/validform/css/style.css" type="text/css" media="all" rel="stylesheet" />
<link href="/resources/validform/css/button.css" type="text/css" media="all" rel="stylesheet" />
<link href="/resources/css/tablestyle.css" type="text/css" media="all" rel="stylesheet" />
<!-- jquery -->
<script src="/resources/easyui/jquery.min.js" type="text/javascript"></script>
<!-- jquery.form -->
<script src="/resources/jquery-plugins/jquery.form.min.js" type="text/javascript"></script>
<!-- 客服 -->
<!-- jquery.cookie -->
<script src="/resources/jquery-plugins/jquery.cookie.js" type="text/javascript"></script>
<!-- jquery.hotkeys -->
<script src="/resources/jquery-plugins/jquery.hotkeys.js" type="text/javascript"></script>
<!-- rangy -->
<script src="/resources/rangy/rangy-core.js" type="text/javascript"></script>
<script src="/resources/rangy/rangy-classapplier.js" type="text/javascript"></script>
<script src="/resources/rangy/rangy-textrange.js" type="text/javascript"></script>

<script src="/resources/page/top.js" type="text/javascript"></script>
<script src="/resources/page/bottom.js" type="text/javascript"></script>
<!-- jquery.autoTextarea -->
<script type="text/javascript" src="/resources/jquery-plugins/jquery.autoTextarea.js"></script>
<!-- jquery.autoTable -->
<script type="text/javascript" src="/resources/jquery-plugins/jquery.autoTable.js"></script>
<!-- jquery.sizing -->
<script type="text/javascript" src="/resources/jquery-plugins/jquery.sizing.js"></script>

<c:if test="${not empty easyui and easyui}">
	<link href="/resources/easyui/themes/tender/extendsEasyUI.css" rel="stylesheet" type="text/css" />
	<link href="/resources/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
	<script src="/resources/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="/resources/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
	<script src="/resources/jquery-plugins/jquery.easyui.validType.ext.js" type="text/javascript"></script>
</c:if>
<%-- <c:if test="${not empty datepicker and datepicker}"> --%>
	<!-- my97datepicjer -->
	<script src="/resources/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<%-- </c:if> --%>
<!-- 打印 -->
<script src="/resources/print/jquery.PrintArea.js" type="text/javascript"></script>
<!-- jquery.jgrowl -->
<c:if test="${not empty jgrowl and jgrowl}">
	<link href="/resources/jgrowl/jquery.jgrowl.min.css" type="text/css" rel="stylesheet" />
	<script src="/resources/jgrowl/jquery.jgrowl.min.js" type="text/javascript"></script>
</c:if>
<c:if test="${not empty ztree and ztree}">
	<link href="/resources/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css" rel="stylesheet" />
	<script src="/resources/zTree_v3/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
	<script src="/resources/zTree_v3/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
	<script src="/resources/zTree_v3/js/jquery.ztree.exhide-3.5.min.js" type="text/javascript"></script>
</c:if>
<c:if test="${not empty uedit and uedit}">
	<script type="text/javascript" src="/resources/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="/resources/ueditor/ueditor.all.min.js"></script>
	<script type="text/javascript" src="/resources/ueditor/lang/zh-cn/zh-cn.js"></script>
</c:if>
<c:if test="${not empty plupload and plupload}">
	<script type="text/javascript" src="/resources/plupload-2.1.2/js/moxie.min.js"></script>
	<script type="text/javascript" src="/resources/plupload-2.1.2/js/plupload.full.min.js"></script>
	<script type="text/javascript" src="/resources/plupload-2.1.2/js/i18n/zh_CN.js"></script>
</c:if>
<c:if test="${not empty spectrum and spectrum}">
	<link rel="stylesheet" type="text/css" href="/resources/spectrum-master/spectrum.css">
	<script type="text/javascript" src="/resources/spectrum-master/spectrum.js"></script>
	<script type="text/javascript" src="/resources/spectrum-master/i18n/jquery.spectrum-zh-cn.js"></script>
</c:if>
<!-- FusionCharts -->
<c:if test="${not empty fusioncharts and fusioncharts}">
	<script type="text/javascript" src="/resources/fusionCharts/FusionCharts.js"></script>
</c:if>
<c:if test="${not empty webedit and webedit}">
	<link href="/resources/css/document.css" type="text/css" media="all" rel="stylesheet" />
	<script type="text/javascript" src="/resources/jquery-plugins/jquery.webEditor.js"></script>
</c:if>
<c:if test="${not empty ca and ca}">
	<!-- <script type="text/javascript" src="/resources/jquery-plugins/jquery.ca.js"></script> -->
	<script type="text/javascript" src="/resources/ca/LoadJITDsign.js"></script>
	<!--<script type="text/javascript" src="/resources/ca/sha256.js"></script>-->
	<!--<script type="text/javascript" src="/resources/ca/LoadSXCACertInfo.js"></script>-->
	<!-- <script type="text/javascript" src="/resources/ca/Loadwebsign.js"></script> -->
	<script type="text/javascript" src="/resources/ca/main1.js"></script>
	<script type="text/javascript" src="/resources/kinggrid/LoadHTMLSign.js"></script>
	<!-- <script type="text/javascript" src="/resources/kinggrid/LoadSXCASignClient.js"></script> -->
	<script type="text/javascript" src="/resources/kinggrid/sealUtil.js"></script>
</c:if>
<c:if test="${not empty laypage and laypage}">
	<link rel="stylesheet" type="text/css" href="/resources/laypage/skin/laypage.css" id="skinlayercss">
	<script type="text/javascript" src="/resources/laypage/laypage.js"></script>
</c:if>
<link href="/resources/myicons/myicon.css" rel="stylesheet" type="text/css" />
<!-- CuPlayer -->
<script type="text/javascript" src="/resources/player/images/swfobject.js"></script>
<script type="text/javascript" src="/resources/page/util.js"></script>
<c:if test="${not empty CURRENT_USER_SESSION_INFO and CURRENT_USER_SESSION_INFO.organ.isAudits=='2'}">
	<script type="text/javascript" src="/dwr/engine.js"></script>
	<script type="text/javascript" src="/dwr/util.js"></script>
	<script type="text/javascript" src="/dwr/interface/chatManagerService.js"></script>
	<script type="text/javascript">dwr.engine._errorHandler = function(message, ex) {dwr.engine._debug("Error: " + ex.name + ", " + ex.message, true);};</script>
	<script type='text/javascript' src="/dwr/interface/chatManagerService.js"></script>
	<script type="text/javascript" src="/resources/jquery-plugins/jquery.im.js"></script>
	<script type="text/javascript">
	$(function(){
		if(false&&$.parser&&$("#${empty chatbtnid?'showBar':chatbtnid}").length==1){
			$("#${empty chatbtnid?'showBar':chatbtnid}").im({
				//title:"答疑澄清",
				//userName:"${CURRENT_USER_SESSION_INFO}",
				userId:"${CURRENT_USER_SESSION_INFO.id}",//当前用户ID
				userName:"${CURRENT_USER_SESSION_INFO.userName}",
				address:"${CURRENT_USER_SESSION_INFO.address}",
				email:"${CURRENT_USER_SESSION_INFO.email}",
				contactUrl:ctx+"/chat/getContactList",//获取联系人列表地址
				groupUrl:ctx+"/chat/getGroupList",//获取讨论组列表地址
				contactData:undefined,
				groupData:undefined
			});
		}
		/* org.activemq.Amq.init({ uri: 'amq', logging: true, timeout: 45, clientId:(new Date()).getTime().toString() });
        org.activemq.Chat.init();   */
	});
	</script>
</c:if>
<link href="/resources/page/form.css" type="text/css" rel="stylesheet" />
<!-- <script type="text/javascript">
$(document).ajaxError(function(event,request, settings){
	if(request.statusText!="canceled"){
		$.messager.alert("系统提示","操作失败!","error");
	}
}); -->