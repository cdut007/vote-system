收到投标人提出的问题！<br/>
<table style="border:1px solid #000;border-collapse:collapse;">
	<tr>
		<th style="border:1px solid #000;width:80px;">项目名称</th>
		<td style="border:1px solid #000;width:250px;">${question.projectInstanceName}</td>
	</tr>
	<tr>
		<th style="border:1px solid #000;">标段名称</th>
		<td style="border:1px solid #000;">${question.projectItemName}</td>
	</tr>
	<tr>
		<th style="border:1px solid #000;">投标人</th>
		<td style="border:1px solid #000;">${question.organBName}</td>
	</tr>
	<tr>
		<th style="border:1px solid #000;">问题内容</th>
		<td style="border:1px solid #000;">${question.questionContent}</td>
	</tr>
</table>
<a href='/question/pagingRecruitFileQuestionByT' target="_blank">问题列表</a>&nbsp;<a href='/question/form?projectItemId=${question.projectItemId}&questionId=${question.id}' target="_blank">立即澄清</a>
