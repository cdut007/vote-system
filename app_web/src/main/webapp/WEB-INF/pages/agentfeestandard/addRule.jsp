<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function(){
		$("#saveView").click(function(){
			//获取数据
			/* var bzmc=$("#bzmc").val();
			var tableArr=[];//存放所有数据
			$("table tr:not(:first)").each(function(){//便利除标题行外的所有行
				var trArr=[];//存行数据
				$("input,text",this).each(function(){//便利行内的input text的值
					trArr.push($(this).val());
				});
				tableArr.push(trArr.join());//行数据格式
				alert(tableArr);
			}); */
			$("#ruleForm").ajaxSubmit({
				url:"${pageContext.request.contextPath}/agentfeestandard/addAgentRule",
				type:"post",
				dataType:"json",
				success:function(result){
					var msg=result.msg;
					alert(msg);
					window.location="${pageContext.request.contextPath}/agentfeestandard/rule_list";
				},
				error:function(){
					alert("存取数据失败");
				}
			});	
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			合同管理
			<code>&gt;</code>
			招标代理服务收费
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<form id="ruleForm"  action="${pageContext.request.contextPath}/agentfeestandard/addAgentRule" method="post">
					<table width="800px" class="mytableStyle"  id="myTable">
						<thead>
						<tr>
							<th>标准名称：</th>
							<td colspan="4"><input type="text" name="rule_name"/></td>
						</tr>
						<tr>
							<th>起始价(万)</th>
							<th>终止价(万)</th>
							<th>工程招标费率</th>
							<th>货物招标费率</th>
							<th>服务招标费率</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><input name="agentRuleViewList[0].start_num" type="text"/></td>
							<td><input name="agentRuleViewList[0].end_num" type="text"/></td>
							<td><input name="agentRuleViewList[0].workRate" type="text"/></td>
							<td><input name="agentRuleViewList[0].goodaRate" type="text"/></td>
							<td><input name="agentRuleViewList[0].serveRate" type="text"/></td>
						</tr>
						<tr>
							<td><input name="agentRuleViewList[1].start_num" type="text"/></td>
							<td><input name="agentRuleViewList[1].end_num" type="text"/></td>
							<td><input name="agentRuleViewList[1].workRate" type="text"/></td>
							<td><input name="agentRuleViewList[1].goodaRate" type="text"/></td>
							<td><input name="agentRuleViewList[1].serveRate" type="text"/></td>
						</tr>
						<tr>
							<td><input name="agentRuleViewList[2].start_num" type="text"/></td>
							<td><input name="agentRuleViewList[2].end_num" type="text"/></td>
							<td><input name="agentRuleViewList[2].workRate" type="text"/></td>
							<td><input name="agentRuleViewList[2].goodaRate" type="text"/></td>
							<td><input name="agentRuleViewList[2].serveRate" type="text"/></td>
						</tr>
						<tr id="four">
							<td><input name="agentRuleViewList[3].start_num" type="text"/></td>
							<td><input name="agentRuleViewList[3].end_num" type="text"/></td>
							<td><input name="agentRuleViewList[3].workRate" type="text"/></td>
							<td><input name="agentRuleViewList[3].goodaRate" type="text"/></td>
							<td><input name="agentRuleViewList[3].serveRate" type="text"/></td>
						</tr>
						<tr>
							<td><input name="agentRuleViewList[4].start_num" type="text"/></td>
							<td><input name="agentRuleViewList[4].end_num" type="text"/></td>
							<td><input name="agentRuleViewList[4].workRate" type="text"/></td>
							<td><input name="agentRuleViewList[4].goodaRate" type="text"/></td>
							<td><input name="agentRuleViewList[4].serveRate" type="text"/></td>
						</tr>
						<tr>
							<td><input name="agentRuleViewList[5].start_num" type="text"/></td>
							<td><input name="agentRuleViewList[5].end_num" type="text"/></td>
							<td><input name="agentRuleViewList[5].workRate" type="text"/></td>
							<td><input name="agentRuleViewList[5].goodaRate" type="text"/></td>
							<td><input name="agentRuleViewList[5].serveRate" type="text"/></td>
						</tr>
						</tbody>
					</table>
					<input type="button" class="button orange" id="saveView" value="保存" />
					<input type="reset" class="button blue" value="重置" />
				</form>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
