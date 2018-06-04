<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>欢迎使用${util:property('business.platformName')}电子交易平台</title>
    <link href="/resources/portal/yc-css/yc-public.css" type="text/css" rel="stylesheet"/>
    <link href="/resources/portal/yc-css/yc-main.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/resources/portal/yc-js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="/resources/portal/yc-js/BreakingNews.js"></script>
</head>
<body>
<jsp:include page="/front/include/header.jsp"/>
<div class="clear"></div>
<!-- 4 内容 -->
<div class="ctr content">

    <!-- 4.1 面包屑导航    通知栏 -->
    <div class="address_nav">
        <!--4.1.1 当前位置 导航-->
        <div class="address_main left">
            当前位置：<a href="#">首页</a> > <a href="#">投诉举报</a>
        </div>
        <!-- 4.1.2通知 -->
        <jsp:include page="/front/include/inform.jsp"/>
        <div class="clear"></div>
    </div>
</div>
<div class="clear"></div>


<!--5 内容信息栏------------------------------------------------------>
<div class="ctr marginTop ">
    <div class="tsjb">
        <span>
        为加强招标投标活动的社会监督,完善相关举报和投诉制度, 进一步健全工程建设项目招投标制度，根据《国务院办公厅进一步规范招投标活动的若干意见》（国办发[2004]56号）要求，贯彻落实“2007年全省党风廉政建设和反腐败工作任务分解意见”,现将省直有关行政监督部门受理招投标投诉的机构、受理电话等信息向社会公布。
        </span>
        <table cellpadding="0" cellspacing="0">
            <tbody>
            <tr><td>山西省发展和改革委员会</td><td>法规处</td><td>3119410</td></tr>
            <tr><td>山西省经济委员会</td><td>投资规划处</td><td>3046026</td></tr>
            <tr><td>山西省商务厅</td><td>机电处</td><td>4073150</td></tr>
            <tr><td>山西省建设厅</td><td>稽查处</td><td>3580083</td></tr>
            <tr><td>山西省交通厅</td><td>省监委驻交通厅监察组</td><td>4663058</td></tr>
            <tr><td>山西省水利厅</td><td>基建处</td><td>4666211</td></tr>
            <tr><td>太原铁路局</td><td>执法监察室</td><td>2623980</td></tr>　　　　　　　　　　
            </tbody>
        </table>
        <script type="text/javascript">
            $(document).ready(function() {
                // $(".tab_dljg tr").attr("bgColor", "#f0f0f0"); //为单数行表格设置背景颜色
                $(".tsjb table tbody tr:even").css("background-color", "#f0f0f0"); //为双数行表格设置背颜色素
            });
        </script>
        <span>
       投标人和其他利害关系人认为招标投标活动不符合法律、法规和规章规定的，可以依据《工程建设项目招标投标活动投诉处理办法》（国家发改委等七部委第11号令），在知道或者应当知道权益受到侵害之日十日内，向有关行政监督部门提出书面投诉。行政监督部门收到投诉书后，五日内进行审查，视情况作出是否受理的决定；一经受理，应当自受理投诉之日起三十日内对投诉事项做出处理决定，情况复杂的，经本部门负责人批准，可以适当延长，并告知投诉人和被投诉人。
        </span>
    </div>
</div>
<div class="clear"></div>

<!-- 6帮助栏 -->
<jsp:include page="/front/include/footer.jsp"/>
<div class="clear"></div>
</body>
</html>