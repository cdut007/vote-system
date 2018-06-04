<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply" />
<c:set value="${expertApply.projectInstance}" var="projectInstance" />
<c:set value="${projectItemService.createProjectItemQuery().expertApplyId(processBusinessKey).list()}" var="projectItemList" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" datepicker="true" jgrowl="true" uedit="true" ca="true"/>
<script>
	$(function() {
		var sealName=$("#sealName").val();
		/* $("#sign").click(function(){
			var signData=sealUtil.addSeal(sealName,["gsnr"],"gsnrss",0,0);
			$("#SigndataStrSealName").val(sealName);
			$("#SigndataStrSignData").val(signData);
		});	 */
		$("#subBtn").click(function(){
			formSubmit(2);
		});
		$("#saveBtn").click(function(){
			formSubmit(1);
		});
		function autoTitle(){
			var projectInstanceId = $("#projectInstanceId").val();
			var projectInstanceName = $("#projectInstanceId").children("option[value='" + projectInstanceId + "']").html();
			var projectItemName = $('#bdjh').combotree("getText");
			$(":input[name='publicityTitle']").val(projectInstanceName + "(" + projectItemName + ")中标候选人公示");
		}
		$("#projectInstanceId").change(function() {
			$("#bdjh").combotree(this.value==""?"disable":"enable");
			if(this.value!=""){
				$("#bdjh").combotree("setValue",[]);
				$("#bdjh").combotree("reload",ctx+'/projectItem/pagingProjectItemData?projectInstanceId='+this.value);
			}
		});
		$(document).on("blur",":input", function() {
			loadDefaultCandidatePublicity();
		});
		/* $(".Wdate").focus(function() {
			WdatePicker({
				dateFmt : 'yyyy-MM-dd HH:mm:ss',
				onpicked : loadDefaultCandidatePublicity
			});
		}); */
		$(":input").filter(function() {
			return !$(this).hasClass("Wdate") && $(this).attr("type") == "text";
		}).blur(function() {
			loadDefaultCandidatePublicity();
		});
		function loadDefaultCandidatePublicity() {
			$.ajax({
				url : ctx + "/candidatePublicity/defaultCandidatePublicity",
				type : "post",
				data : $("#publicityForm").serialize(),
				dataType : "html",
				success : function(data) {
					$("#gsnr").val(data);
					$("#gsnrHTML").html(data);
				}
			});
		}
		$('#bdjh').combotree({
			onClick:function(node){
				var leafId=$($(this).tree("getChildren",node.target)).filter(function(){
					return this.children==undefined||this.children==null||this.children.length==0;
				}).map(function(){
					return this.id;
				}).get();
				$("#bdjh").combotree("setValue",leafId);
			},
			multiple:true,
			onlyLeafCheck:true,  
		    url:ctx+'/projectItem/pagingProjectItemData?projectInstanceId='+$("#projectInstanceId").val(),
		    required: true,
		    onBeforeLoad:function(){
		    	var needLoad=$("#projectInstanceId").val()!="";
		    	if(needLoad){
		    		$.messager.progress({title:"系统提示",msg:"正在加载标段信息"}); 
		    	}
		    	return needLoad;
		    },
		    onLoadSuccess:function(){
		    	$.messager.progress("close"); 
		    },
		    disabled:$("#projectInstanceId").val()=="",
		    onChange:function(newValue,oldValue){
		    	autoTitle();
		    }
		}); 
		//var tree=$("#bdjh").combotree('tree');
		//tree.tree({onBeforeSelect:function(node){var isLeaf = node.children==undefined||node.children==null||node.children.length==0;if(!isLeaf){$.messager.alert("系统提示","不能选择包,请选择标段!");} return isLeaf;}});
		function formSubmit(submitType) {
			//保存草稿
			$("#publicityForm").ajaxSubmit({
				type:"post",
				data:{expertApplyId:"${processBusinessKey}",isComplete:2 == submitType},
				beforeSend:function(){
					if(2 == submitType){
						/* if(!sealUtil.sealExists(sealName)){
							$.messager.alert('系统提示',"请先盖章！");
							return false;	
						} */
						return $("#publicityForm").form("validate");
					}
					return true;
				},
				success:function(){
					if(2 == submitType){
						window.location.href=ctx+"/home";
					}else{
						$.messager.alert("系统提示","保存草稿成功！");
					}
				},
				error:function(e,s1,s2){
					$.messager.alert(s1);
				}
			});
		}	
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			公告管理
			<code>&gt;</code>
			添加中标候选人公示			
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				添加中标候选人公示
			</h4>
			<form id="publicityForm" method="post" action='${pageContext.request.contextPath}/candidatePublicity/createOrUpdatePublicity'>
				<%-- <form:hidden path="id" /> --%>
				<input type="hidden" name="gsnr" id="gsnr" />
				<input type="hidden" value="${token}" name="token" />
				<table style="table-layout:fixed;width:100%">
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:12%">招标项目名称：</td>
						<td colspan="4">
							${projectInstance.zbxmmc}<input type="hidden" name="projectInstanceId" value="${projectInstance.id}" id="projectInstanceId" />
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td style="vertical-align:middle;">标段（包）:</td>
						<td style="padding-left:3px;" colspan="4">
							
							<c:forEach items="${expertApply.projectItemList}" var="projectItem">
								<div>${projectItem}</div>
								<input name="projectItemList" type="hidden" value="${projectItem.id}"/>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>公示标题：</td>
						<td style="text-align: left" colspan="4">
							<input type="text" style="width:99%" value="${projectInstance.zbxmmc}中标候选人公示" name="publicityTitle" nullmsg="请填写公示标题！" class="inputxt" datatype="s1-100" />
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:12%;">公示类型：</td>
						<td colspan="4">
							<select name="gslx">
								<c:forEach items="${util:dictionaryTree('GSLXDM',false)}" var="item">
									<option value="${item.itemCode}" ${item.itemCode==candidatePublicity.gslx?"selected='selected'":""}>${item.itemName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<%-- <td class="need" style="width:10px;">*</td>
						<td>公示开始时间：</td>
						<td>
							<input type="text" id="gskssj" value="<fmt:formatDate value="${candidatePublicity.gskssj}" type="both" dateStyle="default" timeStyle="default" />" name="gskssj" class="inputxt Wdate" nullmsg="请选择公示开始时间！" />
						</td>
						<td class="need" style="width:10px;">*</td>
						<td>公示结束时间：</td>
						<td>
							<input type="text" id="gsjssj" value="<fmt:formatDate value="${candidatePublicity.gsjssj}" type="both" dateStyle="default" timeStyle="default" />" name="gsjssj" class="inputxt Wdate" nullmsg="请选择公示结束时间！" />
						</td> --%>
						
						<td class="need" style="width:10px;">*</td>
						<td>公示开始时间：</td>
						<td>
							<%-- <input type="text" id="gskssj" value="<fmt:formatDate value="${candidatePublicity.gskssj}" type="both" dateStyle="default" timeStyle="default" />" name="gskssj" class="inputxt Wdate" nullmsg="请选择公示开始时间！" /> --%>
							<input type="text" id="gskssj" value="<fmt:formatDate value="${candidatePublicity.gskssj}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />" name="gskssj" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" nullmsg="请选择公示开始时间！"/>
						</td>
						<td class="need" style="width:10px;">*</td>
						<td>公示结束时间：</td>
						<td>
							<input type="text" id="gsjssj" value="<fmt:formatDate value="${candidatePublicity.gsjssj}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />" name="gsjssj" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" nullmsg="请选择公示结束时间！"/>
						</td>
						
						
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>联系人：</td>
						<td>
							<input name="contacts" class="inputxt" />
						</td>
						<td class="need" style="width:10px;">*</td>
						<td>联系电话：</td>
						<td>
							<input name="phone" class="inputxt" />
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>电子邮箱：</td>
						<td>
							<input path="email" class="inputxt" />
						</td>
						<td class="need" style="width:10px;"></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="6">
							<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
								<span id="gsnrss"></span><div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;" id="gsnrHTML">${candidatePublicity.gsnr}</div>
							</div>
						</td>
					</tr>
					<c:if test="${candidatePublicity.gszt==2 || candidatePublicity.gszt==3 || candidatePublicity.gszt==4}">
						<tr>
							<td class="need"></td>
							<td style="vertical-align:middle">审核意见:</td>
							<td colspan='4'>
								${candidatePublicity.gszt==2?"代理机构审核未通过":candidatePublicity.gszt == 3?"招标人审核未通过":candidatePublicity.gszt == 19?"项目经理审核未通过":"公共服务平台审核未通过"}
							</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="vertical-align:middle">审核意见:</td>
							<td colspan="4">${candidatePublicity.shyj }</td>
						</tr>
					</c:if>
					<tr>
						<td colspan="6" style="padding:10px 0 18px 0;">
						<!-- <input type="hidden" id='sealName' name="sealName" value="SigndataStr"/>
						<input type="hidden" id='signData' name="signData" />
						<input type="hidden" id='SigndataStrSealName' name="SigndataStrSealName" />
						<input type="hidden" id='SigndataStrSignData' name="SigndataStrSignData" /> -->
						<input type="button" class="button red" value="保存草稿" id="saveBtn"/>
						<!-- <input type="button" class='button red' id="sign" value="电子印章"/> -->
						<input type="button" class="button red" value="提交审核" id="subBtn" />
						<input type="button" class="button red" value="返回" onclick="history.go(-1)" />
						</td>
					</tr>
				</table>
			</form>
		</div>		
	</div>
		
</body>