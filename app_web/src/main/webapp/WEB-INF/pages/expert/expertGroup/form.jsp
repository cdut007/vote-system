<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
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
<style type="text/css">

</style>
<script type="text/javascript">
	
</script>
	<div id="ur_here">
		当前位置: 首页
		<code>&gt;</code>
		抽取需求
	</div>
	<form:form class="registerform" commandName="expertDemand">
		<form:hidden path="id"/>
		<table >
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td style="width:100px;">专家类别：</td>
				<td style="width:210px;"><form:select path="zjlb00" items="${util:dictionaryTree('ZJLB00',false)}" datatype="*" nullmsg="请选择专家类别！"  itemValue="itemCode" itemLabel="itemName"/></td>
				<td style="width:180px;"><span class="Validform_checktip"><form:errors path="zjlb00" cssClass="Validform_wrong" /></span>
				</td>
				<td class="need" style="width:10px;">*</td>
				<td style="width:100px;">抽取人数：</td>
				<td style="width:210px;"><form:input path="cqrs00"  cssClass="inputxt" datatype="n1-2" nullmsg="请输入抽取人数！"/></td>
				<td style="width:180px;"><span class="Validform_checktip"><form:errors path="cqrs00" cssClass="Validform_wrong" /></span>
				</td>
			</tr>
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td style="width:100px;">职业资格：</td>
				<td style="width:210px;"><form:select path="zyzgbm" items="${ZYZGBM}" datatype="*" nullmsg="请选择职业资格！"  itemValue="itemCode" itemLabel="itemName"/></td>
				<td><span class="Validform_checktip"><form:errors path="zyzgbm" cssClass="Validform_wrong" /></span>
				</td>
				<td class="need">*</td>
				<td style="width:100px;">所属库：</td>
				<td style="width:210px;"><form:select path="ssk000" items="${util:dictionaryTree('SSK000',false)}" datatype="*"  nullmsg="请选择所属库！"  itemValue="itemCode" itemLabel="itemName"/></td>
				<td><span class="Validform_checktip"><form:errors path="ssk000" cssClass="Validform_wrong" /></span>
				</td>
			</tr>
			<tr>
				<td class="need" style="width:10px;">*</td>
				<td style="width:100px;">评审品目：</td>
				<td style="width:210px;"><form:input path="pspm00"  cssClass="inputxt" datatype="*" nullmsg="请选择评审品目！"/></td>
				<td><span class="Validform_checktip">
							<form:errors path="pspm00" cssClass="Validform_wrong" />
						</span>
				</td>
				<td class="need">*</td>
				<td style="width:100px;">专家所在区域：</td>
				<td style="width:210px;"><form:input path="zjszq0"  cssClass="inputxt" datatype="*" nullmsg="请选择专家所在区！"/></td>
				<td><span class="Validform_checktip"><form:errors path="zjszq0" cssClass="Validform_wrong" /></span>
				</td>
			</tr>
			<tr>
				<td></td>
				<td style="width:100px;">备注：</td>
				<td colspan="6"><form:textarea path="beizhu" datatype="*" cssStyle="width:90%"/></td>
			</tr>
		</table>
	</form:form>