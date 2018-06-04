<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML>
<html>
<head>
<title>数据字典管理</title>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript" src="/resources/page/base/dictionary/listDictionary.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			系统管理
			<code>&gt;</code>
			数据字典管理
		</div>
	</div>
	<div class="block">
		<div class="usBox" style="height:600px">
			<!-- <a class="button red" onclick="addType();"><span class="icon-botton icons-main_images_add"> </span>添加字典类型</a>
			<a class="button red" onclick="editType();"><span class="icon-botton icons-main_images_edit"> </span>编辑字典类型</a> 
			<a class="button red" onclick="deleteType();"><span class="icon-botton icons-main_images_delete"> </span>删除字典类型</a>
			<a class="button red" onclick="add();"><span class="icon-botton icons-main_images_add"> </span>添加字典项</a> 
			<a class="button red" onclick="edit();"><span class="icon-botton icons-main_images_edit"> </span>编辑字典项</a>
			<a class="button red" onclick="Delete();"><span class="icon-botton icons-main_images_delete"> </span>删除字典项</a>
			<div class="blank10"></div> -->
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'west',width:350">
					<table id="dictionaryType"></table>
				</div>
				<div data-options="region:'center'">
					<table id="dictionaryTree"></table>
				</div>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
