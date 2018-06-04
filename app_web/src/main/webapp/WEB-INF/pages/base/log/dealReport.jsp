<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib
	prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
</head>
<script type="text/javascript">
	
</script>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			系统管理
			<code>&gt;</code>
			成交金额统计
		</div>
	</div>
	<div class="block">
		<div class="panel datagrid" style="">
			<div class="panel-header" style="width: 802px;">
				<div class="panel-title">项目成交金额统计表</div>
				<div class="panel-tool"></div>
			</div>
			<div class="datagrid-wrap panel-body" title=""
				style="width: 807px; height: 390px;">
				<div class="datagrid-toolbar">
					<table cellspacing="0" cellpadding="0">
						<tbody>
							<tr></tr>
						</tbody>
					</table>
				</div>
				<div class="datagrid-view" style="width: 807px; height: 320px;">
					<div class="datagrid-view1" style="width: 26px;">
						<div class="datagrid-header" style="width: 26px; height: 28px;">
							<div class="datagrid-header-inner" style="display: block;">
								<table class="datagrid-htable" border="0" cellspacing="0"
									cellpadding="0" style="height: 29px;">
									<tbody>
										<tr class="datagrid-header-row">
											<td rowspan="0"><div class="datagrid-header-rownumber"></div></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="datagrid-body"
							style="width: 26px; margin-top: 0px; height: 291px;">
							<div class="datagrid-body-inner">
								<table class="datagrid-btable" cellspacing="0" cellpadding="0"
									border="0">
									<tbody>
										<tr id="datagrid-row-r1-1-0" datagrid-row-index="0"
											class="datagrid-row" style="height: 28px;">
											<td class="datagrid-td-rownumber"><div
													class="datagrid-cell-rownumber">1</div></td>
										</tr>
										<tr id="datagrid-row-r1-1-1" datagrid-row-index="1"
											class="datagrid-row datagrid-row-alt" style="height: 28px;">
											<td class="datagrid-td-rownumber"><div
													class="datagrid-cell-rownumber">2</div></td>
										</tr>
										<tr id="datagrid-row-r1-1-2" datagrid-row-index="2"
											class="datagrid-row" style="height: 28px;">
											<td class="datagrid-td-rownumber"><div
													class="datagrid-cell-rownumber">3</div></td>
										</tr>
										<tr id="datagrid-row-r1-1-3" datagrid-row-index="3"
											class="datagrid-row datagrid-row-alt" style="height: 28px;">
											<td class="datagrid-td-rownumber"><div
													class="datagrid-cell-rownumber">4</div></td>
										</tr>
										<tr id="datagrid-row-r1-1-4" datagrid-row-index="4"
											class="datagrid-row" style="height: 28px;">
											<td class="datagrid-td-rownumber"><div
													class="datagrid-cell-rownumber">5</div></td>
										</tr>
										<tr id="datagrid-row-r1-1-5" datagrid-row-index="5"
											class="datagrid-row datagrid-row-alt " style="height: 28px;">
											<td class="datagrid-td-rownumber"><div
													class="datagrid-cell-rownumber">6</div></td>
										</tr>
										<tr id="datagrid-row-r1-1-6" datagrid-row-index="6"
											class="datagrid-row" style="height: 28px;">
											<td class="datagrid-td-rownumber"><div
													class="datagrid-cell-rownumber">7</div></td>
										</tr>
										<tr id="datagrid-row-r1-1-7" datagrid-row-index="7"
											class="datagrid-row datagrid-row-alt" style="height: 28px;">
											<td class="datagrid-td-rownumber"><div
													class="datagrid-cell-rownumber">8</div></td>
										</tr>
										<tr id="datagrid-row-r1-1-7" datagrid-row-index="8"
											class="datagrid-row datagrid-row-alt" style="height: 28px;">
											<td class="datagrid-td-rownumber"><div
													class="datagrid-cell-rownumber">9</div></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="datagrid-footer" style="width: 26px;">
							<div class="datagrid-footer-inner" style="display: none;"></div>
						</div>
					</div>
					<div class="datagrid-view2" style="width: 781px;">
						<div class="datagrid-header" style="width: 781px; height: 28px;">
							<div class="datagrid-header-inner" style="display: block;">
								<table class="datagrid-htable" border="0" cellspacing="0"
									cellpadding="0" style="height: 29px;">
									<tbody>
										<tr class="datagrid-header-row">
											<td field="name" class=""><div
													class="datagrid-cell datagrid-cell-c1-name" style="">
													<span>项目名称</span><span class="datagrid-sort-icon">&nbsp;</span>
												</div></td>
											<td field="description" class=""><div
													class="datagrid-cell datagrid-cell-c1-description" style="">
													<span>成交额</span><span class="datagrid-sort-icon">&nbsp;</span>
												</div></td>
											<td field="createTime"><div
													class="datagrid-cell datagrid-cell-c1-createTime" style="">
													<span>年度</span><span class="datagrid-sort-icon">&nbsp;</span>
												</div></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="datagrid-body"
							style="width: 781px; margin-top: 0px; height: 291px; overflow-x: hidden;">
							<table class="datagrid-btable" cellspacing="0" cellpadding="0"
								border="0">
								<tbody>
									<tr id="datagrid-row-r1-2-0" datagrid-row-index="0"
										class="datagrid-row" style="height: 28px;">
										<td field="name"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-name">
												<a href="#">同煤集团项目</a>
											</div></td>
										<td field="description"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-description">4亿元</div></td>
										<td field="createTime"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-createTime">2016</div></td>
									</tr>
									<tr id="datagrid-row-r1-2-1" datagrid-row-index="1"
										class="datagrid-row datagrid-row-alt" style="height: 28px;">
										<td field="name"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-name">
												<a href="/workflow/customTaskForm?taskId=7284481">山西普正汇通投资有限公司视频监控设备采购项目</a>
											</div></td>
										<td field="description"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-description">125万元</div></td>
										<td field="createTime" rowspan="8"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-createTime">2017</div></td>
									</tr>
									<tr id="datagrid-row-r1-2-1" datagrid-row-index="2"
										class="datagrid-row datagrid-row-alt" style="height: 28px;">
										<td field="name"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-name">
												<a href="/workflow/customTaskForm?taskId=7284481">太原市汇城建筑科技有限公司原料及产品罐S30408不锈钢板材料采购招标</a>
											</div></td>
										<td field="description"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-description">90万</div></td>
									</tr>
									<tr id="datagrid-row-r1-2-1" datagrid-row-index="3"
										class="datagrid-row datagrid-row-alt" style="height: 28px;">
										<td field="name"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-name">
												<a href="/workflow/customTaskForm?taskId=7284481">山西晟达通科贸有限公司办公家具采购</a>
											</div></td>
										<td field="description"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-description">80万</div></td>
									</tr>
									<tr id="datagrid-row-r1-2-1" datagrid-row-index="4"
										class="datagrid-row datagrid-row-alt" style="height: 28px;">
										<td field="name"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-name">
												<a href="/workflow/customTaskForm?taskId=7284481"> 山西潞安羿神能源有限责任公司、麟绛镇东河北村建设周边居民环保搬迁安置小区项目施工 </a>
											</div></td>
										<td field="description"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-description">2.8亿</div></td>
									</tr>
									<tr id="datagrid-row-r1-2-1" datagrid-row-index="5"
										class="datagrid-row datagrid-row-alt" style="height: 28px;">
										<td field="name"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-name">
												<a href="/workflow/customTaskForm?taskId=7284481">山西潞安羿神能源有限责任公司、麟绛镇东河北村建设周边居民环保搬迁安置小区项目监理 </a>
											</div></td>
										<td field="description"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-description">332万</div></td>
									</tr>
									<tr id="datagrid-row-r1-2-1" datagrid-row-index="6"
										class="datagrid-row datagrid-row-alt" style="height: 28px;">
										<td field="name"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-name">
												<a href="/workflow/customTaskForm?taskId=7284481">山西普正汇通投资有限公司选聘律师事务所项目 </a>
											</div></td>
										<td field="description"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-description">10万</div></td>
									</tr>
									<tr id="datagrid-row-r1-2-1" datagrid-row-index="7"
										class="datagrid-row datagrid-row-alt" style="height: 28px;">
										<td field="name"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-name">
												<a href="/workflow/customTaskForm?taskId=7284481">太原公共资源拍卖中心有限公司项目 </a>
											</div></td>
										<td field="description"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-description">10万</div></td>
									</tr>
									<tr id="datagrid-row-r1-2-1" datagrid-row-index="8"
										class="datagrid-row datagrid-row-alt" style="height: 28px;">
										<td field="name"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-name">
												<a href="/workflow/customTaskForm?taskId=7284481">山西普正汇通投资有限公司购置电脑等办公设备项目 </a>
											</div></td>
										<td field="description"><div
												style="white-space: normal; height: auto;"
												class="datagrid-cell datagrid-cell-c1-description">20万</div></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="datagrid-footer" style="width: 781px;">
							<div class="datagrid-footer-inner" style="display: none;"></div>
						</div>
					</div>
					<table id="activititask-datagrid" style="display: none;"></table>
					<style type="text/css" easyui="true">
.datagrid-cell-c1-name {
	width: 529px
}

.datagrid-cell-c1-description {
	width: 79px
}

.datagrid-cell-c1-createTime {
	width: 78px
}

</style>
				</div>
				<div class="datagrid-pager pagination">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td><select class="pagination-page-list"><option>10</option>
										<option>20</option>
										<option>30</option>
										<option>40</option>
										<option>50</option></select></td>
								<td><div class="pagination-btn-separator"></div></td>
								<td><a href="javascript:void(0)"
									class="l-btn l-btn-small l-btn-plain l-btn-disabled l-btn-plain-disabled"
									group="" id=""><span class="l-btn-left l-btn-icon-left"><span
											class="l-btn-text l-btn-empty">&nbsp;</span><span
											class="l-btn-icon pagination-first">&nbsp;</span></span></a></td>
								<td><a href="javascript:void(0)"
									class="l-btn l-btn-small l-btn-plain l-btn-disabled l-btn-plain-disabled"
									group="" id=""><span class="l-btn-left l-btn-icon-left"><span
											class="l-btn-text l-btn-empty">&nbsp;</span><span
											class="l-btn-icon pagination-prev">&nbsp;</span></span></a></td>
								<td><div class="pagination-btn-separator"></div></td>
								<td><span style="padding-left: 6px;">第</span></td>
								<td><input class="pagination-num" type="text" value="1"
									size="2"></td>
								<td><span style="padding-right: 6px;">共1页</span></td>
								<td><div class="pagination-btn-separator"></div></td>
								<td><a href="javascript:void(0)"
									class="l-btn l-btn-small l-btn-plain" group="" id=""><span
										class="l-btn-left l-btn-icon-left"><span
											class="l-btn-text l-btn-empty">&nbsp;</span><span
											class="l-btn-icon pagination-next">&nbsp;</span></span></a></td>
								<td><a href="javascript:void(0)"
									class="l-btn l-btn-small l-btn-plain" group="" id=""><span
										class="l-btn-left l-btn-icon-left"><span
											class="l-btn-text l-btn-empty">&nbsp;</span><span
											class="l-btn-icon pagination-last">&nbsp;</span></span></a></td>
								<td><div class="pagination-btn-separator"></div></td>
								<td><a href="javascript:void(0)"
									class="l-btn l-btn-small l-btn-plain" group="" id=""><span
										class="l-btn-left l-btn-icon-left"><span
											class="l-btn-text l-btn-empty">&nbsp;</span><span
											class="l-btn-icon pagination-load">&nbsp;</span></span></a></td>
							</tr>
						</tbody>
					</table>
					<div class="pagination-info">显示1到10,共9记录</div>
					<div style="clear: both;"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>