<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" datepicker="true" jgrowl="true" uedit="true" ca="true"/>
<script type="text/javascript"></script>
<script>
	$(function() {
		//电子印章部分
		//var sealName=$("#sealName").val();
		/* $("#sign").click(function(){
			var signData=sealUtil.addSeal(sealName,["gsnr"],"gsnrss",150,200);
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
			var publicityType="${util:dictionary('GSLXDM',candidatePublicity.gslx)}";
			if(projectItemName.split(",").length!=1){
				$(":input[name='publicityTitle']").val(projectInstanceName + "(" + projectItemName + ")"+(publicityType=="正常公示"?"中标候选人公示":publicityType));
			}else{
				$(":input[name='publicityTitle']").val(projectInstanceName + (publicityType=="正常公示"?"中标候选人公示":publicityType));
			}
			
		}
		$("#projectInstanceId").change(function() {
			$("#bdjh").combotree(this.value==""?"disable":"enable");
			if(this.value!=""){
				$("#bdjh").combotree("setValue",[]);
				$("#bdjh").combotree("reload",ctx+'/projectItem/pagingProjectItemDataForNotice?noticeType=candi&projectInstanceId='+this.value+ "&noticeId=" + $("#id").val());
			}
			autoTitle();
		});
		$("#gslx").change(function(){
			autoTitle();
		});
		$(document).on("blur",":input", function() {
			if($(this).attr("type")=="button"||$(this).attr("type")=="submit"){
				return;
			}
			loadDefaultCandidatePublicity();
		});
		/* $(".Wdate").focus(function() {
			WdatePicker({
				dateFmt : 'yyyy-MM-dd',
				onpicked : loadDefaultCandidatePublicity
			});
		}); */
		function loadDefaultCandidatePublicity() {
			$.ajax({
				url : ctx + "/candidatePublicity/defaultCandidatePublicity",
				type : "post",
				data : $("#publicityForm").serialize(),
				dataType : "html",
				success : function(data) {
					$("#gsnr").val(data);
					$("#gsnrHTML").html(data);
					document.all.DWebSignSeal.DelSeal("SigndataStr");
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
				for(var i=0,l=leafId.length;i<l;i++){
					var id=leafId[i];
					var n=$(this).tree("find",id);
					//alert(n);
					$(this).tree("check",n.target);
				}
			},
			loadFilter:function(data,parent){
				return [{text:"全部",id:"",children:data}];
			},
			multiple:true,
			onlyLeafCheck:true,  
		    url:ctx+'/projectItem/pagingProjectItemDataForNotice?noticeType=candi&projectInstanceId='+$("#projectInstanceId").val()+ "&noticeId=" + $("#id").val(),
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
		    onCheck:function(newValue,oldValue){
		    	autoTitle();
		    	loadDefaultCandidatePublicity();
		    }
		}); 
		function formSubmit(submitType) {
			$("#publicityForm").ajaxSubmit({
				dataType:"json",
				type:"post",
				beforeSend:function(){
					var valid = true;
					if(2 == submitType){
						/* if(!sealUtil.sealExists(sealName)){
							$.messager.alert('系统提示',"请先盖章！");
							return false;	
						} */
						
						valid = $("#publicityForm").form("validate");
					}
					return valid;
				},
				data:{expertApplyId:"${processBusinessKey}",isComplete:2 == submitType},
				success:function(data){
					if(data.success){
						$.jGrowl(data.msg);
						history.go(-1);
					}else{
						$.messager.alert("系统提示",data.msg);
					}
					//window.location.href="/candidatePublicity/publicityLayout";
				},
				error:function(e,s1,s2){
					$.messager.alert(s1);
				}
			});
		}
		//变更公示
		$("#gsnrHTML").blur(function(){
			$("#gsnr").val(this.innerHTML);
			$("#"+sealName).remove();
		});
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
			中标候选人公示管理
			<code>&gt;</code>
			添加公示
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				<c:choose>
					<c:when test="${candidatePublicity.id==null}">新增</c:when>
					<c:otherwise>修改</c:otherwise>
				</c:choose>
				中标候选人公示
			</h4>
			<form:form id="publicityForm" method="post" action='${pageContext.request.contextPath}/candidatePublicity/createOrUpdatePublicity' modelAttribute="candidatePublicity">
				<form:hidden path="id" />
				<form:hidden path="gsnr" id="gsnr" />
				<input type="hidden" value="${token}" name="token" />
				<table width="100%" style="table-layout:fixed">
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:12%">招标项目名称：</td>
						<td colspan="4">
							<form:select path="projectInstanceId" cssStyle="width:99%" >
								<form:option value="" label="---==请选择==---"/>
								<form:options items="${projectInstanceList}" itemValue="id" itemLabel="zbxmmc"/>
							</form:select>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td style="vertical-align:middle;">标段（包）:</td>
						<td style="padding-left:3px;" colspan="4">
							<select id="bdjh"  name="projectItemList" multiple="multiple">
								<c:forEach items="${candidatePublicity.projectItemList}" var="projectItem">
									<option value="${projectItem.id}" selected="selected">${projectItem}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>公示标题：</td>
						<td style="text-align: left" colspan="4">
							<input type="text" style="width:99%" value="${candidatePublicity.publicityTitle}" name="publicityTitle" nullmsg="请填写公示标题！" data-options="required:true" class="inputxt" datatype="s1-100" />
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:12%;">公示类型：</td>
						<td colspan="4">
							<%-- <form: path="gslx">
								<c:forEach items="${util:dictionaryTree('GSLXDM',false)}" var="item">
									<form:option value="${item.itemCode}" label="${item.itemName}"/>
								</c:forEach>
								${util:dictionaryTree('GSLXDM',false)}
							</form:select> --%>
							<form:hidden path="gslx"/>
							${util:dictionary('GSLXDM',candidatePublicity.gslx)}
							<%-- ${util:dictionaryTree('GSLXDM',candidatePublicity.gslx)} --%>
						</td>
					</tr>
					</table>
					<table width="100%" style="table-layout:fixed">
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:12%">公示开始时间：</td>
						<td>
							<%-- <input type="text" id="gskssj" value="<fmt:formatDate value="${candidatePublicity.gskssj}" type="both" dateStyle="default" timeStyle="default" />" name="gskssj" class="inputxt Wdate" nullmsg="请选择公示开始时间！" /> --%>
							<input type="text" id="gskssj" value="<fmt:formatDate value="${candidatePublicity.gskssj}" type="both" pattern="yyyy-MM-dd" dateStyle="default" timeStyle="default" />" name="gskssj" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" nullmsg="请选择公示开始时间！"/>
						</td>
						<td class="need" style="width:10px;">*</td>
						<td style="width:12%">公示结束时间：</td>
						<td>
							<input type="text" id="gsjssj" value="<fmt:formatDate value="${candidatePublicity.gsjssj}" type="both" pattern="yyyy-MM-dd" dateStyle="default" timeStyle="default" />" name="gsjssj" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" nullmsg="请选择公示结束时间！"/>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>提出异议的渠道和方式：</td>
						<td>
							<form:input path="objectionsWay" cssClass="inputxt" />
						</td>
						<td class="need" style="width:10px;"></td>
						<td>其他内容：</td>
						<td>
							<form:input path="otherContent" cssClass="inputxt" />
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>联系人：</td>
						<td>
							<form:input path="contacts" cssClass="inputxt" />
						</td>
						<td class="need" style="width:10px;">*</td>
						<td>联系电话：</td>
						<td>
							<form:input path="phone" cssClass="inputxt" />
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>电子邮箱：</td>
						<td>
							<form:input path="email" cssClass="inputxt" />
						</td>
						<td class="need" style="width:10px;"></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="6">
							<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
								<span id="gsnrss"></span><div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;" id="gsnrHTML" ${candidatePublicity.gslx=='1' or candidatePublicity.gslx=='3'?"contenteditable='true'":"contenteditable='true'"}>${candidatePublicity.gsnr}</div>
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
							<input type="hidden" id='sealName' name="sealName" value="SigndataStr"/>
							<input type="hidden" id='signData' name="signData" />
							<input type="hidden" id='SigndataStrSealName' name="SigndataStrSealName" />
							<input type="hidden" id='SigndataStrSignData' name="SigndataStrSignData" />
							<input type="button" class="button red" value="保存草稿" id="saveBtn"/>
							<!-- <input type="button" class='button red' id="sign" value="电子印章"/> -->
							<input type="button" class="button red" value="提交审核" id="subBtn" />
							<input type="button" class="button red" value="返回" onclick="history.go(-1)" />
						</td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</body>
</html>