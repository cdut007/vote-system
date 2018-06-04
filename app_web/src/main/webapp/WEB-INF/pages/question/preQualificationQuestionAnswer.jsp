<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新建澄清文件</title>
<sys:link uedit="true" jgrowl="true" easyui="true" ca="true"/>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		var sealName="${CURRENT_USER_SESSION_INFO.userName}";
		var preQualificationQuestionId = "${preQualificationQuestion.id}";
		$("#id").val(preQualificationQuestionId);		
		var posX = 500;
		var posY = -200;
		
		$("#sign").click(function(){
			var  string2sign = $("#modifyContentOrigin").val();
			sealUtil.addSealWithBKey(preQualificationQuestionId,sealName,"data=string2sign","sealPos",posX,posY);
			
			//var signDta = sealUtil.addSealWithBKeyNoSave(sealName,"data=string2sign","sealPosition2",posX,posY);
			//TODO 盖完章后将编辑器disabled掉，防止用户再次编辑 by xieyang
			//ue.setEditable(false);
			//$("input[name='signatureData']").val(signDta);
			
			$("#modifyContentOrigin").attr("readonly","readonly");
		});
		
		//验证电子印章
		sealUtil.loadAllSealWithBKey(preQualificationQuestionId,"data=string2sign","sealPos");
		
		$("#sub").click(function() {
			if(!sealUtil.sealExists(sealName)){
				$.messager.alert("系统提示","请先盖章！");
				return;
			}
			$("#preQualificationQuestionAnswerForm").ajaxSubmit({
				dataType:"json",
				beforeSend:function(){
					$.messager.progress({
						title:"系统提示",
						msg:"正在保存澄清文件"
					});
				},
				success : function(data) {
					if(data.success){
						$.messager.alert("系统提示","澄清文件发布成功！","info",function(){
							window.close();
						});
					}
				},
				complete:function(){
					$.messager.progress("close");
				}
			});
		});
	});
	

	function updateContent(){
		$("#detail_content").html($("#modifyContentOrigin").val());
		$("#questionAnswer").val($("#content").html());
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
	</div>
	<form id="preQualificationQuestionAnswerForm" action="${pageContext.request.contextPath}/question/savePreQualificationQuestionAnswer" method="post">
		<div class="block">
		
			<table style="width:100%;">
				<tr>
					<td>澄清内容：</td>
					<td>
						<textarea oninput="updateContent();" onpropertychange="updateContent();" id="modifyContentOrigin" name="modifyContentOrigin" class="easyui-validatebox" style="height:200px;width:930px;" data-options="required:true" ></textarea>
					</td>
				</tr>
				<tr>
					<td>澄清通知：</td>
					<td>
						<div id="content" style="padding:50px;border:1px solid #ddd;"><jsp:include page="preQualificationQuestionDefault.jsp" /></div>
					</td>
				</tr>
			</table>
				<input type="hidden" id="questionAnswer" name="questionAnswer" />
				<input type="hidden" id="id" name="id" value="${preQualificationQuestion.id }" />
			
			<span id="sealPos"></span>
		
			<p></p>
			
		</div>
		
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div style="border-radius: 5px;border:#e4e4e4 1px solid;padding:5px;position:fixed;bottom:0px;height:30px;background-color:#eeeeff;z-index:9999;right:5px;left:5px;">

			<input type='hidden' name="sealName" value="${CURRENT_USER_SESSION_INFO.userName}" />
			<input type='hidden' name="posX" value="500"/>
			<input type='hidden' name="posY" value="-200"/>

			<span style="float:right"> 
				<a class="button red" id='sign'>电子印章</a>
				<a class="button red" id='sub'>提交澄清</a>
			</span>
		</div>
	</form>
</body>
</html>
