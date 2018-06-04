<%@page pageEncoding="utf-8"%>
<%@page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form action="${pageContext.request.contextPath}/tool/createOrAlter" method="post">
	<table id="tableform" class="mytableStyle" style="width:100%;">
		<col width="50px" />
		<col width="50px" />
		<col />
		<col width="100px" />
		<col />
		<col width="100" />
		<col width="50px" />
		<col width="45px" />
		<col width="45px" />
		<col width="68px" />
		<tr>
			<th colspan="2">表名</th>
			<td>
				<input type='hidden' name="old_table_name" value="${tabs.table_name}" /><input type="text" name="table_name" class="inputxt" value="${tabs.table_name}" />
			</td>
			<th>表空间</th>
			<td>
				<select name="tablespace_name" class="inputxt">
					<c:forEach items="${tablespace_names}" var="item">
						<option value="${item}" ${item==tabs.tablespace_name?"selected='selected'":""}>${item}</option>
					</c:forEach>
				</select>
			</td>
			<th>表备注</th>
			<td colspan="4">
				<input type="text" name="table_comments" class="inputxt" value="${tabs.comments}" />
			</td>
		</tr>
		<tr>
			<th>序号</th>
			<th colspan="2">列名</th>
			<th colspan="2">数据类型</th>
			<th colspan="2">列备注</th>
			<th>主键</th>
			<th>非空</th>
			<th>操作</th>
		</tr>
		<tbody class="editor">
			<c:forEach items="${tabs.cols}" var="column" varStatus="status">
				<tr>
					<th><span class="countnum">${status.count}</span></th>
					<td colspan="2">
						<input type="hidden" name="old_column_name" value="${column.column_name}" />
						<input type="text" class="inputxt" name="column_name" value="${column.column_name}" class="validate[required,maxSize[100]]" />
					</td>
					<td colspan="2">
						<input type="text" class="inputxt" name="data_type" value="${column.fullDataType}" class="validate[required,maxSize[100]]" />
					</td>
					<td colspan="2">
						<input type="text" class="inputxt" name="column_comments" value="${column.comments}" />
					</td>
					<td align="center">
						<input type="checkbox" name="primary" <c:if test="${column.primary=='Y'}">checked="checked"</c:if> onclick="if($(this).prop('checked')){$(this).parent().next().find(':input').prop('checked',true);}" />
					</td>
					<td align="center">
						<input type="checkbox" name="nullable" <c:if test="${column.nullable=='N'}">checked="checked"</c:if> onclick="if(!$(this).prop('checked')){$(this).parent().prev().find(':input').prop('checked',false);}" />
					</td>
					<td>
						<a class="button small red delete" title="删除">删除</a>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<th><span class="countnum"></span></th>
				<td colspan="2">
					<input type="hidden" name="old_column_name" /> <input type="text" name="column_name" class="inputxt" />
				</td>
				<td colspan="2">
					<input type="text" class="inputxt" name="data_type" class="validate[required,maxSize[100]]" />
				</td>
				<td colspan="2">
					<input type="text" class="inputxt" name="column_comments" />
				</td>
				<td align="center">
					<input type="checkbox" name="primary" onclick="if($(this).prop('checked')){$(this).parent().next().find(':input').prop('checked',true);}" />
				</td>
				<td align="center">
					<input type="checkbox" name="nullable" onclick="if(!$(this).prop('checked')){$(this).parent().prev().find(':input').prop('checked',false);}" />
				</td>
				<td>
					<a class="button small none red delete" title="删除">删除</a>
				</td>
			</tr>
		</tbody>
	</table>
</form>
