<%@page pageEncoding="UTF-8"  import="com.mhb.common.util.DateUtils"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div style="background:#fff;width:400px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">
	<div style="font-family:'仿宋_GB2312';font-size:18px;line-height:28pt; ">
		<p style="text-align:center;height:100px; "></p>
		<p style="text-align:center; ">
			<span style="letter-spacing:0pt; font-weight:bold; font-size:18pt; font-family:'宋体'; ">投标邀请书(代资格预审通过通知书)①</span>
		</p>
		<p style="height:40px;"></p>
		
		<%-- <p style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
				<span style="font-size: 16px;font-family: 宋体">委托人：
				<span style="text-decoration:underline;">&nbsp; ${projectInstance.project.organ.ztmc00} &nbsp;</span></span>
		</p> --%>
		
		<p style="text-align:center; ">
			<span style="letter-spacing:0pt; font-weight:bold; font-size:13pt; font-family:'宋体'; ">
				<span style="text-decoration:underline">&nbsp;${tenderItem.projectInstanceName } &nbsp;</span>
				<span style="text-decoration:underline">&nbsp;${tenderItem.projectItemName } &nbsp;</span>施工投标邀请书②
			</span>
		</p>
		<p style="height:5px;"></p>
		<p style="text-align:left; ">
			<span style="letter-spacing:0pt; font-weight:bold; font-size:12pt; font-family:'宋体'; ">
				<span style="text-decoration:underline">&nbsp;${tenderItem.organBName } &nbsp;</span>:</span>
		</p>
		
		
		<p style="height:5px;"></p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;line-height:20pt;  ">你单位已通过资格预审， 现邀请你单位按招标文件规定的内容， 参加 
				<span style="text-decoration:underline">&nbsp;${tenderItem.projectInstanceName } &nbsp;</span>
				<span style="text-decoration:underline">&nbsp;${tenderItem.projectItemName } &nbsp;</span>施工投标 。</span>
		</p>
		
		<p style="height:5px;"></p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;line-height:20pt;  ">请你单位于
				<span style="text-decoration:underline">&nbsp;<fmt:formatDate value="${recruitFile.tenderNoticeData.applyDateBegin}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;</span>至
				<span style="text-decoration:underline">&nbsp;<fmt:formatDate value="${recruitFile.tenderNoticeData.applyDateEnd}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;</span>，在
				<span style="text-decoration:underline">&nbsp;www.jcebid.com &nbsp;</span>支付相关费用后下载招标文件 。</span>
		</p>
		
		<p style="height:5px;"></p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;line-height:20pt;  ">招标文件每套售价<span style="text-decoration:underline">&nbsp;${projectItem.price } &nbsp;</span>元，图纸每套售价
				<span style="text-decoration:underline">&nbsp; &nbsp;</span>元，招标人根据对本合同工程勘察所取得的水文、地质、气象和料场分布、取土场、弃土场位置等资料编制的参考资料每套售价
				<span style="text-decoration:underline">&nbsp; &nbsp;</span>元， 售后不退③ 。</span>
		</p>
		
		<p style="height:5px;"></p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;line-height:20pt;  ">招标人将于下列时间和地点组织进行工程现场踏勘并召开投标预备会。</span>
		</p>
		
		<p style="height:5px;"></p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;line-height:20pt;  ">踏勘现场时间:
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>年
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>月
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>日
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>时
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>分，集中地点:
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>；</span>
		</p>
		
		<p style="height:5px;"></p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;line-height:20pt;  ">投标预备会时间:
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>年
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>月
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>日
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>时
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>分， 地点:
			<span style="text-decoration:underline">&nbsp; &nbsp;</span>。</span>
		</p>
		
		<p style="height:5px;"></p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;line-height:20pt;  ">投标文件递交的截止时间为	
				<span style="text-decoration:underline">&nbsp;<fmt:formatDate value="${recruitFile.tenderNoticeData.bidDeadline}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;</span>，投标文件递交方式为
				<span style="text-decoration:underline">&nbsp;${recruitFile.tenderNoticeData.bidSendForm} &nbsp;</span>④，投标人应于截止时间之前将投标文件递交至
				<span style="text-decoration:underline">&nbsp;www.jcebid.com &nbsp;</span>，逾期送达的、未送达指定地点的或不按照招标文件要求密封的投标文件，招标人将予以拒收。
			</span>
		</p>
		
		<p style="height:5px;"></p>
		<p style="text-indent:24pt; ">
			<span style="font-size:12pt;line-height:20pt;  ">你单位收到本邀请书后，请于
				<span style="text-decoration:underline">&nbsp;<fmt:formatDate value="${recruitFile.invitation.inviteEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;</span>前，以
				<span style="text-decoration:underline">&nbsp; &nbsp;</span>形式确认是否参加投标 。在本邀请书规定的时间内未表示是否参加投标或明确表示不参加投标的， 不得再参加投标。</span>
		</p>
		
		<p style="height:40px;"></p>
		<p>
			<span style="font-size:10pt;line-height:15pt;  ">①招标人可根据项目具体特点和实际需要对本章内容进行补充、细化，但应遵守«中华人民共和国招标投标法»等有关法律法规的规定。</span>
		</p>
		<p>
			<span style="font-size:10pt;line-height:15pt;  ">②招标人应当自招标文件开始发售之日起， 将招标文件的关键内容上传至具有招t示、监督职责的交通运输主管部门政府网站或者其指定的其他网站上进行公开， 公开内容包括项目概况、 对投标人的全部资格条件要求、 评标办法全文、招标人联系方式等。</span>
		</p>
		<p>
			<span style="font-size:10pt;line-height:15pt;  ">③每套招标文件售价只计工本费，最高不超过1000元(不含图纸部分) ;图纸每套售价最高不超过3000元;参考资料也应只计工本费，最高不超过1000元。</span>
		</p>
		<p>
			<span style="font-size:10pt;line-height:15pt;  ">④依法必须进行招标的公路工程，自招标文件开始发售之日起至投标人递交投标文件截止之日止，不得少于20日。</span>
		</p>
		
		<p style="height:40px;"></p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr style=";height:40px" class="firstRow">
					<td width="350" style="border-width: 1px; padding: 0px 7px;" height="40" id="signdataIdWtr">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">招标人:${tenderItem.organTName }</span>
						</p>
					</td>
					<td width="350"	style="border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-style: none; padding: 0px 7px;" height="40" id="signdataIdStr">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">招标代理机构:${tenderItem.organAName }</span>
						</p>
					</td>
				</tr>
				
				
				<tr style=";height:40px">
					<td width="350"	style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">地  址:</span>
						</p>
					</td>
					<td width="350"	style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">地   址:</span>
						</p>
					</td>
				</tr>
				
				<tr style=";height:40px">
					<td width="350"	style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">邮政编码:</span>
						</p>
					</td>
					<td width="350"	style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">邮政编码:</span>
						</p>
					</td>
				</tr>
				
				<tr style=";height:40px">
					<td width="350"	style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">联系人:</span>
						</p>
					</td>
					<td width="350"	style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">联系人:</span>
						</p>
					</td>
				</tr>
				<tr style=";height:40px">
					<td width="350"	style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">电   话:</span>
						</p>
					</td>
					<td width="350"	style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">电   话:</span>
						</p>
					</td>
				</tr>
				<tr style=";height:40px">
					<td width="350"	style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">传   真:</span>
						</p>
					</td>
					<td width="350"	style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">传   真:</span>
						</p>
					</td>
				</tr>
				<tr style=";height:40px">
					<td width="350"	style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">电子邮件:</span>
						</p>
					</td>
					<td width="350"	style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">电子邮件:</span>
						</p>
					</td>
				</tr>
				<tr style=";height:40px">
					<td width="350"	style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">网   址:</span>
						</p>
					</td>
					<td width="350"	style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">网   址:</span>
						</p>
					</td>
				</tr>
				<tr style=";height:40px">
					<td width="350"	style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">开户银行:</span>
						</p>
					</td>
					<td width="350"	style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">开户银行:</span>
						</p>
					</td>
				</tr>
				<tr style=";height:40px">
					<td width="350"	style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">账   号:</span>
						</p>
					</td>
					<td width="350"	style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;" height="40">
						<p style="line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">账   号:</span>
						</p>
					</td>
				</tr>
				
			</tbody>
		</table>
		
		<p style="line-height: 150%;text-indent: 350px;">
			<span style="font-family: 宋体; font-size: 14px;"><%=DateUtils.getYear()%>年<%=DateUtils.getMonth()%>月<%=DateUtils.getDay()%>日</span>
		</p>
		
		
		
	</div>
	<!--EndFragment-->
</div>