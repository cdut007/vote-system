<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%
	String fjsszt = request.getParameter("fjsszt");
	String fjgslx = request.getParameter("fjgslx");
%>
<!--装载文件-->

<script type="text/javascript" src="<%=request.getContextPath()%>/uploadify/scripts/jquery.uploadify.js"></script>

<!--ready事件-->
<script type="text/javascript">
	$(function() {
		$('#file_upload').uploadify({
			swf:'<%=request.getContextPath()%>/uploadify/scripts/uploadify.swf',
			uploader:'<%=request.getContextPath()%>/servlet/fileUploadServlet',
			formData:{fjsszt:'<%=fjsszt%>',fjgslx:'<%=fjgslx%>'},
			buttonText:'请选择文件',
			buttonImage:'<%=request.getContextPath()%>/uploadify/img/add.jpg',
			buttonClass:'uploadify-button_my',
		//	fileSizeLimit:'1048576',
			fileTypeDesc:'*.doc;*.docx;',
			fileTypeExts:'*.doc;*.docx;',
			auto:false,
			multi:true,
			queueID:'fileQueue',
			width:'102',
			height:'28',
			method:'get',
		//	uploadLimit:'10',
			'onQueueComplete' : function(event,data) {
				$('#fileListDiv').load('${pageContext.request.contextPath}/attachment/fileList',{"random":Math.random(),"uploadUserId":'${loginUser.id}',"fjsszt":'<%=fjsszt%>'});
			}
		});
	});  
</script>
		<div style="width:100%;">
			<form id='fileForm'>
			<input type="file" name="file_upload" id="file_upload" />
			<div id="fileQueue" class="fileQueue"></div>
			</form>
		</div>
