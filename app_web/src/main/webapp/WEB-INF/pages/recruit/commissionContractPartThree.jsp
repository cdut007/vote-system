<%@page import="com.mhb.common.util.DateUtils"%>
<%@page import="com.mhb.common.Constants"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set value="${projectInstanceService.createProjectInstanceQuery().projectInstanceId(processBusinessKey).singleResult()}" var="projectInstance"/>
<c:set value="${commissionContractService.retrieveCommissionContractByProjectInstanceId(projectInstance.id)}" var="commissionContract"/>
					<textarea id="commissionContract3" name="commissionContract3" style="width:100%;height:800px;overflow-y:visible;display:none;">
						<p>
							<span style="font-size: 29px;font-family: 宋体"><br clear="all"
								style=";page-break-before:always" /> </span>
						</p>
						<p style="margin: 5px 0">
							<span style="font-size: 16px;font-family: Arial, sans-serif">&nbsp;</span>
						</p>
						<p style="margin-top:auto;text-align:center;line-height:64px">
							<strong><span style="font-size: 32px;font-family: 宋体">第二部分</span></strong><strong><span
								style="font-size: 32px;font-family: Arial, sans-serif">&nbsp;&nbsp;</span></strong><strong><span
								style="font-size: 32px;font-family: 宋体">专用条款</span></strong>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">一、词语定义和适用法律</span></strong>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">2</span><span
								style="font-size: 16px;font-family: 宋体">、合同文件及解释顺序</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">2.1 </span><span
								style="font-size: 16px;font-family: 宋体">合同文件及解释顺序<span
								style="text-decoration:underline;">&nbsp; 本合同协议书 &nbsp;专用条款
									&nbsp;通用条款&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">3</span><span
								style="font-size: 16px;font-family: 宋体">、语言文字和适用法律</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">3.1 </span><span
								style="font-size: 16px;font-family: 宋体">语言文字</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">本合同采用的文字为：<span
								style="text-decoration:underline;">&nbsp; 中文 &nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">3.2 </span><span
								style="font-size: 16px;font-family: 宋体">本合同需要明示的法律、行政法规：<span
								style="text-decoration:underline;">《中华人民共和国合同法》、
									《中华人民共和国招标投标法》</span></span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">二、双方一般权利和义务</span></strong>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">4</span><span
								style="font-size: 16px;font-family: 宋体">、委托人的义务</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">4.1 </span><span
								style="font-size: 16px;font-family: 宋体">委托招标代理工作的具体范围和内容：<span
								style="text-decoration:underline;">发布公告并接受投标单位报名、发售资格预审文件或招标文件、组织标前会、组织开标及评标会议、公示中标结果，发放中标通知书
									、提交招标档案资料。</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">4.2 </span><span
								style="font-size: 16px;font-family: 宋体">委托人应按约定的时间和要求完成下列工作：</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（1）向受托人提供本工程招标代理业务应具备的相关工作前期资料（如立项批准手续、规划许可、报建证等）及资金落实情况资料的时间：<span
								style="text-decoration:underline;">合同订立后五个工作日内</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（2）向受托人提供完全代理招标业务所需的全部资料的时间：<span
								style="text-decoration:underline;">合同订立后五个工作日内</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（3）向受托人提供保证招标工作顺利完成的条件：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（4）指定的与受托人联系的人员</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">姓名：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">职务：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">职称：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">电话：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（5）需要与第三方协调的工作：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（6）应尽的其他义务：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">5</span><span
								style="font-size: 16px;font-family: 宋体">、受托人的义务</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">5.1 </span><span
								style="font-size: 16px;font-family: 宋体">招标代理项目负责人姓名：<span
								style="text-decoration:underline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>身份证号：<span
								style="text-decoration:underline;">&nbsp;&nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">5.2 </span><span
								style="font-size: 16px;font-family: 宋体">受托人应按约定的时间和要求完全下列工作：</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（1）组织招标工作的内容和时间：（<span
								style="text-decoration:underline;">按招标工作的程序写明每项工作的具体内容和时间）发布公告并接受投标单位报名（5个工作日）、发售资格预审文件或招标文件（5个工作日）、组织标前会（开标前15日）、组织开标及评标会议（招标文件发出后20天）、公示中标结果(3-5)天，发放中标通知书
									、提交招标档案资料 （中标通知书后15天内）</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（2）为招标人提供的为完成招标工作的相关咨询服务：<span
								style="text-decoration:underline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（3）承担招标代理业务过程中，应由受托人支付的费用：<span
								style="text-decoration:underline;">开标、评标会务费、专家评审费</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（4）应尽的其他义务：<span
								style="text-decoration:underline;">同通用条款</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">6</span><span
								style="font-size: 16px;font-family: 宋体">、委托人的权利</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">6.1 </span><span
								style="font-size: 16px;font-family: 宋体">委托人拥有的权利：<span
								style="text-decoration:underline;">同通用条款</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">6.2 </span><span
								style="font-size: 16px;font-family: 宋体">委托人拥有的其他权利：<span
								style="text-decoration:underline;">同通用条款</span>&nbsp;
							</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">7</span><span
								style="font-size: 16px;font-family: 宋体">、受托人的权利</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">7.1 </span><span
								style="font-size: 16px;font-family: 宋体">受托人拥有的权利：<span
								style="text-decoration:underline;">同通用条款</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">7.2 </span><span
								style="font-size: 16px;font-family: 宋体">受托人拥有的其他权利：<span
								style="text-decoration:underline;">同通用条款</span></span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">三、委托代理报酬与收取</span></strong>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">8</span><span
								style="font-size: 16px;font-family: 宋体">、委托代理报酬</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">8.1 </span><span
								style="font-size: 16px;font-family: 宋体">代理报酬的计算方法：<span
								style="text-decoration:underline;">&nbsp;
									按国家标准收取&nbsp;&nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">代理报酬的金额或收取比例：<span
								style="text-decoration:underline;">&nbsp;&nbsp; / &nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">代理报酬的币种：<span
								style="text-decoration:underline;">&nbsp; 人民币 &nbsp;</span>&nbsp;&nbsp;汇率：<span
								style="text-decoration:underline;">&nbsp;
									&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">代理报酬的支付方式：<span
								style="text-decoration:underline;">&nbsp;&nbsp;&nbsp; &nbsp;
									&nbsp; &nbsp; / &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">代理报酬的支付时间：<span
								style="text-decoration:underline;">&nbsp;领取中标通知书时同时支付</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">9</span><span
								style="font-size: 16px;font-family: 宋体">、委托代理报酬的收取</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">9.1 </span><span
								style="font-size: 16px;font-family: 宋体">预计委托代理费用额度（比例）：<span
								style="text-decoration:underline;">&nbsp; &nbsp;/&nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">9.3 </span><span
								style="font-size: 16px;font-family: 宋体">逾期支付时，银行贷款利率：<span
								style="text-decoration:underline;">&nbsp;&nbsp; / &nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">9.4 </span><span
								style="font-size: 16px;font-family: 宋体">逾期支付时，应收取的利息：<span
								style="text-decoration:underline;">&nbsp;&nbsp; / &nbsp;&nbsp;</span></span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">四、违约、索赔和争议</span></strong>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">10</span><span
								style="font-size: 16px;font-family: 宋体">、违约</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">10.1 </span><span
								style="font-size: 16px;font-family: 宋体">本合同关于委托人违约的具体责任：</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（1）委托人未按照本合同通用条款第4.2－（3）款的约定，向受托人提供保证招标工作顺利完成的条件应承担的违约责任：<span
								style="text-decoration:underline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（2）委托人未按本合同通用条款第4.2－（6）款的约定，向受托人支付委托代理报酬应承担的违约责任：<span
								style="text-decoration:underline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（3）双方约定的委托人的其他违约责任：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; /&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">10.2 </span><span
								style="font-size: 16px;font-family: 宋体">本合同关于受托人违约的具体责任：</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（1）受托人未按照本合同通用条款第5.2－（2）款的约定，向委托人提供为完成招标工作的咨询服务应承担的责任：<span
								style="text-decoration:underline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（2）受托人违反本合同通用条款第5.4款的约定，接受了与本合同工程建设项目有关的投标咨询业务应承担的违约责任：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; /&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（3）受托人违反本合同通用条款第5.7款的约定，泄露了与本合同工程有关的任何不应泄露的招标资料和情况应承担的违约责任：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; /&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（4）双方约定的受托人的其他违约责任：<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; /&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">12</span><span
								style="font-size: 16px;font-family: 宋体">、争议</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">12.1 </span><span
								style="font-size: 16px;font-family: 宋体">双方约定，凡因执行本合同所发生的与本合同有关的一切争议，当和解或调解不成时，选择下列第<span
								style="text-decoration:underline;">&nbsp; &nbsp; &nbsp;</span>种方式解决：
							</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（1）将争议提交<span
								style="text-decoration:underline;">&nbsp; 合同订立所在地 &nbsp;</span>仲裁委员会仲裁；
							</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">（2）依法向<span
								style="text-decoration:underline;">&nbsp; 合同订立所在地 &nbsp;</span>人民法院提起诉讼。
							</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">六、其他</span></strong>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">16</span><span
								style="font-size: 16px;font-family: 宋体">、合同份数</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">16.2 </span><span
								style="font-size: 16px;font-family: 宋体">双方约定本合同副本<span
								style="text-decoration:underline;">&nbsp;&nbsp;&nbsp;</span>份，其中，委托人
							</span><span style="text-decoration:underline;"><sub><span
									style="font-size: 16px;font-family: Arial, sans-serif">&nbsp;</span></sub></span><span
								style="text-decoration:underline;"><span
								style="font-size: 16px;font-family: 宋体">&nbsp;&nbsp;&nbsp;</span></span><span
								style="font-size: 16px;font-family: 宋体">份，受托人<span
								style="text-decoration:underline;">&nbsp;&nbsp;&nbsp;</span>份。
							</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">17</span><span
								style="font-size: 16px;font-family: 宋体">、补充条款：</span>
						</p>
						<p style="margin: 5px 0;text-indent: 27px;line-height: 24px">
							<span style="text-decoration:underline;"><span
								style="font-size: 13px;font-family: 宋体">&nbsp; &nbsp; &nbsp;
									&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp;/&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span></span><span
								style="text-decoration:underline;"><span
								style="font-size: 16px;font-family: 宋体">&nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp;</span></span>
						</p>
						<p>&nbsp;</p>
						<p>
							<br />
						</p>
					</textarea>
    