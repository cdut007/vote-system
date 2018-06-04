<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>

<script type="text/javascript">

function queryOrganPage() {
	var ztmc00 = $('#ztmc00').val();
	$("#organBInfo_list").datagrid("reload", {
		ztmc00 : ztmc00,
	});
}

function organ_info(organId){
	window.location='${pageContext.request.contextPath}/organ/organBInfoView?organId='+organId;
}
function organ_aptitude(organId){
	window.location='${pageContext.request.contextPath}/organ/organBAptitudeView?organId='+organId;
}
function organ_user_certificate(organId){
	window.location='${pageContext.request.contextPath}/organ/organBCertificateView?organId='+organId;
}
function organ_credit(organId){
	window.location='${pageContext.request.contextPath}/organ/organBCreditView?organId='+organId;
}
function organ_project_achievement(organId){
	window.location='${pageContext.request.contextPath}/organ/organBProjectAchievementView?organId='+organId;
}

function organ_performance(organId){
	window.location='${pageContext.request.contextPath}/organ/organBPerformanceView?organId='+organId;
}
function organ_rewardsAndPunishment(organId){
	window.location='${pageContext.request.contextPath}/organ/organBRewardsAndPunishmentView?organId='+organId;
}
function organ_winBidMessage(organId){
	window.location='${pageContext.request.contextPath}/organ/organBWinBidMessageView?organId='+organId;
}

$(function() {
	
	$("#organBInfo_list").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		height : 400,
		pagination : true,
		title:"投标单位列表",
		url : "${pageContext.request.contextPath}/organ/organBInfoListData",
		idField : "id",
		columns : [ [
			{field:"ztdm00",title:"主体代码",width:130}, 
			{field:"ztmc00",title:"主体名称",width:200}, 
			{field:"createTime",title:"注册时间",width:120}, 
			{field:"organType",title:"机构状态",width:100,align:"center",formatter:function(value){
				if(value == '1'){
					return '正常'
				}else{
					return '禁用'
				}
			}}, 
			{field:"id",title:"操作",width:450,formatter:function(value, row, index) {
				return 	"<a target=\"_blank\" class=\"button red small\" href=\"${pageContext.request.contextPath}/organ/organBInfoView?organId=" + row.id + "\">统计信息</a>"+
					 	"<a target=\"_blank\" class=\"button red small\" href=\"${pageContext.request.contextPath}/organ/organBAptitudeView?organId=" + row.id + "\">资质证书</a>"+
				 		"<a target=\"_blank\" class=\"button red small\" href=\"${pageContext.request.contextPath}/organ/organBCertificateView?organId=" + row.id + "\">执业人员</a>"+
				 		"<a target=\"_blank\" class=\"button red small\" href=\"${pageContext.request.contextPath}/organ/organBPerformanceView?organId=" + row.id + "\">履约记录</a>"+
				 		"<a target=\"_blank\" class=\"button red small\" href=\"${pageContext.request.contextPath}/organ/organBRewardsAndPunishmentView?organId=" + row.id + "\">奖惩信息</a>"+
				 		"<a target=\"_blank\" class=\"button red small\" href=\"${pageContext.request.contextPath}/organ/organBWinBidMessageView?organId=" + row.id + "\">中标业绩</a>";
						/* "<a target='_blank' class='button red small' onclick='organ_aptitude(\""+row.id+"\")'>资质证书</a>"+
						"<a class='button red small' onclick='organ_user_certificate(\""+row.id+"\")'>执业人员</a>"+
						"<a class='button red small' onclick='organ_performance(\""+row.id+"\")'>履约记录</a>"+
						"<a class='button red small' onclick='organ_rewardsAndPunishment(\""+row.id+"\")'>奖惩信息</a>"+
						"<a class='button red small' onclick='organ_winBidMessage(\""+row.id+"\")'>中标业绩</a>"; */
			}
			} ] ]
		});
});

</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标单位信息管理
		</div>
	</div>
	
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<table>
				    <tr>
						<td>机构名称:</td>
						<td> 
							<input id="ztmc00" name="ztmc00" class="inputxt" />
						</td>
						<td><a class="button red" onclick="queryOrganPage()">查 询</a></td>
					</tr>
				</table> 
				<div class="blank10"></div>
				<table id="organBInfo_list"></table>
			</div>
		</div>
	</div>
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
