<%@page pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<sys:link title="初步评审" easyui="true" webedit="true" jgrowl="true" spectrum="true" />
	<%-- <jsp:include page="/common/link.jsp" /> --%>
	<c:catch var="exception">
		<jsp:useBean id="nowDate" class="java.util.Date" />
		<c:set value="${tenderItem.projectItemId}" var="projectItemId"></c:set>
		<c:set value="${recruitFileService.findRecruitFileOfModify(projectItemId)}" var="modifyAttachmentId"></c:set>
	</c:catch>
	<%
		//String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		pageContext.setAttribute("basePath",basePath);
	%>
	<style type="text/css">
		.bold_red {
			font-weight: bold;
			color: red;
		}

		.button{
			padding-right: 15px;
			padding-left: 15px;
		}
	</style>
	<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
        HWPostil1_NotifyCtrlReady();
	</SCRIPT>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil2 EVENT=NotifyCtrlReady>
        HWPostil2_NotifyCtrlReady();
	</SCRIPT>
	<script type="text/javascript">
        $(function() {
            $("#sub").click(function() {
                var r = ShowMessageOkCancel("您确定提交审核结果吗?");
                if(r==1){
                    $("#form1").attr("action", "${pageContext.request.contextPath}/flow/completeTask");
                    $("#form1").attr("method", "post");
                    $("#form1").submit();
				}
            });
            $(":input[name='qualificationResult']").change(function() {
                if ($(this).val() != "" && $(this).val() != "0") {
                    $(this).addClass("bold_red");
                } else {
                    $(this).removeClass("bold_red");
                }
            }).change();
            //初步评审
            $("#btn_com_review").click(function() {
                $("#div_com_review").dialog("open");
            });
            $("#div_com_review").css("padding", 5).dialog({
                width : 1000,
                height : 600,
                title : "${recruitFile.isPrejudication==true ? '资格预审':'初步评审'}",
                closed : true,
                modal : true,
                maximizable : true,
                closable : true,
                buttons : [ {
                    text : '关闭',
                    handler : function() {
                        $("#div_com_review").dialog("close");
                    }
                }, {
                    text : '保存',
                    handler : function() {
                        //checkReason();
                        var results1 = $("select[name='qualificationResult']").val();/* 为什么jquery不能获取所有值？ */

                        var results = document.getElementsByName("qualificationResult");
                        var reasons = document.getElementsByName("qualificationResultReason");
                        for(var i=0;i<results.length;i++){
                            var result = results[i].value;
                            //alert(result);
                            if(result=="1" || result=="2"){
                                var reason = reasons[i].value;
                                if(reason=="" || reason==null){
                                    //$.messager.alert("系统提示","请输入不合格或不评审原因！");
                                    ShowMessage("请输入不合格或不评审原因！");
                                    return false;
                                }
                            }
                        }

                        $("#result_form").ajaxSubmit({
                            dataType : "json",
                            success : function(data) {
                                //$.jGrowl(data.msg);
                                ShowMessage(data.msg);
                            }
                        });
                    }
                } ]
            });
            
            
    		$("#open_compliance_reviews").click(function() {
    			$("#compliance_reviews_dialog").dialog("open");
    		});
    		$("#compliance_reviews_dialog").dialog({
    			width : 1000,
    			height : 600,
    			title : '初步评审结果',
    			closed : true,
    			modal : true,
    			maximizable : true,
    			closable : true,
    			bodyCls : "box",
    			buttons : [ {
    				text : '关闭',
    				handler : function() {
    					$("#compliance_reviews_dialog").dialog("close");
    				}
    			} ]
    		});
    		/*$("#pbbfss  input").each(function(){
    			$(this).attr("readonly","readonly");
    		});*/
    	});
            

        function checkReason(){
            var results1 = $("select[name='qualificationResult']").val();/* 为什么jquery不能获取所有值？ */
            var results = document.getElementsByName("qualificationResult");
            var reasons = document.getElementsByName("qualificationResultReason");
            for(var i=0;i<results.length;i++){
                var result = results[i].value;
                alert(result);
                if(result=="1" || result=="2"){
                    var reason = reasons[i].value;
                    if(reason=="" || reason==null){
                        //$.jGrowl("请输入原因！");
                        ShowMessage("请输入原因！");
                    }
                }
            }
        }
	</script>
	<script type="text/javascript">
        //$(function() {
        //	$("#webEditor").webEditor({
        //		user : {
        //			id : "${CURRENT_USER_SESSION_INFO.id}",
        //			name : "${CURRENT_USER_SESSION_INFO.userName}"
        //		},
        //		zoomPercent : 100,
        //		href : [ "${pageContext.request.contextPath}/attachment/download/${path}","${pageContext.request.contextPath}/attachment/download/${recruitFilePath}" ],
        //		saveable : false,
        //		saveasable : false,
        //		openable : false,
        //		editable : false,
        //		reviewable : false
        //	});
        //});
        function HWPostil1_NotifyCtrlReady() {
            document.all.HWPostil1.HideMenuItem(30);
            OpenFile("${pageScope.basePath}/attachment/download/${recruitFile.pdfAttachment.fjid00}");
        }
        function HWPostil2_NotifyCtrlReady() {
            document.all.HWPostil2.HideMenuItem(30);
            var AipObj = document.getElementById("HWPostil2");
            var IsOpen = AipObj.LoadFile("${pageScope.basePath}/attachment/download/${bidFile.wordAttachmentId}");
            if (IsOpen != 1) {
                ShowMessage("打开文档失败！");
            }
        }
	</script>
</head>
<body class="easyui-layout">
<div data-options="region:'center',border:false">
	<!--<div id="webEditor"></div-->
	<style>
		.aip_box{
			width:100%;
			text-align:center;
			margin:0 auto;
		}
		.aip{
			padding: 1px;
			width: 48%;
			height:660px;
			margin:0 auto;
			display:inline-block;
			float:left;
		}
		body{
			margin:0 auto;
			text-align:center;
		}
	</style>
	<div class="aip_box">
		<div class="aip">
			<script src="/resources/aip/LoadAip.js"></script>
		</div>
		<div class="aip">
			<script src="/resources/aip/LoadAip2.js"></script>
		</div>
	</div>
	<div id="div_com_review">
		<iframe frameborder=0 scrolling=no style="background-color:transparent; position: absolute; z-index: -1; width: 100%; height: 100%; top: 0;left:0;"></iframe>
		<form action="${pageContext.request.contextPath}/evaluation/savePreliminaryReviewDetail" id='result_form' method="post">
			<input type="hidden" name="tenderItemId" value="${tenderItem.id}" />
			<input type="hidden" name="processBusinessKey" value="${processBusinessKey}" />
			<input type="hidden" name="reviewType" value="${reviewType}" />
			<c:forEach items="${qualificationReviewTypeList}" var="qualificationReviewType" varStatus="status">
				<h2 class="tableTitle">${qualificationReviewType.preliminaryReviewType}</h2>
				<table class="mytableStyle">
					<thead>
					<tr>
						<th style="width:50px;">序号</th>
						<c:if test="${envelopeType!='two' }">
														<th style="width:350px;">评分因素</th>
						<th style="width:350px;">评审标准</th>
												</c:if>
						<c:if test="${envelopeType=='two' }">
								<th style="width:350px;">评审因素与评审标准</th>
						</c:if>							
						<th style="width:80px;">评审</th>
						<th style="width:80px;">原因</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${qualificationReviewType.qualificationReviewList}" var="qualificationReview" varStatus="childStatus">
						<tr>
							<th>${childStatus.count}</th>
							<c:if test="${envelopeType!='two' }">
								<td style="text-align:left">${qualificationReview.evaluationFactor}</td>
								<td style="text-align:left">${qualificationReview.reviewStandard}</td>
							</c:if>
							<c:if test="${envelopeType=='two' }">
								<td style="text-align:left">${qualificationReview.evaluationFactor}</td>
							</c:if>
							<td>
								<input type="hidden" name="qualificationRequirementId" value="${qualificationReview.id}" />
								<select name="qualificationResult">
									<c:forEach items="${util:dictionaryTree('QUALIFICATION_RESULT',false)}" var="item">
										<option value="${item.itemCode}" ${qualificationResultDetailMap[qualificationReview.id].qualificationResult==item.itemCode?"selected='selected'":""}>${item.itemName}</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<input type="text" class="inputxt" name="qualificationResultReason" value="${qualificationResultDetailMap[qualificationRequirement.id].qualificationResultReason}" />
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<div class="blank10"></div>
			</c:forEach>
		</form>
	</div>
	
	<div id="compliance_reviews_dialog">
	<iframe frameborder=0 scrolling=no style="background-color:transparent; position: absolute; z-index: -1; width: 100%; height: 100%; top: 0;left:0;"></iframe>
	<table class="mytableStyle">
		<thead>
			<tr>
				<th style='width:30px'>序号</th>
				<th style="width:12%">评审类型</th>
				<c:if test="${envelopeType!='two' }">
						<th style="width:350px;">评分因素</th>
						<th style="width:350px;">评审标准</th>
				</c:if>
				<c:if test="${envelopeType=='two' }">
						<th style="width:350px;">评审因素与评审标准</th>
				</c:if>					
				<th style="width:10%">评审结果</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${qualificationFinalResultList}" var="item" varStatus="status">
				<tr>
					<th>${status.count}</th>
					<td class="rowspan" key="${item.qualificationReview.preliminaryReviewType}">${item.qualificationReview.preliminaryReviewType}</td>
					<c:if test="${envelopeType!='two' }">
						<td>${item.qualificationReview.evaluationFactor}</td>
						<td>${item.qualificationReview.reviewStandard}</td>
					</c:if>
					<c:if test="${envelopeType=='two' }">
						<td>${item.qualificationReview.evaluationFactor}</td>
					</c:if>
					<td>${util:dictionary('QUALIFICATION_RESULT',item.qualificationResult)}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
</div>
<div data-options="region:'south',height:40,split:false" style="padding:4px;text-align:right;background-color:#efefef;">
	<form id="form1" action="${pageContext.request.contextPath}/flow/completeTask">

		<c:choose>
			<c:when test="${recruitFile.isPrejudication == true}">
				<span style="float:left;font-weight:900;font-size:12px;margin-left:15px;line-height:30px;">${tenderItem.projectItem}&nbsp;共有${tender_count}家单位进入资格预审阶段</span>
			</c:when>
			<c:otherwise>
				<span style="float:left;font-weight:900;font-size:12px;margin-left:15px;line-height:30px;">${tenderItem.projectItem}&nbsp;共有${tender_count}家单位进入初步评审阶段</span>
			</c:otherwise>
		</c:choose>

		<span style="float:left;font-size:12px;margin-left:15px;line-height:30px;">当前单位 ：${tenderItem.organ}</span>
		<c:if test="${not empty prev}">
			<input type="button" class="button red" value="上一个" onclick="window.location='${pageContext.request.contextPath}/evaluation/preliminaryReviewTenderItemDetail?id=${prev.id}&taskId=${taskId}&processBusinessKey=${processBusinessKey}&reviewType=${reviewType}'" />
		</c:if>

		<c:choose>
			<c:when test="${recruitFile.isPrejudication == true}">
				<input type="button" class="button red" value="显示资格预审" name="score" id='btn_com_review' />
			</c:when>
			<c:otherwise>
				<a class="button red" href="${pageContext.request.contextPath}/bidFile/bidDepositPage?processBusinessKey=${processBusinessKey}&projectItemId=${tenderItem.projectItemId}" target="_blank">保证金缴纳情况</a>
				<input type="button" class="button red" value="显示初步评审" name="score" id='btn_com_review' />
			</c:otherwise>
		</c:choose>
		
		<c:if test="${not empty reviewType}">
		   <input type="button" class="button red" value="初步评审结果" id="open_compliance_reviews" />
		</c:if>

		<c:if test="${not empty next}">
			<input type="button" class="button red" value="下一个" onclick="window.location='${pageContext.request.contextPath}/evaluation/preliminaryReviewTenderItemDetail?id=${next.id}&taskId=${taskId}&processBusinessKey=${processBusinessKey}&reviewType=${reviewType}'" />
		</c:if>
		<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${recruitFile.pdfAttachment.fjid00}">招标文件下载</a>
		<c:if test="${not empty zipInviteAttachmentId }">
			<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${zipInviteAttachmentId}">招标文件附件下载</a>
		</c:if>
		<%-- <a class="button red" href="${pageContext.request.contextPath}/recruitFile/preview?recruitFileId=${recruitFile.id}" target="_blank">招标文件预览</a> --%>
		<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${bidFile.wordAttachmentId}">投标文件下载</a>
		<c:if test="${not empty bidFile.pngAttachmentId }">
			<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${bidFile.pngAttachmentId}">投标文件附件下载</a>
		</c:if>
		<c:if test="${not empty modifyAttachmentId }">
			<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${modifyAttachmentId}">澄清文件下载</a>
		</c:if>

		<!--房建项目要看 工程量清单-->
		<c:if test="${projectInstance.projectInstanceType == 'A01' }">
			<a class="button red" href="${pageContext.request.contextPath}/clearup/viewaip?tendid=${tenderItem.id}" target="_blank">已标价工程量清单</a>
		</c:if>

		<a class="button red" href="${pageContext.request.contextPath}/evaluation/preliminaryReviewProjectItemList?processBusinessKey=${processBusinessKey}&taskId=${taskId}&projectItemId=${tenderItem.projectItemId}&reviewType=${reviewType}">标段总览</a>
	</form>
</div>
</body>
</html>
