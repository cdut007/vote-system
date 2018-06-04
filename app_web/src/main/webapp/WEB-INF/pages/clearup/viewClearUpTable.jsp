<%--
  Created by IntelliJ IDEA.
  User: OoO
  Date: 2018/5/11
  Time: 17:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Title</title>

    <sys:link easyui="true" jgrowl="true" plupload="true" ztree="true" uedit="true"/>
    <script type="text/javascript">
        function selectProject(obj) {
            $("#myform").submit();
        }
    </script>
    <style type="text/css">
        .tabTables table {
            width: 100%;
            border: 0;
            margin: 0;
            border-collapse: collapse;
            border-spacing: 0;
            margin-bottom: 40px;
            border-top: 1px solid #C3C3C3;
        }

        .tabTables td {
            text-align: center;
            border-right: 1px solid #C3C3C3;
            border-bottom: 1px solid #C3C3C3;
        }
    </style>
</head>
<body>
<jsp:include page="/common/top.jsp"/>


<div class="block">
    <div id="ur_here">
        当前位置: <a href="${util:property('frontEnd')}">首页</a>
        <code>&gt;</code>
        新建项目
    </div>
    <div class="blank10"></div>
    <div class="usBox1">
        <form id="myform" action="${pageContext.request.contextPath}/clearup/viewtable?tendid=${tendid}" method="post">

            <div style="margin-bottom: 10px;">
                单项工程:
                <select name="projectName" onchange="selectProject(this)">
                    <c:forEach items="${projectNames}" var="name">
                        <option value="<c:out value="${name}"></c:out>" ${name==projectName?"selected":""}><c:out
                                value="${name}"></c:out></option>
                    </c:forEach>
                </select>
            </div>
        </form>
        <div class="clearfix1">
            <c:forEach items="${project.unitProjects}" var="unitProject">
                <div id="p" class="easyui-panel" style="height:800px;padding:10px; margin-bottom:10px;"
                     data-options="title:'单位工程: <c:out value="${unitProject.name}"></c:out>',iconCls:'icon-tip',
						collapsible:true">

                    <div id="tt" class="easyui-tabs" data-options="tools:'#tab-tools'"
                         style="width:980px;height:745px;">

                        <c:forEach items="${unitProject.tables}" var="table">
                            <div title="${table.name}" class="tabTables">
                                    ${table.body}
                            </div>
                        </c:forEach>

                    </div>

                </div>
            </c:forEach>
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
