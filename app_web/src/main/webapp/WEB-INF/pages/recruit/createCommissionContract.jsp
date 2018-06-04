<%@page import="com.mhb.common.util.DateUtils"%>
<%@page import="com.mhb.common.Constants"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${projectInstanceService.createProjectInstanceQuery().projectInstanceId(processBusinessKey).singleResult()}" var="projectInstance"/>
<c:set value="${commissionContractService.retrieveCommissionContractByProjectInstanceId(projectInstance.id)}" var="commissionContract"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		$("#sub").click(function() {
			$.messager.confirm("系统提示", "确认将合同传给代理机构确认签章？", function(r) {
				if (r) {
					$("#wthtForm").submit();
				}
			});
		});
		var ue1 = UE.getEditor('commissionContract', {
			toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|', 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols' ] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		});
		var ue2 = UE.getEditor('commissionContract2', {
			toolbars : [ [ 'fullscreen'] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		});
		var ue3 = UE.getEditor('commissionContract3', {
			toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|', 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols' ] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		});
	
		
		ue1.addListener('ready',function(){
			$("#commissionContract").show();
			$("#commissionContract2_div").show();
			$("#commissionContract3").show();
			$("#sub").show();
		 })
		
		
	
		
	});

</script>
<!-- <script type="text/javascript">
var id="${projectInstance.id}"
alert(id);
</script> -->
<title>创建合同</title>
<style type="text/css">
form {
	margin: 0;
}

textarea {
	display: block;
}

.mytable td {
	border-bottom: #eee 1px dashed;
}

span.fill {
	font-weight: 500;
	text-decoration: underline;
	font-family: 楷体;
	font-size: 15px;
	font-style: italic;
}

.user_write {
	font-size: 14px;
	font-style: italic;
	text-decoration: underline;
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			制作委托代理合同
		</div>
		<!-- <div class="AreaL" style="height:500px;">
			<div class="left_cp">模板列表</div>
			<div class="allsort fl allsorthover">
				<div class="ap_category" id="ap_category" style="width:184px">
					<div class="mc" style="padding-bottom:8px;height:500px;">
						<span><a href="#">系统模板</a></span><br /> 
						<span style="padding-left:20px"><a href="#">系统模板一</a></span><br /> 
						<span style="padding-left:20px"><a href="#">系统模板二</a></span><br /> 
						<span style="padding-left:20px"><a href="#">系统模板三</a></span><br /> 
						<span style="padding-left:20px"><a href="#">系统模板四</a></span><br /> 
						<span style="padding-left:20px"><a href="#">系统模板五</a></span><br /> <br /> 
						<span><a href="#">自定义模板</a></span><br /> 
						<span style="padding-left:20px"><a href="#">自定义模板一</a></span><br /> 
						<span style="padding-left:20px"><a href="#">自定义模板二</a></span><br /> 
						<span style="padding-left:20px"><a href="#">自定义模板三</a></span><br /> 
						<span style="padding-left:20px"><a href="#">自定义模板四</a></span><br /> 
						<span style="padding-left:20px"><a href="#">自定义模板五</a></span><br />
					</div>
				</div>
			</div>
		</div>
		<div class="AreaR"> -->
			<div class="usBox">
				<form id="wthtForm" method="post" action="${pageContext.request.contextPath}/commissionContract/completeFormEntrust">
					<input type='hidden' name='taskId' value='${taskId}' /> 
					<input type='hidden' name='id' value='${t_wtht.id}' />
					<input type='hidden' name='projectInstanceId' value='${projectInstance.id}' />
					<c:if test="${not empty commissionContract.reason}">
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">异议内容是:${commissionContract.reason}</span></strong>
						</p>
					</c:if>
					<p>&nbsp;&nbsp;</p>
					<c:choose>
						<c:when test="${not empty commissionContract.contentPartOne}">
							<textarea id="commissionContract" name="commissionContract" style="width:100%;height:800px;overflow-y:visible; display:none;">
									${commissionContract.contentPartOne}
							</textarea>
						</c:when>
						<c:otherwise>
							<jsp:include page="commissionContractPartOne.jsp" />
						</c:otherwise>
					</c:choose>	
				
					
					
					<textarea id="commissionContract2" name="commissionContract2" style="width:100%;height:800px;overflow-y:visible; display: none;">
						<p style="margin: 5px 0">
							<span style="font-size: 16px;font-family: Arial, sans-serif">&nbsp;</span>
						</p>
						<p style="margin-top:auto;text-align:center;line-height:64px">
							<strong><span style="font-size: 32px;font-family: 宋体">第一部分</span></strong><strong><span
								style="font-size: 32px;font-family: Arial, sans-serif"> </span></strong><strong><span
								style="font-size: 32px;font-family: 宋体">通用条款</span></strong>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">一、词语定义和适用法律</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1</span><span
								style="font-size: 16px;font-family: 宋体">、词语定义</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">下列词语除本合同专用条款另有约定外，应具有本条款所赋予的定义：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">l.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">招标代理合同：委托人将工程建设项目招标工作委托给具有相应招标代理资质的受托人，实施招标活动签订的委托合同，</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">l.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">通用条款：是根据有关法律、行政法规和工程建设项目招标代理的需要所订立，通用于各类工程建设项目招标代理的条款。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">专用条款：是委托人与受托人根据有关法律、行政法规规定，结合具体工程建设项目招标代理的实际，经协商达成一致意见的条款，是对通用条款的具体化、补充或修改。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">l.4&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人：指在合同中约定的，具有建设项目招标委托主体资格的当事人，以及取得该当事人资格的合法继承人。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.5&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人：指在合同中约定的，被委托人接受的具有建设项目招标代理主体资格的当事人，以及取得该当事人资格的合法继承人。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.6&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">招标代理项目负责人：指受托人在专用条款中指定的负责合同履行的代表。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.7&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">工程建设项目：指由委托人和受托人在合同中约定的委托代理招标的工程。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.8&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">招标代理业务：委托人委托受托人代理实施工程建设项目招标的工作内容。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.9&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">附加服务：指委托人和受托人在本合同通用条款4.1款和专用条款4.1款中双方约定工作范围之外的附加工作。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.10&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">代理报酬：委托人和受托人在合同中约定的，受托人按照约定应收取的代理报酬总额。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.11&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">图纸：指由委托人提供的满足招标需要的所有图纸、计算书、配套说明以及相关的技术资料。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.12&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">书面形式：指具有公章、法定代表人或授权代理人签字的合同书、信件和数据电文（包括电报、电传、传真）等可以有形地表现所载内容的形式。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.13&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">违约责任：指合同一方不履行合同义务或履行合同义务不符合约定所应承担的责任。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.14&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">索赔：指在合同履行过程中，对于并非自己的过错，而是应由对方承担责任的情况造成的实际损失，向对方提出经济补偿或其他的要求。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.15&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">不可抗力：指双方无法控制和不可预见的事件，但不包括双方的违约或疏忽。这些事件包括但不限于战争、严重火灾、洪水、台风、地震，或其他双方一致认为属于不可抗力的事件。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.16&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">小时或天：本合同中规定按小时计算时间的，从事件有效开始时计算（不扣除休息时间）；规定按天计算时间的，开始当天不计入，从次日开始计算。时限的最后一天是休息日或者其他法定节假日的，以节假日次日为时限的最后一天。时限的最后一天的截止时间为当日24时。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">2</span><span
								style="font-size: 16px;font-family: 宋体">、合同文件及解释顺序</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">2.l&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">合同文件应能互相解释，互为说明。除本合同专用条款另有约定外，组成本合同的文件及优先解释顺序如下：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）本合同履行过程中双方以书面形式签署的补充和修正文件；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）本合同协议书：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）本合同专用条款；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）本合同通用条款。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">2.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">当合同文件内容出现含糊不清或不相一致时，应在不影响招标代理业务正常进行的情况下，由委托人和受托人协商解决。双方协商不成时，按本合同通用条款第12条关于争议的约定处理。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">3</span><span
								style="font-size: 16px;font-family: 宋体">、语言文字和适用法律</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">3.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">语言文字</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">除本合同专用条款中另有约定，本合同文件使用汉语语言文字书写、解释和说明。如本合同专用条款约定使用两种以上（含两种）语言文字时，汉语应为解释和说明本合同的标准语言文字。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">3.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">适用法律和行政法规</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">本合同文件适用有关法律和行政法规。需要明示的法律和行政法规，双方可在本合同专用条款中约定。</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">二、双方一般权利和义务</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4</span><span
								style="font-size: 16px;font-family: 宋体">、委托人的义务</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人将委托招标代理工作的具体范围和内容在本合同专用条款中约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人按本合同专用条款约定的内容和时间完成下列工作：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）向受托人提供本工程招标代理业务应具备的相关工程前期资料（如立项批准手续规划许可、报建证等）及资金落实情况资料；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）向受托人提供完成本工程招标代理业务所需的全部技术资料和图纸，需要交底的须向受托人详细交底，并对提供资料的真实性、完整性、准确性负责；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）向受托人提供保证招标工作顺利完成的条件，提供的条件在本合同专用条款内约定；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）指定专人与受托人联系，指定人员的姓名、职务、职称在本合同专用条款内约定；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（5）根据需要，作好与第三方的协调工作；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（6）按本合同专用条款的约定支付代理报酬；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（7）依法应尽的其他义务，双方在本合同专用条款内约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人在履行招标代理业务过程中，提出的超出招标代理范围的合理化建议，经委托人同意并取得经济效益，委托人应向受托人支付一定的经济奖励。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4.4&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人负有对受托人为本合同提供的技术服务进行知识产权保护的责任。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4.5&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人未能履行以上各项义务，给受托人造成损失的，应当赔偿受托人的有关损失。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5</span><span
								style="font-size: 16px;font-family: 宋体">、受托人的义务</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人应根据本合同专用条款中约定的委托招标代理业务的工作范围和内容，选择有足够经验的专职技术经济人员担任招标代理项目负责人。招标代理项目负责人的姓名、身份证号在专用条款内写明。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人按本合同专用条款约定的内容和时间完成下列工作：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）依法按照公开、公平、公正和诚实信用原则，
								组织招标工作，维护各方的合法权益；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）应用专业技术与技能为委托人提供完成招标工作相关的咨询服务；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）向委托人宣传有关工程招标的法律、行政法规和规章，解释合理的招标程序，&nbsp;
								以便得到委托人的支持和配合；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）依法应尽的其他义务，双方在本合同专用条款内约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人应对招标工作中受托人所出具有关数据的计算、技术经济资料等的科学性和准确性负责。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.4&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人不得接受与本合同工程建设项目中委托招标范围之内的相关的投标咨询业务。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.5&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人为本合同提供技术服务的知识产权应属受托人专有。任何第三方如果提出侵权指控，受托人须与第三方交涉并承担由此而引起的一切法律责任和费用。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.6&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">未经委托人同意，受托人不得分包或转让本合同的任何权利和义务。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.7&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人不得接受所有投标人的礼品、宴请和任何其它好处，不得泄露招标、评标、定标过程中依法需要保密的内容。合同终止后，未经委托人同意，受托人不得泄漏与本合同工程相关的任何招标资料和情况。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.8&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人未能履行以上各项义务，给委托人造成损失的，应当赔偿委托人的有关损失。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">6</span><span
								style="font-size: 16px;font-family: 宋体">、委托人的权利</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">6.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人拥有下列权利：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）按合同约定，接收招标代理成果；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）向受托人询问本合同工程招标工作进展情况和相关内容或提出不违反法律、行政法规的建议；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）审查受托人为本合同工程编制的各种文件，并提出修正意见；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）要求受托人提交招标代理业务工作报告；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（5）与受托人协商，建议更换其不称职的招标代理从业人员；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（6）依法选择中标人；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（7）本合同履行期间，由于受托人不履行合同约定的内容，给委托人造成损失或影响招标工作正常进行的，委托人有权终止本合同，并依法向受托人追索经济赔偿，直至追究法律责任；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（8）依法享有的其他权利，双方在本合同专用条款内约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">7</span><span
								style="font-size: 16px;font-family: 宋体">、受托人的权利</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">7.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人拥有下列权利：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）按合同约定收取委托代理报酬；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）对招标过程中应由委托人做出的决定，受托人有权提出建议；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）当委托人提供的资料不足或不明确时，有权要求委托人补足资料或作出明确的答复；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）拒绝委托人提出的违反法律、行政法规的要求，并向委托人作出解释；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（5）有权参加委托人组织的涉及招标工作的所有会议和活动；&nbsp;&nbsp;&nbsp;</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（6）对于为本合同工程编制的所有文件拥有知识产权，委托人仅有使用或复制的权利；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（7）依法享有的其他权利，双方在本合同专用条款内约定。</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">三、委托代理报酬与收取</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">8</span><span
								style="font-size: 16px;font-family: 宋体">、委托代理报酬</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">8.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">双方按照本合同约定的招标代理业务范围，在本合同专用条款内约定委托代理报酬的计算方法、金额、币种、汇率和支付方式、支付时间。</span><span
								style="font-size:16px;font-family:宋体;color:red">&nbsp;&nbsp;</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">8.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人对所承接的招标代理业务需要出外考察的，其外出人员数量和费用，经委托人同意后，向委托人实报实销。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">8.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">在招标代理业务范围内所发生的费用（如：评标会务费、评标专家的差旅费、劳务费、公证费等），由委托人与受托人在补充条款中约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9</span><span
								style="font-size: 16px;font-family: 宋体">、委托代理报酬的收取</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">由委托人支付代理报酬的，在本合同签订后10日内，委托人应向受托人支付不少于全部代理报酬20％的代理预付款，具体额度（或比例）双方在专用条款内约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">由中标人支付代理报酬的，在中标人与委托人签订承包合同5日内，将本合同约定的全部委托代理报酬一次性支付给受托人。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人完成委托人委托的招标代理工作范围以外的工作，为附加服务项目，应收取的报酬由双方协商，签订补充协议。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人在本合同专用条款约定的支付时间内，未能如期支付代理预付费用，自应支付之日起，按同期银行贷款利率，计算支付代理预付费用的利息。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9.4&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人在本合同专用条款约定的支付时间内，未能如期支付代理报酬，除应承担违约责任外，还应按同期银行贷款利率，计算支付应付代理报酬的利息。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9.5&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托代理报酬应由委托人按本合同专用条款约定的支付方法和时间，直接向受托人支付；或受托人按照约定直接向中标人收取。</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">四、违约、索赔和争议</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">10</span><span
								style="font-size: 16px;font-family: 宋体">、违约</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">10.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人违约。 当发生下列情况时：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）本合同通用条款第4.2
								-（3）款提到的委托人未按本合同专用条款的约定向委托人提供为保证招标工作顺利完成的条件，致使招标工作无法进行；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）本合同通用条款第4.2
								-（6）款提到的委托人未按本合同专用条款的约定向受托人支付委托代理报酬；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）委托人不履行合同义务或不按合同约定履行义务的其他情况。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">委托人承担违约责任，赔偿因其违约给受托人造成的经济损失，双方在本合同专用条款内约定委托人赔偿受托人损失的计算方法或委托人应当支付违约金的数额或计算方法。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">10.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人违约。 当发生下列情况时：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）本合同通用条款第5.2
								-（2）款提到的受托人未按本合同专用条款的约定，向委托人提供为完成招标工作的咨询服务；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）本合同通用条款第5.4款提到的受托人未按本合同专用条款的约定，接受了与本合同工程建设项目有关的投标咨询业务；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）本合同通用条款第5.7款提到的受托人未按本合同专用条款的约定，泄露了与本合同工程相关的任何招标资料和情况；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）受托人不履行合同义务或不按合同约定履行义务的其他情况。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">受托人承担违约责任，赔偿因其违约给委托人造成的经济损失，双方在本合同专用条款内约定受托人赔偿委托人损失的计算方法或受托人应当支付违约金的数额或计算方法。受托人承担违约责任，赔偿金额最高不应超过委托代理报酬的金额（扣除税金）。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">10.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">第三方违约。如果一方的违约被认定为是与第三方共同造成的，则应由合同双方中有违约的一方先行向另一方承担全部违约责任，再由承担违约责任的一方向第三方追索。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">11</span><span
								style="font-size: 16px;font-family: 宋体">、索赔</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">11.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">当事人一方向另一方提出索赔时，要有正当的索赔理由，且有索赔事件发生时的有效证据。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">11.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人未能按合同约定履行自己的各项义务，或者发生应由委托人承担责任的其他情况，给受托人造成损失，受托人可按下列程序以书面形式向委托人索赔：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）索赔事件发生后7天内，向委托人发出索赔报告及有关资料；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）委托人收到受托人的索赔报告及有关资料后，于7天内给予答复，或要求受托人进一步补充索赔理由和证据；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）委托人在收到受托人送交的索赔报告和有关资料后7天内未予答复，或未对受托人作进一步要求，视为该项索赔已经认可。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">11.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人未能按合同约定履行自己的各项义务，或者发生应由受托人承担责任的其他情况，给委托人造成经济损失，委托人可按11.2款确定的时限和程序向受托人提出索赔。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">12</span><span
								style="font-size: 16px;font-family: 宋体">、争议</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">12.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人和受托人履行合同时发生争议，可以和解或者向有关部门或机构申请调解。当事人不愿和解、调解或者和解、调解不成的，双方可以在本合同专用条款约定以下一种方式解决争议：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）双方达成仲裁协议，向约定的仲裁委员会申请仲裁；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）向有管辖权的人民法院起诉。</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">五、合同变更、生效与终止</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">13</span><span
								style="font-size: 16px;font-family: 宋体">、合同变更或解除</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">13.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">本合同签订后，由于委托人原因，使得受托人不能持续履行招标代理业务时，委托人应及时通知受托人暂停招标代理业务。当需要恢复招标代理业务时，应当在正式恢复前7天通知受托人。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">若暂停时间超过六个月，当需要恢复招标代理业务时，委托人应支付重新启动该招标代理工作一定的补偿费用，具体计算方式经双方协商以补充协议确定。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">13.2 </span><span
								style="font-size: 16px;font-family: 宋体">本合同签订后，如因法律、行政法规发生变化或由于任何后续新颁布的法律、行政法规导致服务所需的成本或时间发生改变，则本合同约定的服务报酬和服务期限由双方签订补充协议进行相应调整。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">13.3 </span><span
								style="font-size: 16px;font-family: 宋体">本合同当事人一方要求变更或解除合同时，除法律、行政法规另有规定外，应与对方当事人协商一致并达成书面协议。未达成书面协议的，本合同依然有效。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">13.4 </span><span
								style="font-size: 16px;font-family: 宋体">因解除合同使当事人一放遭受损失的，除依法可以免除责任外，应由责任方负责赔偿对方的损失，赔偿方法与金额由双方在协议书约定。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">14</span><span
								style="font-size: 16px;font-family: 宋体">、合同生效</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">14.1 </span><span
								style="font-size: 16px;font-family: 宋体">除生效条件双方在协议书中另有约定外，本合同自双方签字盖章之日起生效。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">15</span><span
								style="font-size: 16px;font-family: 宋体">、合同终止</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">15.1 </span><span
								style="font-size: 16px;font-family: 宋体">受托人完成委托人全部委托招标代理业务，且委托人或中标人支付了全部代理报酬（含附加服务的报酬）后本合同终止。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">15.2 </span><span
								style="font-size: 16px;font-family: 宋体">本合同终止并不影响各方应有的权利和应承担的义务。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">15.3 </span><span
								style="font-size: 16px;font-family: 宋体">因不可抗力，致使当事人一方或双方不能履行本合同时，双方应协商确定本合同继续履行的条件或终止本合同。如果双方不能就本合同继续履行的条件或终止本合同达成一致意见，本合同自行终止。除委托人应付给受托人已完成工作的报酬外，各自承担相应的损失。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">15.4 </span><span
								style="font-size: 16px;font-family: 宋体">本合同的权利和义务终止后，委托人和受托人应当遵循诚实信用原则，履行通知、协助、保密等义务。</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">六、其他</span></strong>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">16</span><span
								style="font-size: 16px;font-family: 宋体">、合同的份数</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">16.1 </span><span
								style="font-size: 16px;font-family: 宋体">本合同正本一式两份，委托人和受托人各执一份。副本根据双方需要在本合同专用条款内约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">17</span><span
								style="font-size: 16px;font-family: 宋体">、补充条款</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">双方根据有关法律、行政法规规定，结合本合同招标工程实际，经协商一致后，可对本合同通用条款未涉及的内容进行补充。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom:5px;margin-left:0;text-align:center;line-height:32px">
							<span style="font-size: 16px;font-family: Arial, sans-serif">&nbsp;</span>
						</p>

					</textarea>
					<div style="width:100%; display:none;" id="commissionContract2_div">
						<p style="margin: 5px 0">
							<span style="font-size: 16px;font-family: Arial, sans-serif">&nbsp;</span>
						</p>
						<p style="margin-top:auto;text-align:center;line-height:64px">
							<strong><span style="font-size: 32px;font-family: 宋体">第一部分</span></strong><strong><span
								style="font-size: 32px;font-family: Arial, sans-serif">&nbsp;&nbsp;</span></strong><strong><span
								style="font-size: 32px;font-family: 宋体">通用条款</span></strong>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">一、词语定义和适用法律</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1</span><span
								style="font-size: 16px;font-family: 宋体">、词语定义</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">下列词语除本合同专用条款另有约定外，应具有本条款所赋予的定义：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">l.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">招标代理合同：委托人将工程建设项目招标工作委托给具有相应招标代理资质的受托人，实施招标活动签订的委托合同，</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">l.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">通用条款：是根据有关法律、行政法规和工程建设项目招标代理的需要所订立，通用于各类工程建设项目招标代理的条款。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">专用条款：是委托人与受托人根据有关法律、行政法规规定，结合具体工程建设项目招标代理的实际，经协商达成一致意见的条款，是对通用条款的具体化、补充或修改。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">l.4&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人：指在合同中约定的，具有建设项目招标委托主体资格的当事人，以及取得该当事人资格的合法继承人。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.5&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人：指在合同中约定的，被委托人接受的具有建设项目招标代理主体资格的当事人，以及取得该当事人资格的合法继承人。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.6&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">招标代理项目负责人：指受托人在专用条款中指定的负责合同履行的代表。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.7&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">工程建设项目：指由委托人和受托人在合同中约定的委托代理招标的工程。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.8&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">招标代理业务：委托人委托受托人代理实施工程建设项目招标的工作内容。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.9&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">附加服务：指委托人和受托人在本合同通用条款4.1款和专用条款4.1款中双方约定工作范围之外的附加工作。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.10&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">代理报酬：委托人和受托人在合同中约定的，受托人按照约定应收取的代理报酬总额。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.11&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">图纸：指由委托人提供的满足招标需要的所有图纸、计算书、配套说明以及相关的技术资料。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.12&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">书面形式：指具有公章、法定代表人或授权代理人签字的合同书、信件和数据电文（包括电报、电传、传真）等可以有形地表现所载内容的形式。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.13&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">违约责任：指合同一方不履行合同义务或履行合同义务不符合约定所应承担的责任。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.14&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">索赔：指在合同履行过程中，对于并非自己的过错，而是应由对方承担责任的情况造成的实际损失，向对方提出经济补偿或其他的要求。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.15&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">不可抗力：指双方无法控制和不可预见的事件，但不包括双方的违约或疏忽。这些事件包括但不限于战争、严重火灾、洪水、台风、地震，或其他双方一致认为属于不可抗力的事件。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">1.16&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">小时或天：本合同中规定按小时计算时间的，从事件有效开始时计算（不扣除休息时间）；规定按天计算时间的，开始当天不计入，从次日开始计算。时限的最后一天是休息日或者其他法定节假日的，以节假日次日为时限的最后一天。时限的最后一天的截止时间为当日24时。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">2</span><span
								style="font-size: 16px;font-family: 宋体">、合同文件及解释顺序</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">2.l&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">合同文件应能互相解释，互为说明。除本合同专用条款另有约定外，组成本合同的文件及优先解释顺序如下：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）本合同履行过程中双方以书面形式签署的补充和修正文件；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）本合同协议书：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）本合同专用条款；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）本合同通用条款。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">2.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">当合同文件内容出现含糊不清或不相一致时，应在不影响招标代理业务正常进行的情况下，由委托人和受托人协商解决。双方协商不成时，按本合同通用条款第12条关于争议的约定处理。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">3</span><span
								style="font-size: 16px;font-family: 宋体">、语言文字和适用法律</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">3.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">语言文字</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">除本合同专用条款中另有约定，本合同文件使用汉语语言文字书写、解释和说明。如本合同专用条款约定使用两种以上（含两种）语言文字时，汉语应为解释和说明本合同的标准语言文字。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">3.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">适用法律和行政法规</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">本合同文件适用有关法律和行政法规。需要明示的法律和行政法规，双方可在本合同专用条款中约定。</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">二、双方一般权利和义务</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4</span><span
								style="font-size: 16px;font-family: 宋体">、委托人的义务</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人将委托招标代理工作的具体范围和内容在本合同专用条款中约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人按本合同专用条款约定的内容和时间完成下列工作：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）向受托人提供本工程招标代理业务应具备的相关工程前期资料（如立项批准手续规划许可、报建证等）及资金落实情况资料；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）向受托人提供完成本工程招标代理业务所需的全部技术资料和图纸，需要交底的须向受托人详细交底，并对提供资料的真实性、完整性、准确性负责；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）向受托人提供保证招标工作顺利完成的条件，提供的条件在本合同专用条款内约定；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）指定专人与受托人联系，指定人员的姓名、职务、职称在本合同专用条款内约定；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（5）根据需要，作好与第三方的协调工作；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（6）按本合同专用条款的约定支付代理报酬；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（7）依法应尽的其他义务，双方在本合同专用条款内约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人在履行招标代理业务过程中，提出的超出招标代理范围的合理化建议，经委托人同意并取得经济效益，委托人应向受托人支付一定的经济奖励。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4.4&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人负有对受托人为本合同提供的技术服务进行知识产权保护的责任。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">4.5&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人未能履行以上各项义务，给受托人造成损失的，应当赔偿受托人的有关损失。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5</span><span
								style="font-size: 16px;font-family: 宋体">、受托人的义务</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人应根据本合同专用条款中约定的委托招标代理业务的工作范围和内容，选择有足够经验的专职技术经济人员担任招标代理项目负责人。招标代理项目负责人的姓名、身份证号在专用条款内写明。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人按本合同专用条款约定的内容和时间完成下列工作：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）依法按照公开、公平、公正和诚实信用原则，
								组织招标工作，维护各方的合法权益；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）应用专业技术与技能为委托人提供完成招标工作相关的咨询服务；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）向委托人宣传有关工程招标的法律、行政法规和规章，解释合理的招标程序，&nbsp;
								以便得到委托人的支持和配合；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）依法应尽的其他义务，双方在本合同专用条款内约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人应对招标工作中受托人所出具有关数据的计算、技术经济资料等的科学性和准确性负责。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.4&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人不得接受与本合同工程建设项目中委托招标范围之内的相关的投标咨询业务。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.5&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人为本合同提供技术服务的知识产权应属受托人专有。任何第三方如果提出侵权指控，受托人须与第三方交涉并承担由此而引起的一切法律责任和费用。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.6&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">未经委托人同意，受托人不得分包或转让本合同的任何权利和义务。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.7&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人不得接受所有投标人的礼品、宴请和任何其它好处，不得泄露招标、评标、定标过程中依法需要保密的内容。合同终止后，未经委托人同意，受托人不得泄漏与本合同工程相关的任何招标资料和情况。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">5.8&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人未能履行以上各项义务，给委托人造成损失的，应当赔偿委托人的有关损失。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">6</span><span
								style="font-size: 16px;font-family: 宋体">、委托人的权利</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">6.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人拥有下列权利：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）按合同约定，接收招标代理成果；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）向受托人询问本合同工程招标工作进展情况和相关内容或提出不违反法律、行政法规的建议；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）审查受托人为本合同工程编制的各种文件，并提出修正意见；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）要求受托人提交招标代理业务工作报告；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（5）与受托人协商，建议更换其不称职的招标代理从业人员；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（6）依法选择中标人；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（7）本合同履行期间，由于受托人不履行合同约定的内容，给委托人造成损失或影响招标工作正常进行的，委托人有权终止本合同，并依法向受托人追索经济赔偿，直至追究法律责任；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（8）依法享有的其他权利，双方在本合同专用条款内约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">7</span><span
								style="font-size: 16px;font-family: 宋体">、受托人的权利</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">7.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人拥有下列权利：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）按合同约定收取委托代理报酬；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）对招标过程中应由委托人做出的决定，受托人有权提出建议；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）当委托人提供的资料不足或不明确时，有权要求委托人补足资料或作出明确的答复；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）拒绝委托人提出的违反法律、行政法规的要求，并向委托人作出解释；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（5）有权参加委托人组织的涉及招标工作的所有会议和活动；&nbsp;&nbsp;&nbsp;</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（6）对于为本合同工程编制的所有文件拥有知识产权，委托人仅有使用或复制的权利；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（7）依法享有的其他权利，双方在本合同专用条款内约定。</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">三、委托代理报酬与收取</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">8</span><span
								style="font-size: 16px;font-family: 宋体">、委托代理报酬</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">8.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">双方按照本合同约定的招标代理业务范围，在本合同专用条款内约定委托代理报酬的计算方法、金额、币种、汇率和支付方式、支付时间。</span><span
								style="font-size:16px;font-family:宋体;color:red">&nbsp;&nbsp;</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">8.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人对所承接的招标代理业务需要出外考察的，其外出人员数量和费用，经委托人同意后，向委托人实报实销。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">8.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">在招标代理业务范围内所发生的费用（如：评标会务费、评标专家的差旅费、劳务费、公证费等），由委托人与受托人在补充条款中约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9</span><span
								style="font-size: 16px;font-family: 宋体">、委托代理报酬的收取</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">由委托人支付代理报酬的，在本合同签订后10日内，委托人应向受托人支付不少于全部代理报酬20％的代理预付款，具体额度（或比例）双方在专用条款内约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">由中标人支付代理报酬的，在中标人与委托人签订承包合同5日内，将本合同约定的全部委托代理报酬一次性支付给受托人。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人完成委托人委托的招标代理工作范围以外的工作，为附加服务项目，应收取的报酬由双方协商，签订补充协议。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人在本合同专用条款约定的支付时间内，未能如期支付代理预付费用，自应支付之日起，按同期银行贷款利率，计算支付代理预付费用的利息。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9.4&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人在本合同专用条款约定的支付时间内，未能如期支付代理报酬，除应承担违约责任外，还应按同期银行贷款利率，计算支付应付代理报酬的利息。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">9.5&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托代理报酬应由委托人按本合同专用条款约定的支付方法和时间，直接向受托人支付；或受托人按照约定直接向中标人收取。</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">四、违约、索赔和争议</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">10</span><span
								style="font-size: 16px;font-family: 宋体">、违约</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">10.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人违约。 当发生下列情况时：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）本合同通用条款第4.2
								-（3）款提到的委托人未按本合同专用条款的约定向委托人提供为保证招标工作顺利完成的条件，致使招标工作无法进行；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）本合同通用条款第4.2
								-（6）款提到的委托人未按本合同专用条款的约定向受托人支付委托代理报酬；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）委托人不履行合同义务或不按合同约定履行义务的其他情况。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">委托人承担违约责任，赔偿因其违约给受托人造成的经济损失，双方在本合同专用条款内约定委托人赔偿受托人损失的计算方法或委托人应当支付违约金的数额或计算方法。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">10.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人违约。 当发生下列情况时：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）本合同通用条款第5.2
								-（2）款提到的受托人未按本合同专用条款的约定，向委托人提供为完成招标工作的咨询服务；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）本合同通用条款第5.4款提到的受托人未按本合同专用条款的约定，接受了与本合同工程建设项目有关的投标咨询业务；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）本合同通用条款第5.7款提到的受托人未按本合同专用条款的约定，泄露了与本合同工程相关的任何招标资料和情况；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（4）受托人不履行合同义务或不按合同约定履行义务的其他情况。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">受托人承担违约责任，赔偿因其违约给委托人造成的经济损失，双方在本合同专用条款内约定受托人赔偿委托人损失的计算方法或受托人应当支付违约金的数额或计算方法。受托人承担违约责任，赔偿金额最高不应超过委托代理报酬的金额（扣除税金）。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">10.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">第三方违约。如果一方的违约被认定为是与第三方共同造成的，则应由合同双方中有违约的一方先行向另一方承担全部违约责任，再由承担违约责任的一方向第三方追索。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">11</span><span
								style="font-size: 16px;font-family: 宋体">、索赔</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">11.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">当事人一方向另一方提出索赔时，要有正当的索赔理由，且有索赔事件发生时的有效证据。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">11.2&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人未能按合同约定履行自己的各项义务，或者发生应由委托人承担责任的其他情况，给受托人造成损失，受托人可按下列程序以书面形式向委托人索赔：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）索赔事件发生后7天内，向委托人发出索赔报告及有关资料；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）委托人收到受托人的索赔报告及有关资料后，于7天内给予答复，或要求受托人进一步补充索赔理由和证据；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（3）委托人在收到受托人送交的索赔报告和有关资料后7天内未予答复，或未对受托人作进一步要求，视为该项索赔已经认可。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">11.3&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">受托人未能按合同约定履行自己的各项义务，或者发生应由受托人承担责任的其他情况，给委托人造成经济损失，委托人可按11.2款确定的时限和程序向受托人提出索赔。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">12</span><span
								style="font-size: 16px;font-family: 宋体">、争议</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">12.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">委托人和受托人履行合同时发生争议，可以和解或者向有关部门或机构申请调解。当事人不愿和解、调解或者和解、调解不成的，双方可以在本合同专用条款约定以下一种方式解决争议：</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（1）双方达成仲裁协议，向约定的仲裁委员会申请仲裁；</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">（2）向有管辖权的人民法院起诉。</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">五、合同变更、生效与终止</span></strong>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">13</span><span
								style="font-size: 16px;font-family: 宋体">、合同变更或解除</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">13.1&nbsp;</span><span
								style="font-size: 16px;font-family: 宋体">本合同签订后，由于委托人原因，使得受托人不能持续履行招标代理业务时，委托人应及时通知受托人暂停招标代理业务。当需要恢复招标代理业务时，应当在正式恢复前7天通知受托人。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">若暂停时间超过六个月，当需要恢复招标代理业务时，委托人应支付重新启动该招标代理工作一定的补偿费用，具体计算方式经双方协商以补充协议确定。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">13.2 </span><span
								style="font-size: 16px;font-family: 宋体">本合同签订后，如因法律、行政法规发生变化或由于任何后续新颁布的法律、行政法规导致服务所需的成本或时间发生改变，则本合同约定的服务报酬和服务期限由双方签订补充协议进行相应调整。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">13.3 </span><span
								style="font-size: 16px;font-family: 宋体">本合同当事人一方要求变更或解除合同时，除法律、行政法规另有规定外，应与对方当事人协商一致并达成书面协议。未达成书面协议的，本合同依然有效。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">13.4 </span><span
								style="font-size: 16px;font-family: 宋体">因解除合同使当事人一放遭受损失的，除依法可以免除责任外，应由责任方负责赔偿对方的损失，赔偿方法与金额由双方在协议书约定。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">14</span><span
								style="font-size: 16px;font-family: 宋体">、合同生效</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">14.1 </span><span
								style="font-size: 16px;font-family: 宋体">除生效条件双方在协议书中另有约定外，本合同自双方签字盖章之日起生效。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">15</span><span
								style="font-size: 16px;font-family: 宋体">、合同终止</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">15.1 </span><span
								style="font-size: 16px;font-family: 宋体">受托人完成委托人全部委托招标代理业务，且委托人或中标人支付了全部代理报酬（含附加服务的报酬）后本合同终止。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">15.2 </span><span
								style="font-size: 16px;font-family: 宋体">本合同终止并不影响各方应有的权利和应承担的义务。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">15.3 </span><span
								style="font-size: 16px;font-family: 宋体">因不可抗力，致使当事人一方或双方不能履行本合同时，双方应协商确定本合同继续履行的条件或终止本合同。如果双方不能就本合同继续履行的条件或终止本合同达成一致意见，本合同自行终止。除委托人应付给受托人已完成工作的报酬外，各自承担相应的损失。</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">15.4 </span><span
								style="font-size: 16px;font-family: 宋体">本合同的权利和义务终止后，委托人和受托人应当遵循诚实信用原则，履行通知、协助、保密等义务。</span>
						</p>
						<p style="margin-top: 5px;line-height: 24px">
							<strong><span style="font-size: 19px;font-family: 宋体">六、其他</span></strong>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">16</span><span
								style="font-size: 16px;font-family: 宋体">、合同的份数</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">16.1 </span><span
								style="font-size: 16px;font-family: 宋体">本合同正本一式两份，委托人和受托人各执一份。副本根据双方需要在本合同专用条款内约定。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
							<span style="font-size: 16px;font-family: 宋体">17</span><span
								style="font-size: 16px;font-family: 宋体">、补充条款</span>
						</p>
						<p style="margin: 5px 0;text-indent: 32px;line-height: 24px">
							<span style="font-size: 16px;font-family: 宋体">双方根据有关法律、行政法规规定，结合本合同招标工程实际，经协商一致后，可对本合同通用条款未涉及的内容进行补充。</span>
						</p>
						<p
							style="margin-top:5px;margin-right:0;margin-bottom:5px;margin-left:0;text-align:center;line-height:32px">
							<span style="font-size: 16px;font-family: Arial, sans-serif">&nbsp;</span>
						</p>
					</div>
					
					<c:choose>
						<c:when test="${not empty commissionContract.contentPartThree}">
							
							<textarea id="commissionContract3" name="commissionContract3" style="width:100%;height:800px;overflow-y:visible;display: none;">
									${commissionContract.contentPartThree}
							</textarea>
						</c:when>
						<c:otherwise>
							<jsp:include page="commissionContractPartThree.jsp" />
						</c:otherwise>
					</c:choose>	
					
					<div class="blank10"></div>
					<input type="button" class='button red' id="sub" value="确认提交" style="display:none;" />
				</form>
			</div>
		</div>
<!-- 	</div> -->
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
