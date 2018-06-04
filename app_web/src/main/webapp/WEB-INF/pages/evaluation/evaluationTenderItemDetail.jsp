<%@page pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<c:set value="${recruitFileService.findRecruitFile(projectItem.id)}" var="recruitFile"></c:set>
<c:catch var="exception">
	<jsp:useBean id="nowDate" class="java.util.Date" />
	<c:set value="${tenderItem.projectItemId}" var="projectItemId"></c:set>
	<c:set value="${recruitFileService.findRecruitFileOfModify(projectItemId)}" var="modifyAttachmentId"></c:set>
</c:catch>
<sys:link title="详细评审" easyui="true" webedit="true" jgrowl="true" spectrum="true"/>
	<%
		//String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		pageContext.setAttribute("basePath",basePath);
	%>
<style type="text/css">
.contentBox {
	position: fixed;
	bottom: 67px;
	height: 500px;
	left: 10%;
	width: 70%;
	min-width: 800px;
	z-index: 1000;
	opacity: 1;
	border-radius: 5px;
	background-color: #fafafa;
}

/* p {
	text-indent: 2em
} */

/* input[type=text] {
	width: 30px;
} */
.owner_info {
	border-radius: 5px;
	border: 1px #ccc solid;
	padding: 5px;
	width: 95%;
	margin-top: 5px;
	margin-bottom: 10px;
}

.o_title {
	width: 100%;
	height: 20px;
	border-bottom: 1px #ccc solid;
}

.o_title span {
	margin-right: 50px;
}
</style>
<style type="text/css">
#comp_box {
	width: 178px;
	position: fixed;
	right: 20px;
	top: 200px;
	text-align: center;
	background-color: #fff;
}

#comp_box_title {
	padding-left: 5px;
	color: #fff;
	background-color: #d40000;
} /*background-color:#F0974F;  橙色*/
#comp_item {
	border: 1px solid #d40000;
	line-height: 50px;
}

#comp_item li {
	border-bottom: 1px solid #d40000;
}

.delImg {
	position: absolute;
	display: none;
	right: 0;
	height: 15px;
	width: 15px;
	margin: 2px;
	cursor: pointer;
	background: url(http://icon.zol-img.com.cn/detail0802/del.gif)
}

.comp_foot {
	height: 25px;
	border: 1px solid #d40000;
	padding: 10px 5px 6px;
	margin-top: 2px;
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
<!--ready事件-->
<script type="text/javascript">
	$(function() {
		$("#open_score").click(function() {
			$("#score_dialog").dialog("open");
		});
		$("#score_dialog").css("padding", 5).dialog({
			width : 1000,
			height : 600,
			title : "评分",
			closed : true,
			modal : true,
			maximizable : true,
			closable : true,
			bodyCls : "box",
			buttons : [ {
				text : '关闭',
				handler : function() {
					$("#score_dialog").dialog("close");
				}
			}, {
				text : '保存',
				handler : function() {
					$("#score_form").ajaxSubmit({
						beforeSend : function() {
							return $("#score_form").form("validate");
						},
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
		$("#pbbfss  input").each(function(){
			$(this).attr("readonly","readonly");
		});
	});
</script>
<script type="text/javascript">
	/*$(function() {
		//根据cookie信息初始化对比栏信息
		var cookieArray = document.cookie.split(";"); //得到分割的cookie名值对    
		var cookie = new Object();
		var exist = false;
		for (var i = 0; i < cookieArray.length; i++) {
			var arr = cookieArray[i].split("="); //将名和值分开
			if ($.trim(arr[0]).indexOf("comp_item-") == 0) { //如果存在chat-的cookie，则初始化对比栏
				exist = true;
				$("#comp_item").append("<li><em class='delImg'></em>" + $.cookie($.trim(arr[0])) + "<input type='hidden' name='tbid00'  value='" + $.trim(arr[0]).substring(10) + "'/></li>");
			}
		}
		if (!exist) {
			$("#comp_item").append("<li class='empty'>暂时为空！</li>");
		}

		$("#comp_item").on("mouseover", "li", function() {
			$(this).css("background-color", "#fafafa");
			$(this).find(".delImg").css({
				display : "block"
			});
		}).on("mouseout", "li", function() {
			$(this).css("background-color", "#fff");
			$(this).find(".delImg").css({
				display : "none"
			});
		});

		//加入对比项
		$("#addComp_item").click(function() {
			var cookieArray = document.cookie.split(";"); //得到分割的cookie名值对    
			var cookie = new Object();
			var exist = false;
			for (var i = 0; i < cookieArray.length; i++) {
				var arr = cookieArray[i].split("="); //将名和值分开
				if ($.trim(arr[0]).indexOf("comp_item-") == 0) { //如果存在comp_item-的cookie，则初始化对比栏
					if ($.trim(arr[0]).substring(10) == $("#tenderItemId").val()) {
						exist = true;
					}
				}
			}
			if (!exist) {
				$.cookie("comp_item-" + $("#tenderItemId").val(), $("#organBName").val());
				$("#comp_item  li").remove(".empty");
				$("#comp_item").append("<li><em class='delImg'></em>" + $("#organBName").val() + "<input type='hidden' name='tbid00'  value='" + $("#tenderItemId").val() + "'/></li>");
			} else {
				$.messager.alert("系统提示", "您已将【" + $("#organBName").val() + "】添加到对比栏！", "warning");
			}
		});

		//删除对比项
		$("#comp_item").on("click", ".delImg", function() {
			var id = $(this).parent("li").find("input[name='tenderItemId']:eq(0)").val();
			$.cookie("comp_item-" + id, null);
			$(this).parent().remove();
			if (!$("#comp_item").has("li").length) {
				$("#comp_item").append("<li class='empty'>暂时为空！</li>");
			}
		});

		//清空对比栏
		$("#clearComp_box").click(function() {
			var cookieArray = document.cookie.split(";"); //得到分割的cookie名值对    
			var cookie = new Object();
			for (var i = 0; i < cookieArray.length; i++) {
				var arr = cookieArray[i].split("="); //将名和值分开
				if ($.trim(arr[0]).indexOf("comp_item-") == 0) { //如果存在comp_item-的cookie，则删除该对比项
					$.cookie($.trim(arr[0]), null);
					$("#comp_item").find("li").remove();
					$("#comp_item").append("<li class='empty'>暂时为空！</li>");
				}
			}
		});

		$("#comp_box").draggable();
	});*/
</script>
<script type="text/javascript">
	/*$(function() {
		
		$("#webEditor").webEditor({
			user : {
				id : "${CURRENT_USER_SESSION_INFO.id}",
				name : "${CURRENT_USER_SESSION_INFO.userName}"
			},
			zoomPercent : 100,
			href : [ "${pageContext.request.contextPath}/attachment/download/${path}","${pageContext.request.contextPath}/attachment/download/${recruitFilePath}" ],
			layout: "H",
			saveable : false,
			saveasable:false,
			openable : false,
			editable : false,
			reviewable : false
		});
	});*/
	
	/*function comtrast(){
		alert();
		$("#webEditor").webEditor({
			user : {
				id : "${CURRENT_USER_SESSION_INFO.id}",
				name : "${CURRENT_USER_SESSION_INFO.userName}"
			},
			zoomPercent : 100,
			href : [ "${pageContext.request.contextPath}/attachment/download/${path}","${pageContext.request.contextPath}/attachment/download/${recruitFilePath}" ],
			saveable : false,
			saveasable:false,
			openable : false,
			editable : false,
			reviewable : false
		});
	}*/
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
		
		<div id="score_dialog">
			<iframe frameborder=0 scrolling=no style="background-color:transparent; position: absolute; z-index: -1; width: 100%; height: 100%; top: 0;left:0;"></iframe>
			<form id="score_form" action="${pageContext.request.contextPath}/evaluation/saveScore" method="post">
				<input type="hidden" name="tenderItemId" id="tenderItemId" value="${tenderItem.id}" /> 
				<input type="hidden" name="organBName" id="organBName" value="${tenderItem.organBName}" /> 
				<input type="hidden" name="processBusinessKey" value="${processBusinessKey}" />
				<div class="block" style="width:100%;">
					<c:forEach items="${scoreReviewTypeList}" var="detailReviewType" varStatus="status">
						<h2 class="tableTitle">${status.count}、${detailReviewType.groupName}(共计：${detailReviewType.groupFullScore})</h2>
						<c:choose>
							<c:when test="${detailReviewType.flag=='price'}">
								<table class="mytableStyle">
									<thead>
										<tr>
											<th style="width:15%">评审项目</th>
											<th>评分办法</th>
											<th style="width:60px">得分</th>
										</tr>
									</thead>
									<tr>
										<td>${detailReviewType.groupName}</td>
										<td style="text-align:left;text-indent: 2em" id="pbbfss">${detailReviewType.scoreReviewList[0].reviewStandard}</td>
										<td align="right">
											<input type="text" readonly="readonly" class="easyui-numberbox" value="${scoreReviewResultDetailMap[detailReviewType.scoreReviewList[0].id].scoreValue}" data-options="precision:2"/>
										</td>
									</tr>
								</table>
							</c:when>
							<c:otherwise>
								<table class='mytableStyle' id="scoreTable">
									<thead>
										<tr>
											<th style='width:30px'>序号</th>
											<th style="width:12%">评审项目</th>
											<c:if test="${envelopeType!='two' }">
												<th>评审因素</th>
												<th>评审标准</th>
											</c:if>
											<c:if test="${envelopeType=='two' }">
												<th>评审因素与评审标准</th>
											</c:if>
											<th style="width:10%">分值范围</th>
											<th style="width:60px">得分</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${detailReviewType.scoreReviewList}" var="item" varStatus="status">
											<tr>
												<th>${status.count}</th>
												<c:if test="${status.index==0}">
													<td rowspan="${fn:length(detailReviewType.scoreReviewList)}">${detailReviewType.groupName}</td>
												</c:if>
												<c:if test="${envelopeType!='two' }">
													<td style="text-align:left;">${item.evaluationFactor}</td>
													<td style="text-align:left;">${item.reviewStandard}</td>
												</c:if>
												<c:if test="${envelopeType=='two' }">
													<td style="text-align:left;">${item.evaluationFactor}</td>
												</c:if>
												<td align="center">（0~${item.itemFullScore}）</td>
												<td align="center">
													<input name="scoreReviewId" type="hidden" value="${item.id}" />
													<input  type="text" name="scoreValue" value="${scoreReviewResultDetailMap[item.id].scoreValue}" class="easyui-numberbox" data-options="required:true,precision:2,min:0,onChange:function(value,oldValue){
														var numberbox=$(this);
														if(value > ${item.itemFullScore}){
															$.messager.alert('系统提示','当前得分项的最大分值为 ${item.itemFullScore},您输入的分值为'+value,'warning',function(){
																numberbox.numberbox('setValue',${item.itemFullScore});
															});
														}
														
														if('${scoreReviewType.groupName}'=='施工组织设计'){
															var num = (Number(${item.itemFullScore*recruitFile.CMPRate*0.01})).toFixed(2);
															if(value < ${item.itemFullScore*recruitFile.CMPRate*0.01}){
																$.messager.alert('系统提示','当前得分项的最低得分不能小于'+num+'分！','warning',function(){
																	numberbox.numberbox('setValue',${item.itemFullScore*recruitFile.CMPRate*0.01});
																});
															}
														}
													}"/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:otherwise>
						</c:choose>
						<div class="blank10"></div>
					</c:forEach>
					<c:forEach items="${qualificationReviewTypeList}" var="qualificationReviewType" varStatus="status">
						<h2 class="tableTitle">${fn:length(scoreReviewTypeList)+status.count}、${qualificationReviewType.preliminaryReviewType}</h2>
						<table class="mytableStyle">
							<thead>
								<tr>
									<th style="width:50px;">序号</th>
									<c:if test="${envelopeType!='two' }">
								 		<th>评审因素</th>
										<th>评审标准</th>
									</c:if>
										<c:if test="${envelopeType=='two' }">
										<th>评审因素与评审标准</th>
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
											<input type="text" class="inputxt" name="qualificationResultReason" value="${qualificationResultDetailMap[qualificationReview.id].qualificationResultReason}" />
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="blank10"></div>
					</c:forEach>
				</div>
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
					 		<th>评审因素</th>
							<th>评审标准</th>
						</c:if>
							<c:if test="${envelopeType=='two' }">
							<th>评审因素与评审标准</th>
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
		<!--<div id='fly'>&nbsp;</div>
		<div id="comp_box">
			<div id="comp_box_title">投标文件对比栏</div>
			<ul id="comp_item"></ul>
			<div class="comp_foot">
				<form id="" method="post">
					<input type="button" class="button red small" id="addComp_item" value="加入对比" /> <input type="button" class="button red small" id="clearComp_box" value="清空对比" />
				</form>
			</div>
			<div class="comp_foot">
				<a class="button red small" id="enterComp" href="${pageContext.request.contextPath}/evaluation/evaluationComp" target="_blank">进入对比</a>
			</div>
			<div class="comp_foot">
				<a class="button red small" id="showBar">通讯</a>
			</div>
		</div-->
	</div>
	<div data-options="region:'south',height:40,split:false" style="padding:4px;text-align:right;background-color:#efefef;">
		<form action="${pageContext.request.contextPath}/flow/completeTask">
			<input type="hidden" name="taskId" value="${task.id}" /> 
			<input type="hidden" name="pass" value="true" /> 
			<span style="float:left;font-weight:900;font-size:12px;margin-left:15px;line-height:30px;">${tenderItem.projectItem}&nbsp;共有${tender_count}家单位进入详细评审阶段</span>
			<span style="float:left;font-size:12px;margin-left:15px;line-height:30px;">当前单位 ：${tenderItem.organ}</span>
			<c:if test="${not empty prev}">
				<a class="button red" href="${pageContext.request.contextPath}/evaluation/evaluationTenderItemDetail?id=${prev.id}&taskId=${taskId}&processBusinessKey=${processBusinessKey}">上一个</a>
			</c:if>
			<c:if test="${not empty next}">
				<a class="button red" href="${pageContext.request.contextPath}/evaluation/evaluationTenderItemDetail?id=${next.id}&taskId=${taskId}&processBusinessKey=${processBusinessKey}">下一个</a>
			</c:if>
			<a class="button red" href="${pageContext.request.contextPath}/evaluationClarify/evaluationClarifyEdit?expertApplyId=${processBusinessKey}&tenderItemId=${tenderItem.id}" target="_blank">发起澄清</a>
			<input type="button" class="button red" value="打开评分" id="open_score" />
			<input type="button" class="button red" value="初步评审结果" id="open_compliance_reviews" />
			<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${recruitFile.pdfAttachment.fjid00}">招标文件下载</a>
			<c:if test="${not empty zipInviteAttachmentId }">
				<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${zipInviteAttachmentId}">招标文件附件下载</a>
			</c:if>
			<%-- <a class="button red" href="${pageContext.request.contextPath}/recruitFile/preview?recruitFileId=${recruitFile.id}" target="_blank">招标文件在线预览</a> --%>
			<!-- <a class="button red" onclick="comtrast()">对比招标文件</a> -->
			<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${bidFile.wordAttachmentId}">投标文件下载</a> 
			<c:if test="${not empty bidFile.pngAttachmentId }">
				<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${bidFile.pngAttachmentId}">投标文件附件下载</a> 
			</c:if>
			<c:if test="${not empty modifyAttachmentId }">
				<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${modifyAttachmentId}">澄清文件下载</a>
			</c:if>

			<!--房建项目要看 工程量清单-->
			<c:if test="${projectInstance.projectInstanceType == 'A01' }">
				<a class="button red" href="${pageContext.request.contextPath}/attachment/download/${modifyAttachmentId}">已标价工程量清单</a>
			</c:if>


			<a class="button red" href="${pageContext.request.contextPath}/evaluation/evaluationProjectItemList?processBusinessKey=${processBusinessKey}&taskId=${taskId}&projectItemId=${tenderItem.projectItemId}">标段总览</a>
			<!-- <input type="button" class="button red" value="废标" /> -->
		</form>
	</div>
</body>
</html>
