<%@page pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<c:set value="${qualificationResultDetailService.listReviewQualificationResultDetailList2pdf(processBusinessKey,projectItemId,reviewType)}" var="attachmentId" />
<c:set value="${userService.retrieveExpertSign(processBusinessKey)}" var="expertList" />
<c:set value="${expertApplyService.getExpertSealSignList(processBusinessKey,projectItemId,'','FIRST_PRE',reviewType)}" var="expertSignList" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${recruitFile.isPrejudication == true ? '资格预审':(reviewType=='1'?'详细评审':'初步评审')}合议结果确认签名</title>
<jsp:include page="/common/link.jsp" />
	<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
		 HWPostil1_NotifyCtrlReady();
	</SCRIPT>
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyAfterAction(lActionType,lType,strName,strValue)>
        HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue);
	</SCRIPT>
<style type="text/css">
.bold_red {
	font-weight: bold;
	color: red;
}
</style>
<%
	java.util.List<com.mhb.expert.entity.TBExpertSealSign> expertSignList=(java.util.List<com.mhb.expert.entity.TBExpertSealSign>)pageContext.getAttribute("expertSignList"); 
	java.util.List<com.mhb.base.entity.TBUser> expertList=(java.util.List<com.mhb.base.entity.TBUser>)pageContext.getAttribute("expertList");
	//out.println("size="+expertSignList);
%>
<%! public boolean hasSign(java.util.List<com.mhb.expert.entity.TBExpertSealSign> expertSignList,String userId){
		if(expertSignList==null||expertSignList.isEmpty()) return false;
		for(int i=0;i<expertSignList.size();i++){
			com.mhb.expert.entity.TBExpertSealSign sign=expertSignList.get(i);
			if(userId.equals(sign.getUserId())){
				if("1".equals(sign.getIsSign())) return true;
			}
		}
		return false;
	}
%>
<script type="text/javascript">

	function HWPostil1_NotifyCtrlReady() {
	    document.all.HWPostil1.HideMenuItem(30);
	    OpenFile("${pageScope.basePath}/attachment/download/${attachmentId}");
	}

    var sealNum=0;
	$(function() {
		
		$("#disagree").click(function() {
			$(document).scrollTop(0);
			$("#disagreeDiv").dialog("open");
		});

        $("#sign").click(function(){
        	if(AddSeal(0)=="-200"){
                ShowMessage("请插入有效的USBKey！");
			}
		});
        
		$("#agree").click(function() {
			
			/* $("#workflowForm").submit();
			
			
			return false; */
			var isSign=$("input[name='isSign']").val();
			if (sealNum<=0 && isSign==0) {
                alert("请先盖章！");
                sealNum=0;
                return false;
            }
			
			var paramsArray = {"expertApplyId":"${processBusinessKey}","reviewType":"${reviewType}","projectItemId":"${projectItemId}"};
            var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/evaluation/expertPreliminaryReviewSign2");
            if ("OK" == returnValue) {
                $("#workflowForm").submit();
                ShowMessage("操作成功！");
            } else {
                ShowMessage("操作失败！");
            }
		});
		
		$("#disagreeDiv").dialog({
			open : false,
			title : '不同意原因填写窗口',
			closed:true,
			modal:true,
			width:300,
			height:200,
			buttons:[
				{text:"提交",handler:function(){
					if($("textarea[name='disagreeReason']").val()===""){
						$.messager.alert("系统提示", "请填写审核不通过原因！");
						return;
					}
					$.messager.confirm("系统提示", "确认提交吗？", function(r) {
						if (r) {
							$.ajax({
								url : ctx + "/evaluation/saveTheSignature",
								type : "post",
								dataType : "json",
								cache : false,
								beforeSend : function() {
									$("#disagree,#agree").prop("disabled", true);
									$.messager.progress({
										title : "系统提示",
										msg : "正在提交数据"
									});
								},
								data :{
									projectItemId : "${projectItemId}",
									expertApplyId : "${processBusinessKey}",
									reviewType:"${reviewType}",
									currentStage : "FIRST_PRE"
								},
								success : function(data) {
									alert(data.msg);
									if(data.success){
										$(":input[name='agree']").val("false");
										$("#workflowForm").submit();
									}			
								}
							});
						}
					});
				}},
				{text:"关闭",handler:function(){
					$('#disagreeDiv').dialog('close');
				}}
			]
		});
		
	});
	
	/* setTimeout('reloadPage()',1000*60*1);
	function reloadPage(){
		window.location.reload(true);
	} */
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
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			${recruitFile.isPrejudication == true ? '资格预审':'初步评审'}合议结果确认签名
		</div>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;评审专家：
		<%
			com.mhb.base.entity.TBUser currUser=com.mhb.base.entity.TBUser.getCurrentUser();
			int signStatus=-1;
			int isSign=0;
			int currPos=0;
			int signPos=-1;
			for(int i=0;i<expertList.size();i++){
				com.mhb.base.entity.TBUser expert=(com.mhb.base.entity.TBUser)expertList.get(i);
				if(expert.getId().equals(currUser.getId())){
					currPos=i;break;
				}
			}
			
			for(int i=0;i<expertList.size();i++){
				com.mhb.base.entity.TBUser expert=(com.mhb.base.entity.TBUser)expertList.get(i);
				//out.print(expert.getId()+","+expert.getUserName());
				boolean hasSign=hasSign(expertSignList,expert.getId());
				if(!hasSign){
					signPos=i-1;break;
				}
			}
			
			//out.print(signPos);
			
			if(currPos>signPos+1) signStatus=-1;
			else if(currPos==signPos+1) signStatus=0;
			else signStatus=1;
			
			//out.print(currPos+","+signStatus+","+signPos);
			//out.print(signPos);
			
			if(expertList.size()<=expertSignList.size()||hasSign(expertSignList,currUser.getId())){
				signStatus=0;
				isSign=1;
				out.print("<b>您已签章</b>&nbsp;&nbsp;&nbsp;&nbsp;");
			}else{
				for(int i=0;i<expertList.size();i++){
					com.mhb.base.entity.TBUser expert=(com.mhb.base.entity.TBUser)expertList.get(i);
					boolean isSelf=false;
					if(expert.getId().equals(currUser.getId())) isSelf=true;
					
			        if(i<=signPos){			
						out.print("<b>"+expert.getUserName()+"</b>&nbsp;&nbsp;&nbsp;&nbsp;");
			        }else{
			        	out.print(expert.getUserName()+"&nbsp;&nbsp;&nbsp;&nbsp;");
			        }
				}
				if(signStatus==-1) out.print("&nbsp;&nbsp;&nbsp;&nbsp;（请等待前面的专家评审完！）");
			}
		%>
		
		<div class="usBox">
			
			<div id="disagreeDiv" >
				<iframe frameborder=0 scrolling=no style="background-color:transparent; position: absolute; z-index: -1; width: 100%; height: 100%; top: 0;left:0;"></iframe>
				<form id="workflowForm" action="${pageContext.request.contextPath}/workflow/completeForm">
					<textarea id="disagreeReason" name="disagreeReason" style="width:250px;height:80px;"></textarea>
					<input type="hidden" name="taskId" value="${taskId}" /> 
					<input type="hidden" name="agree" value="true" />
				</form>
			</div>
			
				<div class="usBox main" style="padding: 3px;height:560px;" id="">
					<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
					<script src="/resources/aip/LoadAip.js"></script>
					<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
				</div>
				
				<%if(signStatus==0){%>
				 	<input type="button" class="button red" value="电子印章" id="sign"/>
				 	<input type="button" class="button red" value="不同意合议结果" id="disagree" /> 
				 	<input type="button" class="button red" value="同意合议结果" id="agree" />
				<%}%>
				<input type="hidden" name="isSign" value="<%out.print(isSign);%>" />
		</div>
		
	</div>
	
</body>
</html>
