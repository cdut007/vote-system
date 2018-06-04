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
<sys:link easyui="true" jgrowl="true" datepicker="true"/>
<script type="text/javascript" src="/resources/page/document/ivitation.js"></script>
<style type="text/css">
#bigJE {
	color: #f00;
	font-size: 14px;
	font-weight: 900
}
</style>

<script>


</script>

</head>

<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			<a href="javascript:history.go(-1);">项目管理</a>
			<code>&gt;</code>
			投标邀请
		</div>
	</div>
	<div class="block">
		<form:form id="invitation_form" method="post" action="${pageContext.request.contextPath}/invitationFile/saveInvitationFile" modelAttribute="invitationFile">
			<c:if test="${invitationFile.reviewStatus and not (invitationFile.reviewStatus=='0' or invitationFile.reviewStatus=='1' or invitationFile.reviewStatus=='9')}">
				<div class="easyui-panel" data-options="collapsible:true,title:'申请状态',border:false">
					<table class="mytableStyle">
						<tr>
							<th width="150px;">审核结果：</th>
							<td>
								<span class="f1">${util:dictionary('GGZT',invitationFile.reviewStatus)}</span>
							</td>
						</tr>
						<tr>
							<th>审核不通过原因</th>
							<td>${invitationFile.nopassReason}</td>
						</tr>
					</table>
				</div>
			</c:if>
			<div class="blank10"></div>
			<input type="hidden" name="token" value="${token}" />
			<input type="hidden" name="isComplete" id="isComplete" value="false" />
			<form:hidden path="id" />
			<form:hidden path="bidderUserIds" />
			<form:hidden path="projectInstanceId" />
			<form:hidden path="invitationContent" />
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
							<td style="width:100px">招标人</td>
							<td>${invitationFile.projectInstance.project.organ.ztmc00}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标方式</td>
							<td>${util:dictionary('ZBFS00',invitationFile.projectInstance.zbfs00)}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标组织形式</td>
							<td>${util:dictionary('ZBZZXS',invitationFile.projectInstance.zbzzxs)}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td>资金来源</td>
							<td>${invitationFile.projectInstance.project.funding}</td>
						</tr>
						
					
					
					
					</tbody>
				</table>
			</div>

			
			<div class="blank10"></div>
		
					<div class="easyui-panel" data-options="title:'投标邀请内容',collapsible:true">
						<table width="98%" style="table-layout:fixed;margin:0 auto;">
							<tbody>
							<tr>
									<td class="need">*</td>
									<td style="width:100px">标段</td>
									<td>
										<c:if test="${not empty invitationFile.id}">
											<form:hidden path="projectItemId" />
											${invitationFile.projectItem.bdmc00}
										</c:if>
										<c:if test="${empty invitationFile.id}">
											
											<select id="projectItemId" name="projectItemId" style="width:60%" class="easyui-validatebox" missingMessage="请选择项目标段（包）！" data-options="required:true">
												<option value="">---==请选择==---</option>
												<c:forEach items="${invitationFile.projectItemList}" var="projectItem">
													<c:choose>
														<c:when test="${projectItem.id == invitationFile.projectItemId}">
															<option value="${projectItem.id}" selected="selected" price="${projectItem.price}">${projectItem.bdmc00 }</option>
														</c:when>
														<c:otherwise>
															<option value="${projectItem.id}" price="${projectItem.price}">${projectItem.bdmc00 }</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												</select>	
										</c:if>
									</td>
							</tr>
								<tr>
									<td class="need">*</td>
									<td style="width:100px">资质要求</td>
									<td>
										<form:input cssStyle="width:60%" path="aptitudeRequire" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" missingMessage="请输入资质要求" />
									</td>
								</tr>
								
								<tr>
									<td class="need">*</td>
									<td style="width:100px">业绩要求</td>
									<td>
										<form:input cssStyle="width:60%" path="achievementRequire" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" missingMessage="请输入业绩要求" />
									</td>
								</tr>
								
								<tr>
									<td class="need">*</td>
									<td style="width:100px">是否接受联合体投标</td>
									<td>
										<form:select path="isComboBid">
											<c:forEach items="${util:dictionaryTree('IS',false)}" var="item">
												<form:option value="${item.itemCode}" label="${item.itemName}"/>
											</c:forEach>
										</form:select>
									</td>
								</tr>
								
								<tr>
									<td class="need">*</td>
									<td>招标文件获取开始时间</td>
									<td>
										<form:input id="recruitFileOpenDate" path="recruitFileOpenDate" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true" />
									</td>
								</tr>
								
								<tr>
									<td class="need">*</td>
									<td>招标文件获取结束时间</td>
									<td>
										<form:input id="recruitFileDeadLine" path="recruitFileDeadLine" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true"  />
									</td>
								</tr>
					
								<tr>
									<td class="need">*</td>
									<td>投标文件递交截止时间:</td>
									<td>
																												
										<form:input id="bidEndDate" path="bidEndDate" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true"  />
									</td>
								</tr>
								
								<tr>
									<td class="need">*</td>
									<td>投标邀请确认截止时间:</td>
									<td>
										<form:input id="confirmEndDate" path="confirmEndDate" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true"  />
									
									</td>
								</tr>
								<tr>
									<td class="need"></td>
									<td>
										设备名称
									</td>
									<td>
										<form:input cssStyle="width:60%" path="deviceName" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" missingMessage="请输入设备名称" />
									</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>保证金支付方式</td>
									<td>
										<input type="radio" name="payType" value="1"  ${invitationFile.payType!="0"?"checked":""} />支付给平台
										<input type="radio" name="payType" value="0"  ${invitationFile.payType=="0"?"checked":""} />支付给代理机构
									</td>
								</tr>
								<tr>
									<td class="need"></td>
									<td>
										招标内容与范围
									</td>
									<td>
										<textarea style=" width:650px;height:100px;" name="invitationSummary" data-options="required:true">${invitationFile.invitationSummary}</textarea>（说明工程建设项目的建设地点、规模、建设工期、标段划分和本次招标采购设备的名称、数量、技术规格、交货地点、交货期等）。
									
									</td>
								</tr>
									
								<tr>
									<td class="need"></td>
									<td>投标邀请内容</td>
									<td>
										<div id="invitationContentShow" style="padding:50px;border:1px solid #ddd;">${invitationFile.invitationContent}</div>
									</td>
								</tr>
								
								
					
							</tbody>
						</table>
					</div>
				
			
			
					<div class="blank10"></div>
		
		
					<table id="invitation_tender_datagrid"></table>					
					
					
			
					<c:if test="${invitationFile.reviewStatus=='0' || invitationFile.reviewStatus=='2' || invitationFile.reviewStatus=='3' || invitationFile.reviewStatus=='4'}">
						
					</c:if>
					<input id="save" type="button" class="button red" value="保 存草稿" />
					<input id='complete' type="button" class="button red" value="提交审核" />
					<a class="button orange" onclick="history.go(-1)">返回</a>
		</form:form>
	</div>
	<div class="blank10"></div>
	<div id="container"></div>
	<div id="container1" style="padding:50px;border:1px solid #ddd"></div>
	
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>