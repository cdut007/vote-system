<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<script type="text/javascript">

</script>
<table width="98%" style="margin:0 auto;">
	<tr>
		<td class="need"></td>
		<td style="width:100px;">招标人：</td>
		<td colspan="5">
			<b>${project.organ.ztmc00}</b>
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>项目名称：</td>
		<td colspan="5">
			${project.xmmc00}
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>项目地址：</td>
		<td colspan="5">
			${project.xmdz00}
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>项目行政区划：</td>
		<td style="width:210px;">
		
				${util:dictionary('REGION',project.region)}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>项目法人：</td>
		<td>
			${project.xmfr00}
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>项目行业类型：</td>
		<td>
		${util:dictionary('INDUSTRY',project.industry)}
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>投资金额币种：</td>
		<td>
		${util:dictionary('CURRENCY',project.currencyCode)}
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>投资金额：</td>
		<td>${project.investmentAmount}
		<c:forEach items="${util:dictionaryTree('JEDWDM',false)}" var="item">
					<c:if test="${item.itemCode==project.priceUnit}">
						${item.itemName}
					</c:if>
				</c:forEach>
		</td>
		<td>
				
		</td>
		

	</tr>
	<tr>
		<td class="need"></td>
		<td>项目批文名称：</td>
		<td colspan="5">
		${project.approvalName}
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>招标方案核准号：</td>
		<td>${project.zbfaNumber}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>项目批文</td>
		<td colspan="5"><span id="container"></span></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>项目批文单位：</td>
		<td>${project.approvalAuthority}
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>批准文号：</td>
		<td>${project.pzwh00}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		
	</tr>
	<tr>		
		<td class="need"></td>
		<td>项目规模：</td>
		<td colspan="5"><textarea name="xmgm00" value="${project.xmgm00}" class="inputxt easyui-validatebox" enullmsg="请输入项目规模！" data-options="required:true" style="width:672px;height:100px" >${project.xmgm00}</textarea></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>
	<tr>
		<td class="need"></td>
		<td>资金来源：</td>
		
		<td>${project.funding}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>		
		<td class="need"></td>
		<td>是否依法招标：</td>
		<td><c:forEach items="${util:dictionaryTree('ACCORDING_TO_LAW',false)}" var="item">

				<c:if test="${item.itemCode==project.accordingToLaw}">
						${item.itemName}
				</c:if>
			</c:forEach></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>		
	</tr>
	<tr>
		<td class="need"></td>
		<td>出资比例：</td>
		<td colspan="5"><textarea name="czbl" value="${project.czbl}" class="inputxt easyui-validatebox" enullmsg="请输入出资比例！" style="width:672px;height:100px" >${project.czbl}</textarea></td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>	
	<tr>	
		<td class="need"></td>
		<td>项目审批时间：</td>		
			<td><fmt:formatDate value="${project.xmlxsj}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />
			</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		
		<td class="need"></td>
		<td>是否进场：</td>		
			<td>
					<c:forEach items="${util:dictionaryTree('YES_NO',false)}" var="item">
					<c:if test="${item.itemCode==project.sfjc00}">
						${item.itemName}
					</c:if>
						
					</c:forEach>
				
			</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>	
	</tr>	
	<tr>
		<td class="need"></td>
		<td>联系人：</td>
		<td>${project.contacts}
		</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
		<td class="need"></td>
		<td>联系方式：</td>
		<td>${project.phones}</td>
		<td>
			<div class="Validform_checktip"></div>
		</td>
	</tr>


	
</table>