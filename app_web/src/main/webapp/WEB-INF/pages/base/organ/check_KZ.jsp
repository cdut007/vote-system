<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招投标主体基本信息管理表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<jsp:include page="/common/link.jsp" />
</head>
<script type="text/javascript">
</script>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			会员管理
			<code>&gt;</code>
			机构信息维护
			<code>&gt;</code>
			扩展信息
		</div>
	</div>
	<div class="block">
		<div class="usBox">
		
			<div class="easyui-panel" data-options="title:'招标人信息'" style="overflow:hidden;padding:10px;">
				<table id="dlr_EX_msg" style="table-layout:auto;width:100%;font-size:12px">				
					<tr>
						<td style="width:20%">主体代码</td>
						<td style="width:30%">${map_zbr['LEGAL_CODE']}</td>
					</tr>
				</table>
			</div>			
			<div class="blank10"></div>
			
			<div class="easyui-panel" data-options="title:'招标代理机构信息'" style="overflow:hidden;padding:10px;">
				<table id="dlr_EX_msg" style="table-layout:auto;width:100%;font-size:12px">
					<tr>
						<td style="width:20%">主体代码</td>
						<td style="width:30%">${map_dlr['LEGAL_CODE']}</td>
						<td style="width:20%">资质等级</td>
						<td style="width:30%">${map_dlr['QUAL_LEVEL']}</td>
					</tr>
					<tr>
						<td>资质名称</td>
						<td>${map_dlr['QUAL_NAME']}</td>
						<td>资质序列、行业和专业类别</td>
						<td>${map_dlr['QUAL_TYPE']}</td>
					</tr>
					<tr>
						<td>资质证书编号</td>
						<td>${map_dlr['QUAL_CERT_NO']}</td>
						<td>资质证书失效日期</td>
						<td>${map_dlr['QUAL_CERT_END_DATE']}</td>
					</tr>
					<tr>
						<td>附件关联标识号集合</td>
						<td>${map_dlr['ATTACHMENT_SET_CODE']}</td>
					</tr>				
				</table>
			</div>
			<div class="blank10"></div>
			
			<div class="easyui-panel" data-options="title:'投标人信息'" style="overflow:hidden;padding:10px;">
				<table id="dlr_EX_msg" style="table-layout:auto;width:100%;font-size:12px">
					<tr>
						<td style="width:20%">主体代码</td>
						<td style="width:30%">${map_tbr['LEGAL_CODE']}</td>
						<td style="width:20%">资质等级</td>
						<td style="width:30%">${map_tbr['QUAL_LEVEL']}</td>
					</tr>
					<tr>
						<td>资质名称</td>
						<td>${map_tbr['QUAL_NAME']}</td>
						<td>资质序列、行业和专业类别</td>
						<td>${map_tbr['QUAL_TYPE']}</td>
					</tr>
					<tr>
						<td>资质证书编号</td>
						<td>${map_tbr['QUAL_CERT_NO']}</td>
						<td>资质证书失效日期</td>
						<td>${map_tbr['QUAL_CERT_END_DATE']}</td>
					</tr>
					<tr>
						<td>附件关联标识号集合</td>
						<td>${map_tbr['ATTACHMENT_SET_CODE']}</td>
					</tr>
				</table>
			</div>
			<div class="blank10"></div>
			
			<div class="easyui-panel" data-options="title:'法人交易业绩信息'" style="overflow:hidden;padding:10px;">
				<table id="dlr_EX_msg" style="table-layout:auto;width:100%;font-size:12px">
					<tr>
						<td style="width:20%">主体代码</td>
						<td style="width:30%">${map_frjyyj['BIDDER_NO']}</td>
						<td style="width:20%">招标项目编号</td>
						<td style="width:30%">${map_frjyyj['SECTION_NO']}</td>
					</tr>
					<tr>
						<td>标段（包）编号</td>
						<td>${map_frjyyj['BID_SECTION_CODE']}</td>
						<td>招标项目名称</td>
						<td>${map_frjyyj['SECTION_NAME']}</td>
					</tr>
					<tr>
						<td>标段（包）名称</td>
						<td>${map_frjyyj['BID_SECTION_NAME']}</td>
						<td>招标人（采购人/出让人）代码</td>
						<td>${map_frjyyj['TENDER_NO']}</td>
					</tr>
					<tr>
						<td>招标人（采购人/出让人）名称</td>
						<td>${map_frjyyj['TENDER_NAME']}</td>
						<td>中标（成交/竞得）金额</td>
						<td>${map_frjyyj['BID_AMOUNT']}</td>
					</tr>
					<tr>
						<td>交易分类</td>
						<td>${map_frjyyj['TRADE_TYPE']}</td>
						<td>金额币种代码</td>
						<td>${map_frjyyj['CURRENCY']}</td>
					</tr>
					<tr>
						<td>金额单位</td>
						<td>${map_frjyyj['MONEY_UNIT']}</td>
						<td>合同签署时间</td>
						<td>${map_frjyyj['CONTRACT_SIGN_DATE']}</td>
					</tr>			
				</table>
			</div>
			<div class="blank10"></div>
			
			<div class="easyui-panel" data-options="title:'执业人员基本信息'" style="overflow:hidden;padding:10px;">
				<table id="dlr_EX_msg" style="table-layout:auto;width:100%;font-size:12px">
					<tr>
						<td style="width:20%">身份证件号码</td>
						<td style="width:30%">${map_zyryxx['ID_CARD']}</td>
						<td style="width:20%">身份证件类型</td>
						<td style="width:30%">${map_zyryxx['ID_CARD_TYPE']}</td>
					</tr>
					<tr>
						<td>姓名</td>
						<td>${map_zyryxx['PERSON_NAME']}</td>
						<td>性别</td>
						<td>${map_zyryxx['GENDER']}</td>
					</tr>
					<tr>
						<td>出生年月</td>
						<td>${map_zyryxx['BIRTHDATE']}</td>
						<td>行政区域代码</td>
						<td>${map_zyryxx['REGION_CODE']}</td>
					</tr>
					<tr>
						<td>最高学历</td>
						<td>${map_zyryxx['PERSON_EDU']}</td>
						<td>所在单位代码</td>
						<td>${map_zyryxx['UNIT_CODE']}</td>
					</tr>
					<tr>
						<td>所在单位名称</td>
						<td>${map_zyryxx['UNIT_NAME']}</td>
						<td>是否在职</td>
						<td>${map_zyryxx['ON_JOB']}</td>
					</tr>
					<tr>
						<td>职务</td>
						<td>${map_zyryxx['JOB']}</td>
						<td>职称</td>
						<td>${map_zyryxx['TECH_TITLE']}</td>
					</tr>
					<tr>
						<td>从业开始时间</td>
						<td>${map_zyryxx['WORK_START_DATE']}</td>						
					</tr>
				</table>
			</div>
			<div class="blank10"></div>
				
			<div class="easyui-panel" data-options="title:'执业人员资格信息'" style="overflow:hidden;padding:10px;">
				<table id="dlr_EX_msg" style="table-layout:auto;width:100%;font-size:12px">	
					<tr>
						<td style="width:20%">执业资格名称</td>
						<td style="width:30%">${map_zyryzg['QUAL_NAME']}</td>
						<td style="width:20%">执业资格类型</td>
						<td style="width:30%">${map_zyryzg['QUAL_TYPE']}</td>
					</tr>
					<tr>
						<td>执业人员证件号</td>
						<td>${map_zyryzg['ID_CARD']}</td>
						<td>执业人员身份证件类型</td>
						<td>${map_zyryzg['ID_CARD_TYPE']}</td>
					</tr>
					<tr>
						<td>执业资格证书编号</td>
						<td>${map_zyryzg['CERT_NO']}</td>
						<td>执业资格注册有效期止</td>
						<td>${map_zyryzg['CERT_END_DATE']}</td>
					</tr>
					<tr>
						<td>附件关联标识号集合</td>
						<td>${map_zyryzg['ATTACHMENT_SET_CODE']}</td>
					</tr>
				</table>
			</div>
			<div class="blank10"></div>
				
				
				
			<div class="easyui-panel" data-options="title:'执业人员业绩信息'" style="overflow:hidden;padding:10px;">
				<table id="dlr_EX_msg" style="table-layout:auto;width:100%;font-size:12px">	
					<tr>
						<td>人员身份证件号</td>
						<td>${map_zyryyj['ID_CARD_NO']}</td>
						<td>人员身份证件类型</td>
						<td>${map_zyryyj['ID_CARD_TYPE']}</td>
					</tr>
					<tr>
						<td>招标项目编号</td>
						<td>${map_zyryyj['SECTION_NO']}</td>
						<td>标段（包）编号</td>
						<td>${map_zyryyj['BID_SECTION_CODE']}</td>
					</tr>
					<tr>
						<td>招标项目名称</td>
						<td>${map_zyryyj['SECTION_NAME']}</td>
						<td>标段（包）名称</td>
						<td>${map_zyryyj['BID_SECTION_NAME']}</td>
					</tr>
					<tr>
						<td>招标人/采购人/出让人代码</td>
						<td>${map_zyryyj['OWNER_NO']}</td>
						<td>招标人/采购人/出让人名称</td>
						<td>${map_zyryyj['OWNER_NAME']}</td>
					</tr>
					<tr>
						<td>合同金额</td>
						<td>${map_zyryyj['CONTRACT_AMOUNT']}</td>
						<td>交易分类</td>
						<td>${map_zyryyj['TRADE_TYPE']}</td>
					</tr>
					<tr>
						<td>结算金额</td>
						<td>${map_zyryyj['SETTLE_AMOUNT']}</td>
						<td>金额币种代码</td>
						<td>${map_zyryyj['CURRENCY']}</td>
					</tr>
					<tr>
						<td>金额单位</td>
						<td>${map_zyryyj['MONEY_UNIT']}</td>
						<td>合同签署时间</td>
						<td>${map_zyryyj['CONTRACT_SIGN_DATE']}</td>
					</tr>
					<tr>
						<td>合同完成时间</td>
						<td>${map_zyryyj['CONTRACT_FINISH_DAT']}</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>
