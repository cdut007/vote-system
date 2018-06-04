<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标计划表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<link rel="stylesheet" href="plug-in/validform/css/style.css" type="text/css" />
<link rel="stylesheet" href="plug-in/validform/css/demo.css" type="text/css" />
<style type="text/css">
.mytable td {
 border-bottom: #eee 1px dashed;
}

.btn {
 color: #484848;
 font: 12px/1.5 arial;
 padding-top: 8px;
 padding-bottom: 8px;
 align: center
}

#bdjh {
 line-height: 30px;
}
</style>
<script charset="utf-8" src="js/kindeditor-4.1.1/kindeditor-min.js"></script>
<script charset="utf-8" src="js/kindeditor-4.1.1/zh_CN.js"></script>
</head>
<body>
	<div class="blank10"></div>
	<h3 style="background-color: #eee;color:#79a605!important;text-align:left;margin-left:3px">招标公告</h3>
	<form id="zhaobnoticeForm" class="registerform" method="post" action='${pageContext.request.contextPath}/notice/saveOrUpdate'>
		<input type='hidden' name="id" value="${noticeZhaob.id}"/> 
		<input type='hidden' name="zbxmbh" value="${noticeZhaob.zbxmbh}"/> 
		<input type='hidden' name="projectInstanceId" value="${projectInstance.id}"/>
		<input type="hidden" name="zbxmmc" value="${projectInstance.zbxmmc}" />
		<table width="100%" style="table-layout:fixed;">
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td style="width:15%">招标项目名称：</td>
				<td colspan="6"><h1>${projectInstance.zbxmmc}</h1></td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td style="vertical-align:middle;">标段（包）编号集合:</td>
				<td style="padding-left:3px;">
					<div id='bdjh' style="margin-left: 10px">
						<c:forEach items="${projectInstance.projectItems}" var="item" varStatus="num">
							<c:out value="${num.count}"></c:out>、<c:out value="${item.bdbh00}"></c:out>:<c:out value="${item.bdmc00}"></c:out>
							<br />
						</c:forEach>
					</div> <input type='hidden' id="projectItemId" name="projectItemId" />
				</td>
				<td style="width:2px"></td>
			</tr>
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td>公告标题：</td>
				<td style="text-align: left"><input type="text" style="width:99%" value="${noticeZhaob.noticeTitle}" name="noticeTitle" nullmsg="请填写公告标题！" class="inputxt" datatype="s1-100" /></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
		</table>
		<table width="100%" style="table-layout:fixed;">
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td style="width:15%;">公告性质：</td>
				<td><select name="ggxzdm">
									<c:forEach items="${util:dictionaryTree('GGLXDM',false)}" var="item">
										<option value="${item.itemCode}" ${item.itemCode==noticeZhaob.ggxzdm?"selected='selected'":""}>${item.itemName}</option>
									</c:forEach>
							</select></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
				<td class="need" style="width:10px;">*</td>
				<td style="width:15%;">公告类型：</td>
				<td><select name="gglxdm">
									<c:forEach items="${util:dictionaryTree('GGLXDM',false)}" var="item">
										<option value="${item.itemCode}" ${item.itemCode==noticeZhaob.gglxdm?"selected='selected'":""}>${item.itemName}</option>
									</c:forEach>
							</select></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td>招标文件获取时间：</td>
				<td><input type="text" value="<fmt:formatDate value="${projectInstance.wjhqsj}" type="both" dateStyle="default" timeStyle="default" />" name="wjhqsj" class="inputxt Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="*" nullmsg="请输入招标文件获取时间！" /></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
				<td class="need" style="width:10px;">*</td>
				<td>投标文件递交截止时间：</td>
				<td><input type="text" value="<fmt:formatDate value="${projectInstance.tbjzsj}" type="both" dateStyle="default" timeStyle="default" />" name="tbjzsj" class="inputxt Wdate" datatype="*" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" nullmsg="请选择投标文件递交截止时间！" /></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td>招标文件获取方法：</td>
				<td><input type="text" value="${noticeZhaob.wjhqff}" name="wjhqff" class="inputxt" datatype="s1-100" /></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
				<td class="need" style="width:10px;">*</td>
				<td>投标文件递交方法：</td>
				<td><input type="text" value="${noticeZhaob.wjdjff}" name="wjdjff" class="inputxt" datatype="s1-100" /></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td>公告发布责任人：</td>
				<td><input type="text" value="${noticeZhaob.fbzrr0}" name="fbzrr0" class="inputxt" datatype="s1-100" /></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
				<td class="need" style="width:10px;">*</td>
				<td>交易平台验证责任人：</td>
				<td><input type="text" value="${noticeZhaob.yzzrr0}" name="yzzrr0" class="inputxt" datatype="s1-100" /></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td>购买标书费用：</td>
				<td><input type="text" value="${noticeZhaob.gmbsfy}" name="gmbsfy" class="inputxt" datatype="s1-100" /></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need"></td>
				<td style="vertical-align:middle">公告内容:</td>
				<td colspan='5'><textarea name="ggnrwb" nullmsg="请输入公告内容！" datatype="*" style="width:99%;height:360px;">${noticeZhaob.ggnrwb}</textarea></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need"></td>
				<td style="vertical-align:middle">公告发布媒体:</td>
				<td colspan='5'><textarea name="tenderNoticeData.ggfbmt" nullmsg="请输入公告发布媒介！" datatype="*" style="width:99%;height:120px;">${noticeZhaob.tenderNoticeData.ggfbmt}</textarea></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need"></td>
				<td></td>
				<td colspan="2" style="padding:10px 0 18px 0;"><input type="submit" class="btn" value="保 存" /></td>
			</tr>
		</table>
	</form>
</body>
</html>