<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>

				<table class='mytableStyle'>
					<tr>
						<th width="120px">项目名称</th>
						<td colspan='3'>	${exception.expertApply.projectInstance.project.xmmc00}</td>
					</tr>
					<tr>

						<th>招标项目名称:</th>
						<td>${exception.expertApply.projectInstanceName}</td>
					</tr>
					<tr>
						<th width="120px">相关标段（包）名称:</th>
						<td colspan='3'>${exception.projectItem.bdmc00}</td>
					</tr>

					<tr>
						<th width="120px">报告名称</th>
						<td colspan='3'>${exception.exceptionTitle}</td>
					</tr>
					<tr>
						<th width="120px">招标异常情况描述:</th>
						<td colspan='3'>${exception.exceptionContent}</td>
					</tr>
				</table>
				<div class="blank10"></div>
