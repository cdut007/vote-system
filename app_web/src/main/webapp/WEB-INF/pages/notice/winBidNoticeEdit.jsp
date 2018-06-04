<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<sys:link easyui="true" datepicker="true" jgrowl="true" uedit="true" ca="true"/>
<script>
	$(function() {
		//var sealName=$("#sealName").val();
		/* $("#sign").click(function(){
			var signData=sealUtil.addSeal(sealName,["noticeContent"],"noticeCont",0,0);
			$("#SigndataStrSealName").val(sealName);
			$("#SigndataStrSignData").val(signData);
		});	 */
		function autoTitle(){
			var projectInstanceId = $("#projectInstanceId").val();
			var projectInstanceName = $("#projectInstanceId").children("option[value='" + projectInstanceId + "']").html();
			var projectItemName = $('#bdjh').combotree("getText");
			if(projectInstanceId==""){
				$(":input[name='noticeTitle']").val();
				return;
			}
			$(":input[name='noticeTitle']").val(projectInstanceName + "(" + projectItemName + ")中标结果公告");
		}
		$("#projectInstanceId").change(function() {
			//loadProjectItemList();
			 $("#bdjh").combotree(this.value==""?"disable":"enable");
			if(this.value!=""){
				$("#bdjh").combotree("setValue",[]);
				$("#bdjh").combotree("reload",ctx+'/projectItem/pagingProjectItemDataForNotice?noticeType=winbid&projectInstanceId='+$("#projectInstanceId").val()+ "&noticeId=" + $("#id").val());
			}
		});
		$(".Wdate").focus(function() {
			WdatePicker({
				dateFmt : 'yyyy-MM-dd',
				onpicked : loadDefaultWinBidNotice
			});
		});
		$(":input").filter(function(){
			return !$(this).hasClass("Wdate")&&$(this).attr("type")=="text";
		}).blur(function(){
			loadDefaultWinBidNotice();
		});
		$("#organBList").on("change",":radio",function(){
			loadDefaultWinBidNotice();
		});
		$("#save").click(function(){
			$("#publicityForm").ajaxSubmit({
				beforeSend:function(){
					var projectItemIdArray= $('#bdjh').combotree("getValues");
 					if(projectItemIdArray.length==0){
						$.jGrowl("请选择标段！");
						return false;
					} 
					for(var i=0,l=projectItemIdArray.length;i<l;i++){
						var projectItemId=projectItemIdArray[i];
						if($(":radio[name='"+projectItemId+"']:checked").length==0){
							$.jGrowl("请选择中标人！");
							return false;
						}
					}
					var validate=$("#publicityForm").form("validate");
					if(validate){
						$.messager.progress({title:"系统提示",msg:"正在加载标段信息"}); 
					}
					return validate;
				},
				complete:function(){
					$.messager.progress("close"); 
				},
				dataType:"json",
				data:{isComplete:false},
				success:function(data){
					$.jGrowl(data.msg);
				}
			});
		});
		$("#submit").click(function(){
			//提交时判断又没有章，
			//alert($("#sealName").val());
			/* if(!sealUtil.sealExists(sealName)){
				$.messager.alert('系统提示',"请先盖章！");
				return false;	
			} */
			$("#publicityForm").ajaxSubmit({
				beforeSend:function(){
					var projectItemIdArray= $('#bdjh').combotree("getValues");
 					if(projectItemIdArray.length==0){
						$.jGrowl("请选择标段！");
						return false;
					} 
					for(var i=0,l=projectItemIdArray.length;i<l;i++){
						var projectItemId=projectItemIdArray[i];
						if($(":radio[name='"+projectItemId+"']:checked").length==0){
							$.jGrowl("请选择中标人！");
							return false;
						}
					}
					var validate=$("#publicityForm").form("validate");
					if(validate){
						$.messager.progress({title:"系统提示",msg:"正在加载标段信息"}); 
					}
					return validate;
				},
				complete:function(){
					$.messager.progress("close"); 
				},
				dataType:"json",
				data:{isComplete:true},
				success:function(data){
					$.jGrowl(data.msg);
					// 设置提交审核成功后跳转到中标公告列表页面，为什么href不是ctx+"winBidNotice/pagingWinBidNotice"?
					window.location.href=ctx+"pagingWinBidNotice";
				}
			});
		});
		function loadProjectItemList(){
			$.ajax({
				type : "post",
				url : ctx + "/notice/findProjectItemList",
				data : $("#publicityForm").serialize(),
				dataType : "json",
				success : function(data) {
					$("#bdjh").html($(data).map(function(){
						return "<input id=\""+this.id+"\" type='radio' name='projectItemId' value='"+this.id+"'/><label for=\""+this.id+"\">" + this.bdmc00 + "</label>";
					}).get().join(""));
				}
			});
		}
		function loadOrganBList(){
			$.ajax({
				url:ctx+"/winBidNotice/loadOrganBList",
				type:"post",
				data : $("#publicityForm").serialize(),
				dataType:"json",
				success:function(data){
					$("#organBList").html($(data).map(function(i){
						var projectItemId=this["projectItemId"];
						return "<div>"+this["projectItemName"]+$(this["organBList"]).map(function(i){
							return "</div><div>第"+(i==0?"一":i==1?"二":"三")+"中标候选人:&nbsp;&nbsp;<input type=\"radio\" name=\""+projectItemId+"\" id=\""+projectItemId+this["id"]+"\" value=\""+this["id"]+"\"/><label for=\""+projectItemId+this["id"]+"\">"+this["ztmc00"]+"</label></div>";
						}).get().join("");
					}).get().join("<br/>"));
				}
			});
		}
		function loadDefaultWinBidNotice() {
			
			var projectInstanceId = $("#projectInstanceId").val();
			if(projectInstanceId &&projectInstanceId!=""){
				$.ajax({
					url : ctx + "/winBidNotice/defaultWinBidNotice",
					type : "post",
					data : $("#publicityForm").serialize(),
					dataType : "html",
					success : function(data) {
						$("#noticeContent").val(data);
						$("#noticeContentHTML").html(data);
						$("#"+sealName).remove();
						//document.all.DWebSignSeal.DelSeal("SigndataStr");
					}
				});
			}
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
			onlyLeafCheck:true,  
			multiple:false,
		    url:ctx+'/projectItem/pagingProjectItemDataForNotice?noticeType=winbid&projectInstanceId='+$("#projectInstanceId").val() + "&noticeId=" + $("#id").val(),
		    required: true,
		    disabled:$("#projectInstanceId").val()=='',
		    onBeforeLoad:function(){
		    	var needLoad=$("#projectInstanceId").val()!="";
		    	if(needLoad){
		    		$.messager.progress({title:"系统提示",msg:"正在加载标段信息"}); 
		    	}
		    	return needLoad;
		    },
		    onLoadSuccess:function(){
		    	$.messager.progress("close"); 
		    	loadOrganBList();
		    },
		    onCheck:function(node,checked){
		    	autoTitle();
		    	loadDefaultWinBidNotice(),//中标通知
		    	loadOrganBList();//中标人
			}, 
		    onChange:function(newValue,oldValue){
		    	loadDefaultWinBidNotice(),//中标通知
		    	loadOrganBList();//中标人
		    	autoTitle();
		    } 
		}); 
		/* var tree=$("#bdjh").combotree('tree');
		tree.tree({onBeforeSelect:function(node){var isLeaf = node.children==undefined||node.children==null||node.children.length==0;if(!isLeaf){$.messager.alert("系统提示","不能选择包,请选择标段!");} return isLeaf;}}); */
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
			中标公告管理
			<code>&gt;</code>
			添加中标公告
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				<c:choose>
					<c:when test="${winBidNotice.id==null}">新增</c:when>
					<c:otherwise>修改</c:otherwise>
				</c:choose>
				中标公告
			</h4>
			<form:form id="publicityForm" method="post" action='${pageContext.request.contextPath}/winBidNotice/createOrUpdateWinBidNotice' modelAttribute="winBidNotice">
				<form:hidden path="id"/>
				<form:hidden path="noticeContent" id="noticeContent"/>
				<input type="hidden" name="token" value="${token}"/>
				<table style="table-layout:fixed;width:100%">
					<col style="width:10px"/>
					<col style="width:100px"/>
					<col/>
					<col style="width:10px"/>
					<col style="width:100px"/>
					<col/>
					<tr>
						<td class="need">*</td>
						<td>招标项目名称：</td>
						<td colspan="4">
							<form:select path="projectInstanceId" cssStyle="width:99%">
								<form:option value="" label="---==请选择==---"/>
								<form:options items="${projectInstanceList}" itemLabel="zbxmmc" itemValue="id"/> 
							</form:select>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td style="vertical-align:middle;">标段（包）:</td>
						<td style="padding-left:3px;" colspan="4">
							<select id="bdjh"  name="projectItemList">
								<c:forEach items="${winBidNotice.projectItemList}" var="projectItem">
									<option value="${projectItem.id}" selected="selected">${projectItem}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td>公告标题：</td>
						<td style="text-align: left" colspan="4">
							<form:input cssStyle="width:99%" path="noticeTitle" cssClass="inputxt easyui-validatebox" data-options="required:true"/>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td>公告开始时间：</td>
						<td style="text-align: left">
							<form:input path="publishDate" cssClass="inputxt Wdate easyui-validatebox"  data-options="required:true"/>
						</td>
						<td class="need">*</td>
						<td>公告结束时间：</td>
						<td style="text-align: left">
							<form:input path="deadline" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true"/>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td>中标人：</td>
						<td colspan="4" id="organBList">
							<c:forEach items="${organBList}" var="organB" varStatus="status">
								<div>
									第${status.count==1?"一":status.count==2?"二":"三"}中标候选人:&nbsp;&nbsp;<input type="radio" name="organId" value="${organB.id}" id="${organB.id}" ${organB.id eq winBidNotice.organId?"checked='checked'":""}/><label>${organB}</label>
								</div>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>联系人：</td>
						<td>
							<form:input path="contacts" cssClass="inputxt easyui-validatebox" data-options="required:true"/>
						</td>
						<td class="need" style="width:10px;">*</td>
						<td>联系电话：</td>
						<td>
							<form:input path="phone" cssClass="inputxt easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>电子邮箱：</td>
						<td>
							<form:input path="email" cssClass="inputxt easyui-validatebox" data-options="required:true" />
						</td>
						<td class="need" style="width:10px;"></td>
						<td>其他内容：</td>
						<td>
							<form:input path="otherContent" cssClass="inputxt" />
						</td>
					</tr>
					<tr>
						<td colspan="6">
							<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
								<span id="noticeCont"></span><div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;" id="noticeContentHTML">${winBidNotice.noticeContent}</div>
							</div>
						</td>
					</tr>
					<c:if test="${winBidNotice.reviewStatus==2 || winBidNotice.reviewStatus==3 || winBidNotice.reviewStatus==4}">
						<tr>
							<td class="need"></td>
							<td style="vertical-align:middle">审核意见:</td>
							<td colspan='4'>
								${winBidNotice.reviewStatus == 2?"项目经理审核未通过":candidatePublicity.gszt == 3?"招标人审核未通过":"公共服务平台审核未通过"}
							</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="vertical-align:middle">审核意见:</td>
							<td colspan="4">${winBidNotice.reviewComment }</td>
						</tr>
					</c:if>
					<tr>
						<td colspan="6" style="padding:10px 0 18px 0;">
							<input type="hidden" id='sealName' name="sealName" value="SigndataStr"/>
							<input type="hidden" id='signData' name="signData" />
							<input type="hidden" id='SigndataStrSealName' name="SigndataStrSealName" />
							<input type="hidden" id='SigndataStrSignData' name="SigndataStrSignData" />
							<input type="button" id="save" class="button red" value="保存草稿"/> 
							<!-- <input type="button" class='button red' id="sign" value="电子印章"/> -->
							<input type="button" id="submit" class="button red" value="提交审核"/> 
							<a class="button red" href="${pageContext.request.contextPath}/winBidNotice/pagingWinBidNotice">返回</a>
						</td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</body>
</html>