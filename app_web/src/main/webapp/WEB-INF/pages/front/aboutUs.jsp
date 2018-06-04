<%@page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<div class="about_100">
    <div class="ctr marginTop about1">
       <!--  <img src="/resources/portal/yc-images/about1.png" width="300" height="200" /> -->
    </div>
</div>
<div class="ctr about2">
    <span>山西省${util:property('business.platformName')}是一家综合性高科技公司，位于山西省太原市高新技术开发区。一直秉承着“专业、权威、安全、高效”的服务精神．以诚挚的态度，更好、更快地帮助客户取得成功。立足山西省面向全国。为高速发展的现代企业、单位提供先进的应用解决方案、优质优惠的产品及完善的技术支持与服务。公司注册资金为1000万。办公场所2500平米。</span>
</div>
<div class="about_100">
    <div class="ctr about3 about_text">
        <span>专业 · 快捷</span>
        <span>公司采用垂直管理方式，充分体现以客户为本的经营理念。公司分为研发中心、业务部、业务服务及咨询部、培训部等，各部门充分发挥各自专业领域的管理特色级灵活应用性，为各类型容户提供专业、快捷的服务。</span>
    </div>
</div>
<div class="ctr about4 about_text">
    <span>未来 · 方向</span>
    <span>公司秉承专业的态度力争做“互联网＋”时代的领军人。在当下，我们致力于成为正规、透明、权威的第三方服务平台。力创行内高效、便捷、专业的服务团队。在未来．我们愿拢手各行业精英共创集多元化、智能化、流程化的高科技软件公司。</span>
</div>
<div class="about_100">
    <div class="ctr about5">
        <div class="left about5_text">
            <span>联系我们</span>
            <ul>
                <li>地址：晋阳街 发展路 88号</li>
                <li>电话：<span>${util:property('hotline')}</span></li>
                <li>邮编：<span>030006</span></li>
            </ul>
            <span>关注我们</span>
            <ul>
                <!-- <li>微博：<span>http://**************************</span></li> -->
                <li>微信：<span>搜索公众号 金蝉电子招投标</span></li>
            </ul>
            <img src="/resources/portal/yc-images/about_ew.jpg" width="130" height="130" alt=""/>
        </div>
        <div class="left">
            <img src="/resources/portal/yc-images/about_address.jpg" width="620" height="400" alt=""/>
        </div>
    </div>
</div>
<jsp:include page="/front/include/footer.jsp"/>
<div class="clear"></div>
</body>
</html>