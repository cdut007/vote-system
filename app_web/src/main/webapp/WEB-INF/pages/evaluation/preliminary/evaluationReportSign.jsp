 <%@page pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply" />
<c:set value="${expertApply.projectInstance}" var="projectInstance" />
<c:set value="${projectItemService.createProjectItemQuery().expertApplyId(processBusinessKey).list()}" var="projectItemList" />
<c:set value="${evaluationReportService.getEvaluationReportByExpertApplyId(processBusinessKey,projectItemId)}" var="evaluationReport" scope="request"/>

<c:set value="${userService.retrieveExpertSign(processBusinessKey)}" var="expertList" />
<c:set value="${expertApplyService.getExpertSealSignList(processBusinessKey,projectItemId,'QUAL_REPORT')}" var="expertSignList" />
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>提交评标报告</title>
<sys:link ca="true" uedit="true" easyui="true"/>
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
	    // $("#passBtn").scrollIntoView();
	    // $('#test').scrollTop( "9999px" );
	    $("#addSeal").click(function(){
	        if(AddSeal(0)=="-200"){
	            ShowMessage("请插入有效的USBKey！");
			}
		});
		
		$("#noPass").click(function(){
			if ($.trim($("#disagreeReason").val()) == '') {
				ShowMessage("请填写审核意见！");
				return;
			}
			if($("#disagreeReason").val().length > 200){
				ShowMessage("最多输入200个汉字(包含符合和空格)！");
				return;
			}
			  var r = ShowMessageOkCancel("确认提交吗?");
				if(r==1){
					$("#evaluationReportSignForm").submit();
				}
		});
		$("#submitBtn").click(function(){
			var isSign=$("input[name='isSign']").val();
			if (sealNum<=0 && isSign==0) {
                alert("请先盖章！");
                sealNum=0;
                return false;
            }
            var r = ShowMessageOkCancel("确认提交吗?");
			if(r==1){
				var paramsArray = {"taskId":"${taskId}", "DocumentID":"${evaluationReport.id}","projectItemId":"${projectItemId}","expertApplyId":"${processBusinessKey}","agree":"true"};
                var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/evaluation/completeFormEvaluationReportSign");
                if ("OK" == returnValue) {
                    ShowMessage("文件上传成功");
                    window.location.href="/home";
                } else {
                	if("workflow/taskNotFound"==returnValue){
                    	ShowMessage("任务不存在或已被处理");
                		window.location.href="/home";
                	}else{
                		ShowMessage("文件上传失败");
                	}
                }
			}
			
		});
	});
	
	function HWPostil1_NotifyCtrlReady() {
        document.all.HWPostil1.HideMenuItem(30);
        OpenFile("${pageScope.basePath}/attachment/download/${evaluationReport.pdfAttachment.fjid00}");
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
    
	/* setTimeout('reloadPage()',1000*60*2);//1000*60*2  1000*10
	
	function reloadPage(){
		window.location.reload(true);
	} */
	
	
</script>
</head>
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
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			提交评标报告
		</div>
	</div>
	<div class="block">
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
		
		if(currPos>signPos+1) signStatus=-1;
		else if(currPos==signPos+1) signStatus=0;
		else signStatus=1;
		//out.print(currPos+","+signStatus+","+signPos);
		
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
	</div>
	<div class="block">
		<!-- <div style="width:100%;background:#f1f1f1;border:1px solid #ddd"> -->
			<div class="usBox main" style="padding: 3px;height:660px;">
				<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
				<script src="/resources/aip/LoadAip.js"></script>
				<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
				<%-- ${evaluationReport.evaluationReportContent} --%>
			</div>
			<!-- <span id="sealPos"></span> -->
		<!-- </div> -->
	</div>
	<form:form action="${pageContext.request.contextPath}/evaluation/completeFormEvaluationReportSignB" method="post" id="evaluationReportSignForm" modelAttribute="evaluationReport">
		            <input type="hidden" name="DocumentID" value="${evaluationReport.id}" />
					<input type="hidden" name="taskId" value="${taskId}" />
					<input type="hidden" name="projectItemId" value="${projectItemId}" />
					<!-- <input type="hidden" name="sealSignData" id="sealSignData"/>
					<input type="hidden" name="sealName" id="sealName"/> -->
					<input type="hidden" name="expertApplyId" id="expertApplyId" value="${processBusinessKey}"/>
					<input type="hidden" name="signSha256"/>
					<input type="hidden" name="agree" value="false"/>
					<table width="100%" class="mytableStyle" style="table-layout:fixed;">
							<tr>
								<th style="vertical-align:middle">不通过意见:</th>
								<td colspan='3'><textarea id="disagreeReason" name="disagreeReason" style="width:99%;height:60px;"></textarea></td>
							</tr>
					</table>
				</form:form>
	<div style="border-radius: 5px;border:#e4e4e4 1px solid;padding:5px;bottom:0px;height:30px;background-color:#eeeeff;right:5px;left:5px;">
			<span style="float:left"> 
				<a class="button red" href="${pageContext.request.contextPath}/evaluation/bidOpenStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">开标记录表</a> 
				<a class="button red" href="${pageContext.request.contextPath}/evaluation/preliminaryStatisticsPass?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">初步评审表</a> 
				<%--<a class="button red" href="${pageContext.request.contextPath}/evaluation/priceScoreStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">报价打分表</a> --%>
				<c:choose>
					<c:when test="${projectInstance.prereviewType=='1'}" >
						<a class="button red" href="${pageContext.request.contextPath}/evaluation/evaluationDetailScoreStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">招标评分表</a>  
						<a class="button red" href="${pageContext.request.contextPath}/evaluation/tenderItemSortStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">投标人排序表</a>
					</c:when>
					<c:otherwise>
						<a class="button red" href="${pageContext.request.contextPath}/evaluation/preliminaryStatistics1?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">详细评审表</a>
					</c:otherwise>
				</c:choose>
					</span>
					<!-- <input type='button' class="button red" id='chatDetail' value="显示询标澄清表" />
					<input type='button' class="button red" id='scoreDetail' value="显示评分汇总表" /> -->
					<span style="float:right">
					<%if(signStatus==0){%>
						<input type='button' class="button red" id='noPass' value="有异议" />
						<input type='button' class="button red" id='addSeal' value="电子印章" />
						<!-- <input type='button' class="button red" value="保存" /> -->
						<input type='button' class="button red" id='submitBtn' value="提交下一步" />
					<%}%>
					<input type="hidden" name="isSign" value="<%out.print(isSign);%>" />
		</span>
	</div>
</body>
</html>
