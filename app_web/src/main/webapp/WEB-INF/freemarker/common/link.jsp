<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>${util:property('business.platformName')}电子招投标交易平台</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="keywords" content="${util:property('business.platformName')}电子招投标" />
<meta name="description" content="${util:property('business.platformName')}电子招投标" />
<meta name="author" content="${util:property('business.platformName')}电子交易平台" />
<meta name="copyright" content="${util:property('business.platformName')}电子招投标" />
<script type="text/javascript">
	var ctx = "${pageContext.request.contextPath=='/'?'':pageContext.request.contextPath}";
</script>
<link rel="shortcut icon" href="/resources/img/favicon.ico" />
<!-- jquery -->
<script src="/resources/easyui/jquery.min.js" type="text/javascript"></script>
<!-- 页面布局样式 -->
<script src="/resources/page/top.js" type="text/javascript"></script>
<!-- 客服 -->
<script src="/resources/page/bottom.js" type="text/javascript"></script>
<!-- jquery常用插件 -->
<script src="/resources/jquery-plugins/jquery.cookie.js" type="text/javascript"></script>
<script src="/resources/jquery-plugins/jquery.form.min.js" type="text/javascript"></script>
<!-- jquery.jgrowl -->
<link href="/resources/jgrowl/jquery.jgrowl.min.css" type="text/css" rel="stylesheet" />
<script src="/resources/jgrowl/jquery.jgrowl.min.js" type="text/javascript"></script>
<!-- jquery EasyUi -->
<link href="/resources/easyui/themes/tender/extendsEasyUI.css" rel="stylesheet" type="text/css" />
<link href="/resources/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="/resources/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<script src="/resources/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<!-- 平台主样式 -->
<link href="/resources/tender/style.css" rel="stylesheet" type="text/css" />
<!-- validform -->
<link href="/resources/validform/css/style.css" type="text/css" media="all" rel="stylesheet" />
<!-- 按钮样式 -->
<link href="/resources/validform/css/button.css" type="text/css" media="all" rel="stylesheet" />
<!-- my97datepicjer -->
<script src="/resources/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 打印 -->
<script src="/resources/print/jquery.PrintArea.js" type="text/javascript"></script>
<!-- kindeditor富文本编辑器 -->
<%-- <script src="/resources/kindeditor-4.1.10/kindeditor-min.js" type="text/javascript"></script>
<script src="/resources/kindeditor-4.1.10/lang/zh_CN.js" type="text/javascript"></script> --%>
<!-- uploadify文件上传 -->
<%-- <link href="/resources/uploadify/css/uploadify.css" rel='stylesheet' type="text/css" />
<script src="/resources/uploadify/scripts/jquery.uploadify.min.js" type="text/javascript"></script> --%>
<!-- qq客服开始 -->
<%-- <link href="/resources/qqkefu/qqkefu.css" rel="stylesheet" type="text/css" />
<script src="/resources/qqkefu/qqkefu.js" type="text/javascript"></script> --%>
<!-- 支付页面 -->
<link href="/resources/css/cashier.main.css" type="text/css" rel="stylesheet" />
<link href="/resources/css/cashier.css" type="text/css" rel="stylesheet" />
<!-- flexpaper -->
<%-- <link href="/resources/Flexpaper/css/flexpaper.css" type="text/css" rel="stylesheet" />
<script src="/resources/Flexpaper/js/flexpaper.js" type="text/javascript"></script>
<script src="/resources/Flexpaper/js/flexpaper_handlers.js" type="text/javascript"></script> --%>
<!-- zTree -->
<%-- <link href="/resources/zTree_v3/css/demo.css" type="text/css" rel="stylesheet" /> --%>
<link href="/resources/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css" rel="stylesheet" />
<script src="/resources/zTree_v3/js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script src="/resources/zTree_v3/js/jquery.ztree.excheck-3.5.js" type="text/javascript"></script>
<script src="/resources/zTree_v3/js/jquery.ztree.exhide-3.5.min.js" type="text/javascript"></script>
<script src="/resources/myutil.js" type="text/javascript"></script>
<!-- 自定义表格样式 -->
<link href="/resources/css/tablestyle.css" type="text/css" media="all" rel="stylesheet" />
<!-- 颜色选择器 -->
<link rel="stylesheet" type="text/css" href="/resources/spectrum-master/spectrum.css">
<script type="text/javascript" src="/resources/spectrum-master/spectrum.js"></script>
<script type="text/javascript" src="/resources/spectrum-master/i18n/jquery.spectrum-zh-cn.js"></script>
<!-- layer -->
<%-- <link rel="stylesheet" type="text/css" href="/resources/layer/skin/layer.css" id="skinlayercss">
<script type="text/javascript" src="/resources/layer/layer.js"></script> --%>
<link rel="stylesheet" type="text/css" href="/resources/laypage/skin/laypage.css" id="skinlayercss">
<script type="text/javascript" src="/resources/laypage/laypage.js"></script>
<!-- FusionCharts -->
<script type="text/javascript" src="/resources/fusionCharts/FusionCharts.js"></script>
<!-- plupload -->
<script type="text/javascript" src="/resources/plupload-2.1.2/js/moxie.min.js"></script>
<script type="text/javascript" src="/resources/plupload-2.1.2/js/plupload.full.min.js"></script>
<script type="text/javascript" src="/resources/plupload-2.1.2/js/i18n/zh_CN.js"></script>
<!-- uedit富文本编辑器 -->
<script type="text/javascript" src="/resources/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="/resources/ueditor/ueditor.all.js"></script>
<!-- 自动textarea -->
<script type="text/javascript" src="/resources/jquery-plugins/jquery.autoTextarea.js"></script>
<script type="text/javascript" src="/resources/jquery-plugins/jquery.autoTable.js"></script>
<script type="text/javascript" src="/resources/jquery-plugins/jquery.sizing.js"></script>
<!-- 线上文件编制工具 -->
<link href="/resources/css/document.css" type="text/css" media="all" rel="stylesheet" />
<script type="text/javascript" src="/resources/jquery-plugins/jquery.webEditor.js"></script>
<!-- jquery.ca -->
<script type="text/javascript" src="/resources/jquery-plugins/jquery.ca.js"></script>
<!-- 扩展图标样式 -->
<link href="/resources/myicons/myicon.css" rel="stylesheet" type="text/css" />
<!-- 全局函数库 -->
<script type="text/javascript" src="/resources/page/util.js"></script>
<!-- 表单样式 -->
<link href="/resources/page/form.css" type="text/css" rel="stylesheet" />
<c:if test="${not empty CURRENT_USER_SESSION_INFO and CURRENT_USER_SESSION_INFO.organ.isAudits=='2'}">
	<script type="text/javascript" src="/dwr/engine.js"></script>
	<script type="text/javascript" src="/dwr/util.js"></script>
	<script type="text/javascript" src="/dwr/interface/chatManagerService.js"></script>
	<script type="text/javascript">if(dwr){dwr.engine._errorHandler = function(message, ex) {dwr.engine._debug("Error: " + ex.name + ", " + ex.message, true);};}</script>
	<script type='text/javascript' src='/resources/jquery-plugins/jquery.im.js'></script>
	<script type="text/javascript">
	$(function(){
		<%--$("#showBar").im({--%>
			<%--title:"答疑澄清",--%>
			<%--userId:"${CURRENT_USER_SESSION_INFO.id}",//当前用户ID--%>
			<%--userName:"${CURRENT_USER_SESSION_INFO.userName}",//用户名--%>
			<%--address:"${CURRENT_USER_SESSION_INFO.address}",//通讯地址--%>
			<%--//userName:"${CURRENT_USER_SESSION_INFO}",--%>
			<%--contactUrl:ctx+"/chat/getContactList",//获取联系人列表地址--%>
			<%--groupUrl:ctx+"/chat/getGroupList",//获取讨论组列表地址--%>
			<%--contactData:undefined,--%>
			<%--groupData:undefined--%>
		<%--});--%>
	});
	</script>
</c:if>
