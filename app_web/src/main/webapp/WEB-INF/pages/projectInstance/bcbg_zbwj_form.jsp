<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>招标文件信息</title>
<jsp:include page="/common/link.jsp" />
<script charset="utf-8" src="js/kindeditor-4.1.1/kindeditor-min.js"></script>
<script charset="utf-8" src="js/kindeditor-4.1.1/zh_CN.js"></script>
<script>
	var editor;
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="tbzg00"]', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : false,
					items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'image', 'link','|','fullscreen'],
					afterBlur : function() {
						this.sync();//同步KindEditor的值到textarea文本域
					}
				});
		editor1 = K.create('textarea[name="wjdjfs"]', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : false,
					items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'image', 'link','|','fullscreen'],
					afterBlur : function() {
						this.sync();//同步KindEditor的值到textarea文本域
					}
				});
		editor2 = K.create('textarea[name="pbff00"]', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : false,
					items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'image', 'link','|','fullscreen'],
					afterBlur : function() {
						this.sync();//同步KindEditor的值到textarea文本域
					}
				});
		editor3 = K.create('textarea[name="kbfs00"]', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : false,
					items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'image', 'link','|','fullscreen'],
					afterBlur : function() {
						this.sync();//同步KindEditor的值到textarea文本域
					}
				});
		editor4 = K.create('textarea[name="zgscfs"]', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : false,
					items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'image', 'link','|','fullscreen'],
					afterBlur : function() {
						this.sync();//同步KindEditor的值到textarea文本域
					}
				});
		
	});

	$("#bzjje").keyup(function(event) {
		$("#bigJE").html(convertCurrency($("#bzjje").val()));
	});

	$(function(){
		$('#menubar>ul>li>a').click(function(){
			$('#menubar>ul>li>a').removeClass('select_a').addClass('no_select_a');
			$(this).removeClass('no_select_a').addClass('select_a');
		});
	});
	
	function subZbxx(){
		if(confirm("提交后将不可修改，确认要提交审核吗？")){
			$("#zbxxForm").attr("action","${pageContext.request.contextPath}/flow/completeTask");
			$("#zbxxForm").submit();
		}
	}
	
	function cls(){
		window.close();
	}
	
</script>
<style type="text/css">
#bigJE {
 font-color: #f00;
 font-size: 14px
}
.fileQueue {
	width: 100%;
	height: 1%;
	overflow: auto;
}
</style>
</head>
<body>
<jsp:include page="/common/top.jsp"/>
<div class="block">
	<div class="AreaR">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标文件补充变更
		</div>
	</div>
	<div class="blank10"></div>
	<h4 style="background-color: #eee;color:#79a605!important;text-align:left;margin-left:3px">招标文件</h4>
	<form id="zbwjForm" class="registerform" method="post" action="${pageContext.request.contextPath}/node_6/zbwj_save">
		<input type='hidden' name="id" value="${t_zbwj.id}" /> 
		<input type='hidden' name="zbxmid" value="${t_zbwj.zbxmid}" />
		<table width="100%" style="table-layout:fixed;">
			<tr>
				<td class="need" style="width:2px;">*</td>
				<td style="width:18%">招标文件获取时间：</td>
				<td style="width:30%"><input type="text" id='wjhqsj' value="<fmt:formatDate value="${t_zbwj.wjhqsj}" type="both" dateStyle="default" timeStyle="default" />" name="wjhqsj"  datatype="*" nullmsg="请输入招标文件获取时间！" /></td>
				<td style="width:2px;"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
				<td class="need" style="width:2px;">*</td>
				<td style="width:18%">投标文件递交截止时间：</td>
				<td style="width:30%"><input type="text" value="<fmt:formatDate value="${t_zbwj.tbjzsj}" type="both" dateStyle="default" timeStyle="default" />" name="tbjzsj" class="inputxt Wdate" datatype="*" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" nullmsg="请选择投标文件递交截止时间！" /></td>
				<td style="width:2px"><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td>投标保证金币种：</td>
				<td><select name="bzdm00">
									<c:forEach items="${util:dictionaryTree('GGLXDM',false)}" var="item">
										<option value="${item.itemCode}" ${item.itemCode==t_zbwj.bzdm00?"selected='selected'":""}>${item.itemName}</option>
									</c:forEach>
							</select></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
				<td class="need">*</td>
				<td>投标保证金单位：</td>
				<td><select name="bzjdw0">
									<c:forEach items="${util:dictionaryTree('JEDWDM',false)}" var="item">
										<option value="${item.itemCode}" ${item.itemCode==t_zbwj.bzjdw0?"selected='selected'":""}>${item.itemName}</option>
									</c:forEach>
							</select></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td>投标保证金金额：</td>
				<td><input type="text" value="${t_zbwj.bzjje0}" nullmsg="请输入投标保证金金额！" name="bzjje0" id="bzjje" class="inputxt" datatype="n.n" nullmsg="请输入投标保证金金额！" /></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
				<td colspan='4' style="text-align:left"><span id="bigJE"></span></td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td>开标时间：</td>
				<td><input type="text" value="<fmt:formatDate value="${t_zbwj.kbsj00}" type="both" dateStyle="default" timeStyle="default" />" nullmsg="请选择开标时间！" datatype="*" name="kbsj00" class="inputxt Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" errormsg="请选择开标时间！" /></td>
				<td colspan='5'><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td>投标资格:</td>
				<td colspan='5'><textarea name="tbzg00" datatype="*1-2000" nullmsg="请输入投标资格！" style="width:99%;height:160px;">${t_zbwj.tbzg00}</textarea></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td>投标文件递交方法:</td>
				<td colspan='5'><textarea name="wjdjfs" datatype="*1-2000" nullmsg="请输入投标文件递交方法！" style="width:99%;height:160px;">${t_zbwj.wjdjfs}</textarea></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td>评标办法:</td>
				<td colspan='5'><textarea name="pbff00" datatype="*1-2000" nullmsg="请输入评标办法！" style="width:99%;height:160px;">${t_zbwj.pbff00}</textarea></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>

			<tr>
				<td class="need">*</td>
				<td>开标方式:</td>
				<td colspan='5'><textarea name="kbfs00" datatype="*1-2000" nullmsg="请输入开标方式！" style="width:99%;height:160px;">${t_zbwj.kbfs00}</textarea></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>

			<tr>
				<td class="need">*</td>
				<td>资格审查方式:</td>
				<td colspan='5'><textarea name="zgscfs" datatype="*1-2000" nullmsg="请输入资格审查方式！" style="width:99%;height:160px;">${t_zbwj.zgscfs}</textarea></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need"></td>
				<td></td>
				<td colspan="2" style="padding:10px 0 18px 0;"><input type="submit" class="btn_2" value="保 存" /></td>
			</tr>
		</table>
	</form>
	<div id='loading' style='text-align: center'><img src='img/loading/loaderc.gif'/></div>
	<y:uploadify fjsszt="${projectInstance.id==null?zbxmid:projectInstance.id}" fjgslx="08" title="招标文件上传"/>
	</div>
</body>
</html>