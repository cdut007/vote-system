<%@page pageEncoding="utf-8" import="java.util.Date"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- 获取评标组长 --%>
<c:forEach items="${expertApply.expertGroup.expertList}" var="expert" varStatus="status">
	<c:if test="${expertApply.expertGroup.zzzj00 == expert.id }">
		<c:set value="${expert}" var="leader" />
	</c:if>
</c:forEach>
<c:set value="${projectItemService.createProjectItemQuery().projectItemId(projectItemId).singleResult()}" var="projectItem" scope="request"/>

<div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">
	<div style="font-family:'仿宋_GB2312';font-size:18px;line-height:28pt; ">
		<p style="text-align:center;height:150px; "></p>
		<p style="text-align:center; ">
			<span style="letter-spacing:5pt; font-weight:bold; font-size:40pt; font-family:'宋体'; ">评标报告</span>
		</p>
		<p style="text-align:center;height:200px; "></p>
		<p style="text-indent:80pt;font-size:14pt; line-height:37pt; ">
			<span>项目名称： <span style="text-decoration: underline;">${projectInstance.zbxmmc}</span></span>
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
			<span>一、基本情况和数据表</span>
		</p>
		<p>
			<span>1、受 <span style="text-decoration:underline ;">${projectInstance.project.organ.ztmc00}</span> 的正式委托，<span style="text-decoration:underline ;">${projectInstance.organ.ztmc00}</span> 对其<span style="<span style="text-decoration:underline ;">">${projectInstance.project.xmmc00}</span> 组织公开招标，招标编号：<span style="text-decoration:underline ;">${projectInstance.project.xmbh00}</span> 。
			</span>
		</p>
		<p>
			<span>2、项目简介</span>
		</p>
		<p>
			<span>对项目情况和招标内容作简单陈述，如工程类的建设规模、计划工期、招标范围、标段划分，是否接受联合体投标等，货物类的招标范围、内容、规模数量、技术规格、交货或服务方式、标包划分等。</span>
		</p>
		<p>
			<span>3、招标公告于 <span style="text-decoration:underline ;"><fmt:formatDate value="${noticeZhaob.ggfbsj}" pattern="yyyy年MM月dd日 HH时dd分" /></span>在中国采购与招标网和山西招投标网（如有其它网站可增加）发布。招标公告发布后，在规定的时间有以下（如果投标单位数量少，可具体列出 ）个单位报名并购买了招标文件，详见&#8220;招标文件购买登记表&#8221;。
			</span>
		</p>
		<p>
			<span>如有最高投标限价、二次公告或其他情况应说明情况。如：本项目最高投标限价为：______万元，于____年____月____日在中国采购与招标网和山西招投标网公布。</span>
		</p>
		<p>
			<span>4、开标时间： <span style="text-decoration:underline ;"><fmt:formatDate value="${expertApply.bidOpenDate}" pattern="yyyy年MM月dd日  HH时mm分" /></span>。
			</span>
		</p>
		<p>
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;开标地点： <span style="text-decoration:underline ;">${expertApply.bidOpenPlace}</span>。
			</span>
		</p>
		<p>
			<span>5、在规定的投标截止时间</span> <span style="text-decoration:underline ;"><fmt:formatDate value="${t_zbwj.bidDeadline}" pattern="yyyy年MM月dd日  HH时mm分" /> </span> 前，以上<span style="text-decoration:underline ;font-size:14pt;  ">&nbsp;&nbsp;&nbsp;&nbsp;</span><span>个投标单位均递交了投标文件和投标保证金，且投标文件密封完好，投标有效。详见&#8220;投标文件接收表（ 与对应的记录表名称一致 ）&#8221;。 </span>
		</p>
		<p>
			<span>6、</span> <span style="text-decoration:underline ;"><fmt:formatDate value="${expertApply.bidOpenDate}" pattern="yyyy年MM月dd日  HH时mm分" /></span>，开标仪式准时举行。会议由 <span style="text-decoration:underline ;">${projectInstance.organ.ztmc00}</span>主持， <span style="text-decoration:underline ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span>等上级单位和</span>项目单位领导及有关人员参加会议，由 <span style="text-decoration:underline ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> 担任监标人，对开、评标过程进行全程监督。<span style="color:rgb(255,0,0); font-size:12pt;  ">各投标单位代表均签名到会（按招标文件规定写明情况）。 </span>
		</p>
		<p>
			<span>开标前由监标人和投标单位代表核验投标文件的密封情况。开标和唱标均按照招标文件的要求进行。</span><span style="font-size:12pt;  ">（开标现场如有其他情况，都应记录，例如：抽取技术标的百分比或投标人对开标提出异议的等。）</span><span> </span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;">二、评标委员会成员名单</span>
		</p>
		<p>
			<span>评标委员会由招标人按照有关规定组建，成员</span><span style="text-decoration:underline ;font-size:14pt;  ">&nbsp;&nbsp;</span><span>人。其中</span><span style="text-decoration:underline ;font-size:14pt;  ">&nbsp;&nbsp;</span><span>人由山西省评标专家库随机抽取产生，</span><span style="text-decoration:underline ;font-size:14pt;  ">&nbsp;&nbsp;</span><span>人为招标人代表。</span><span style="text-decoration: underline;">${leader}</span><span>被推选为评标委员会主任。</span><span> </span>
		</p>
		<p>
			<span>详见&#8220;评标专家抽取结果通知单&#8221;和&#8220;评委签到表&#8221;。</span><span> </span>
		</p>
		<p>
			<span>评标前，各评委均签署了&#8220;</span><span>评标专家廉洁自律承诺书</span><span>&#8221;和&#8220;</span><span>评标专家回避承诺书</span><span>&#8221;</span><span>。</span><span> </span>
		</p>
		<p>
			<span>&nbsp;</span>
		</p>
		<table class="mytableStyle" align="center" style="width:100%;font-family:仿宋_GB2312;">
			<thead>
				<tr class="firstRow">
					<th>序号</th>
					<th>姓名</th>
					<th>专家编号</th>
					<th>身份证号</th>
					<th>联系方式</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${expertApply.expertGroup.expertList}" var="expert" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>${expert.userName}</td>
						<td></td>
						<td>${expert.identityNo}</td>
						<td>${expert.phone}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;">三、开标记录</span>
		</p>
		<p>
			<span>详见&#8220;开标记录表&#8221;。</span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;">四、符合要求的投标文件投递表</span>
		</p>
		<p>
			<span>详见&#8220;投标文件投递表&#8221;。</span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;">五、否决投标情况说明</span>
		</p>
		<p>
			<span>经资格审查和初步评审，无否决投标情况。详见&#8220;初步评审表&#8221;&#8220;资格审查表&#8221;。</span><span style="font-size:12pt;  ">（此处对否决投标的情况具体说明，否决投标的单位名称、否决的原因及在哪个环节被否决。）</span><span> </span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;">六、评标标准、评标方法或者评标因素一览表</span>
		</p>
		<p style="text-indent:2em">
			<span>详见&#8220;评标办法及评分细则&#8221;。（其中投标报价得分的计算和评审中有关数据的统计、汇总等由工作人员协助评标委员会进行。）</span>
		</p>
		<c:if test="${uniqueMethodId!=null && (uniqueMethodId=='JT_TECH_SCORE_LOWEST_PRICE_METHOD' || uniqueMethodId=='JT_LOWEST_PRICE_METHOD') }">
				<jsp:include page="defaultEvaluationLowPriceMethodReport.jsp" />	<!-- 投标报价排名 -->
		</c:if>
		
		<!-- 房建经评审 -->
		<c:if test="${uniqueMethodId2!=null && uniqueMethodId2=='FWSZ_BMK_5' }">
				<jsp:include page="defaultEvaluationLowPriceMethodReport.jsp" />	<!-- 投标报价排名 -->
		</c:if>
		
		<c:if test="${uniqueMethodId!=null  && (uniqueMethodId=='JT_ZHPF_METHOD' || uniqueMethodId=='JT_REASONABLE_PRICE_METHOD')}">
				<jsp:include page="defaultEvaluationMethodReport.jsp" />			<!-- 详评打分排名 -->
		</c:if>
		
		<c:if test="${uniqueMethodId2!=null  && (uniqueMethodId2=='FWSZ_BMK_1' || uniqueMethodId2=='FWSZ_BMK_2' || uniqueMethodId2=='FWSZ_BMK_3' || uniqueMethodId2=='FWSZ_BMK_4')}">
				<jsp:include page="defaultEvaluationMethodReport.jsp" />			<!-- 详评打分排名 -->
		</c:if>
		
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;  ">（中标候选人应当不超过${projectItem.recruitFileData.candidateNum}个，排序应与评分汇总表排序一致。）</span>
		</p>
		<p>
			<span>评委建议：</span>
		</p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;  ">（请输入评委意见及建议招标人签合同前应注意的事项和完善的内容。）</span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;">十、澄清、说明、补正事项纪要</span>
		</p>
		<p>
			<span>详见&#8220;询标澄清表&#8221;。</span>
		</p>
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:14pt;" id="juryAddSeal">十一、评委签字</span>
		</p>
		<c:forEach items="${expertApply.expertGroup.expertList}" var="expert" varStatus="status">
			<p style="text-indent:42pt; ">
				<span>&nbsp; </span>
			</p>
			<p style="text-indent:48pt; ">
				<span id="juryAddSeal-${expert.id}">${expertApply.expertGroup.zzzj00 == expert.id?"主任委员":"委&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;员" }：</span> <span style="text-decoration:underline ;"></span>
			</p>
		</c:forEach>
		<p style="height:40px;"></p>
		<p style="text-indent:48pt;">
			<span>监&nbsp;标&nbsp;人</span><span>：</span><span style="text-decoration:underline ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span>&nbsp;&nbsp;</span><span style="text-decoration:underline ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		</p>
		<p style="height:40px;"></p>
		<p style="text-align:right; margin-right:80pt; line-height:40pt; ">
			<span style="text-decoration:underline ;font-size:16pt;"> <fmt:formatDate value="<%=new Date()%>" pattern="yyyy年MM月dd日" />
			</span>
		</p>
	</div>
	<!--EndFragment-->
</div>