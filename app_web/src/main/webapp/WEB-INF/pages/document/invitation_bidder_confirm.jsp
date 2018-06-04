<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标邀请文件信息</title>
<sys:link ca="true" easyui="true" jgrowl="true" datepicker="true"/>
<style type="text/css">
#bigJE {
	color: #f00;
	font-size: 14px;
	font-weight: 900
}
</style>

</head>
<c:set value="${invitationFileService.loadInvitationFile(processBusinessKey)}" var="invitationFile" scope="request"></c:set>
<script type="text/javascript">
    $(function() {
        //验证电子印章
        sealUtil.loadAllSealWithBKey("${invitationFile.id}","data=string2sign","sealPos");
    });
</script>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			<a href="javascript:history.go(-1);">项目管理</a>
			<code>&gt;</code>
			投标邀请确认
		</div>
	</div>
	<div class="block">
		<form id="invitation_form" method="post" action='${pageContext.request.contextPath}/invitationFile/submit_reply'>
			
			<div class="blank10"></div>
			<input type="hidden" name="token" value="${token}" />
			<input type="hidden" name="acceptStatus" id="acceptStatus" value="1" />
			<input type="hidden" name="invitationId" id="invitationId" value="${processBusinessKey}" />
			
			<input type="hidden" name="receiptContent" id="receiptContent" value="" />
			<div class="easyui-panel" data-options="title:'项目概况',collapsible:true">
				<table style="width:98%;table-layout:fixed;margin:0 auto;">
					<tbody>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标编号</td>
							<td>${invitationFile.projectInstance.zbxmbh}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标项目名称</td>
							<td>${invitationFile.projectInstance.zbxmmc}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">是否接受投标</td>
							<td>
								<select onchange="updateContent();" name="acceptStatusSelect" id="acceptStatusSelect" class="easyui-validatebox validatebox-text" data-options="required:true">	
									<option value="1">是</option>													
									<option value="0">否</option>																		
								</select>							
							</td>
						</tr>
						
						<tr>
									<td class="need"></td>
									<td>投标邀请内容</td>
									<td>
										<div id="invitationContentShow" style="padding:50px;border:1px solid #ddd">${invitationFile.invitationContent.replace("XXXXXXXXXX",CURRENT_USER_SESSION_INFO.organ.ztmc00)}</div>
										<div id="sealPos"></div>
									</td>
						</tr>
						
						<tr>
									<td class="need"></td>
									<td>回执内容</td>
									<td>
										<div id="invitationreceiptContentShow" style="padding:50px;border:1px solid #ddd"></div>
										<div id="sealPos1"></div>
									</td>
						</tr>
						
						
				
				
					</tbody>
				</table>
			</div>
		
					<div class="blank10"></div>					
					<input id='complete' type="button" class="button red" value="签章并提交" />
					<a class="button orange" onclick="history.go(-1)">返回</a>
		</form>
		
				<form id="invitation_task_Form" method="post" action='${pageContext.request.contextPath}/workflow/completeForm'>
							<input type="hidden" name="taskId" value="${taskId}"></input>
							<input type="hidden" name="acceptStatus" id="acceptStatus_task" value="1" />
				</form>
	</div>
	<script>
	
	function updateContent(){
		
		if($("#acceptStatusSelect").val()=="1"){
			
			$("#accept_str").html("&nbsp;接受&nbsp;");
		}
		
		if($("#acceptStatusSelect").val()=="0"){
			
			$("#accept_str").html("&nbsp;不接受&nbsp;");
		}
		$("#acceptStatus").val($("#acceptStatusSelect").val());
		$("#acceptStatus_task").val($("#acceptStatusSelect").val());
		
		$("#receiptContent").val($("#invitationreceiptContentShow").html());
	}

	function submit_form(){
        $("#invitation_form").ajaxSubmit({
            dataType:"json",
            beforeSend:function(){
                $.messager.progress({
                    title:"系统提示",
                    msg:"正在提交数据"
                });
            },
            success : function(data) {
                if(data.success){
                    $("#invitation_task_Form").submit();
                }
            },
            complete:function(){

            }
        });
	}
	
	$("#complete").click(function(){
        var sealName="${CURRENT_USER_SESSION_INFO.organName}";
        if(!sealUtil.sealExists(sealName)){
            sealUtil.addSealWithBKey("${invitationFile.id}"+":"+"${CURRENT_USER_SESSION_INFO.organId}",sealName,"data=string2sign","sealPos1",600,-200);
            if(sealUtil.sealExists(sealName)) {
                $.messager.alert("系统提示","签章成功", "info", function() {
                    submit_form();
                });
            }else{
                $.messager.alert("系统提示","签章失败！");
            }
        }else if(sealUtil.sealExists(sealName)){
            submit_form();
        }
	});
	
	$(function() {
		$.ajax({
			url:ctx+"/invitationFile/confirm_template",
			type:"post",
			data:{id:"${invitationFile.id}"},
			dataType:"html",
			success:function(data){				
				$("#invitationreceiptContentShow").html(data);
				$("#receiptContent").val(data);
			}
		});
		
	});
	
	</script>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>