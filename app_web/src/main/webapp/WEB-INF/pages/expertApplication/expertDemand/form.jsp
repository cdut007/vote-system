<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<form:form modelAttribute="expertDemand" method="post">
	<form:hidden path="id"/>
	<form:hidden path="expertApplyId" />
	<table style="width:100%;">
		<tr>
			<td class="need"></td>
			<td style="width:100px;">标段：</td>
			<td style="width:210px;" id="dementDialogItem">
				
			</td>
		</tr>
		<tr>
			<td class="need" style="width:10px;">*</td>
			<td style="width:100px;">专家级别：</td>
			<td style="width:210px;">
				<form:select  path="expertLevel">
					<form:option value="" label="---==请选择==---"/>
					<form:options items="${util:dictionaryTree('EXPERT_LEVEL',false)}" itemValue="itemCode" itemLabel="itemName"/>
				</form:select>
			</td>
		</tr>
		<tr>
			<td class="need" style="width:10px;">*</td>
			<td style="width:100px;">专业分类一级类别：</td>
			<td style="width:210px;">
				<select id="specialtyFirstType" name="specialtyFirstType">
				</select>
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">专业分类二级类别：</td>
			<td style="width:210px;">
				<select id="specialtySecondType" name="specialtySecondType">
				</select>
			</td>
		</tr>
		<tr>
			<td class="need" style="width:10px;">*</td>
			<td style="width:100px;">专业分类三级类别：</td>
			<td style="width:210px;">
				<select id="specialtyThirdType" name="specialtyThirdType">
				</select>
			</td>
		</tr>
		<tr>
			<td class="need" style="width:10px;">*</td>
			<td style="width:100px;">抽取人数：</td>
			<td style="width:210px;"><form:input path="expertCount"  cssClass="inputxt"/></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">报到时间：</td>
			<td style="width:210px;">
				<form:input path="expertCheckInTime" cssClass="inputxt Wdate"/>
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">报到地点：</td>
			<td style="width:210px;">
				<form:input path="expertCheckInAddress" cssClass="inputxt"/>
			</td>
		</tr>
		<%-- <tr>
			<td></td>
			<td style="width:100px;">备注：</td>
			<td colspan="4"><form:textarea path="beizhu" datatype="*" cssStyle="width:90%"/></td>
		</tr> --%>
		<%-- <tr>
			<td class="need">*</td>
			<td style="width:100px;">限制单位1人：</td>
			<td style="width:210px;">
				<input type="radio" name="oneOrgOnePerson" value="1" checked="checked"/>是
				<input type="radio" name="oneOrgOnePerson" value="0"/>否
			</td>
			<td colspan="3"></td>
		</tr>
		<tr>
			<td class="need" style="width:10px;">*</td>
			<td style="width:100px;">专家类别：</td>
			<td style="width:210px;"><form:select path="zjlb00" items="${util:dictionaryTree('ZJLB00',false)}" datatype="*" nullmsg="请选择专家类别！"  itemValue="itemCode" itemLabel="itemName"/></td>
			<td class="need">*</td>
			<td style="width:100px;">是否应急：</td>
			<td style="width:210px;">
				<input type="radio" name="urgency" value="1"/>是
				<input type="radio" name="urgency" value="0" checked="checked"/>否
			</td>
		</tr>
		<tr>
			<td class="need" style="width:10px;">*</td>
			<td style="width:100px;">是否异地：</td>
			<td style="width:210px;">
				<input type="radio" name="remote" value="1"/>是
				<input type="radio" name="remote" value="0" checked="checked"/>否
			</td>
			<td class="need">*</td>
			<td style="width:100px;">第几专业：</td>
			<td style="width:210px;">
				<input type="radio" name="specialtyIndex" value="1" checked="checked">1
				<input type="radio" name="specialtyIndex" value="0">不限制
			</td>
		</tr>
		<tr>
			<td class="need" style="width:10px;">*</td>
			<td style="width:100px;">职业资格：</td>
			<td style="width:210px;"><form:select path="zyzgbm" items="${ZYZGBM}" datatype="*" nullmsg="请选择职业资格！"  itemValue="itemCode" itemLabel="itemName"/></td>
			<td class="need">*</td>
			<td class="need" style="width:10px;">*</td>
			<td style="width:100px;">评审品目：</td>
			<td style="width:210px;"><form:input path="pspm00"  cssClass="inputxt" datatype="*" nullmsg="请选择评审品目！"/></td>
		</tr> --%>
	</table>
</form:form>
<script type="text/javascript">
$(function(){
	$("#expertCheckInTime").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss'
		});
	});
	function jsoncallback(json,index){
		//json = eval("("+json+")");
		if(json){
			var optionHtml = "<option value=''>---==请选择==---</option>";
			if(index == 3){
				optionHtml += "<option value=00>不包括中级职称</option>";
			}
			json.sort(function(a,b){
				return a.value<b.value?-1:1;
			});
			for(var i = 0;i< json.length;i++){
				optionHtml += "<option value="+json[i].id+">"+json[i].text+"</option>";
			}
			index=parseInt(index);
			switch(index){
				case 0:$("#specialtyFirstType").html(optionHtml);$("#specialtySecondType").html("<option value=''>---==请选择==---</option>");$("#specialtyThirdType").html("<option value=''>---==请选择==---</option>");break;
				case 1:$("#specialtySecondType").html(optionHtml);$("#specialtyThirdType").html("<option value=''>---==请选择==---</option>");break;
				case 2:$("#specialtyThirdType").html(optionHtml);break;
				case 3:$("#expertLevel").html(optionHtml);break;
			}
		}
	}
	
	var data=getChildren("SPECIALTY_TYPE",false,undefined);
	var firstLevel=[];
	$(data).each(function(){
		$(getChildren("SPECIALTY_TYPE",this["itemCode"]),false).each(function(){
			firstLevel.push(this);
		});
	});
	jsoncallback(firstLevel,0);
	$("#specialtyFirstType").change(function(){
		jsoncallback(getChildren("SPECIALTY_TYPE",this.value),1);
	});
	$("#specialtySecondType").change(function(){
		jsoncallback(getChildren("SPECIALTY_TYPE",this.value),2);
	});
	/* jsoncallback(getChildren("EXPERT_LEVEL"),3); */
	//获取专业分类一级代码
	/* $.getJSON("http://www.sxebid.com.cn/pspeds/a/sys/dict/getDictListByType?type=specialty_first_type&jsoncallback=jsoncallback&index=0",function (json){
		//http://127.0.0.1:8080/tender
	}); */
	//获取专家级别
	/* $.getScript("http://www.sxebid.com.cn/pspeds/a/sys/dict/getDictListByType?type=expert_level&jsoncallback=jsoncallback&index=3",function (json){
	}); */
	function getChildren(typeCode,parentItemCode){
		var data=$.ajax({
			url:ctx+"/dictionary/dynamicDictionaryComboTree",
			type:"post",
			data:{typeCode:"SPECIALTY_TYPE",includeRoot:false,id:(parentItemCode?parentItemCode:"")},
			async:false
		}).responseText;
		return $.parseJSON(data);
	}
});
</script>