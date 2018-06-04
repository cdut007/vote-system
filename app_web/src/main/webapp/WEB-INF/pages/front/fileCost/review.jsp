<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	$(function(){
		$("#paid").click(function(){
			$.ajax({
				url:"${pageContext.request.contextPath}/fileCost/paid",
				data:"id=${fileCost.id}",
				dataType:"json",
				success:function(data){
					$.messager.alert("系统提示",data.msg,"info");
				}
			});
		});
	});
//-->
</script>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置:
			标书费用支付确认
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class='tableTitle'>支付项目：${projectInstance.zbxmmc}</div>
			<table class="mytableStyle">
			<tr>
					<th width='40px'>序号</th>
					<th>标段编号</th>
					<th>标段名称</th>
					<th>状态</th>
				</tr>
				<c:forEach items="${fileCost.tenderList}" var="tender" varStatus="status">
					<c:forEach items="${tender.tenderItemList}" var="tenderItem" varStatus="status">
						<c:forEach items="${projectInstance.projectItems}" var="item">
							<c:if test="${tenderItem.projectItem.id==item.id}" >
								<tr>
									<td style='text-align: center'>${status.count}</td>
									<td>${item.bdbh00}</td>
									<td class="itemName">${item.bdmc00}</td>
									<td style='text-align:center;'>${tenderItem.bmshjg}</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:forEach>
				</c:forEach>
		</table>
		<div class="blank10"></div>
		<div class='tableTitle2'>支付信息</div>
			<table class="mytableStyle">
					<tr>
						<td>支付账号：</td>
						<td>${fileCost.zfzh00}</td>
						<td>支付金额：</td>
						<td>${fileCost.zfje00}</td>
					</tr>
					<tr>
						<td>支付方式：</td>
						<td>${fileCost.zffs00}</td>
						<td>支付时间：</td>
						<td><fmt:formatDate value="${fileCost.zfsj00}" type="both" dateStyle="default" timeStyle="default" /></td>
					</tr>
					<tr>
						<td>备注：</td>
						<td colspan="3" style="padding:2px;">${fileCost.beizhu}</td>
					</tr>
				</table><br/>

			<div id="" style="text-align:center">
				<c:if test="${fileCost.zfqrbz>1}">
					
					<div class='tableTitle2'>确认信息</div>
					<table class="mytableStyle">
						<tr>
							<td>确认人：</td>
							<td>${fileCost.zfqrr0}</td>
							<td>确认时间：</td>
							<td><fmt:formatDate value="${fileCost.zfqrsj}" type="both" dateStyle="default" timeStyle="default" /></td>
						</tr>
						<tr>
							<td colspan='4'>支付确认标志：<i style="font-size:14pt;color:orange">${util:dictionary('ZFQRBZ',fileCost.zfqrbz)}</i></td>
						</tr>
					</table>
				</c:if>
				<c:if test="${fileCost.zfqrbz==1}">
					<input type='button' id="paid" class='button red' value='确认支付'/>
					<input type='button' id="nopay" class='button red' value='还未到账'/>
				</c:if>
			</div>
		</div>
	</div>
	<div class="blank10"></div>

