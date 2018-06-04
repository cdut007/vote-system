<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<form:form modelAttribute="avoidanceOrgan" method="post">
	<form:hidden path="id"/>
	<form:hidden path="expertApplyId" />
	<table style="width:100%;">
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">回避单位代码：</td>
			<td style="width:210px;"><form:input path="organCode"  cssClass="inputxt"/></td>
				
			</td>
		</tr>
		<tr>
			<td class="need" style="width:10px;">*</td>
			<td style="width:100px;">回避单位名称 ：</td>
			<td style="width:210px;"><form:input path="organName"  cssClass="inputxt"/></td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
$(function(){
	

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