<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@ page language="java"%> 
<%@ page contentType="text/html; charset=utf-8"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.text.*"%>  
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" ca="true" jgrowl="true" plupload="true"/>
<script type='text/javascript' src='/resources/jquery-plugins/jquery.im.js'></script>
<script src="/resources/designer/json2.js" type="text/javascript"></script>
<script src="/resources/page/tender/benchmark_choose_fj.js" type="text/javascript"></script>
<script type="text/javascript">
	
</script>
<body>
	<jsp:include page="/common/top.jsp" />	
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>

<c:set var="fwsz_benchmarkList" value="${benchmarkService.findAllChooseTBBenchmarks_fwsz()}"></c:set>
<c:set var="data" value="${recruitFileService.loadBenchMarkInfo(projectItemId, processBusinessKey)}"></c:set>
<c:set var="recruitFile" value="${recruitFileService.findRecruitFile(projectItemId)}"></c:set>
<c:set var="uniqueMethodId_judg" value="${evaluationMethodService.checkUniqueMethodId(processBusinessKey,projectItemId)}"></c:set>

<div class="block">
<form id="benchmark_choose_form" method="post" action="${pageContext.request.contextPath}/recruitFileData/save_benchmark_fj">

	<input id="id" type="hidden" name="id" value="${data.recruitFile.id}"/>
	<input id="projectItemId" type="hidden" name="projectItemId" value="${projectItemId}"/>
	<input id="expertApplyId" type="hidden" name="expertApplyId" value="${processBusinessKey}"/>
	<input id="uniqueMethodId_judg" type="hidden" value="${uniqueMethodId_judg}"/>
	
	<table>
		<c:if test="${data.benchmarkInstance.variableList.size() > 0 || data.benchmarkInstance.uniqueMethodId != null}">
			<tr>
				<td class="need">*</td>
				<td>评标基准价:</td>
				<td>
					${data.benchmarkInstance.benchmarkName}
					<input type="hidden" id="benchmarkId" name="benchmarkId" value="${data.benchmark.id}">
				</td>
			</tr>
	
				<tr>
					<td class="need">*</td>
					<td style="width:100px">评标基准价系数描述</td>
					<td >
						${data.evaluationMethod.evaluationMethodDescription}
					</td>
					</tr>
		</c:if>
	</table>
	<table style="display:none;" class="ratio_p" id="FWSZ_BMK_1">	
	<c:if test="${empty recruitFile.floatRate }">
		<tr>
			<td class="need">*</td>
			<td style="width:100px">基准价合成范围下浮系数</td>
			<td>
				<c:if test="${uniqueMethodId_judg=='FW' && recruitFile.projectInstance.projectInstanceType=='A01'}">
					<select name="FWSZ_BMK_1_DOWN_RATIO" id="FWSZ_BMK_1_DOWN_RATIO">
						<option value="--" selected >--</option>
						<option value="3" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO=='3'}">selected</c:if> >3%</option>
						<option value="4" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO=='4'}">selected</c:if> >4%</option>
						<option value="5" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO=='5'}">selected</c:if> >5%</option>					
						<option value="6" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO=='6'}">selected</c:if> >6%</option>
					</select>	
				</c:if>
				<c:if test="${uniqueMethodId_judg=='FW' && recruitFile.projectInstance.projectInstanceType=='A02'}">
					<select name="FWSZ_BMK_1_DOWN_RATIO" id="FWSZ_BMK_1_DOWN_RATIO">
						<option value="--" selected >--</option>
						<option value="3" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO=='3'}">selected</c:if> >3%</option>
						<option value="4" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO=='4'}">selected</c:if> >4%</option>
						<option value="5" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO=='5'}">selected</c:if> >5%</option>					
						<option value="6" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO=='6'}">selected</c:if> >6%</option>
						<option value="7" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO=='7'}">selected</c:if> >7%</option>
						<option value="8" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_1_DOWN_RATIO=='8'}">selected</c:if> >8%</option>				
					</select>	
				</c:if>
			</td>
			<td><button style="display:none" id="FWSZ_BMK_1_DOWN_RATIO_RANDOM" type="button" class="button red small" onclick="pleaseRandom(this);">抽 取</button></td>
		</tr>
		</c:if>
		<c:if test="${empty recruitFile.CMPRate }">
			<tr>
				<td class="need">*</td>
				<td style="width:100px">施工组织设计最低分比例</td>
				<td>
					<select name="CMPRate" id="CMPRate">
						<c:forEach begin="60" end="80" var="i">
							<option value="${i }"  >${i }%</option>	
						</c:forEach>
					</select>	
				</td>
			</tr>
		</c:if>		
	</table>
	<table style="display:none;" class="ratio_p" id="FWSZ_BMK_2">	
		<c:if test="${empty recruitFile.floatRate }">
		<tr>
			<td class="need">*</td>
			<td style="width:100px">基准价合成范围下浮系数</td>
			<td>
				<c:if test="${uniqueMethodId_judg=='FW' && recruitFile.projectInstance.projectInstanceType=='A01'}">
					<select name="FWSZ_BMK_2_DOWN_RATIO" id="FWSZ_BMK_2_DOWN_RATIO" onchange="updateFWSZBenchmar('FWSZ_BMK_2');">
						<option value="--" selected >--</option>
						<option value="3" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_DOWN_RATIO=='3'}">selected</c:if> >3%</option>
						<option value="4" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_DOWN_RATIO=='4'}">selected</c:if> >4%</option>
						<option value="5" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_DOWN_RATIO=='5'}">selected</c:if> >5%</option>					
						<option value="6" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_DOWN_RATIO=='6'}">selected</c:if> >6%</option>
					</select>	
				</c:if>
				<c:if test="${uniqueMethodId_judg=='FW' && recruitFile.projectInstance.projectInstanceType=='A02'}">
					<select name="FWSZ_BMK_2_DOWN_RATIO" id="FWSZ_BMK_2_DOWN_RATIO" onchange="updateFWSZBenchmar('FWSZ_BMK_2');">
						<option value="--" selected >--</option>
						<option value="3" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_DOWN_RATIO=='3'}">selected</c:if> >3%</option>
						<option value="4" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_DOWN_RATIO=='4'}">selected</c:if> >4%</option>
						<option value="5" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_DOWN_RATIO=='5'}">selected</c:if> >5%</option>					
						<option value="6" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_DOWN_RATIO=='6'}">selected</c:if> >6%</option>
						<option value="7" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_DOWN_RATIO=='7'}">selected</c:if> >7%</option>
						<option value="8" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_DOWN_RATIO=='8'}">selected</c:if> >8%</option>				
					</select>	
				</c:if>
			</td>
			<td><button style="display:none" id="FWSZ_BMK_2_DOWN_RATIO_RANDOM" type="button" class="button red small" onclick="pleaseRandom(this);">抽 取</button></td>
		</tr>
		</c:if>
		<tr>
			<td class="need">*</td>
			<td style="width:100px">最高投标限价权重</td>
			<td>
				<select name="FWSZ_BMK_2_CONTROL_PRICE_RIGHT" id="FWSZ_BMK_2_CONTROL_PRICE_RIGHT">
					<option value="--" selected >--</option>
					<option value="70" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_CONTROL_PRICE_RIGHT=='70'}">selected</c:if> >70%</option>
					<option value="60" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_CONTROL_PRICE_RIGHT=='60'}">selected</c:if> >60%</option>
					<option value="50" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_CONTROL_PRICE_RIGHT=='50'}">selected</c:if> >50%</option>
				</select>
			</td>
			<td><button style="display:none" id="FWSZ_BMK_2_CONTROL_PRICE_RIGHT_RANDOM" type="button" class="button red small" onclick="pleaseRandom(this);">抽 取</button></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px">有效投标报价的算术平均值权重</td>
			<td>
				<select name="FWSZ_BMK_2_AVG_PRICE_RIGHT" id="FWSZ_BMK_2_AVG_PRICE_RIGHT" disabled="disabled">
					<option value="--" selected >--</option>
					<option value="30" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_AVG_PRICE_RIGHT=='30'}">selected</c:if> >30%</option>
					<option value="40" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_AVG_PRICE_RIGHT=='40'}">selected</c:if> >40%</option>
					<option value="50" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_2_AVG_PRICE_RIGHT=='50'}">selected</c:if> >50%</option>
				</select>
			</td>
		</tr>
		<c:if test="${empty recruitFile.CMPRate }">
			<tr>
				<td class="need">*</td>
				<td style="width:100px">施工组织设计最低分比例</td>
				<td>
					<select name="CMPRate" id="CMPRate">
						<c:forEach begin="60" end="80" var="i">
							<option value="${i }"  >${i }%</option>	
						</c:forEach>
					</select>	
				</td>
			</tr>
		</c:if>		
	</table>
	<table style="display:none;" class="ratio_p" id="FWSZ_BMK_3">
		<c:if test="${empty recruitFile.floatRate }">
		<tr>
			<td class="need">*</td>
			<td style="width:100px">基准价合成范围下浮系数</td>
			<td>
				<c:if test="${uniqueMethodId_judg=='FW' && recruitFile.projectInstance.projectInstanceType=='A01'}">
					<select name="FWSZ_BMK_3_DOWN_RATIO" id="FWSZ_BMK_3_DOWN_RATIO" onchange="updateFWSZBenchmar('FWSZ_BMK_3');" >
						<option value="--" selected >--</option>
						<option value="3" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='3'}">selected</c:if> >3%</option>
						<option value="4" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='4'}">selected</c:if> >4%</option>
						<option value="5" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='5'}">selected</c:if> >5%</option>					
						<option value="6" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='6'}">selected</c:if> >6%</option>
					</select>	
				</c:if>
				<c:if test="${uniqueMethodId_judg=='FW' && recruitFile.projectInstance.projectInstanceType=='A02'}">
					<select name="FWSZ_BMK_3_DOWN_RATIO" id="FWSZ_BMK_3_DOWN_RATIO" onchange="updateFWSZBenchmar('FWSZ_BMK_3');" >
						<option value="--" selected >--</option>
						<option value="3" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='3'}">selected</c:if> >3%</option>
						<option value="4" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='4'}">selected</c:if> >4%</option>
						<option value="5" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='5'}">selected</c:if> >5%</option>					
						<option value="6" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='6'}">selected</c:if> >6%</option>
						<option value="7" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='7'}">selected</c:if> >7%</option>
						<option value="8" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='8'}">selected</c:if> >8%</option>				
					</select>	
				</c:if>
			</td>
			<td><button style="display:none" id="FWSZ_BMK_3_DOWN_RATIO_RANDOM" type="button" class="button red small" onclick="pleaseRandom(this);">抽 取</button></td>
		</tr>
		</c:if>
		<c:if test="${empty recruitFile.CMPRate }">
			<tr>
				<td class="need">*</td>
				<td style="width:100px">施工组织设计最低分比例</td>
				<td>
					<select name="CMPRate" id="CMPRate">
						<c:forEach begin="60" end="80" var="i">
							<option value="${i }"  >${i }%</option>	
						</c:forEach>
					</select>	
				</td>
			</tr>
		</c:if>		
	</table>
	<table style="display:none;" class="ratio_p" id="FWSZ_BMK_4">	

		<tr>
			<td class="need">*</td>
			<td style="width:100px">房屋市政勘察权数选择：</td>
			<td>
				<select name="FWSZ_BMK_4_WEIGHT" id="FWSZ_BMK_4_WEIGHT">
					<option value="--" selected >--</option>
					<option value="6/4" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_4_WEIGHT=='6/4'}">selected</c:if> >6/4</option>
					<option value="5/5" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_4_WEIGHT=='5/5'}">selected</c:if> >5/5</option>
					<option value="4/6" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_4_WEIGHT=='4/6'}">selected</c:if> >4/6</option>					
					<option value="3/7" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_4_WEIGHT=='3/7'}">selected</c:if> >3/7</option>
				</select>	
			</td>
			<td><button style="display:none" id="FWSZ_BMK_4_WEIGHT_RANDOM" type="button" class="button red small" onclick="pleaseRandom(this);">抽 取</button></td>
		</tr>
	</table>
	<table style="display:none;" class="ratio_p" id="FWSZ_BMK_5">	
		<c:if test="${empty recruitFile.floatRate }">
			<tr>
				<td class="need">*</td>
				<td style="width:100px">经评审的最低投标价法(房建)下浮系数：</td>
				<td>
					<c:if test="${uniqueMethodId_judg=='FW' && recruitFile.projectInstance.projectInstanceType=='A01'}">
						<select name="FWSZ_BMK_5_DOWN_RATIO" id="FWSZ_BMK_5_DOWN_RATIO"  >	<!-- onchange="updateFWSZBenchmar('FWSZ_BMK_5');" -->
							<option value="--" selected >--</option>
							<option value="3" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='3'}">selected</c:if> >3%</option>
							<option value="4" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='4'}">selected</c:if> >4%</option>
							<option value="5" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='5'}">selected</c:if> >5%</option>					
							<option value="6" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='6'}">selected</c:if> >6%</option>
						</select>	
					</c:if>
					<c:if test="${uniqueMethodId_judg=='FW' && recruitFile.projectInstance.projectInstanceType=='A02'}">
						<select name="FWSZ_BMK_5_DOWN_RATIO" id="FWSZ_BMK_5_DOWN_RATIO"  >	<!-- onchange="updateFWSZBenchmar('FWSZ_BMK_5');" -->
							<option value="--" selected >--</option>
							<option value="3" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='3'}">selected</c:if> >3%</option>
							<option value="4" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='4'}">selected</c:if> >4%</option>
							<option value="5" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='5'}">selected</c:if> >5%</option>					
							<option value="6" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='6'}">selected</c:if> >6%</option>
							<option value="7" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='7'}">selected</c:if> >7%</option>
							<option value="8" <c:if test="${data.benchmarkInstanceVariables.FWSZ_BMK_3_DOWN_RATIO=='8'}">selected</c:if> >8%</option>				
						</select>	
					</c:if>
				</td>
				<td><button style="display:none" id="FWSZ_BMK_5_DOWN_RATIO_RANDOM" type="button" class="button red small" onclick="pleaseRandom(this);">抽 取</button></td>
			</tr>
		</c:if>
		<c:if test="${empty recruitFile.CMPRate }">
			<tr>
				<td class="need">*</td>
				<td style="width:100px">施工组织设计最低分比例</td>
				<td>
					<select name="CMPRate" id="CMPRate">
						<c:forEach begin="60" end="80" var="i">
							<option value="${i }"  >${i }%</option>	
						</c:forEach>
					</select>	
				</td>
			</tr>
		</c:if>		
	</table>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<input type="hidden" name="" id="controlPrice" value="${data.controlPrice}" />
</form>
</div>
	<div class="block">
		<button id="randomData" type="button" class="button red" onclick="random();">平台随机抽取</button>
		<button class="button red" onclick="submitBenchMark();">提  交</button>
	</div>
	<form action="${pageContext.request.contextPath}/workflow/completeForm" id="form2">
			<input type="hidden" name="taskId" value="${taskId}" /> 
			<input type="hidden" name="message" value="${message}" />
	</form>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
<script type="text/javascript">
var controlPrice = ${data.controlPrice};
var avgPrice = ${data.avgPrice};

$(function(){
	//alert("控制价："+controlPrice);
	//alert("平均价："+avgPrice);
	//alert("${jt_benchmarkList}");
	//alert("${fwsz_benchmarkList}");
	//var uniqueMethodId = "${uniqueMethodId}";
	//if(uniqueMethodId==null || uniqueMethodId==""){
	//	uniqueMethodId = "${recruitFile.evaluationMethodInstance.evaluationMethod.uniqueMethodId}"
	//}
	//var uniqueMethodId_head = uniqueMethodId.substring(0,2);
	//alert(uniqueMethodId_head);
	
	if("${data.benchmarkInstance.benchmarkName}"=="评标基准价1(房建)"){
		$("#FWSZ_BMK_1").show();
	}else if("${data.benchmarkInstance.benchmarkName}"=="评标基准价2(房建)"){
		$("#FWSZ_BMK_2").show();
	}else if("${data.benchmarkInstance.benchmarkName}"=="评标基准价3(房建)"){
		$("#FWSZ_BMK_3").show();
	}else if("${data.benchmarkInstance.benchmarkName}"=="房屋市政勘察评标基准价"){
		$("#FWSZ_BMK_4").show();
	}else if("${data.benchmarkInstance.benchmarkName}"=="经评审的最低投标价法(房建)"){
		$("#FWSZ_BMK_5").show();
	}
	$("#uniqueMethodId_judg").val("${uniqueMethodId_judg}");
});

$("#${data.benchmark.uniqueMethodId}").show();
var uniqueMethodId = "${data.benchmark.uniqueMethodId}";
/***************************************************************************
 * 加载评分办法描述
 */
var size = ${data.benchmarkInstance.variableList.size()};
if(size==0){
	$("#benchmarkId").change(function() {
		var benchmarkId = this.value;	
		uniqueMethodId = $("#"+benchmarkId).val();
		$(".benchmarkDescription").hide();
		$("#benchmarkDescription_" + benchmarkId).show();
		$(".ratio_p").hide();
		
		$("#" + uniqueMethodId).show();
	}).change();
}


$("#FWSZ_BMK_2_CONTROL_PRICE_RIGHT").change(function() {
	var selvalue = $('#FWSZ_BMK_2_CONTROL_PRICE_RIGHT option:selected') .val();//选中的值
	var selvalue_next = 100 - Number(selvalue);
	$("#FWSZ_BMK_2_AVG_PRICE_RIGHT").val(100-selvalue);
}).change();


disableInvalidBidFile();

function submitBenchMark(){
	//$.removeAttr("disabled");
	$("input").prop("disabled",false);
	$("select").prop("disabled",false);
	
	$("#benchmark_choose_form").ajaxSubmit({
		dataType:"json",
		beforeSend:function(){
			$.messager.progress({
				title:"系统提示",
				msg:"正在提交,请稍后..."
			});
			return $("#benchmark_choose_form").form("validate");
		},
		success:function(data){
			if(data.msg){
				$.messager.alert("系统提示",data.msg);
			}
			if(data.success){
				$("#form2").submit();
			}
		},
		complete:function(){
			$.messager.progress("close");
		}
	});
}

function updateFWSZBenchmar(method){
	var downRate = 0;
	$(".FWSZ_BMK_BIDDER").hide();
	$("#"+method + " input[type=checkbox]").attr("checked", false);
	if(method == "FWSZ_BMK_3"){
		downRate = $("#FWSZ_BMK_3_DOWN_RATIO").val();
	}else if(method == "FWSZ_BMK_2"){
		downRate = $("#FWSZ_BMK_2_DOWN_RATIO").val();
	}else if(method == "FWSZ_BMK_1"){
		downRate = $("#FWSZ_BMK_1_DOWN_RATIO").val();
	}
	
	$.ajax({
		url : ctx + "/recruitFileData/retriveEvaluationBidFiles",
		type : "POST",
		dataType : "json",
		data : {
			expertApplyId : "${processBusinessKey}",
			projectItemId : "${projectItemId}",
			downRate: downRate
		},
		success : function(data) {
			if (data.success) {
				var list = eval(data.data);
				  list.forEach(function(e){
					  if(method == "FWSZ_BMK_3"){
						  $("#"+e.id+"FWSZ_BMK_3").show();
					  }else if(method == "FWSZ_BMK_2"){
						  $("#"+e.id+"FWSZ_BMK_2").show();
					  }
				  });
				
				}
			}
	});
}

</script>