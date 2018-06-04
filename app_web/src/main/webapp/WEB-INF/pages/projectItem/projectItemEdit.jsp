<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<script type="text/javascript">
</script>
<form:form id="projectItem_form" class="registerform" method="post" action="${pageContext.request.contextPath}/projectItem/saveOrUpdateProjectItem" modelAttribute="projectItem">
	<form:hidden path="id" />
	<input type="hidden" name="token" value="${token}"/>
	<form:hidden path="bdbh00" />
	<form:hidden path="projectInstanceId" />
	<table>
		<tr>
			<td class="need">*</td>
			<td style="width:120px;">标段(包)名称：</td>
			<td>
				<form:input path="bdmc00" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" />
			</td>
		</tr>
		<tr style="display:none">
			<td class="need">*</td>
			<th style="width:120px;">上级标段(包)：</th>
			<td>
				<form:select path="parentId" cssClass="inputxt easyui-combotree" data-options="required:true,url:'${pageContext.request.contextPath}/projectItem/pagingParentProjectItemData?projectInstanceId=${projectItem.projectInstanceId}',loadFilter:function(data,parent){var root=[{text:'无',id:'',children:data}];return root;},required:false"/>
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:120px;">机构内部标段(包)编号：</td>
			<td>
				<form:input path="organProjectItemCode" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,128]'" />
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>标段(包)一级分类：</td>
			<td>
				<form:select path="projectItemType" onchange="loadBdfldm();">
					<form:options items="${util:dictionaryTree('PROJECT_ITEM_TYPE',false)}" itemValue="itemCode" itemLabel="itemName" />
				</form:select>		
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>标段(包)二级分类：</td>
			<td>
			   <input class="easyui-combotree" value="${projectItem.bdfldm}" name="bdfldm" id="bdfldm" data-options="url:'/projectItem/bdcate?parentCode=${projectInstance.tenderProjectClassifyCode}',method:'get',label:'标段(包)分类代码:',labelPosition:'top',required:'true'" style="width:100%">
						
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>标段(包)内容:</td>
			<td>
				<form:textarea path="bdnr00" cssClass="easyui-validatebox" data-options="required:true,validType:'length[0,2000]'" style="width:400px;height:120px;" />
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>计划开工日期：</td>
  			<td><input path="jhkgrq" value="<fmt:formatDate value="${projectItem.jhkgrq}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />" name="jhkgrq" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" />&nbsp;</td>				
  		</tr>
		<tr>
			<td class="need">*</td>
			<td id="jhkgrq_label">
				
			</td>
			<td>
				<form:input path="timeLimit" type="number" cssClass="inputxt easyui-numberbox"  data-options="required:true,validType:'length[0,10]'"  value="${projectItem.timeLimit}"/><span>天</span>
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>投标人资格条件：</td>
 			<td>
				
				<form:textarea path="tbzgtj" cssClass="easyui-validatebox" nullmsg="请输入投标人资格条件！"  data-options="required:true,validType:'length[0,2000]'" style="width:400px;height:40px;" />
			</td> 
		</tr>
		<tr>
			<td class="need">*</td>
			<td>标段(包)合同估算价：</td>
			<td>
				<form:input path="bdhtgj" cssClass="inputxt easyui-numberbox" datatype="n" nullmsg="请输入标段(包)合同估算价！"  data-options="required:true,validType:'length[0,15]'"  />
			</td>
		</tr>
		<tr>
			<td></td>
			<td>标段(包)合同估算价单位：</td>
			<td>
				<form:select path="bdgjdw">
					<form:options items="${util:dictionaryTree('JEDWDM',false)}" itemValue="itemCode" itemLabel="itemName" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>标段(包)合同估算价币种：</td>
			<td>
				<form:select path="bdgjdm">
					<form:options items="${util:dictionaryTree('CURRENCY',false)}" itemValue="itemCode" itemLabel="itemName" />
				</form:select>
			</td>
		</tr>
		<tr>
			<!-- <td class="need">*</td> -->
			<td></td>
			<td>标书售价（元）：</td>
			<td>
				<form:input path="price" cssClass="inputxt easyui-numberbox" data-options="required:false,precision:2,validType:'length[0,8]'" />
			</td>
		</tr>
	</table>
</form:form>

<script>
	$(document).ready(function(){
		loadBdfldm();
	});	
	
	function loadBdfldm(){

		var tenderProjectClassifyCode = $("#projectItemType").val();
		
		if(tenderProjectClassifyCode=="A"){
			$("#jhkgrq_label").text("工期");
		}else if(tenderProjectClassifyCode=="B"){
			$("#jhkgrq_label").text("交货期");
		}else if(tenderProjectClassifyCode=="C"){
			$("#jhkgrq_label").text("服务周期");
		}else{
			$("#jhkgrq_label").text("服务周期");
		}
		$('#bdfldm').combotree({
			url:'/projectItem/bdcate?parentCode=' + tenderProjectClassifyCode,
			method:'get',
			label:'标段(包)分类代码:',
			labelPosition:'top',
			required:'true'
		});
	}

</script>