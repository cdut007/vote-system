<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<form:form method="post" action="" modelAttribute="organForm">
	<form:hidden path="id" />
	<table width="100%" style="table-layout:fixed;">
		<tr>
			<td class="need"></td>
			<td>机构代码：</td>
			<td>${organForm.ztdm00}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>机构名称：</td>
			<td>${organForm.ztmc00}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>负责人：</td>
			<td>${organForm.principal.userName}</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>邮箱地址：</td>
			<td>${organForm.email}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>联系电话：</td>
			<td>${organForm.phone}</td>
			
		</tr>
		<tr>
			<td class="need"></td>
			<td>登录账号：</td>
			<td>${organForm.principal.loginName}</td>
			
		</tr>
		
		<tr>
			<td class="need"></td>
			<td>是否缴费：</td>
			<td>${util:dictionary('IS_PAY',organForm.principal.isPay)}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>审核状态：</td>
			<td>${util:dictionary('JGSHZT',organForm.principal.isAudits)}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>国别地区：</td>
			<td>${util:dictionary('COUNTRY',organForm.gbdq00)}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>行政区划：</td>
			<td>${util:dictionaryPath('REGION',organForm.region)}</td>
		</tr>
			<tr>
			<td class="need"></td>
			<td>联系地址：</td>
			<td>${organForm.address}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>单位性质：</td>
			<td>${util:dictionary('OWNERSHIP',organForm.dwxz00)}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>营业执照号码：</td>
			<td>${organForm.yyzzhm}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>CA证书编号：</td>
			<td>${organForm.cazsbh}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>税务登记号码：</td>
			<td>${organForm.swdjh0}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>开户名称：</td>
			<td>${organForm.accountName}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>开户银行：</td>
			<td>${organForm.khyh00}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>基本账户账号：</td>
			<td>${organForm.jbzhzh}</td>
		</tr>
	
		<tr>
			<td class="need"></td>
			<td>注册资本：</td>
			<td>${organForm.zczb00} ${util:dictionary('JEDWDM',organForm.zczbdw)} (${util:dictionary('CURRENCY',organForm.zczbbz)})</td>
		</tr>
		<c:set value="${organService.getOrganizationCodeCertificate(organForm.id)}" var="organizationCodeCertificate"></c:set>
		<c:set value="${organService.getBusinessLicense(organForm.id)}" var="businessLicense"></c:set>
		<c:set value="${organService.getTaxCertificate(organForm.id)}" var="taxCertificate"></c:set>
		<table class="mytableStyle" style="width:100%;">
			<thead>
				<tr>
					<th style="width:34%">组织机构代码证</th>
					<th style="width:33%">企业营业执照</th>
					<th style="width:33%">税务登记证</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<div id="organizationCodeCertificateAttachment">
							<c:if test="${not empty organizationCodeCertificate}">
								<img src="${pageContext.request.contextPath}/attachment/download/${organizationCodeCertificate.fjid00}" style="width:100%"></img>
							</c:if>
						</div>
					</td>
					<td>
						<div id="businessLicenseAttachment">
							<c:if test="${not empty businessLicense}">
								<img src="${pageContext.request.contextPath}/attachment/download/${businessLicense.fjid00}" style="width:100%"></img>
							</c:if>
						</div>
					</td>
					<td>
						<div id="taxCertificateAttachment">
							<c:if test="${not empty taxCertificate}">
								<img src="${pageContext.request.contextPath}/attachment/download/${taxCertificate.fjid00}" style="width:100%"></img>
							</c:if>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</table>
</form:form>