<%@page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<h1 style="text-align:center">
	${tenderNotice.noticeTitle}
</h1>
<h2 style="text-align:center">
	(招标编号：${projectInstance.organProjectCode})
	<br>
</h2>

<p>
	招标项目所在地区：${util:dictionaryPath('REGION',projectInstance.region)}
</p>
<p><br /></p>

	<h2>一、招标条件</h2>
	<p style="text-indent:0em;">
		<span></span><span class="need_input u" name="projectInstance.terms">${projectInstance.terms}</span>
		<br />
	</p>
	<p><br /></p>

	<h2>二、项目概况与招标范围</h2>
	<p style="text-indent:0em;">
		<span>1、</span>项目名称：<span class="need_input u" name="projectInstance.zbxmmc">${projectInstance.zbxmmc}</span>
	</p>
	<p style="text-indent:0em;">
		<span>2、</span>项目地点：<span class="need_input u" name="tenderNoticeData.deliveryPlace">${tenderNoticeData.deliveryPlace}</span>
	</p>
	<p style="text-indent:0em;">
		<span>3、</span>交货期/工期/服务期：
	</p>
		<ul style="text-indent:0em;">
			<c:forEach items="${projectItemList}" var="projectItem">
				<li>&nbsp;&nbsp;&nbsp;&nbsp;
				<c:if test="${fn:length(projectItemList)>1}">${projectItem.bdmc00}:</c:if>
				${projectItem.deliveryTimeLimit}</li>
			</c:forEach>
		</ul>
	<p style="text-indent:0em;">
		<span>4、</span>质量：<span class="need_input u" name="tenderNoticeData.quality">${tenderNoticeData.quality}</span>
	</p>
	<p style="text-indent:0em;">
		<span>5、</span>项目规模：<span class="need_input u" name="tenderNoticeData.project.xmgm00">${projectInstance.project.xmgm00}</span>
	</p>
	<p style="text-indent:0em;">
		<span>6、</span>招标内容与范围：
	</p>
		<ul style="text-indent:0em;">
			<c:forEach items="${projectItemList}" var="projectItem">
				<li><span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<c:if test="${fn:length(projectItemList)>1}">${projectItem.bdmc00}:</c:if>
						${projectItem.bdnr00}</li>
			</c:forEach>
		</ul>
	<p><br /></p>

	<h2>三、投标人资格要求</h2>
		<ul style="text-indent:0em;">
			<c:forEach items="${projectItemList}" var="item" varStatus="status">
				<li><span>&nbsp;&nbsp;&nbsp;&nbsp;</span>(${status.count})${item.tbzgtj}</li>
			</c:forEach>
		</ul>
	<p><br /></p>

	<h2>四、资格预审文件的获取</h2>
	<p style="text-indent:0em;">
		<span>1、</span>获取时间：<span class="need_input u" name="tenderNoticeData.applyDateBegin"><fmt:formatDate value="${tenderNoticeData.applyDateBegin}" pattern="yyyy-MM-dd HH:mm:ss" /></span>至<span class="need_input u" name="tenderNoticeData.applyDateEnd"><fmt:formatDate value="${tenderNoticeData.applyDateEnd}" pattern="yyyy-MM-dd HH:mm:ss" /><c:if test="${tenderNotice.isWorkHoliday=='1'}">（法定公休日、法定节假日不休息）</c:if>
			<c:if test="${tenderNotice.isWorkHoliday=='0'}">（法定公休日、法定节假日不工作）</c:if></span>
	</p>
	<p style="text-indent:0em;">
		<span>2、</span>获取地点：<span class="need_input u" name="tenderNoticeData.applyPlace">
			在<U>&nbsp;${tenderNoticeData.applyPlace}&nbsp;</U>领取招标文件并在招标文件获取截至时间前在金蝉电子招标投标综合交易平台（www.jcebid.com）下载电子招标文件
			</span>
	</p>
	<p style="text-indent:0em;">
		<span>3、</span>报名合格后同时发售招标文件
	</p>
	<p><br /></p>

	<h2>五、资格预审申请文件的递交</h2>
	<p style="text-indent:0em;">
		<span>1、</span>投标文件递交截止时间：<span class="need_input u" name="tenderNoticeData.bidDeadline"><fmt:formatDate value="${tenderNoticeData.bidDeadline}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
	</p>
	<p style="text-indent:0em;">
		<span>2、</span>递交方式及递交地址：<span class="need_input u" name="tenderNoticeData.bidPlace">
				在<u>&nbsp;${tenderNoticeData.bidPlace}&nbsp;</u>递交投标文件并在投标文件递交截止时间截至前在金蝉电子招标投标综合交易平台（www.jcebid.com）递交电子投标文件
				</span>
	</p>
	<p><br /></p>

	<h2>六、资格预审文件开启</h2>
	<p style="text-indent:0em;">
		<span>1、</span>文件开启时间：<span class="need_input u" name="tenderNoticeData.bidOpenDate"><fmt:formatDate value="${tenderNoticeData.bidOpenDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
	</p>
	<p style="text-indent:0em;">
		<span>2、</span>文件开启方式：<%--<span class="need_input u" name="tenderNoticeData.bidOpenPlace">${tenderNoticeData.bidOpenPlace}</span>--%>
	</p>
	<p style="text-indent:0em;">
		<span>2、</span>评审办法 ：<%--<span class="need_input u" name="tenderNoticeData.bidOpenPlace">${tenderNoticeData.bidOpenPlace}</span>--%>
	</p>
	<p><br /></p>


	<h2>七、其他公告内容</h2>
	<p style="text-indent:0em;">
		<span>1、</span>报名时间：<span class="need_input u" name="tenderNoticeData.applyDateBegin"><fmt:formatDate value="${tenderNoticeData.applyDateBegin}" pattern="yyyy-MM-dd HH:mm:ss"/></span>至<span class="need_input u" name="tenderNoticeData.applyDateEnd"><fmt:formatDate value="${tenderNoticeData.applyDateEnd}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
	</p>
	<p style="text-indent:0em;">
		<span>2、</span>报名地点：<span class="need_input u" name="tenderNoticeData.applyPlace">在<U>&nbsp;${tenderNoticeData.applyPlace}&nbsp;</U>验证相关证件的原件并提交加盖公章的复印件叁套并在金蝉电子招标投标综合交易平台（www.jcebid.com）进行报名</span>
	</p>
	<p style="text-indent:0em;">
		<span>3、</span>投标人报名时应上传以下证件扫描件:
	</p>
	<ul style="text-indent:0em;">
		<c:forEach items="${attachmentRequirementList}" var="attachmentRequirement" varStatus="status">
			<li>&nbsp;&nbsp;&nbsp;&nbsp;(${status.count})${attachmentRequirement.content}</li>
		</c:forEach>
	</ul>
	<p style="text-indent:0em;">
		<span>4、</span>招标文件售价：
	</p>
	<ul>
		<c:forEach items="${projectItemList}" var="projectItem">
			<li><span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<c:if test="${fn:length(projectItemList)>1}">${projectItem.bdmc00}:</c:if>
				招标文件每套售价${projectItem.price}元，售后不退</li>
		</c:forEach>
	</ul>
	<p style="text-indent:0em;">
		<span>5、</span>发布媒体：<span class="need_input" name="tenderNoticeData.ggfbmt">${tenderNoticeData.ggfbmt}
			<br/>本次公告同时在山西省招标投标公共服务平台/山西招投标网、金蝉电子招标投标综合交易平台上发布
			</span>
	</p>
	<p>
		注：本次招标为全流程线上招标项目，凡有意投标的单位，须持有山西CA进行网上投标，已入驻山西省投标人主体库的投标单位，可持山西CA直接报名并投标，未入驻山西省投标人主体库的投标单位，请前往山西省政务大厅办理入驻手续，详情点击下列链接办理：
		<br/><a href="http://jyzt.sxzwfw.gov.cn/ggzyzt/f/page?page=RegistrationGuide" target="_black">http://jyzt.sxzwfw.gov.cn/ggzyzt/f/page?page=RegistrationGuide</a>
		<br/><a href="http://jyzt.sxzwfw.gov.cn/ggzyzt/f/page?page=scsq" target="_black">http://jyzt.sxzwfw.gov.cn/ggzyzt/f/page?page=scsq</a>
		<br/>山西CA办理完成后，请各投标人联系我公司项目负责人，以便信息同步及网上报名等相关流程
	</p>
	<p><br /></p>

	<h2>
		八、监督部门：
	</h2>
	<p>
		本招标项目的监督部门为：${projectInstance.jdbmmc}
	</p>
	<p><br /></p>


<h2>
	九、联系方式：
</h2>
<p>
	招标人：${organT.ztmc00}
	<br />
</p>

<p>
	地址：${organT.address}
	<br />
</p>

<p>
	联系人：${projectInstance.project.contacts}
	<br />
</p>

<p>
	联系方式：${projectInstance.project.phones}
	<br />
	<br />
</p>

<p>
	招标代理机构：${organA.ztmc00}
	<br />
</p>

<p>
	地址：${organA.address}
	<br />
</p>

<p>
	联系人：${projectInstance.contacts}
	<br />
</p>

<p>
	联系方式：${projectInstance.phones}
	<br />
	<br />
</p>

<p>
	平台网站：www.jcebid.com
	<br />
	<br />
	<br />
</p>

<p>
	招标人或其招标代理机构主要负责人（项目负责人）：           （签名）
	<br />
	<br />
</p>
<p>
	招标人或其招标代理机构：                 （盖章）
	<br />
	<br />
</p>










<%--	<p style="text-indent:0em;">
		<span>九、</span>联系方式
	</p>
	<p style="text-indent:0em;">
		<span></span>招 标 人：<span class="need_input u" name="organT.ztmc00">${organT.ztmc00}</span>
	</p>
	<p style="text-indent:0em;">
		<span></span>联 系 人：<span class="need_input u" name="projectInstance.project.contacts">${projectInstance.project.contacts}</span>
	</p>
	<p style="text-indent:0em;">
		<span></span>联系电话：<span class="need_input u" name="projectInstance.project.phones">${projectInstance.project.phones}</span>
	</p>
	<p>
    <br/>
	</p>
	<p style="text-indent:0em;">
		<span></span>代理机构：<span class="need_input u" name="organA.ztmc00">${organA.ztmc00}</span>
	</p>
	<p style="text-indent:0em;">
		<span></span>联 系 人：<span class="need_input u" name="projectInstance.contacts">${projectInstance.contacts}</span>
	</p>
	<p style="text-indent:0em;">
		<span></span>联系电话：<span class="need_input u" name="projectInstance.phones">${projectInstance.phones}</span>
	</p>
	<br>
	<p style="text-indent:0em;">
		<span>十、</span>平台网址
	</p>
	<p style="text-indent:0em;">
		<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>www.jcebid.com
	</p>--%>


	<c:if test="${attachments.size() > 0}">
	<p style="text-indent:0em;">
		<span></span>附件：
	</p>
	
	<c:forEach items="${attachments}" var="attachment">
			<li><a target="_blank" href="${attachment.path}">${attachment.fjmc00}</a></li>
	</c:forEach>
	</c:if>
		