<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page language="java" pageEncoding="utf-8"%>
<c:forEach items="${formData.formProperties}" var="item">
	<c:choose>
		<c:when test="${item.type.name=='date'}">
			<div data-role="fieldcontain">
				<label for="${item.id}">${item.name}:</label>
				<c:choose>
					<c:when test="${item.writable}">
						<input type="text" name="fp_${item.id}" id="${item.id}" value="${item.value}" class="scroller" />
					</c:when>
					<c:otherwise>
						<input type="text" id="${item.id}" value="${item.value}" readonly="readonly" />
					</c:otherwise>
				</c:choose>
			</div>
		</c:when>
		<c:when test="${item.type.name=='enum'}">
			<div data-role="fieldcontain">
				<div data-role="fieldcontain">
					<label for="${item.id}" class="select">${item.name}:</label>
					<c:choose>
						<c:when test="${item.writable}">
							<select name="fp_${item.id}" id="${item.id}">
								<c:forEach items="${LEAVE_TYPE}" var="enumItem">
									<option value="${enumItem.itemCode}" ${enumItem.itemCode eq item.value?"selected='selected'":""}>${enumItem}</option>
								</c:forEach>
							</select>
						</c:when>
						<c:otherwise>
							<input type="text" id="${item.id}" value="${dictionary['LEAVE_TYPE'][item.value]}" readonly="readonly" />
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</c:when>
		<c:when test="${item.type.name=='text'}">
			<div data-role="fieldcontain">
				<div data-role="fieldcontain">
					<label for="${item.id}" class="select">${item.name}:</label>
					<c:choose>
						<c:when test="${item.writable}">
							<textarea name="fp_${item.id}" id="${item.id}">${item.value}</textarea>
						</c:when>
						<c:otherwise>
							<textarea id="${item.id}" readonly="readonly">${item.value}</textarea>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</c:when>
		<c:when test="${item.type.name=='boolean'}">
			<div data-role="fieldcontain">
				<label for="${item.id}" class="select">${item.name}:</label>
				<c:choose>
					<c:when test="${item.writable}">
						<select name="fp_${item.id}" id="${item.id}" data-role="slider">
							<option value="true" ${item.value=="false"?"":"selected='selected'"}>是</option>
							<option value="false" ${item.value=="true"?"":"selected='selected'"}>否</option>
						</select>
					</c:when>
					<c:otherwise>
						<input type="text" id="${item.id}" value="${item.value?'是':'否'}" readonly="readonly" />
					</c:otherwise>
				</c:choose>
			</div>
		</c:when>
		<c:otherwise>
			<div data-role="fieldcontain">
				<label for="${item.id}">${item.name}:</label>
				<c:choose>
					<c:when test="${item.writable}">
						<input type="text" name="fp_${item.id}" id="${item.id}" value="${item.value}" />
					</c:when>
					<c:otherwise>
						<input type="text" id="${item.id}" value="${item.value}" />
					</c:otherwise>
				</c:choose>
			</div>
		</c:otherwise>
	</c:choose>
</c:forEach>