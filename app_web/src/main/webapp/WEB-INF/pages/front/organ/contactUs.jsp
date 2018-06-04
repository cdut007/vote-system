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
    <script type="text/javascript" src="/resources/portal/yc-js/jquery.SuperSlide.2.1.1.js"></script>
</head>
<body>
<jsp:include page="/front/include/topbar.jsp"/>
<div class="clear"></div>
<!--2banner栏-->
<jsp:include page="/front/include/organBanner.jsp"/>
<!--3导航栏-->
<jsp:include page="/front/include/organNavigation.jsp"/>
<div class="clear"></div>
<!-- 4内容栏 -->
<div class="content ctr">
    <!--4.1内容栏 左-->
    <jsp:include page="/front/include/organLeft.jsp"/>
    <!--4.2内容栏 右-->
    <div class="contentR right">
        <div class="marginTop contentMain pro_info">
            <div class="">联系我们</div>
            <div class="boxEdge " style="padding: 0px;">
                <div class="pro_sale_content">
                    <table width="100%" class="callM">
                        <tbody>
                        <tr><td width="60">单位：</td><td>${organ}</td></tr>
                        <tr><td>地址：</td><td>${organ.address}</td></tr>
                        <tr><td>邮编：</td><td>${organ.zipCode}</td></tr>
                        <tr><td>联系人：</td><td>${TODO}</td></tr>
                        <tr><td>电话：</td><td>${organ.phone}</td></tr>
                        <!-- <tr><td>手机：</td><td>18812345678</td></tr> -->
                        <tr><td>传真：</td><td>${organ.faxNo}</td></tr>
                        <tr><td>邮箱：</td><td>${organ.email}</td></tr>
                        <tr><td>网址：</td><td><a href="${organ.portal}" target="_blank">${organ.portal}</a></td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<div class="clear"></div>
<!-- 7帮助栏 -->
<div class="help">
    <div class="ctr">
        <!-- 6.1 帮助文字栏 -->
        <table class="helpTab left" cellspacing="0" cellpadding="0">
            <tr>
                <th><a>易采入门</a></th>
                <th><a>采购商服务</a></th>
                <th><a>供应商服务</a></th>
                <th><a>安全隐私</a></th>
                <th><a>合作共赢</a></th>
            </tr>
            <tr>
                <td><a>${util:property('business.platformName')}介绍</a></td>
                <td><a>发布采购</a></td>
                <td><a>发布商品</a></td>
                <td><a>用户协议</a></td>
                <td><a>投诉与建议</a></td>
            </tr>
            <tr>
                <td><a>采购商指南</a></td>
                <td><a>发布招标</a></td>
                <td><a>报价投标</a></td>
                <td><a>隐私权政策</a></td>
                <td><a>广告服务</a></td>
            </tr>
            <tr>
                <td><a>供应商指南</a></td>
                <td><a>在线采购</a></td>
                <td><a>信息核实</a></td>
                <td><a>在线交易协议</a></td>
                <td><a>市场合作</a></td>
            </tr>
            <tr>
                <td><a>招标机构指南</a></td>
                <td></td>
                <td></td>
                <td><a>在线交易安全</a></td>
                <td><a>友情链接</a></td>
            </tr>
        </table>
        <!-- 6.2 电话栏 -->
        <div class="call right">
            <div>
                <img src="resources/yc-images/call-ico.png"/>
                <span class="right pos2">易采热线</span>
                <span class="left">400-0000-000</span>
            </div>
        </div>
    </div>
</div>
<div class="clear"></div>
<!-- 8底部栏 -->
<div class="foot">
    <div class="ctr footEr">
        <p class="center">Copyright © 2001-2015 版权所有 晋ICP备00000000号-1 公网安备00000000000000号</p>

        <p class="center">山西${util:property('business.platformName')}网 山西${util:property('business.platformName')}有限公司 电话：0000-000-0000</p>
    </div>
</div>
</body>
</html>