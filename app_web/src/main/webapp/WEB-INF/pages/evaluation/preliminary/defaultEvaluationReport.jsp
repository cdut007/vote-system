<%@page pageEncoding="utf-8" import="java.util.Date"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%-- 获取评标组长 --%>
<c:forEach items="${expertApply.expertGroup.expertList}" var="expert" varStatus="status">
	<c:if test="${expertApply.expertGroup.zzzj00 == expert.id }">
		<c:set value="${expert}" var="leader" />
	</c:if>
</c:forEach>
<c:set value="${projectItemService.createProjectItemQuery().projectItemId(projectItemId).singleResult()}" var="projectItem"/>
<%--<c:set value="${evaluationReportService.retrieveBidderSort(expertApplyId,projectItemId)}" var="bidderSortList" />
<c:set value="${evaluationReportService.retrieveCandidate(expertApplyId,projectItemId)}" var="candidateList" /> --%>
<c:set value="${evaluationReportService.getTenders(projectItemId)}" var="tenders" />
<c:set value="${evaluationReportService.getTendersByBidfile(projectItemId)}" var="bidders" />
<c:set value="${evaluationReportService.getReviewResult1(expertApplyId,projectItemId)}" var="reviewList1" />
<c:set value="${evaluationReportService.getReviewResult2(expertApplyId,projectItemId)}" var="reviewList2" />
<c:set value="${evaluationReportService.getCandidates(projectItemId)}" var="candidates" />
<div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">
	<div style="font-family:'仿宋_GB2312';font-size:18px;line-height:28pt; ">
		<p style="text-align:center;height:150px; "></p>
		<p style="text-align:center; ">
			<span style="letter-spacing:5pt; font-weight:bold; font-size:40pt; font-family:'宋体'; ">资格预审评审报告</span>
		</p>
		<p style="text-align:center;height:200px; "></p>
		<p style="text-indent:80pt;font-size:14pt; line-height:37pt; ">
			<span>项目名称： <span style="text-decoration: underline;">${projectInstance.project.xmmc00}</span></span>
		</p>
		<p style="text-indent:80pt;font-size:14pt;line-height:37pt; ">
			<span>招标编号： <span style="text-decoration: underline;">${projectInstance.zbxmbh}</span></span>
		</p>
		<p style="text-indent:80pt;font-size:14pt;line-height:37pt; ">
			<span>招&nbsp;&nbsp;标&nbsp;&nbsp;人： <span style="text-decoration: underline;">${projectInstance.project.organ.ztmc00}</span></span>
		</p>
		<p style="text-indent:80pt;font-size:14pt;line-height:37pt; ">
			<span>招标代理机构： <span style="text-decoration: underline;">${projectInstance.organ.ztmc00}</span></span>
		</p>
		<p style="text-indent:80pt;font-size:14pt; line-height:37pt; ">
			<span>标段名称： <span style="text-decoration: underline;">${projectItem.bdmc00}</span></span>
		</p>
		<p style="text-align:center;height:200px; "></p>
		<p style="margin-right:80pt; text-align:right; line-height:40pt; ">
			<span style="letter-spacing:3pt; font-size:16pt;">&nbsp;评标委员会</span><span style="letter-spacing:3pt; font-size:16pt;"> </span>
		</p>
		<p style="text-align:right; margin-right:80pt; line-height:40pt; ">
			<span style="text-decoration:underline ;font-size:16pt;"> <fmt:formatDate value="<%=new Date()%>" pattern="yyyy年MM月dd日" /></span>
		</p>
		<p style="text-align:center;height:100px; "></p>
		<p style="font-weight:bold; font-size:22pt; text-align:center; line-height:26pt; ">评&nbsp;标&nbsp;报&nbsp;告</p>
		<p style="text-align:center;height:60px; "></p>
		<p style="font-size:14pt;">
			<span>一、参加单位及人员</span>
		</p>
		<p>
			<span>1、资格预审申请人：
			</span>
		</p>
		<table class="mytableStyle" align="center" style="width:100%;background-color:#fff;">
			<thead>
				<tr class="firstRow">
					<th style="width:20px;">序号</th>
					<th style="width:365px;">单位名称</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${tenders}" var="bidderSort" varStatus="s">
					<tr>
						<td>${s.count}</td>
						<td>${bidderSort.ztmc00}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p style="height:20px;"></p>
		<p>
			<span>2、项目实施机构及代表：${projectInstance.project.organ.ztmc00}</span>
		</p>
		<p style="height:20px;"></p>
		<p>
			<span>3、审查委员会：<span style="text-decoration:underline ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</span>
		</p>
		<p style="height:20px;"></p>
		<p>
			<span>4、监督单位及人员：<span style="text-decoration:underline ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;">二、资格预审申请文件递交情况</span>
		</p>
		<p>
			<span>共有<span style="text-decoration:underline">&nbsp;${fn:length(bidders)}&nbsp;</span>名资格预审申请人递交了资格预审申请文件，名单如下</span>
		</p>
		<table class="mytableStyle" align="center" style="width:100%;background-color:#fff;">
			<thead>
				<tr class="firstRow">
					<th style="width:20px;">序号</th>
					<th style="width:365px;">单位名称</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bidders}" var="bidderSort" varStatus="s">
					<tr>
						<td>${s.count}</td>
						<td>${bidderSort.ztmc00}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p style="height:30px;"></p>
		<p>
			<span style="font-size:14pt;">三、评审情况</span>
		</p>
		<p>
			<span>按照资格预审文件中的资格审查办法，审查委员会对以上各家单位递交的资格预审申请文件进行了审查。</span>
		</p>
		<p>
			<span>1、初步评审结果如下：
			</span>
		</p>
		<table class="mytableStyle" align="center" style="width:100%;background-color:#fff;">
			<thead>
				<tr class="firstRow">
					<th style="width:50px;">序号</th>
					<th style="width:365px;">单位名称</th>
					<th style="width:365px;">初审结果</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${reviewList1}" var="bidderSort" varStatus="s">
					<tr>
						<td>${s.count}</td>
						<td>${bidderSort['ZTMC00']}</td>
						<td>${bidderSort['SCORE']==0?'通过':'未通过'}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p style="height:20px;"></p>
		<p>
			<span>2、经审查委员会评议，共有<span style="text-decoration:underline">&nbsp;${fn:length(reviewList2)}&nbsp;</span>家通过初步评审的单位进入详细评审，详细评审后结果如下：
			</span>
		</p>
		<table class="mytableStyle" align="center" style="width:100%;background-color:#fff;">
			<thead>
				<tr class="firstRow">
					<th style="width:50px;">序号</th>
					<th style="width:365px;">单位名称</th>
					<th style="width:200px;">得分</th>
					<th style="width:200px;">资审结果</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${reviewList2}" var="bidderSort" varStatus="s">
					<tr>
						<td>${s.count}</td>
						<td>${bidderSort['ZTMC00']}</td>
						<td>
							<c:choose>
							<c:when test="${fn:contains(bidderSort['SCORE'],'合格')}" >
								${bidderSort['SCORE']}
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${bidderSort['SCORE']}" maxFractionDigits="2" minFractionDigits="2" />
							</c:otherwise>
							</c:choose>
						</td>
						<td>${bidderSort['CONCLUSION']==0?'通过':'未通过'}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;">四、评审结果</span>
		</p>
		<p>
			<span>按照资格预审文件的要求，经过审查委员会评审，通过资格预审的潜在投标人如下：</span>
		</p>
		<table class="mytableStyle" align="center" style="width:100%;background-color:#fff;">
			<thead>
				<tr class="firstRow">
					<th style="width:50px;">序号</th>
					<th style="width:365px;">单位名称</th>
					<th style="width:200px;">得分</th>
					<th style="width:200px;">资审结果</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${reviewList2}" var="bidderSort" varStatus="s">
					<c:if test="${bidderSort['CONCLUSION']==0}">
					<tr>
						<td>${s.count}</td>
						<td>${bidderSort['ZTMC00']}</td>
						<%---<td><fmt:formatNumber value="${bidderSort['SCORE']}" maxFractionDigits="2" minFractionDigits="2" /></td> --%>
						<td>
							<c:choose>
							<c:when test="${fn:contains(bidderSort['SCORE'],'合格')}" >
								${bidderSort['SCORE']}
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${bidderSort['SCORE']}" maxFractionDigits="2" minFractionDigits="2" />
							</c:otherwise>
							</c:choose>
						</td>
						<td>通过</td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>

		<p style="height:40px;"></p>
		<p>
			<span>经审查委员会评审，共有<span style="text-decoration:underline">&nbsp;${fn:length(candidates)}&nbsp;</span>家资格预审申请人合格。</span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:12pt;">项目实施机构代表：<span style="text-decoration:underline ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:12pt;">审查委员会：<span style="text-decoration:underline ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:12pt;">监督人员：<span style="text-decoration:underline ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
		</p>

		<p style="height:40px;"></p>
		<p style="text-align:right; margin-right:80pt; line-height:40pt; ">
			<span style="text-decoration:underline ;font-size:16pt;"> <fmt:formatDate value="<%=new Date()%>" pattern="yyyy年MM月dd日" />
			</span>
		</p>
	</div>
	<!--EndFragment-->
</div>