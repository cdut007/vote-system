<%@page import="com.mhb.common.util.DateUtils"%>
<%@page import="com.mhb.common.Constants"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib
	prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>



<p style="margin-top: auto; text-align: center; line-height: 64px">
	<strong><span style="font-size: 32px; font-family: 宋体;font-weight:bold;">${invitationFile.projectInstance.zbxmmc}设备采购投标邀请书</span></strong>
</p>
<p
	style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 24px">
	<span style="font-size: 16px; font-family: 宋体"><span style="text-decoration: underline;" id="bidder_ztmc">XXXXXXXXXX</span></span>
</p>


<p
	style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 33px">
	<span style="font-size: 16px; font-family: 宋体;font-weight:bold;">1. 招标条件</span>
</p>
<p style="margin: 5px 0; line-height: 33px">
	<span style="">本招标项目 <span style="text-decoration:underline;">&nbsp;${invitationFile.projectInstance.zbxmmc}&nbsp;</span>
			 招标人为<span style="text-decoration:underline;">&nbsp;${invitationFile.projectInstance.project.organ.ztmc00}&nbsp;</span>
		，招标项目资金来自<span style="text-decoration:underline;">&nbsp;${invitationFile.projectInstance.project.funding}&nbsp;</span>，出资比例为<span style="text-decoration:underline;">&nbsp;${invitationFile.projectInstance.project.czbl}&nbsp;</span>。该项目已具备招标条件，现邀请你单位参加
		<span style="text-decoration:underline;">&nbsp;${invitationFile.deviceName}&nbsp;</span>采购投标。</span>
</p>


<p
	style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 33px">
	<span style="font-size: 16px; font-family: 宋体;font-weight:bold;">2. 项目概况与招标范围</span>
	
</p>
<p style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 33px">
	<span>&nbsp;${invitationFile.invitationSummary}&nbsp;</span>
</p>
<p style="margin: 5px 0; line-height: 33px">
	<span style=""></span>
</p>
<p
	style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 33px">
	<span style="font-size: 16px; font-family: 宋体;font-weight:bold;">3. 投标人资格要求</span>
</p>
<p style="margin: 5px 0; line-height: 33px">
	<span style="">3.1
		本次招标要求投标人须具备<span style="text-decoration:underline;">&nbsp;${invitationFile.aptitudeRequire}&nbsp;</span>资质，<span style="text-decoration:underline;">&nbsp;${invitationFile.achievementRequire}&nbsp;</span>业绩，并具有与本招标项目相应的供货能力。 </span> <br /> 
	
	<span
		style="">3.2 本次招标<span style="text-decoration:underline;">&nbsp;不接受&nbsp;</span>联合体投标。 </span> <br />
		
		<span style="">3.3 一个制造商对同一品牌同一型号的设备，仅能委托一个代理商参加投标。 </span>



</p>

<p
	style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 33px">
	<span style="font-size: 16px; font-family: 宋体;font-weight:bold;">4. 招标文件的获取</span>
</p>
<p style="margin: 5px 0; line-height: 33px">
	<span style="">4.1 凡有意参加投标者，请于<span style="text-decoration:underline;">&nbsp;<fmt:formatDate value="${invitationFile.recruitFileOpenDate}" pattern="yyyy年MM月dd日HH时" type="both" dateStyle="default" timeStyle="default" />&nbsp;</span>至
	<span style="text-decoration:underline;">&nbsp;<fmt:formatDate value="${invitationFile.recruitFileDeadLine}" pattern="yyyy年MM月dd日HH时" type="both" dateStyle="default" timeStyle="default" />&nbsp;</span>，登录www.jcebid.com下载电子招标文件。 </span> <br />
	
</p>
<p style="margin: 5px 0; line-height: 33px">
	<span style="">4.2 招标文件每套售价<span style="text-decoration:underline;">&nbsp;${invitationFile.projectItem.price}&nbsp;</span>元，售后不退。
	
</p>
<p
	style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 33px">
	<span style="font-size: 16px; font-family: 宋体;font-weight:bold;">5. 投标文件的递交</span>
</p>
<p style="margin: 5px 0; line-height: 33px">
	<span style="">5.1 请登录www.jcebid.com下载电子招标文件。 </span>投标文件递交截止时间为 
	<span style="text-decoration:underline;">&nbsp;<fmt:formatDate value="${invitationFile.bidEndDate}" pattern="yyyy年MM月dd日HH时mm分" type="both" dateStyle="default" timeStyle="default" />&nbsp;</span>。
	</span> <br /> <span style="">5.2 逾期送达的投标文件，电子招标投标交易平台予以拒收。 </span>
</p>
<p
	style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 33px">
	<span style="font-size: 16px; font-family: 宋体;font-weight:bold;">6. 确认</span>
</p>
<p style="margin: 5px 0; line-height: 33px">
	<span style="">你单位收到本邀请书后，请于<span style="text-decoration:underline;">&nbsp;<fmt:formatDate value="${invitationFile.confirmEndDate}" pattern="yyyy年MM月dd日HH时" type="both" dateStyle="default" timeStyle="default" />&nbsp;</span>前，确认是否参加投标。在本邀请书规定的时间内未表示是否参加投标或明确表示不参加投标的，不得再参加投标。
	</span> <br />

</p>
<p
	style="margin-top: 5px; margin-right: 0; margin-bottom: 5px; margin-left: 0; line-height: 33px">
	<span style="font-size: 16px; font-family: 宋体;font-weight:bold;">7. 联系方式</span>
</p>
<table cellspacing="0" cellpadding="0">
	<tbody>
		<tr style="height: 34px" class="firstRow">
			<td width="319" style="border-width: 1px; padding: 0px 7px;"
				height="34" id="signdataIdWtr"><p style="line-height: 24px">
					<span style="font-size: 16px; font-family: 宋体">招 标
						人（盖章）：${invitationFile.projectInstance.project.organ.ztmc00}</span>
				</p></td>
			<td width="319"
				style="border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-style: none; padding: 0px 7px;"
				height="34" id="signdataIdStr"><p style="line-height: 24px">
					<span style="font-size: 16px; font-family: 宋体">招标代理机构（盖章）：${invitationFile.projectInstance.organ.ztmc00}</span>
				</p></td>
		</tr>
		<tr style="height: 34px">
			<td width="319"
				style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
				height="34"><p style="line-height: 24px">
					<span style="font-size: 16px; font-family: 宋体">地 址：${invitationFile.projectInstance.project.organ.address}</span>
				</p></td>
			<td width="319"
				style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
				height="34"><p style="line-height: 24px">
					<span style="font-size: 16px; font-family: 宋体">地 址：${invitationFile.projectInstance.organ.address}</span>
				</p></td>
		</tr>
		<tr style="height: 34px">
			<td width="319"
				style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
				height="34"><p style="line-height: 24px">
					<span style="font-size: 16px; font-family: 宋体">邮 编：${invitationFile.projectInstance.project.organ.zipCode}</span>
				</p></td>
			<td width="319"
				style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
				height="34"><p style="line-height: 24px">
					<span style="font-size: 16px; font-family: 宋体">邮 编：${invitationFile.projectInstance.organ.zipCode}</span>
				</p></td>
		</tr>
		<tr style="height: 34px">
			<td width="319"
				style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"><p
					style="line-height: 24px">
					<span style="font-size: 16px; font-family: 宋体">联 系
						人：${invitationFile.projectInstance.project.organ.sbzrr0}</span>
				</p></td>
			<td width="319"
				style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"><p
					style="line-height: 24px">
					<span style="font-size: 16px; font-family: 宋体">联 系
						人：${invitationFile.projectInstance.organ.sbzrr0}</span>
				</p></td>
		</tr>
		<tr style="height: 34px">
			<td width="319"
				style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">电
						话：${invitationFile.projectInstance.project.organ.phone}</span>
				</p></td>
			<td width="319"
				style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">电
						话：${invitationFile.projectInstance.organ.phone}</span>
				</p></td>
		</tr>

		<tr style="height: 34px">
			<td width="319"
				style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">传真：${invitationFile.projectInstance.project.organ.faxNo}</span>
				</p></td>
			<td width="319"
				style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">传真：${invitationFile.projectInstance.organ.faxNo}</span>
				</p></td>
		</tr>
		<tr style="height: 34px">
			<td width="319"
				style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">电子邮件：${invitationFile.projectInstance.project.organ.email}</span>
				</p></td>
			<td width="319"
				style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">电子邮件：${invitationFile.projectInstance.organ.email}</span>
				</p></td>
		</tr>
		<tr style="height: 34px">
			<td width="319"
				style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">网
						址：</span>
				</p></td>
			<td width="319"
				style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">网
						址：</span>
				</p></td>
		</tr>
		<tr style="height: 34px">
			<td width="319"
				style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">开户银行：${invitationFile.projectInstance.project.organ.khyh00}</span>
				</p></td>
			<td width="319"
				style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">开户银行：${invitationFile.projectInstance.organ.khyh00}</span>
				</p></td>
		</tr>
		<tr style="height: 34px">
			<td width="319"
				style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">帐号：${invitationFile.projectInstance.project.organ.jbzhzh}</span>
				</p></td>
			<td width="319"
				style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
				height="34"><p>
					<span style="font-size: 16px; font-family: 宋体">帐号：${invitationFile.projectInstance.organ.jbzhzh}</span>
				</p></td>
		</tr>
	</tbody>
</table>
<p style="margin: 5px 0; line-height: 33px;text-align: right;">
	<span style="text-decoration:underline;">&nbsp;<fmt:formatDate value="${currentDate}" pattern="yyyy年MM月dd日" type="both" dateStyle="default" timeStyle="default" />&nbsp;</span>
</p>
