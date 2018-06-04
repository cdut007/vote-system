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
    <title>查看已标价工程量清单</title>

    <sys:link easyui="true" jgrowl="true" plupload="true" ztree="true" uedit="true"/>
    <script type="text/javascript">
        $(function(){
            selectUnit();
        });

        function selectProject(obj) {
            $("#myform").submit();
        }

        function HWPostil1_NotifyCtrlReady() {
            document.all.HWPostil1.HideMenuItem(30);
        }
        
        function selectUnit() {
            var aip = $("#projectUnit").val();

            if(aip == null || aip == ""){
                return;
            }
            $(".unitName").text($.trim($("#projectUnit").text()));
            var host = document.location.protocol + "//" + window.location.host;
            OpenFile(host + "/attachment/downloadByPath?path=" + aip);
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
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
<!--该事件在AIP引擎初始化完毕之后触发-->
<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
    HWPostil1_NotifyCtrlReady();
</SCRIPT>
<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyAfterAction(lActionType,lType,strName,strValue)>
    HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue);
</SCRIPT>



<div class="block">
    <div id="ur_here">
        当前位置: <a href="${util:property('frontEnd')}">首页</a>
        <code>&gt;</code>
        查看投标工程量清单
    </div>
    <div class="blank10"></div>

    <c:if test="${empty project}">
        <div class="usBox1">
        <h2>未找到该投标人的相关数据</h2>
        </div>
    </c:if>

    <c:if test="${not empty project}">
    <div class="usBox1">
        <form id="myform" action="${pageContext.request.contextPath}/clearup/viewaip?tendid=${tendid}" method="post">

            <div style="margin-bottom: 10px;">
                请选择要查看的 单项工程:
                <select name="projectName" onchange="selectProject(this)">
                    <c:forEach items="${projectNames}" var="name">
                        <option value="<c:out value="${name}"></c:out>" ${name==project.projectName?"selected":""}><c:out
                                value="${name}"></c:out></option>
                    </c:forEach>
                </select>

                &nbsp;&nbsp;单位工程:
                <select id="projectUnit" onchange="selectUnit()">
                    <c:forEach items="${project.units}" var="unit">
                        <option value="<c:out value="${unit.aip}"></c:out>"><c:out value="${unit.name}"></c:out></option>
                    </c:forEach>
                </select>
            </div>
        </form>
        <div class="clearfix1">
            <div id="p" class="easyui-panel" style="height:800px;padding:10px; margin-bottom:10px;"
                 data-options="title:'单项工程: ${project.projectName} 单位工程：<span class=unitName></span>',iconCls:'icon-tip',
						collapsible:true">

                <!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
                <script src="/resources/aip/LoadAip.js"></script>
                <!-- --------------------------------== 结束装载控件 ==----------------------------------- -->

            </div>
        </div>
    </div>
    </c:if>
</div>

<div class="blank10"></div>

<jsp:include page="/common/bottom.jsp"/>

<div id="zbOrgan">
    <table id="zbrTable"></table>
</div>
</body>
</html>
