<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	jq(function() {
		loadTaskGeneral();
	});
	function saveTaskGeneral() {
		task.taskId = jq('#id').val();
		task.taskName = jq('#name').val();
		task.setContent(jq('#name').val());
		if (jq('#asynchronous').is(':checked')) {
			task.asynchronous = true;
		} else {
			task.asynchronous = false;
		}
		if (!jq('#exclusive').is(':checked')) {
			task.exclusive = false;
		} else {
			task.exclusive = true;
		}
	}
	function loadTaskGeneral() {
		jq('#id').val(task.taskId);
		jq('#name').val(task.taskName);
		if (task.asynchronous) {
			jq('#asynchronous').prop('checked', true);
		} else {
			jq('#asynchronous').prop('checked', false);
		}
		if (!task.exclusive) {
			jq('#exclusive').prop('checked', false);
		} else {
			jq('#exclusive').prop('checked', true);
		}
	}
//-->
</script>
<table id="general-properties">
	<tr>
		<td align="right" style="width:80px">唯一标识:</td>
		<td>
			<input type="text" id="id" name="id" value="" readonly="readonly" />
		</td>
	</tr>
	<tr>
		<td align="right">名称:</td>
		<td>
			<input type="text" id="name" name="name" value="" />
		</td>
	</tr>
	<tr>
		<td align="right">异步:</td>
		<td>
			<input type="checkbox" id="asynchronous" name="asynchronous" value="true" />
		</td>
	</tr>
	<tr>
		<td align="right">排他:</td>
		<td>
			<input type="checkbox" id="exclusive" name="exclusive" value="true" checked />
		</td>
	</tr>
</table>