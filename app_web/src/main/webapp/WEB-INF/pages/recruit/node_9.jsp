<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="projectInstance" value="${taskService.getVariable(taskId,'projectInstance')}" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
function getData($li) {
	var $parentLi = $li.parent("ul").parent("li");
	var data = {};
	var $pre = $li.children("pre");
	var $span = $pre.children("span.index").remove();
	data["content"] = $pre.html();
	$pre.prepend($span);
	data["id"] = $li.data("id") ? $li.data("id") : "";
	data["noDisplay"] = $li.attr("noDisplay");
	data["isTitle"] = $li.attr("isTitle");
	data["orderno"] = $li.attr("orderno") ? $li.attr("orderno") : "";
	data["parent"] = $parentLi.data("id") ? $parentLi.data("id") : "";
	data["noType"] = $li.attr("noType");
	if (data["id"] == "") {
		var $comment = $li.data("comment");
		if ($comment) {
			data["reference"] = $li.attr("unique");
			data["comment"] = $comment.children(".tooltip-content").html();
		}
	}
	return data;
}
function createInput($li, $form, prefix) {
	var options = this;
	if ($li.children("ul").length == 1) {
		$li.children("ul").children("li").each(function(i) {
			var data = getData($(this));
			$("<input type='hidden'/>").attr("name", prefix + ".recruitFiles[" + i + "].id").val(data["id"]).appendTo($form);
			$("<input type='hidden'/>").attr("name", prefix + ".recruitFiles[" + i + "].noType").val(data["noType"]).appendTo($form);
			$("<input type='hidden'/>").attr("name", prefix + ".recruitFiles[" + i + "].orderno").val(data["orderno"]).appendTo($form);
			$("<input type='hidden'/>").attr("name", prefix + ".recruitFiles[" + i + "].content").val(data["content"]).appendTo($form);
			$("<input type='hidden'/>").attr("name", prefix + ".recruitFiles[" + i + "].isTitle").val(data["isTitle"]).appendTo($form);
			$("<input type='hidden'/>").attr("name", prefix + ".recruitFiles[" + i + "].parent").val(data["parent"]).appendTo($form);
			$("<input type='hidden'/>").attr("name", prefix + ".recruitFiles[" + i + "].noDisplay").val(data["noDisplay"]).appendTo($form);
			if (data["comment"]) {
				$("<input type='hidden'/>").attr("name", prefix + ".recruitFiles[" + i + "].comments[0].content").val(data["comment"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", prefix + ".recruitFiles[" + i + "].comments[0].user.id").val(options.user.id).appendTo($form);
				$("<input type='hidden'/>").attr("name", prefix + ".recruitFiles[" + i + "].comments[0].reference").val(data["reference"]).appendTo($form);
			}
			createInput.call(options, $(this), $form, prefix + ".recruitFiles[" + i + "]");
		});
	}
}
$(function() {
	$("#webEditor").webEditor({
		user : {
			id : "${CURRENT_USER_SESSION_INFO.id}",
			name : "${CURRENT_USER_SESSION_INFO.userName}"
		},
		zoomPercent:80,
		href : [ "${pageContext.request.contextPath}/recruitFile/preview?id=${recruitFileId}" ],
		uploadURL:"${pageContext.request.contextPath}/document/imageUpload",
		openable:false,
		editable : false,
		reviewable : true,
		onSave : function() {
			var options = this;
			var $form = $("<form/>").attr("action", "${pageContext.request.contextPath}/document/updateTemplate");
			$("li[changed='create']").filter(function() {
				return $(this).parent("ul").parent("li").data("id");
			}).each(function(i) {
				var data = getData($(this));
				$("<input type='hidden'/>").attr("name", "createFiles[" + i + "].id").val(data["id"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "createFiles[" + i + "].content").val(data["content"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "createFiles[" + i + "].orderno").val(data["orderno"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "createFiles[" + i + "].isTitle").val(data["isTitle"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "createFiles[" + i + "].parent").val(data["parent"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "createFiles[" + i + "].noDisplay").val(data["noDisplay"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "createFiles[" + i + "].noType").val(data["noType"]).appendTo($form);
				if (data["comment"]) {
					$("<input type='hidden'/>").attr("name", "createFiles[" + i + "].comments[0].user.id").val(options.user.id).appendTo($form);
					$("<input type='hidden'/>").attr("name", "createFiles[" + i + "].comments[0].content").val(data["comment"]).appendTo($form);
					$("<input type='hidden'/>").attr("name", "createFiles[" + i + "].comments[0].reference").val(data["reference"]).appendTo($form);
				}
				createInput.call(options, $(this), $form, "createFiles[" + i + "]");
			});
			$("li[changed='update']").each(function(i) {
				var data = getData($(this));
				$("<input type='hidden'/>").attr("name", "updateFiles[" + i + "].id").val(data["id"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "updateFiles[" + i + "].content").val(data["content"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "updateFiles[" + i + "].orderno").val(data["orderno"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "updateFiles[" + i + "].isTitle").val(data["isTitle"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "updateFiles[" + i + "].parent").val(data["parent"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "updateFiles[" + i + "].noDisplay").val(data["noDisplay"]).appendTo($form);
				$("<input type='hidden'/>").attr("name", "updateFiles[" + i + "].noType").val(data["noType"]).appendTo($form);
			});
			$("li[changed='delete']").each(function(i) {
				var data = getData($(this));
				$("<input type='hidden'/>").attr("name", "deleteFiles[" + i + "].id").val(data["id"]).appendTo($form);
			});
			$(".tooltip[changed='create']").filter(function() {
				return !$(this).data("li").attr("changed") || $(this).data("li").attr("changed") != "create";
			}).each(function(i) {
				$("<input type='hidden'/>").attr("name", "createComments[" + i + "].templateItem.id").val($(this).data("li").data("id")).appendTo($form);
				$("<input type='hidden'/>").attr("name", "createComments[" + i + "].user.id").val(options.user.id).appendTo($form);
				$("<input type='hidden'/>").attr("name", "createComments[" + i + "].content").val($(this).children(".tooltip-content").html()).appendTo($form);
				$("<input type='hidden'/>").attr("name", "createComments[" + i + "].reference").val($(this).data("li").attr("unique")).appendTo($form);
			});
			$(".tooltip[changed='update']").each(function(i) {
				$("<input type='hidden'/>").attr("name", "updateComments[" + i + "].templateItem.id").val($(this).data("li").data("id")).appendTo($form);
				$("<input type='hidden'/>").attr("name", "updateComments[" + i + "].id").val($(this).attr("id")).appendTo($form);
				$("<input type='hidden'/>").attr("name", "updateComments[" + i + "].content").val($(this).children(".tooltip-content").html()).appendTo($form);
				$("<input type='hidden'/>").attr("name", "updateComments[" + i + "].reference").val($(this).data("li").attr("unique")).appendTo($form);
			});
			$(".tooltip[changed='delete']").each(function(i) {
				$("<input type='hidden'/>").attr("name", "deleteComments[" + i + "].templateItem.id").val($(this).data("li").data("id")).appendTo($form);
				$("<input type='hidden'/>").attr("name", "deleteComments[" + i + "].id").val($(this).attr("id")).appendTo($form);
			});
			if ($form.serialize() == "") {
				$.messager.alert("系统提示","没有任何修改");
				return;
			}
			$("<input type=\"hidden\"/>").attr("name", "id").val(templateId).appendTo($form);
			$.ajax({
				url : $form.attr("action"),
				type : "post",
				dataType : "json",
				data : $form.serialize(),
				success : function(data) {
					if (data.success) {
						options.app.webEditor("refreshDocument");
					} else {
						$.messager.alert("系统消息", data.msg);
					}
				}
			});
		}
	});
	$("#pass").click(function(){
		var $form=$(this).parent("form");
		if($(".my_word_document>.my_word_comment>.tooltip").length>0){
			$.messager.confirm("系统提示","当前文件已经添加批注，确认通过后将放弃所有批注?", function(ok){
				if(ok){
					$form.submit();
				}
			});	
		}else{
			$.messager.confirm("系统提示","确认选择通过吗?", function(ok){
				if(ok){
					$form.submit();
				}
			});	
		}
	});
	$("#unpass").click(function(){
		var $form=$(this).parent("form");
		if($(".my_word_document>.my_word_comment>.tooltip").length==0){
			$.messager.alert("系统提示","请在批注中添加审核不通过原因!");	
		}else{
			$.messager.confirm("系统提示","确认选择不通过吗?", function(ok){
				if(ok){
					$("#webEditor").webEditor("saveDocument");
					$form.children("input[name='finalNoticePass']").val("false");
					$form.submit();
				}
			});	
		}
	});
});
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',border:false">
		<div id="webEditor">
		</div>
	</div>
	<div data-options="region:'south',height:40,split:false" style="padding:4px;text-align:right;background-color:#efefef;">
		<form action="${pageContext.request.contextPath}/workflow/completeForm" method="post">			
			<input type="hidden" name="taskId" value="${taskId}"/>
			<input type="hidden" name="finalNoticePass" value="true"/>
			<input type="button" class="button red" value="通过" id="pass"/>
			<input type="button" class="button red" value="不通过" id="unpass"/>
		</form>
	</div>
</body>
</html>