<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--项目信息确认 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新建项目信息</title>
<jsp:include page="/common/link.jsp" />
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			反向拍卖规则
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class="clearfix">
				<form method="post" action="${pageContext.request.contextPath}/reverseAuctionDemand/createAuctionDemant" onsubmit="return $(this).form('validate');">
					<input type="hidden" name="token" value="${token}" /> 
					<input type="hidden" name="processDefinitionId" value="${processDefinitionId}" />
					<table class="mytableStyle" width="98%" style="table-layout:fixed;margin:0 auto;">
						<tbody>
							<tr>
								<th rowspan="5" style="width:120px;text-align: center">报价规则</th>
								<td style="width:200px">截止时间</td>
								<td>
									<input class="inputxt Wdate easyui-validatebox" data-options="required:true" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" />
								</td>
							</tr>
							<tr>
								<td>初始价格</td>
								<td>
									<sys:number />
								</td>
							</tr>
							<tr>
								<td>最小报价单元值</td>
								<td>
									<sys:number />
								</td>
							</tr>
							<tr>
								<td>最小报价时间差</td>
								<td>
									<sys:number />
								</td>
							</tr>
							<tr>
								<td>附加说明</td>
								<td>
									<input class="inputxt" />
								</td>
							</tr>
							<tr>
								<th style="text-align: center">付款规则</th>
								<td colspan="2">
									<textarea style="height:45px;"></textarea>
								</td>
							</tr>
							<tr>
								<th rowspan="2" style="text-align: center">交货规则</th>
								<td>交货地点</td>
								<td>
									<input class="inputxt" />
								</td>
							</tr>
							<tr>
								<td>交货方式</td>
								<td>
									<input class="inputxt" />
								</td>
							</tr>
							<tr>
								<th style="text-align: center">违约责任</th>
								<td colspan="2">
									<textarea style="height:45px;"></textarea>
								</td>
							</tr>
							<tr>
								<th style="text-align: center">延期规则</th>
								<td colspan="2" style="text-align: left;">
									竞价结束前
									<sys:number style="width:50px;background:#efefef" />
									分钟内有报价，则自动延长竞价时间
									<sys:number style="width:50px;background:#efefef" />
									分钟
								</td>
							</tr>
						</tbody>
					</table>
					<div class="blank10"></div>
					<input type="submit" class='button red' value="保 存" /> <input type="reset" class='button red' value="重 置" />
				</form>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	<div id="zbOrgan">
		<table id="zbrTable"></table>
	</div>
</body>
</html>
