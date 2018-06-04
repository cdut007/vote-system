<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	jq(function() {
		loadTaskMultiInstance();
	});
	function saveTaskMultiInstance() {
		if (jq('#sequentialYes').is(':checked')) {
			task.isSequential = true;
		}
		if (jq('#sequentialNo').is('：checked')) {
			task.isSequential = false;
		}
		task._loopCardinality = jq("#loopCardinality").val();
		task._collection = jq("#collection").val();
		task._elementVariable = jq("#elementVariable").val();
		task._completionCondition = jq("#completionCondition").val();
	}
	function loadTaskMultiInstance() {
		if (task.isSequential) {
			jq('#sequentialYes').prop('checked', true);
		} else {
			jq('#sequentialNo').prop('checked', true);
		}

		jq("#loopCardinality").val(task._loopCardinality);
		jq("#collection").val(task._collection);
		jq("#elementVariable").val(task._elementVariable);
		jq("#completionCondition").val(task._completionCondition);
	}
//-->
</script>
<table>
	<tr>
		<td align="right" style="width:80px">Sequential:</td>
		<td>
			<input type="radio" id="sequentialYes" name="sequential" value="true" />Yes 
			<input type="radio" id="sequentialNo" name="sequential" value="false" checked />No
		</td>
	</tr>
	<tr>
		<td align="right">Loop Cardinality:</td>
		<td>
			<input type="text" id="loopCardinality" name="loopCardinality" value="" />
		</td>
	</tr>
	<tr>
		<td align="right">Collection:</td>
		<td>
			<input type="text" id="collection" name="collection" value="" />
		</td>
	</tr>
	<tr>
		<td align="right">Element Variable:</td>
		<td>
			<input type="text" id="elementVariable" name="elementVariable" value="" size="50" />
		</td>
	</tr>
	<tr>
		<td align="right">Completion Condition:</td>
		<td>
			<input type="text" id="completionCondition" name="completionCondition" value="" size="50" />
		</td>
	</tr>
</table>