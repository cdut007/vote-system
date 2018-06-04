<%@page pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>

<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply"/>
<c:set value="${expertApply.projectInstance}" var="projectInstance"/>
<c:set value="${expertApply.projectItemList}" var="projectItemList"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" datepicker="true" jgrowl="true" uedit="true" ca="true"/>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			签到管理
			<code>&gt;</code>
			专家签到
		</div>
	</div>
	<div class="block">
		<div clss="usBox">
		专家您好，欢迎参加【${projectInstance} 】招标项目评标活动现场！请点击签到按钮签到。

		 <form action="${pageContext.request.contextPath}/workflow/completeForm" id="form1"> 
			<input type="hidden" name="taskId" value="${taskId}"/>
			<input type="hidden" name="projectInstanceId" value="${expertApply.projectInstanceId}"/>
			<input type="hidden" name="projectInstanceName" value="${projectInstance}"/>
			<input type="hidden" name="expertApplyId" value="${processBusinessKey}"/>
			<input type="hidden" name="userType" value="1"/><br/>
			<table>
		    <tr>
				<td><a class="button red" id="expertPromise">专家承诺书</a></td>
			</tr>
			</table>
			<div class="clearfix" style="height:400px">
				<table id="sign-datagrid"></table>
			</div>
		  <from/>
		</div>
	</div>
</body>

<script type="text/javascript">
$(function(){
	$("#sign-datagrid").datagrid({
		title:"专家签到列表",
		fit:true,
		url:ctx+"/sign/pagingParticipantsExpertsData",
		pagination:true,
		rownumbers:true,
		striped:true,
		method:"post",
		queryParams:{expertApplyId:"${processBusinessKey}",userType:"1"},
		columns:[[
		    {field:'id',checkbox:true},
		    {title:"专家姓名",field:'userName',align:"center",width:100},
		    {title:"身份证号",field:'userNumber',width:120,formatter : function(value,row,index){ 
		    	if(null!=value){
		    		return value.substring(0,6)+"******"+value.substring(13,18) ;
		    	}else{
		    		return value;
		    	}
		    	
		    }},
		    {title:"项目名称",field:'projectInstanceName',width:180},
		    {title:"签到时间",field:'signtime',width:100},
		    {title:"单位名称",field:'unitName',width:180},
		    {title:"联系方式",field:'phoneNumber',width:100}
		]]
	});

	$("#expertPromise").click(function(){
		var taskId= $("input[name='taskId']").val();
		//window.open(ctx+"/expertPromise/expertPromise?expertApplyId=${processBusinessKey}&taskId="+taskId);
		window.location.href=ctx+"/expertPromise/expertPromise?expertApplyId=${processBusinessKey}&taskId="+taskId;
		return ;
		
		//window.location.href="${pageContext.request.contextPath}/sign/expertPromise?expertApplyId=${processBusinessKey}";
		//$("#promise").dialog("open");
		var dialog=$("<div/>").attr("id","promise").css("padding",5).appendTo($("body")).dialog({
			width:800,
			height:600,
			title:"专家承诺书",
			closed:false,
			modal:true,
			maximizable:true,
			href:ctx+"/expertPromise/expertPromise?expertApplyId=${processBusinessKey}",
			//onLoad:function(){
				//alert($("#DocumentID").val());
              //  sealUtil.loadAllSealWithBKey($("#DocumentID").val(),"data=string2sign","promise");
			//  document.all.DWebSignSeal.ShowSeal("${CURRENT_USER_SESSION_INFO.userName}",1);
			//},
			onClose:function(){
				$(this).dialog("destroy");
			},
			buttons:[/*{
					text:'电子签章',
					handler:function(){
						var sealName="${CURRENT_USER_SESSION_INFO.userName}";
		 				sealUtil.addSealWithBKey($("#DocumentID").val(),sealName,"data=string2sign","promise",280,360);
					}
				},*/{
					text:'签到(电子签章)',
					handler:function(){
						var sealName="${CURRENT_USER_SESSION_INFO.userName}";
                        sealUtil.addSealWithBKey($("#DocumentID").val(),sealName,"data=string2sign","promise",280,360);
						if(sealUtil.sealExists(sealName)){
							var taskId= $("input[name='taskId']").val();
							$("#form1").ajaxSubmit({  
	    						type: 'post',  
	   						 	url: ctx+'/workflow/completeForm' ,  
	    						success: function(data){  
		        					$.messager.alert("系统提示","签到成功","",function(){
		        						/* window.location.href=ctx+'/home'; */
		        						$("#promise").dialog("destroy");
		        						/* reload 为什么3次调用后台方法，第一次返回签到前数据；第二次返回签到后数据但是rownumber为-9；第三次显示正常 */
		        						$('#sign-datagrid').datagrid('reload');
		        					});  
		    					},  
	    						error: function(XmlHttpRequest, textStatus, errorThrown){  
	        						$('#sign-datagrid').datagrid('reload');
	     						}  
	 						}); 
 						}else{
 							$.messager.alert("系统提示","请签章！");
 						}
					} 
				},{
					text:'关闭',
					handler:function(){
						$("#promise").dialog("destroy");
					}
				
				}]
		});
	});
	//$("#promise")
});
</script>
</html>