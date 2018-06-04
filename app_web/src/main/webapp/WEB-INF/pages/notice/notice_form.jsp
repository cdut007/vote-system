<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<jsp:include page="/common/link.jsp" />
	<script type="text/javascript">
        $(document).ready(function(){
            /* if($("#GGXZ").text() == "撤销公告"){
                alert(123);
                $("#FDJR").css("display:none");
            } */
            if($("#GGXZ").text().indexOf("撤销公告") > 0){
                $("#FDJR").css("display","none");
            }
        });
        window.onload = function(){
            if($("#GGXZ").text().indexOf("延期公告") > 0){
              /*   $("#applyDateBegin").val(''); */
                $("#applyDateEnd").val('');
                $("#bidDeadline").val('');
                $("#bidOpenDate").val('');
                $("#ggfbsj").val('');
                $("#ggjssj").val('');
            }
            if($("#GGXZ").text().indexOf("再次公告") > 0){
              /*   $("#applyDateBegin").val(''); */
                $("#applyDateEnd").val('');
                $("#bidDeadline").val('');
                $("#bidOpenDate").val('');
                $("#ggfbsj").val('');
                $("#ggjssj").val('');
            }
            if($("#GGXZ").text().indexOf("正常公告") <= 0){
            	$("input[name=ggfbmtNameArray]").on("click", function(){
            		return false;
            	});
            }
        }

        var noticeId="${notice.id}";
        var referenceNoticeId="${notice.referenceNoticeId}";
	</script>
	<script type="text/javascript" src="/resources/md5.js"></script>
	<script type="text/javascript" src="/resources/page/notice/noticeEdit.js"></script>

</head>
<body>
<jsp:include page="/common/top.jsp" />
<div class="blank10"></div>
<div class="block ">
	<div id="ur_here">
		当前位置: <a href="${util:property('frontEnd')}">首页</a>
		<code>&gt;</code>
		公告管理
		<code>&gt;</code>
		招标/资格预审公告管理
		<code>&gt;</code>
		添加公告
	</div>
</div>

<c:set value="招标公告" var="title_label" />
<c:set value="招标文件获取开始时间" var="applyDateBegin_label" />
<c:set value="招标文件获取截止时间" var="applyDateEnd_label" />
<c:set value="招标文件获取方法" var="bidFileObtainWay_label" />
<c:set value="投标文件递交方法" var="bidSendForm_label" />
<c:set value="投标文件递交截止时间" var="bidDeadline_label" />


<c:if test="${notice.gglxdm=='2'}">
	<c:set value="资格预审公告" var="title_label" />
	<c:set value="预审文件获取开始时间" var="applyDateBegin_label" />
	<c:set value="预审文件获取截止时间" var="applyDateEnd_label" />
	<c:set value="预审文件获取方法" var="bidFileObtainWay_label" />
	<c:set value="申请文件递交方法" var="bidSendForm_label" />
	<c:set value="申请文件递交截止时间" var="bidDeadline_label" />
</c:if>

<div class="block">
	<div class="usBox">
		<h4 style='border-bottom: #666 1px solid;'>
			${empty notice.id?"新增":"修改"}${title_label}
		</h4>
		<div class="blank10"></div>
		<form:form id="noticeForm" method="post" action='${pageContext.request.contextPath}/notice/saveOrUpdateBidNotice' modelAttribute="notice" onsubmit="loadDefaultNoticeContent();return $(this).form('validate');">
			<input type="hidden" name="token" value="${token}" />
			<%-- <input type="hidden" id="changeContent" name="changeContent" value="${notice.changeContent}" /> --%>
			<input type="hidden" id="changeContent" name="changeContent" value="" />
			<form:hidden path="referenceNoticeId"/>
			<%-- <form:hidden id="ggnrwb" path="ggnrwb"/> --%>
			<form:hidden path="id"/>
			<form:hidden path="attachmentSsztId" id="attachmentSsztId"/>
			<table width="100%" style="table-layout:fixed;">
				<tr>
					<td class="need" style="width:10px;">*</td>
					<td style="width:15%">招标项目名称：</td>
					<td colspan="4">
						<c:if test="${not empty notice.id || not empty notice.referenceNoticeId}">
							${notice.projectInstance.zbxmmc}
							<input type="hidden" id="projectInstanceId" name="projectInstanceId" value="${notice.projectInstanceId}"/>
						</c:if>
						<c:if test="${empty notice.id && empty notice.referenceNoticeId}">
							<select id="projectInstanceId" name="projectInstanceId" style="width:60%" class="easyui-validatebox" missingMessage="请选择招标项目！" data-options="required:true">
								<option value="">---==请选择==---</option>
								<c:forEach items="${projectInstanceList}" var="projectInstance">
									<c:choose>
										<c:when test="${projectInstance.id == notice.projectInstanceId}">
											<option value="${projectInstance.id}" selected="selected">${projectInstance.zbxmmc }</option>
										</c:when>
										<c:otherwise>
											<option value="${projectInstance.id}">${projectInstance.zbxmmc }</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</c:if>

					</td>
				</tr>
				<tr>
					<td class="need">*</td>
					<td style="vertical-align:middle;">标段（包）:</td>
					<td style="padding-left:3px;" colspan="6">
						<select id="bdjh" multiple="multiple" name="projectItemList">
								<c:forEach items="${projectItemList}" var="item">
									<c:forEach items="${notice.projectItemList}" var="projectItem">
										<c:if test="${item eq projectItem}">
											<option value="${projectItem.id}" selected="selected">${item}</option>
										</c:if>
									</c:forEach>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="need" style="width:10px;">*</td>
					<td>公告标题：</td>
					<td style="text-align: left" colspan="4">
						<form:input id="noticeTitle" cssStyle="width:60%" path="noticeTitle" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" missingMessage="请输入公告标题" /><!-- <a id="preview" class="button small orange" target="_blank">预览</a> -->
					</td>
				</tr>
			</table>
			<table width="100%" style="table-layout:fixed;">
				<tr>
					<td class="need" style="width:10px;">*</td>
					<td style="width:15%;">公告类型：</td>
					<td>
							${util:dictionary('GGLXDM',notice.gglxdm)}
						<form:hidden path="gglxdm" id="gglxdm"/>
					</td>
					<td class="need" style="width:10px;">*</td>
					<td style="width:15%;">公告性质：</td>
					<td id="GGXZ">
							<%-- <form:select id="ggxzdm" name="ggxzdm" path="ggxzdm">
								<c:forEach items="${util:dictionaryTree('GGXZDM',false)}" var="item">
									<form:option value="${item.itemCode}"  label="${item.itemName}"/>
								</c:forEach>
							</form:select> --%>
						<form:hidden path="ggxzdm"/>
							${util:dictionary('GGXZDM',notice.ggxzdm)}
					</td>
				</tr>
				<tr id="a">
					<td class="need" style="width:10px;">*</td>
					<td id="addressName">(交货/施工/服务)地点：</td>
					<td>
						<form:input id="deliveryPlace" path="tenderNoticeData.deliveryPlace" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" />
					</td>
					<td class="need"></td>
					<td>报名是否审核：</td>
					<td>
						<form:select path="isAudit" id="isAudit">
							<c:forEach items="${util:dictionaryTree('IS',false)}" var="item">
								<form:option value="${item.itemCode}" label="${item.itemName}"/>
							</c:forEach>
						</form:select>
					</td>
				</tr>
				<tr id="b">
					<td class="need" style="width:10px;">*</td>
					<td>质量要求：</td>
					<td>
						<form:input id="quality" path="tenderNoticeData.quality" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,255]'" />
					</td>
					<td class="need"></td>
					<td>付款方式：</td>
					<td>
						<form:input id="payWay"  path="tenderNoticeData.payWay"  cssClass="inputxt easyui-validatebox" />
					</td>
				</tr>
				<tr id="c">
					<td class="need" style="width:10px;">*</td>
					<td>文件获取地点：</td>
					<td>
						<form:input id="applyPlace" path="tenderNoticeData.applyPlace" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" />
					</td>
					<td class="need">*</td>
					<td>投标地点：</td>
					<td>
						<form:input id="bidPlace" path="tenderNoticeData.bidPlace" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" />
					</td>
				</tr>
				<tr id="d">
					<td class="need" style="width:10px;">*</td>
					<td>${applyDateBegin_label}：</td>
					<td>
							<c:choose>
								<c:when test="${notice.ggzt=='9'}">
									<fmt:formatDate value="${notice.tenderNoticeData.applyDateBegin}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/>
									<form:hidden id="applyDateBegin" path="tenderNoticeData.applyDateBegin" />
								</c:when>
								<c:otherwise>
									<input type="text" id="applyDateBegin" value="<fmt:formatDate value="${notice.tenderNoticeData.applyDateBegin}" pattern="yyyy-MM-dd HH:mm:ss" type="both" dateStyle="default" timeStyle="default" />" name="tenderNoticeData.applyDateBegin" class="inputxt Wdate easyui-validatebox" data-options="required:true" missingMessage="请选择招标/预审文件获取开始时间！" />&nbsp;
								</c:otherwise>
							</c:choose>
					</td>
					<td class="need" style="width:10px;">*</td>
					<td>${applyDateEnd_label}：</td>
					<td>
						<input type="text" id="applyDateEnd" value="<fmt:formatDate value="${notice.tenderNoticeData.applyDateEnd}" pattern="yyyy-MM-dd HH:mm:ss" type="both" dateStyle="default" timeStyle="default" />" name="tenderNoticeData.applyDateEnd" class="inputxt Wdate easyui-validatebox" data-options="required:true" missingMessage="请选择招标/预审文件获取截止时间！" />
						<input type="hidden" id="applyDateEnd2" value="<fmt:formatDate value="${notice.tenderNoticeData.applyDateEnd}" pattern="yyyy-MM-dd HH:mm:ss" type="both" dateStyle="default" timeStyle="default" />"  class="inputxt Wdate easyui-validatebox" missingMessage="请选择招标/预审文件获取截止时间！" />
					</td>
				</tr>
				<tr id="e">
					<td class="need" style="width:10px;">*</td>
					<td>${bidFileObtainWay_label}：</td>
					<td colspan="4">
						<input type="text" id="bidFileObtainWay" value="${notice.tenderNoticeData.bidFileObtainWay}" name="tenderNoticeData.bidFileObtainWay" class="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" />
					</td>
				</tr>
				<tr id="f">
					<td class="need" style="width:10px;">*</td>
					<td>${bidDeadline_label}：</td>
					<td>
						<input type="text" id="bidDeadline" value="<fmt:formatDate value="${notice.tenderNoticeData.bidDeadline}" type="both" pattern="yyyy-MM-dd HH:mm:ss" dateStyle="default" timeStyle="default" />" data-options="required:true" name="tenderNoticeData.bidDeadline" class="inputxt Wdate easyui-validatebox" missingMessage="请选择投标/预审文件递交截止时间！"/>
						<input type="hidden" id="bidDeadline2" value="<fmt:formatDate value="${notice.tenderNoticeData.bidDeadline}" type="both" pattern="yyyy-MM-dd HH:mm:ss" dateStyle="default" timeStyle="default" />"  class="inputxt Wdate easyui-validatebox" missingMessage="请选择投标/预审文件递交截止时间！"/>
					</td>
					<td class="need" style="width:10px;">*</td>
					<td>${bidSendForm_label}：</td>
					<td>
						<form:input type="text" id="bidSendForm"  path="tenderNoticeData.bidSendForm" class="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" />
					</td>
				</tr>
				<tr id="g">
					<td class="need" style="width:10px;">*</td>
					<td>开标时间：</td>
					<td>
						<input type="text" id="bidOpenDate" value="<fmt:formatDate value="${notice.tenderNoticeData.bidOpenDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss" timeStyle="default" />" onfocus="" data-options="required:true" name="tenderNoticeData.bidOpenDate" class="inputxt Wdate easyui-validatebox" missingMessage="请选择开标时间！" />
						<input type="hidden" id="bidOpenDate2" value="<fmt:formatDate value="${notice.tenderNoticeData.bidOpenDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss" timeStyle="default" />" onfocus="" class="inputxt Wdate easyui-validatebox" missingMessage="请选择开标时间！" />
					</td>
					<td class="need" style="width:10px;">*</td>
					<td>开标地点：</td>
					<td>
						<input type="text" id="bidOpenPlace" value="${notice.tenderNoticeData.bidOpenPlace}" name="tenderNoticeData.bidOpenPlace" class="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" missingMessage="请填写开标地点！" />
					</td>
				</tr>
				<tr >
					<td class="need" style="width:10px;"></td>
					<td>招标方案核准号：</td>
					<td>
						<input type="text" id="applyProjectNumber" value="${notice.applyProjectNumber}" name="applyProjectNumber" class="inputxt easyui-validatebox" data-options="validType:'length[0,100]'" />
					</td>
					<td class="need">*</td>
					<td>保证金支付方式</td>
					<td>
						<input type="radio" name="payType" value="1" ${notice.payType!="0"?"checked":""} />支付给平台
						<input type="radio" name="payType" value="0" ${notice.payType=="0"?"checked":""} />支付给代理机构
					</td>
				</tr>
				<tr id="FDJR">
					<td class="need" style="width:10px;">*</td>
					<td>法定节假日是否工作：</td>
					<td>
						<!-- <div>
                            <label for="yes">是</label>
                              <input type="radio" name="tenderNoticeData.isWorkHoliday" id="isWorkHoliday" />
                              <br />
                          </div> -->
						<form:select path="isWorkHoliday" id="isWorkHoliday">
							<c:forEach items="${util:dictionaryTree('IS',false)}" var="item">
								<form:option value="${item.itemCode}" label="${item.itemName}"/>
							</c:forEach>
						</form:select>

					</td>
					<td class="need" style="width:10px;">*</td>
					<td>是否允许联合体投标：</td>
					<td>
						<!-- <div>
                            <label for="yes">是</label>
                              <input type="radio" name="tenderNoticeData.isComboBid" id="yes" />
                              <br />
                          </div>
                          <div>
                              <label for="no">否</label>
                              <input type="radio" name="tenderNoticeData.isComboBid" id="no" checked/>
                          <div> -->
						<form:select path="isComboBid" id="isComboBid">
							<c:forEach items="${util:dictionaryTree('IS',false)}" var="item">
								<form:option value="${item.itemCode}" label="${item.itemName}"/>
							</c:forEach>
						</form:select>

					</td>
				</tr>
				<tr >
					<td class="need" style="width:10px;">*</td>
					<td>公告发布时间：</td>
					<td>
							<%-- <form:input id="ggfbsj" path="ggfbsj" cssClass="inputxt Wdate easyui-validatebox"
								data-options="required:true" validType="ltTime['#ggjssj','公告发布时间不能大于结束时间']"  /> --%>
						<input type="text" id="ggfbsj" value="<fmt:formatDate value="${notice.ggfbsj}" type="both" pattern="yyyy-MM-dd HH:mm:ss" timeStyle="default" />" name="ggfbsj" class="inputxt Wdate easyui-validatebox" data-options="required:true"  missingMessage="请选择公告发布时间！" />
						<input type="hidden" id="ggfbsj2" value="<fmt:formatDate value="${notice.ggfbsj}" type="both" pattern="yyyy-MM-dd HH:mm:ss" timeStyle="default" />"  class="inputxt Wdate easyui-validatebox"  />
					</td>
					<td class="need" style="width:10px;">*</td>
					<td>公告结束时间：</td>
					<td>
							<%-- <form:input id="ggjssj" path="ggjssj" cssClass="inputxt Wdate easyui-validatebox"
								data-options="required:true"  validType="gtTime['#ggfbsj','公告结束时间不能小于发布时间']"/> --%>
						<input type="text" id="ggjssj" value="<fmt:formatDate value="${notice.ggjssj}" type="both" pattern="yyyy-MM-dd HH:mm:ss" timeStyle="default" />" name="ggjssj" class="inputxt Wdate easyui-validatebox" data-options="required:true"  missingMessage="请选择公告结束时间！" />
						<input type="hidden" id="ggjssj2" value="<fmt:formatDate value="${notice.ggjssj}" type="both" pattern="yyyy-MM-dd HH:mm:ss" timeStyle="default" />"  class="inputxt Wdate easyui-validatebox" />
					</td>
				</tr>
				<c:if test="${notice.ggxzdm=='6'}">	
						<c:choose>
							<c:when test="${notice.projectInstance.projectInstanceType=='A01'||notice.projectInstance.projectInstanceType=='A02'}">
								<tr id="kzj">
									<td class="need" style="width: 10px;"></td>
									<td>最高投标限价总价：</td>
									<td><input type="number" id="controlPrice"
										value="${notice.controlPrice}" name="controlPrice"
										class="inputxt easyui-validatebox" missingMessage="请填写最高投标限价总价！" />
										</td>
								</tr>
								 <tr id="bskzj">
									<td class="need" style="width: 10px;"></td>
									<td>最高投标限价分部分项工程费合价：</td>
									<td><input type="number" id="FBFXGCF"
										value="${notice.FBFXGCF}" name="FBFXGCF"
										class="inputxt easyui-validatebox" />(元)</td>
									<td class="need" style="width: 10px;"></td>
									<td>最高投标限价措施项目费合价：</td>
									<td><input type="number" id="CSXMF"
										value="${notice.CSXMF}" name="CSXMF"
										class="inputxt easyui-validatebox" />(元)</td>
								</tr>
								<tr id="bsfwss">
								<td class="need" style="width: 10px;"></td>
								<td>最高投标限价：</td>
								<td><input type="number" id="controlPrice"
									value="${notice.controlPrice}" name="controlPrice"
									class="inputxt easyui-validatebox" 
									missingMessage="请填写控制价！" /></td>
								<td class="need" style="width: 10px;"></td>
									<td>控制价单位：</td>
									<td>
										<select id="kzjdw">
											<option selected value='1'>元</option>
											<option value='3'>%费率</option>
										</select>
									</td>
							</tr>
							</c:when>
							<c:otherwise>
							<tr >
								<td class="need" style="width: 10px;"></td>
								<td>最高投标限价：</td>
								<td><input type="number" id="controlPrice"
									value="${notice.controlPrice}" name="controlPrice"
									class="inputxt easyui-validatebox" 
									missingMessage="请填写控制价！" /></td>
								<td class="need" style="width: 10px;"></td>
									<td>控制价单位：</td>
									<td>
										<select id="kzjdw">
											<option selected value='1'>元</option>
											<option value='3'>%费率</option>
										</select>
									</td>
							</tr>
							</c:otherwise>
						</c:choose>
					</c:if> 
				<tr>
					<td class="need" style="width:10px;">*</td>
					<td>公告发布责任人：</td>
					<td>
						<input type="text" id="fbzrr0" value="${notice.fbzrr0}" name="fbzrr0" class="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,10]'" missingMessage="请填写公告发布责任人！" />
					</td>
					<%--<td class="need" style="width:10px;">*</td>--%>
					<%--<td>交易平台验证责任人：</td>--%>
					<%--<td>--%>
						<%--<input type="text" id="yzzrr0" value="${notice.yzzrr0}" name="yzzrr0" class="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,10]'" missingMessage="请填写交易平台验证责任人！" />--%>
					<%--</td>--%>
				</tr>
				<c:if test="${notice.ggxzdm=='1'}">
					<tr id="aaa" style="display: none">
						<td class="need">*</td>
						<td>投标人资格要求：</td>
						<td colspan="4">
							<table id="qualificationRequirement" class="mytableStyle">
								<thead>
								<tr>
									<th style="width:50px;">序号</th>
									<th>投标人资格要求内容</th>
									<th style="width:120px;">操作</th>
								</tr>
								</thead>
								<tbody class="editor">
								<c:forEach items="${notice.qualificationRequirementList}" var="item" varStatus="status" >
									<tr>
										<th>${status.count}</th>
										<td>
											<textarea name="content" data-options="required:true">${item.content}</textarea>
										</td>
										<td style="vertical-align: middle;">
											<a class="button small orange insert">插入</a><a class="button small red delete">删除</a>
										</td>
									</tr>
								</c:forEach>
								<tr>
									<th>${status.count}</th>
									<td>
										<textarea name="content"></textarea>
									</td>
									<td style="vertical-align: middle;">
										<a class="button small orange none insert">插入</a><a class="button small red none delete">删除</a>
									</td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<tr id="bbb" >
						<td class="need">*</td>
						<td>报名资料要求：</td>
						<td colspan="4">
							<table id="attachmentRequirementList" class="mytableStyle" >
								<thead>
								<tr>
									<th style="width:50px;">序号</th>
									<th>报名资料要求内容</th>
									<th style="width:120px;">操作</th>
								</tr>
								</thead>
								<tbody class="editor" >
								<c:forEach items="${notice.attachmentRequirementList}" var="item" varStatus="status" >
									<tr>
										<th>${status.count}</th>
										<td>
											<textarea name="content" >${item.content}</textarea>
										</td>
										<td style="vertical-align: middle;">
											<a class="button small orange insert">插入</a><a class="button small red delete">删除</a>
										</td>
									</tr>
								</c:forEach>
								<tr>
									<th>${status.count}</th>
									<td>
										<textarea name="content" ></textarea>
									</td>
									<td style="vertical-align: middle;">
										<a class="button small orange none insert">插入</a><a class="button small red none delete">删除</a>
									</td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</c:if>
					<%-- <tr id="ccc" style="display:none;">
						<td class="need">*</td>
						<td style="vertical-align:middle">公告内容:</td>
						<td colspan='4'>
							<form:textarea path="ggnrwb" style="width:100%;height:350px;"/>
						</td>
					</tr> --%>
				<tr>
					<td class="need">*</td>
					<td style="vertical-align:middle">公告发布媒体:</td>
					<td colspan='4'>
						<c:forEach var="item" items="${notice.ggfbmtList}">
							<form:checkbox path="ggfbmtNameArray" value="${item.name}" label="${item.name}" ></form:checkbox>
						</c:forEach>
					</td>
				</tr>

				<tr>
					<td ></td>
					<td ></td>
					<td colspan='4'>
					<c:choose>
						<c:when test="${notice.ggxzdm=='6'}">
							<a id="addAttachment_controlPrice" class="button red">添加附件</a><i>可以上传.doc .docx .xls .xlsx .zip</i>
						</c:when>
						<c:otherwise>
							<a id="addAttachment" class="button red">添加附件</a><i>可以上传.pdf .doc .docx</i>
						</c:otherwise>
					</c:choose>	
					</td>
				</tr>
				<tr>
					<td ></td>
					<td ></td>
					<td colspan='4'>
						<table id="attachmentUpload"></table>
					</td>
				</tr>
			<c:if test="${notice.ggxzdm=='6'}">
				<tr>
					<td class="need"></td>
					<td>控制价内容</td>
					<td colspan="4">
						<span id="ggcontrolnr"></span><textarea id="controlPriceContent" name="controlPriceContent" contenteditable="true" style="padding:50px;border:1px solid #ddd; width:80%;">${notice.controlPriceContent}</textarea>
					</td>
				</tr>
			
			</c:if>
				<tr>
					<td class="need"></td>
					<td>公告内容</td>
					<td colspan="4">
						<span id="ggnr"></span><div id="noticeContent" ${notice.ggxzdm=='6'? "contenteditable='false'":"contenteditable='true'"} style="padding:50px;border:1px solid #ddd">${notice.ggnrwb}</div>
						<input id="ggnrwb" name="ggnrwb" type="hidden">
					</td>
				</tr>

				<c:if test="${notice.ggzt==2 || notice.ggzt==3 || notice.ggzt==4|| notice.ggzt==19}">
					<tr>
						<td class="need"></td>
						<td style="vertical-align:middle">审核结果:</td>
						<td colspan='4'>
								${notice.ggzt == 2?'代理机构审核未通过':notice.ggzt == 3?'招标人审核未通过':notice.ggzt == 19?'经理审核未通过':'公共服务平台审核未通过' }
						</td>
					</tr>
					<tr>
						<td class="need"></td>
						<td style="vertical-align:middle">审核意见:</td>
						<td colspan='4'>${notice.shyj}</td>
					</tr>
				</c:if>
					<%-- <tr>


                            <c:forEach items="attachmentRequirementList">

                            </c:forEach>
                            <div class="blank10"></div>
                            <table id="attachmentUpload"></table>
                            <div class="blank10"></div>

                            <!-- <a id="selectAptitude" class="button red">选择资质</a> -->




                    </tr>   --%>
			</table>
			<div class="blank10"></div>
			<input type="hidden" id='sealName' name="sealName" value="SigndataStr"/>
			<input type="hidden" id='signData' name="signData" />
			<input type="hidden" id='SigndataStrSealName' name="SigndataStrSealName" />
			<input type="hidden" id='SigndataStrSignData' name="SigndataStrSignData" />
			<!--  <input id="addAttachment" type=button class="button red" value="添加附件"/>-->
			<input type="button" class="button red" value="保存草稿" id="save" />
			<!-- <input type="button" class='button red' value="电子印章" id="sign" /> -->
			<input type="button" class="button red" value="提交审核" id="complete" />
			<input type="button" class="button red" value="返回" onclick="goBack()" />
		</form:form>
	</div>
</div>
<script type="text/javascript">
$(function() { 
	var gb = new Array();
$("#deliveryPlace").change( function() {
	 var gb14="${notice.tenderNoticeData.deliveryPlace}"!=$("#deliveryPlace").val()?$(this).parent().prev().html()+"由  ${notice.tenderNoticeData.deliveryPlace}  更改为  "+$("#deliveryPlace").val():"";
	gb[13]=gb14;
	zhuang();
});
$("#quality").change( function() {
	 var gb15="${notice.tenderNoticeData.quality}"!=$("#quality").val()?$(this).parent().prev().html()+"由  ${notice.tenderNoticeData.quality}  更改为  "+$("#quality").val():"";
	 gb[14]=gb15;
	zhuang();
});
$("#payWay").change( function() {
	 var gb16="${notice.tenderNoticeData.payWay}"!=$("#payWay").val()?$(this).parent().prev().html()+"由  ${notice.tenderNoticeData.payWay}  更改为  "+$("#payWay").val():"";
	 gb[15]=gb16;
	 zhuang();
});
$("#applyPlace").change( function() {
	 var gb17="${notice.tenderNoticeData.applyPlace}"!=$("#applyPlace").val()?$(this).parent().prev().html()+"由  ${notice.tenderNoticeData.applyPlace}  更改为  "+$("#applyPlace").val():"";
	gb[16]=gb17;
	zhuang();
});
$("#bidPlace").change( function() {
	 var gb19="${notice.tenderNoticeData.bidPlace}"!=$("#bidPlace").val()?$(this).parent().prev().html()+"由  ${notice.tenderNoticeData.bidPlace}  更改为  "+$("#bidPlace").val():"";
	gb[18]=gb19;
	zhuang();
});
$("#noticeTitle").change( function() {
	 var gb18="${notice.noticeTitle}"!=$("#noticeTitle").val()?$(this).parent().prev().html()+"由  ${notice.noticeTitle}  更改为  "+$("#noticeTitle").val():"";
	gb[17]=gb18;
	zhuang();
});
$("#bidOpenPlace").change( function() {
	 var gb1="${notice.tenderNoticeData.bidOpenPlace}"!=$("#bidOpenPlace").val()?$(this).parent().prev().html()+"由 ${notice.tenderNoticeData.bidOpenPlace}  更改为  "+$("#bidOpenPlace").val():"";
	gb[0]=gb1;
	zhuang();
});
$("#applyDateEnd").blur( function() {
	 var gb2="<fmt:formatDate value='${notice.tenderNoticeData.applyDateEnd}' pattern='yyyy-MM-dd HH:mm:ss' type='both' dateStyle='default' timeStyle='default' />"!=$("#applyDateEnd").val()?$(this).parent().prev().html()+"由 <fmt:formatDate value='${notice.tenderNoticeData.applyDateEnd}' pattern='yyyy-MM-dd HH:mm:ss' type='both' dateStyle='default' timeStyle='default' />  更改为  "+$("#applyDateEnd").val():"";
	gb[1]=gb2;
	zhuang();
	$("#bstzsj").html($(this).val());
});
$("#bidFileObtainWay").change( function() {
	 var gb3="${notice.tenderNoticeData.bidFileObtainWay}"!=$("#bidFileObtainWay").val()?$(this).parent().prev().html()+"由 ${notice.tenderNoticeData.bidFileObtainWay}  更改为  "+$("#bidFileObtainWay").val():"";
	gb[2]=gb3;
	zhuang();
});
//时间
$("#bidDeadline").blur( function() {
	 var gb4="<fmt:formatDate value='${notice.tenderNoticeData.bidDeadline}' type='both' pattern='yyyy-MM-dd HH:mm:ss' dateStyle='default' timeStyle='default' />"!=$("#bidDeadline").val()?$(this).parent().prev().html()+"由 <fmt:formatDate value='${notice.tenderNoticeData.bidDeadline}' type='both' pattern='yyyy-MM-dd HH:mm:ss' dateStyle='default' timeStyle='default' />  更改为  "+$("#bidDeadline").val():"";
	gb[3]=gb4;
	zhuang();
});
$("#bidSendForm").change( function() {
	 var gb5="${notice.tenderNoticeData.bidSendForm}"!=$("#bidSendForm").val()?$(this).parent().prev().html()+"由 ${notice.tenderNoticeData.bidSendForm}  更改为  "+$("#bidSendForm").val():"";
	gb[4]=gb5;
	zhuang();
});
$("#bidOpenDate").blur( function() {
	 var gb6="<fmt:formatDate value='${notice.tenderNoticeData.bidOpenDate}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />"!=$("#bidOpenDate").val()?$(this).parent().prev().html()+"由 <fmt:formatDate value='${notice.tenderNoticeData.bidOpenDate}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />  更改为  "+$("#bidOpenDate").val():"";
	gb[5]=gb6;
	zhuang();
	$("#kbsj").html($(this).val());
});
$("#applyProjectNumber").change( function() {
	 var gb7="${notice.applyProjectNumber}"!=$("#applyProjectNumber").val()?$(this).parent().prev().html()+"由 ${notice.applyProjectNumber}  更改为  "+$("#applyProjectNumber").val():"";
	gb[6]=gb7;
	zhuang();
});
$("#isWorkHoliday").change( function() {
	 var gb8="${notice.isWorkHoliday}"!=$("#isWorkHoliday").val()?$(this).parent().prev().html()+"由 ${notice.isWorkHoliday=='0'?'否':'是'}  更改为  "+($("#isWorkHoliday").val()=='0'?'否':'是'):"";
	gb[7]=gb8;
	zhuang();
});
$("#isComboBid").change( function() {
	 var gb9="${notice.isComboBid}"!=$("#isComboBid").val()?$(this).parent().prev().html()+"由 ${notice.isComboBid=='0'?'否':'是'}  更改为  "+($("#isComboBid").val()=='0'?'否':'是'):"";
	gb[8]=gb9;
	zhuang();
});
$("#ggfbsj").blur( function() {
	var gb10="<fmt:formatDate value='${notice.ggfbsj}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />"!=$("#ggfbsj").val()?$(this).parent().prev().html()+"由 <fmt:formatDate value='${notice.ggfbsj}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />  更改为  "+$("#ggfbsj").val():"";
	gb[9]=gb10;
	zhuang();
	$("#bmkssj").html($(this).val());
});
$("#ggjssj").blur( function(){
	 var gb11="<fmt:formatDate value='${notice.ggjssj}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />"!=$("#ggjssj").val()?$(this).parent().prev().html()+"由 <fmt:formatDate value='${notice.ggjssj}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />  更改为  "+$("#ggjssj").val():"";
	 gb[10]=gb11;
	zhuang();
	$("#bmjssj").html($(this).val());
});
$("#fbzrr0").change( function() {
	 var gb12="${notice.fbzrr0}"!=$("#fbzrr0").val()?$(this).parent().prev().html()+"由 ${notice.fbzrr0}  更改为  "+$("#fbzrr0").val():"";
	gb[11]=gb12;
	zhuang();
});
$("#yzzrr0").change( function() {
	 var gb13="${notice.yzzrr0}"!=$("#yzzrr0").val()?$(this).parent().prev().html()+"由 ${notice.yzzrr0}  更改为  "+$("#yzzrr0").val():"";
	gb[12]=gb13;
	zhuang();
});
function zhuang(){
	var ngb = new Array();
	var j=0;
	$.each(gb, function(i, n){
			if(n){
				  ngb[j++]="<br/>"+n;
			}
		});
	$("#changeContent").val(ngb);
}

var projectItemName = $("#bdjh").combotree("getText");
var projectItemIds = $("#bdjh").combotree("getValues");
var ids="";
for(var id in projectItemIds){
	ids+=projectItemIds[id];
	if(id!=projectItemIds.length-1){
		ids+=",";
	}
}
var projectInstanceId = $("#projectInstanceId").val();
if($("#GGXZ").text().indexOf("控制价") > 0){
	$.ajax({
		url:ctx+"/notice/getProjectItemType?t="+new Date().getTime(),
		type:"post",
		dataType:"json",
		data:{
			projectInstanceId : projectInstanceId,
			projectItemId:ids
		},
		success:function(data){
			for ( var key in data) {
				var map=data[key];
				var projectItemType=map["projectItemType"];
				var bdfldm=map["bdfldm"];
				if(projectItemType.indexOf("A") >=0){//工程
					$("#bsfwss").html('');
				}else if(projectItemType.indexOf("C") >=0){//服务
					//if(bdfldm.indexof("A05") >=0||bdfldm.indexof("A03") >=0){
						$("#kzj").html('');
						$("#bskzj").html('');
					//}
				}else if(projectItemType.indexOf("B") >=0){//货物
					$("#kzj").html('');
					$("#bskzj").html('');
				}else{
					$("#kzj").html('');
					$("#bskzj").html('');
					$("#bsfwss").html('');
				}
			}
		}
		});
}
$("#kzjdw").change(function(){
	if($(this).children("option:selected").val() == 3){
		$.messager.confirm('系统提示','暂不支持费率');
		$(this).prop('selectedIndex', 0);
	}
});
}); 

</script>
<script src="/resources/page/notice/notice_form.js" type="text/javascript">
</script>
<script type="text/javascript">
var uploader1 = undefined;

var percent="<div class=\"progressbar easyui-fluid\" style=\"width: 127px; height: 20px;\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div><div class=\"progressbar-value\" style=\"width: 100%; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div></div></div>";

$(function() {//上传控制价公告附件
	var uploader1 = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : 'addAttachment_controlPrice',
		//container : document.getElementById('container'),
		url : ctx + '/attachment/uploadAttachment',
		flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
		silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
		multi_selection : true,
		multipart_params : {
			fjsszt : $("#attachmentSsztId").val()==""?"-1":$("#attachmentSsztId").val(),
			fjgslx:"02"
		},
		//file_data_name:"Filedata",
		//drop_element : 'drop_area',
		filters : {
			mime_types : [ //只允许上传图片和zip文件
				{ title : "Excel files", extensions : "xls,xlsx" },
				{ title : "Word files", extensions : "doc,docx" },
				{ title : "Zip files", extensions : "zip" }
			],
			prevent_duplicates : true,//不允许选取重复文件
			max_file_size : '5000mb'//最大只能上传400kb的文件
		},
		init : {
			PostInit : function() {
			},
			FilesAdded : function(up, files) {

				if($("#id").val()==""){
					$("#attachmentUpload").datagrid("options").queryParams["fjsszt"]=$("#id").val();
				}
				for(var i=0;i<files.length;i++){
					var file=files[i];
					$("#attachmentUpload").datagrid("appendRow",{
						 id:file.id,
						 fjid00:file.id,
						 fjmc00:file.name,
						 status:"<div class='" + file.id + "' style='width:100%;'></div>",
						 uploadTime:new Date().format("yyyy-MM-dd HH:mm:ss"),
						 length:file.size,
						 fjgslx:""
					});
					$("div." + file.id).progressbar({});
				}
				up.start();
			},
			UploadProgress : function(up, file) {
				$("div." + file.id).progressbar("setValue", file.percent);
			},
			FileUploaded : function(up, file, result) {
				var data=$.parseJSON(result.response);
				data.data.id=file.id;
				data.data.status=percent;
				
				$($("#attachmentUpload").datagrid("getRows")).each(function(index){
					if(this.id==data.data.id){
						$("#attachmentUpload").datagrid("updateRow",{index:index,row:data.data});
					}
				});
				$("#tenderApplicationForm").append($("<input/>").attr("type","hidden").addClass(file.id).val(data.data.fjid00));
				up.removeFile(file);
				loadDefaultNoticeContent();
			},
			UploadComplete : function(uploader, files) {
			},
			Error : function(up, err) {
			},
			FilesRemoved:function(up,files){
				
			}
		}
	});
	uploader1.init();
});

</script>
</body>
</html>