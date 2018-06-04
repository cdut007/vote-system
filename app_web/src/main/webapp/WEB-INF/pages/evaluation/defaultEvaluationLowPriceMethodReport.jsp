<%@page pageEncoding="utf-8" import="java.util.Date"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set value="${evaluationReportService.retrieveBidderSortByLowPrice(expertApplyId,projectItemId)}" var="bidderSortListByLowPrice" />
<c:set value="${evaluationReportService.retrieveCandidateByLowPrice(expertApplyId,projectItemId)}" var="candidateListByLowPrice" />

		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;">七、评审情况及评分比较一览表</span>
		</p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;  ">（如有需要说明评委对各投标人的评审意见，或是同一评委对投标人打分差距太大的写出理由。）</span>
		</p>
		<p>
			<span>详见&#8220;初步评分表&#8221;和&#8220;投标人排序表&#8221;。</span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;">八、经评审的投标人排序</span>
		</p>
		<p>
			<span>按照招标文件规定的评标原则和评标办法，各评委独立进行了评审，投标人排序如下：</span>
		</p>
		<p style="line-height:12pt; ">
			<span>&nbsp; </span>
		</p>
		<table class="mytableStyle" align="center" style="width:100%;background-color:#fff;">
			<thead>
				<tr class="firstRow">
					<th style="width:20px;">排名</th>
					<th style="width:365px;">投标单位</th>
					<th style="width:123px;">投标报价</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bidderSortListByLowPrice}" var="bidderSort" varStatus="s">
					<tr>
						<td>${s.count}</td>
						<td>${bidderSort.organBName}</td>
						<td><fmt:formatNumber value="${bidderSort.tbbjje}" maxFractionDigits="2" minFractionDigits="2" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p style="height:40px;"></p>
		<p style="margin-bottom:0pt; ">
			<span style="font-size:14pt;">九、推荐的中标候选单位名单与签订合同前要处理的事宜</span>
		</p>
		<p>
			<span>经评审，评标委员会推荐的中标候选人名单如下：</span>
		</p>
		<h4>${projectItem.bdmc00}</h4>
		<c:forEach items="${candidateListByLowPrice}" var="candidate" varStatus="s">
			<p>
				<span>第${s.count}名：</span><span style="text-decoration:underline">${candidate.organBName}</span>
			</p>
		</c:forEach>
	
