<%@page import="com.mhb.common.util.DateUtils"%>
<%@page import="com.mhb.common.Constants"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set value="${projectInstanceService.createProjectInstanceQuery().projectInstanceId(processBusinessKey).singleResult()}" var="projectInstance"/>
<c:set value="${commissionContractService.retrieveCommissionContractByProjectInstanceId(projectInstance.id)}" var="commissionContract"/>
					<textarea id="commissionContract" name="commissionContract" style="width:100%;height:800px;overflow-y:visible;display:none;">
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">GF-2005-0215</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom:5px;margin-left:0;text-align:center">
							<strong><span style="font-size: 48px;line-height:48px;font-family: 宋体"><%-- ${projectInstance.zbxmmc} --%>建设工程招标代理合同</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom:5px;margin-left:0;text-align:center;text-indent:16px">
							<strong><span style="font-size: 48px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:16px;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:16px;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:16px;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:16px;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:16px;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:16px;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:16px;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:16px;line-height:27px">
							<strong><span style="font-size: 16px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:24px">
							<strong><span style="font-size: 21px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:24px">
							<strong><span style="font-size: 21px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:24px">
							<strong><span style="font-size: 21px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p style="margin: 5px 0;text-indent: 192px;line-height: 24px">
							<span style="margin-left:180px; font-size: 21px;font-family: 宋体">中华人民共和国建设部</span>
						</p>
						<p style="margin: 5px 0;text-indent: 428px;line-height: 24px">
							<span style="margin-left:180px; font-size: 21px;font-family: 宋体">制定</span>
						</p>
						<p style="margin: 5px 0;text-indent: 192px;line-height: 24px">
							<span style="margin-left:180px; font-size: 21px;font-family: 宋体">国家工商行政管理总局&nbsp;</span>
						</p>
						<p style="margin: 5px 0;line-height: 51px">
							<strong><span style="font-size: 29px;font-family: 宋体">&nbsp;</span></strong>
						</p>
						<p style="margin: 5px 0;text-indent: 192px;line-height: 24px">
							<span style="font-size: 21px;font-family: 宋体">&nbsp;</span>
						</p>
						<p style="margin-top:auto;text-align:center;line-height:64px">
							<strong><span style="font-size: 32px;font-family: 宋体"><%-- ${projectInstance.zbxmmc} --%>建设工程招标代理协议书</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">委托人：<span
								style="text-decoration:underline;">&nbsp; ${projectInstance.project.organ.ztmc00} &nbsp;</span></span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">受托人：<span
								style="text-decoration:underline;">&nbsp; ${projectInstance.organ.ztmc00} &nbsp;</span></span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">&nbsp;</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">依照《中华人民共和国合同法》、
								《中华人民共和国招标投标法》、《中华人民共和国招标投标法实施条例》及国家的有关法律、行政法规，遵循平等、
								自愿、公平和诚实信用的原则，双方就<span style="text-decoration:underline;">&nbsp;${projectInstance.zbxmmc}&nbsp;</span>招标代理事项协商一致，订立本合同。
							</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">一、工程概况</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 33px">
							<span style="font-size: 16px;font-family: 宋体">工程名称：<span
								style="text-decoration:underline;">&nbsp; ${projectInstance.zbxmmc} &nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 33px">
							<span style="font-size: 16px;font-family: 宋体">地&nbsp;&nbsp;点：<span
								style="text-decoration:underline;">&nbsp; ${projectInstance.project.xmdz00} &nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 33px">
							<span style="font-size: 16px;font-family: 宋体">规&nbsp;&nbsp;模：<span
								style="text-decoration:underline;">&nbsp; ${projectInstance.project.xmgm00} &nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 33px">
							<span style="font-size: 16px;font-family: 宋体">招标范围：<span
								style="text-decoration:underline;">&nbsp; ${projectInstance.nryfw0} &nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 33px">
							<span style="font-size: 16px;font-family: 宋体">总投资额：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp;
									&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span></span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">二、委托人委托受托人为<span
								style="text-decoration:underline;">&nbsp; ${projectInstance.zbxmmc} &nbsp;</span>工程建设项目的招标代理机构，承担本工程的<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp;</span>招标代理工作。
							</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">三、合同价款</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">代理报酬<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp;</span></span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">四、组成本合同的文件：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">1</span><span
								style="font-size: 16px;font-family: 宋体">、本合同履行过程中双方以书面形式签署的补充和修正文件；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">2</span><span
								style="font-size: 16px;font-family: 宋体">、本合同协议书；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">3</span><span
								style="font-size: 16px;font-family: 宋体">、本合同专用条款；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">4</span><span
								style="font-size: 16px;font-family: 宋体">、本合同通用条款。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">五、本协议书中的有关词语定义与本合同第一部分《通用条款》中分别赋予它们的定义相同。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">六、受托人向委托人承诺，按照本合同的约定，承担本合同专用条款中约定范围内的代理业务。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">七、委托人向受托人承诺，按照本合同的约定，确保代理报酬的支付。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">八、合同订立</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">合同订立时间：<span
								style="text-decoration:underline;">&nbsp; <%=DateUtils.getYear()%> &nbsp;</span>年<span
								style="text-decoration:underline;">&nbsp; <%=DateUtils.getMonth() %> &nbsp;</span>月<span
								style="text-decoration:underline;">&nbsp; <%=DateUtils.getDay() %> &nbsp;</span>日
							</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">合同订立地点：<span
								style="text-decoration:underline;">&nbsp; <%=Constants.PLATFORM_NAME %> &nbsp;</span></span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">九、合同生效</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
							<span style="font-size: 16px;font-family: 宋体">本合同双方约定<span
								style="text-decoration:underline;">&nbsp; 签字或盖章 &nbsp;</span>后生效。
							</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">&nbsp;</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">&nbsp;</span>
						</p>
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<tr style=";height:65px" class="firstRow">
									<td width="319" style="border-width: 1px; padding: 0px 7px;"
										height="65" id="signdataIdWtr"><p style="line-height:24px">
											<span style="font-size: 16px;font-family: 宋体">委托人（盖章）：${projectInstance.project.organ.ztmc00}</span>
										</p></td>
									<td width="319"
										style="border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-style: none; padding: 0px 7px;"
										height="65" id="signdataIdStr"><p style="line-height:24px">
											<span style="font-size: 16px;font-family: 宋体">受托人（盖章）：${projectInstance.organ.ztmc00}</span>
										</p></td>
								</tr>
								<tr style=";height:65px">
									<td width="319"
										style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
										height="65"><p style="line-height:24px">
											<span style="font-size: 16px;font-family: 宋体">法定代表人（签字或盖章）：</span>
										</p></td>
									<td width="319"
										style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
										height="65"><p style="line-height:24px">
											<span style="font-size: 16px;font-family: 宋体">法定代表人（签字或盖章）：</span>
										</p></td>
								</tr>
								<tr style=";height:65px">
									<td width="319"
										style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
										height="65"><p style="line-height:24px">
											<span style="font-size: 16px;font-family: 宋体">授权代理人（签字或盖章）：</span>
										</p></td>
									<td width="319"
										style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
										height="65"><p style="line-height:24px">
											<span style="font-size: 16px;font-family: 宋体">授权代理人（签字或盖章）：</span>
										</p></td>
								</tr>
								<tr>
									<td width="319"
										style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"><p
											style="line-height:24px">
											<span style="font-size: 16px;font-family: 宋体">单位地址：${projectInstance.project.organ.address}</span>
										</p></td>
									<td width="319"
										style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"><p
											style="line-height:24px">
											<span style="font-size: 16px;font-family: 宋体">单位地址：${projectInstance.organ.address}</span>
										</p></td>
								</tr>
								<tr style=";height:34px">
									<td width="319"
										style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">邮政编码：${projectInstance.project.organ.zipCode}</span>
										</p></td>
									<td width="319"
										style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">邮政编码：${projectInstance.organ.zipCode}</span>
										</p></td>
								</tr>
								<tr style=";height:34px">
									<td width="319"
										style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">联系电话：${projectInstance.project.organ.phone}</span>
										</p></td>
									<td width="319"
										style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">联系电话：${projectInstance.organ.phone}</span>
										</p></td>
								</tr>
								<tr style=";height:34px">
									<td width="319"
										style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">传真：${projectInstance.project.organ.faxNo}</span>
										</p></td>
									<td width="319"
										style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">传真：${projectInstance.organ.faxNo}</span>
										</p></td>
								</tr>
								<tr style=";height:34px">
									<td width="319"
										style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">电子信箱：${projectInstance.project.organ.email}</span>
										</p></td>
									<td width="319"
										style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">电子信箱：${projectInstance.organ.email}</span>
										</p></td>
								</tr>
								<tr style=";height:34px">
									<td width="319"
										style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">开户银行：${projectInstance.project.organ.khyh00}</span>
										</p></td>
									<td width="319"
										style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">开户银行：${projectInstance.organ.khyh00}</span>
										</p></td>
								</tr>
								<tr style=";height:34px">
									<td width="319"
										style="border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: none; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">帐号：${projectInstance.project.organ.jbzhzh}</span>
										</p></td>
									<td width="319"
										style="border-top-style: none; border-left-style: none; border-bottom-width: 1px; border-right-width: 1px; padding: 0px 7px;"
										height="34"><p>
											<span style="font-size: 16px;font-family: 宋体">帐号：${projectInstance.organ.jbzhzh}</span>
										</p></td>
								</tr>
							</tbody>
						</table>
						<p>
							<strong><span style="font-size: 29px;font-family: 仿宋_GB2312"><br
									clear="all" style=";page-break-before:always" /> </span></strong>
						</p>
						</textarea>
    