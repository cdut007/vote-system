<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<c:if test="${empty tender}">
	<jsp:useBean id="tender" class="com.mhb.tender.entity.TBTender" scope="request"></jsp:useBean>
	<jsp:setProperty property="projectInstanceId" name="tender" value="${projectInstance.id}" />
	<jsp:setProperty property="noticeId" name="tender" value="${noticeId}" />
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--投标报名申请表--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>报名申请</title>
<sys:link easyui="true" datepicker="true" jgrowl="true" uedit="true" plupload="true" ca="true"/>
<script src="/resources/page/tender/tenderApplyForm.js" type="text/javascript"></script>
<!-- <script type="text/javascript" src="/resources/kinggrid/LoadSXCASignClient.js"></script> -->
<style type="text/css">
pre {
 white-space: pre-wrap; /* CSS-3 */
 white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
 white-space: -pre-wrap; /* Opera 4-6 */
 white-space: -o-pre-wrap; /* Opera 7 */
 Word-wrap: break-word; /* Internet Explorer 5.5+ */
}
</style>
</head>
<script>
	var xmbh00="${projectInstance.project.xmbh00}";
	var zbxmbh="${projectInstance.zbxmbh}";
	var bidderName="${organ.ztmc00}";
	var bidderCode="${organ.ztdm00}";
    var sealName="${CURRENT_USER_SESSION_INFO.organName}";
    var bidderId="${CURRENT_USER_SESSION_INFO.organId}";
    var ownerId="${CURRENT_USER_SESSION_INFO.id}";
    var noticeId="${noticeId}";
    var attachmentRequirements = new Array();
</script>
<!-- <OBJECT ID="CertInfo" CLASSID="CLSID:6FA144DC-ADDC-75EE-B5D5-7F5519F93C36"></OBJECT>
 -->
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			报名申请
		</div>
		<div class="blank10"></div>
		<c:if test="${not empty tender.id}">
			<div class="easyui-panel" data-options="collapsible:true,title:'申请状态',border:false">
				<table class="mytableStyle">
					<tr>
						<th width="150px;">审核结果：</th>
						<td>
							<span class="f1">${util:dictionary('BMSHBZ',tender.reviewStatus)}</span>
						</td>
					</tr>
					<c:if test="${tender.reviewStatus=='2'||tender.reviewStatus=='-2'}">
						<!-- 审核不通过 -->
						<th>${tender.reviewStatus=='2'?"审核不通过原因":"撤销原因"}：</th>
						<td>${tender.nopassReason}</td>
					</c:if>
				</table>
			</div>
		</c:if>
		<div class="blank10"></div>
		<div class="easyui-panel" data-options="collapsible:true,title:'项目信息',border:false">
			<table class='mytableStyle' style="width:100%;">
				<col width="120px"/>
				<col/>
				<col width="120px"/>
				<col/>
				<tr>
					<th width="120px">所属项目</th>
					<td colspan='3'>${projectInstance.project.xmmc00}</td>
				</tr>
				<tr>
					<th>招标项目编号:</th>
					<td>${projectInstance.zbxmbh}</td>
					<th>招标项目名称:</th>
					<td>${projectInstance.zbxmmc}</td>
				</tr>
				<tr>
					<th width="120px">招标人</th>
					<td>${projectInstance.organTName}</td>
					<th width="120px">代理机构</th>
					<td>${projectInstance.organAName}</td>
				</tr>
				<tr>
					<th width="120px">招标方式</th>
					<td>${util:dictionary("ZBFS00",projectInstance.zbfs00)}</td>
					<th width="120px">组织形式</th>
					<td>${util:dictionary("ZBZZXS",projectInstance.zbzzxs)}</td>
				</tr>
				<tr>
					<th width="120px">招标内容与范围</th>
					<td colspan='3'>
						<pre>${projectInstance.nryfw0}</pre>
					</td>
				</tr>
			</table>
		</div>
		<div class="blank10"></div>
		<div class="easyui-panel" data-options="title:'项目标段列表',border:false">
			<table class='mytableStyle'>
				<thead>
					<tr>
						<th width='40px'>序号</th>
						<th width='20px'><input type='checkbox' name='all' ${tender.reviewStatus=='-1'?"":"disabled='disabled'T"} /></th>
						<!-- <th>标段编号</th> -->
						<th width='60px'>标段名称</th>
						<th>标段内容</th>
						<th width='45px'>状态</th>
					</tr>
				</thead>
				<c:forEach items="${projectItemWithTenderApplyAbleList}" var="item" varStatus="status">
					<tr>
						<th style='text-align: center'>${status.count}</th>
						<td>
							<input type='checkbox' name='item_ids' value="${item[0].id}" ${(not item[2] && tender.reviewStatus=='-1')?"":"disabled='disabled'"} ${item[1]?"checked='checked'":""} />
							<input type="hidden" id="${item[0].id}" value="${item[0].bdbh00}" class="bdbh"></input>
						</td>
						<%-- <td>${item[0].bdbh00}</td> --%>
						<td class="itemName">${item[0].bdmc00}</td>
						<td>${item[0].bdnr00}</td>
						<td style='text-align:center;'>${item[2]?"已报名":"可报名"}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="blank10"></div>
		<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
			
			
			
				
				
				
			<div id="tender_application" style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">
				<c:choose>
					<c:when test="${empty tender.content}">
						<h1 style="text-align:center;" align="center">
							<br /> <b><span style="font-family:宋体;font-size:18pt;">投标报名申请书<span></span></span></b> <br />
						</h1>
						<br />
						<div style="font-family:FangSong_GB2312;font-size:14px;">
							<p>
								<u><span>${projectInstance.organ.ztmc00}：</span></u>
							</p>
							<p style="text-indent:22pt;">
								<span>根据贵单位</span><u> <span>${projectInstance.zbxmmc}</span>
								</u><span>的招标公告，我单位拟参与该工程</span><u><span id="projectItemName"> <c:forEach items="${tender.tenderItemList}" var="tenderItem">
											<c:forEach items="${projectInstance.projectItemList}" var="item">
												<c:if test="${tenderItem.id==item.id}">
													<c:out value="${item.bdmc00}"></c:out>&nbsp;
												</c:if>
											</c:forEach>
										</c:forEach>
								</span></u><span>标段的投标报名。特此申请。</span>
							</p>
							<p>
								<br />
							</p>
							<p>
								<span>基本情况：</span>
							</p>
							<span></span>
							<p>
								<span>1.</span><span>企业营业执照：</span> <span>${CURRENT_USER_SESSION_INFO.organ.yyzzhm}</span>
							</p>
							<p>
								<span>2.</span><span>注册资本：</span> <span>${CURRENT_USER_SESSION_INFO.organ.zczb00}${CURRENT_USER_SESSION_INFO.organ.zczbdw==1?"元":"万元"}</span>
							</p>
							<p>
								<span>3.</span> <span>组织机构代码证号： <span>${CURRENT_USER_SESSION_INFO.organ.ztdm00}</span></span>
							</p>
							<p>
								<span>4.</span> <span>我单位将对本次投标中所有材料的真实性负全部责任，如有不实将承担由此造成的一切后果。</span>
							</p>
							<p>
								<span>5.</span> <span>如果我单位中标，将按有关规定和招标人的要求在规定时间内办理好开工前的相关手续。</span>
							</p>
							<p>
								<span>6.</span> <span>首次投标报名提供以下资料：按照本项目招标公告要求提供的相关资质扫描件</span>
							</p>
							<p style="text-indent:0cm;"></p>
							<br />
							<div style="text-indent:65pt;" id="tborgansealposition"></div>
							<br /> <br /> <br /> <br />
							<p style="text-indent:35pt;">
								<span>申请单位名称： ${CURRENT_USER_SESSION_INFO.organ.ztmc00}</span>
							</p>
							<p style="text-indent:35pt;">
								<span>法定代表人：（签章）</span>
							</p>
							<p style="text-indent:35pt;">
								<span>联 系 人：</span><span id="lxr000" contenteditable="true">${CURRENT_USER_SESSION_INFO.userName}</span>
							</p>
							<p style="text-indent:35pt;">
								<span>联系电话：</span><span id="lxdh00" contenteditable="true">${CURRENT_USER_SESSION_INFO.phone}</span>
							</p>
							<p style="text-indent:35pt;">
								<span>电子邮箱：</span><span id="email" contenteditable="true">${CURRENT_USER_SESSION_INFO.email}</span>
							</p>
							<p style="text-indent:35pt;">
								<span>传&nbsp;&nbsp;&nbsp;&nbsp;真：</span><span id="faxNo">${CURRENT_USER_SESSION_INFO.organ.faxNo}</span>
							</p>
							<p style="text-indent:35pt;">
								<span>地&nbsp;&nbsp;&nbsp;&nbsp;址：</span><span id="address">${CURRENT_USER_SESSION_INFO.organ.address}</span>
							</p>
							<p>&nbsp;</p>
						</div>
					</c:when>
					<c:otherwise>
						${tender.content}
					</c:otherwise>
				</c:choose>
			</div>
			<div id="sealPos"></div>
			<div id="ht_end"></div>
		</div>
		<div class="blank10"></div>
		<c:choose>
			<c:when test="${tender.reviewStatus=='-1'}">
				<div class="blank10"></div>
				<table id="attachmentUpload"></table>
				<table id="attachmentUpload1" class="easyui-datagrid"
					data-options="title:'附件列表',rownumbers:true,striped:true,height:200,autoRowHeight:true,singleSelect:true">
					<thead>
						<tr>
							<th data-options="field:'fjmc',align:'center',width:200">附件名称 </th>
							<th data-options="field:'uploadTime',align:'center',width:150">上传时间 </th>
							<th data-options="field:'length',align:'center',width:150,formatter:function(value){return castSize(value);}">附件大小</th>
							<th data-options="field:'status',align:'center',width:150">进度 </th>
							<th data-options="field:'fjlx00',align:'center'">附件类型 </th>
							<th data-options="field:'opt',align:'center',width:150">操作 </th>
							<th data-options="field:'flag',align:'center',hidden:true">状态 </th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${attachmentRequirementList}" var="item" varStatus="status">
							<script>
								var data = {id:"${item.id}",content:"${item.content}"};
								attachmentRequirements.push(data);
							</script>
							<tr>
								<td>${item.content}</td>
								<td>-</td>
								<td>0</td>
								<td>-</td>
								<td>-</td>
								<td><a id="${item.id}" class="button small red">添加附件</a></td>
								<td>false</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="blank10"></div>
<!-- 				<a id="addAttachment" class="button red">添加附件</a> -->
				<i>可以上传.jpg .gif .png .bmp .pdf .doc .docx</i>
				<!-- <a id="selectAptitude" class="button red">选择资质</a> -->
			</c:when>
			<c:otherwise>
				<table id="attachment"></table>
			</c:otherwise>
		</c:choose>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div id="reason-dialog">
			<form:form action="${pageContext.request.contextPath}/tenderApply/cancelTender" method="post" modelAttribute="tender">
				<form:hidden path="id" />
				<form:textarea path="nopassReason" style="width:678px;height:365px;" />
			</form:form>
		</div>
		<c:choose>
			<c:when test="${tender.reviewStatus!=2&&tender.reviewStatus!=-2}">
				<form:form id="tenderApplicationForm" method="post" modelAttribute="tender">
					<div style="text-align:right;position:fixed;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:999;border: #ccc 1px solid;">
						<input type="hidden" value="${token}" name="token" />
						<form:hidden path="id" />
						<form:hidden id="content" path="content" />
						<form:hidden path="projectInstanceId" />
						<form:hidden path="noticeId" />
						<input type="hidden" name="signatureData" id="sealSignData" />
						<input type="hidden" name="sealName" id="sealName" />
						<c:if test="${tender.reviewStatus=='-1'}">
							<input type="button" class='red button' id="saveBtn" value="保存草稿" />
							<!-- <input type="button" class="red button" id='sign' value="电子印章" /> -->
							<input type="button" id='subBtn' class='red button' value="提交审核" />
						</c:if>
						<c:if test="${tender.reviewStatus!='-1'}">
							<input type="button" class='red button' id="cancelBtn" value="撤销申请" />
						</c:if>
						<a class="button red" onclick="history.go(-1)">返回</a>
					</div>
				</form:form>
			</c:when>
			<c:otherwise>
				<form:form id="tenderApplicationForm" method="post" modelAttribute="tender">
					<input type="hidden" value="${token}" name="token" />
					<!-- <input type="hidden" name="signatureData" id="sealSignData" /> -->
					<!-- <input type="hidden" name="sealName" id="sealName" /> -->
					<form:hidden path="id" id="id" />
					<form:hidden id="content" path="content" />
					<form:hidden path="projectInstanceId" />
					<form:hidden path="noticeId" />
				</form:form>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
