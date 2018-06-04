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
<style type="text/css">
.none {
	display: none;
}

.need {
	color: red;
}

table {
	width: 100%;
}

table th {
	text-align: center;
	background: #efefef;
}

table td,table th {
	border: 1px solid #ddd;
}

table td .inputxt,table td textarea {
	width: 100%;
}

table td {
	padding: 2px 6px;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#customProperty").autoTable();
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			反向拍卖需求
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class="clearfix">
				<form method="post" action="${pageContext.request.contextPath}/reverseAuctionDemand/createAuctionDemant" onsubmit="return $(this).form('validate');">
					<input type="hidden" name="token" value="${token}" /> <input type="hidden" name="processDefinitionId" value="${processDefinitionId}" />
					<table width="100%" style="table-layout:fixed;margin:0 auto;">
						<tbody>
							<tr>
								<th colspan="4"><h1>反向拍卖需求</h1></th>
							</tr>
							<tr>
								<th style="width:120px;">招标人：</th>
								<td>
									<input type="hidden" name="organId" value="${CURRENT_USER_SESSION_INFO.organ.id}" /> <b>${CURRENT_USER_SESSION_INFO.organ}</b>
								</td>
								<td style="width:120px;"></td>
								<td></td>
							</tr>
							<tr>
								<th>需求名称<em class="need">*</em>：
								</th>
								<td colspan="3">
									<input name="demandName" class="inputxt easyui-validatebox" datatype="*1-100" nullmsg="项目名称不能为空！" errormsg="项目名称最多100个字符！" data-options="required:true" />
								</td>
							</tr>
							<tr>
								<th>产品/服务分类<span class="need">*</span>：
								</th>
								<td colspan="3">
									<input name="demandCategory" value="${project.xmdz00}" class="inputxt easyui-validatebox" datatype="*1-100" nullmsg="请输入项目地址！" errormsg="请输入项目地址！" data-options="required:true" />
								</td>
							</tr>
							<tr>
								<th>产品/服务图片<span class="need">*</span>：
								</th>
								<td colspan="3">
									<a>选择图片</a>
								</td>
							</tr>
							<tr>
								<th>产品/服务简介<span class="need">*</span>:
								</th>
								<td colspan='3'>
									<textarea name="demandDescription" style="height:120px;">${nryfw0}</textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="blank10"></div>
					<table id="customProperty">
						<thead>
							<tr>
								<th colspan="4"><h1>产品/服务自定义参数</h1></th>
							</tr>
							<tr>
								<th>属性名</th>
								<th>属性类型</th>
								<th>属性值</th>
								<th width="120px">操作</th>
							</tr>
						</thead>
						<tbody class="editor">
							<tr>
								<td>
									<input class="inputxt" name="propertyName" />
								</td>
								<td>
									<input class="inputxt" name="propertyType" />
								</td>
								<td>
									<input class="inputxt" name="propertyValue" />
								</td>
								<td>
									<a class="button small orange none insert">插入</a><a class="button small red none delete">删除</a>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="blank10"></div>
					<table width="100%">
						<tbody>
							<tr>
								<th colspan="3"><h1>反向拍卖规则</h1></th>
							</tr>
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
									<label><input type="checkbox" />含税</label>
									<br/>
									<label><input type="checkbox" /> 含运费 </label>
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
