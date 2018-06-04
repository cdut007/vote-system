<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<%@page pageEncoding="utf-8"%>
<%@page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<table class="mytablerow" style="width:600px;">
	<c:forEach items="${list}" var="column">
		<tr>
			<td>${column.COLUMN_NAME}</td>
			<td>${column.DATA_TYPE}</td>
			<td>${column.COMMENTS}</td>
		</tr>
	</c:forEach>
</table>