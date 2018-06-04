<%@page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎使用${util:property('business.platformName')}电子交易平台</title>
<link href="/resources/portal/yc-css/yc-public.css" type="text/css" rel="stylesheet" />
<link href="/resources/portal/yc-css/yc-main.css" type="text/css" rel="stylesheet" />
<!-- 弹出通知 -->
<style type="text/css">
        #winpop { width:400px;color:blance; height:0px; background:#C70000; position:fixed; right:0; bottom:0; border:1px solid #666; margin:0; padding:1px; overflow:hidden; display:none;z-index:500}
        #winpop .title { width:100%; height:26px; color:#FFFFFF; line-height:20px; background:#C70000; font-weight:bold; text-align:left; font-size:18px;}
        #winpop .con { width:100%; height:140px; color:black; font-size:14px; padding-left: 5px;padding-top: 7px;padding-right: 5px;}
        #winpop .bottom{ height:40px; float: right; cursor: hand;}
        .close { position:absolute; right:4px; top:-1px; color:#FFF; cursor:pointer}
</style>

<script type="text/javascript" src="/resources/portal/yc-js/jquery-1.4.2.min.js"></script>
<!--  SuperSlide为多选项搜索栏 -----BreakingNews为动态通知栏-->
<script type="text/javascript" src="/resources/portal/yc-js/jquery.SuperSlide.2.1.1.js"></script>
<script type="text/javascript" src="/resources/portal/yc-js/BreakingNews.js"></script>
<script type="text/javascript">
       function tips_pop(){
           var MsgPop=document.getElementById("winpop");
           var popH=parseInt(MsgPop.style.height);//将对象的高度转化为数字
           if (popH==0){
               MsgPop.style.display="block";//显示隐藏的窗口
               show=setInterval("changeH('up')",2);
           }else { 
               hide=setInterval("changeH('down')",2);
           }
       }
       function changeH(str) {
           var MsgPop=document.getElementById("winpop");
           var popH=parseInt(MsgPop.style.height);
         
           if(str=="up"){
               if (popH<=200){
                   MsgPop.style.height=(popH+4).toString()+"px";
                }else{  
                    clearInterval(show);
                }
            }
           if(str=="down"){ 
                 if (popH>=4){  
                     MsgPop.style.height=(popH-4).toString()+"px";
                 }else{ 
                     clearInterval(hide);   
                     MsgPop.style.display="none";  //隐藏DIV
                 }
            }
       }
       function showPageMsg() {//查看全部
           alert("弹出更新具体内容");
       }
       window.onload=function(){//加载
           $('#winpop').height(0);
           setTimeout(tips_pop,0);//0秒后调用tips_pop()这个函数
           $('#bianjiqi').attr('href', "https://"+window.location.hostname+":9090/");  
       };
</script>
</head>
<body>
<div class="bodyBg">
	<jsp:include page="/front/include/header.jsp" />
	<div class="clear"></div>
	<!--4 内容全部------------------------------------------------------------------------------------------------------------------------------------------->
	<div class="ctr content marginTop">
		<!--4.1  平台信息    轮播banner    登录操作栏 ------------------------------------------------->
		<div class="marginTop">
			<!--4.1.1  平台信息------------------------------------->
			<%-- <div class="boxWidth_290 boxHeight_280 left">
				<div class="headTr">
					<span>平台信息</span><a class="right" href="${pageContext.request.contextPath}/front_article/platform/pagingArticle" target="_blank">更多&gt;</a>
				</div>
				<div class="CtList_width_270 Content_list ">
					<ul class="ContentWidth_200 Content_list_out ">
						<c:forEach items="${articleService.findTop8ByArticleType('platform')}" var="item">
							<li><a href="${pageContext.request.contextPath}/front_article/${item.articleType}/articleDetail/${item.id}" target="_blank" title="${item}"><span class="list_spot"> · </span>${item}</a><span class="right"><fmt:formatDate value="${item.publishTime}" pattern="MM-dd" /></span></li>
						</c:forEach>
					</ul>
				</div>
			</div> --%>
			<!--4.1.2   轮播banner---------------------------------->
			<div class="banner_ctr left">
				<div id="slideBox" class="slideBox">
					<c:set value="${imageService.findAll()}" var="imageList"></c:set>
					<div class="hd">
						<ul>
							<c:forEach varStatus="status" items="${imageList}" var="image">
								<li>${status.count}</li>
							</c:forEach>
						</ul>
					</div>
					<div class="bd">
						<ul>
							<c:forEach varStatus="status" items="${imageList}" var="image">
								<li><a href="${image.url}" target="_blank"><img src="${pageContext.request.contextPath}/attachment/download/${image.attachment.path}" title="${image.name}" /></a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<script type="text/javascript">
					jQuery(".slideBox").slide({
						mainCell : ".bd ul",
						effect : "fold",
						autoPlay : true
					});
				</script>
			</div>
			<!--4.1.3    登录 快捷栏--------------------------------->
			<div class="boxWidth_290 boxHeight_350 right  ">
				<!--登录  注册按钮-->
				<jsp:include page="/front/include/loginbar.jsp" />
				<!--注册指南入口按钮-->
				<a href="${pageContext.request.contextPath}/help/hyzc">
					<div class="InSize InEdit ">
						<span class="InBt">注册指南</span> <span class="InCt">Registration guidelines</span>
					</div>
				</a>
				<div class="InSizeBottomLine"></div>
				<!--业务流程入口按钮-->
				<a href="${pageContext.request.contextPath}/home" target="_blank">
					<div class="InSize InFlow ">
						<span class="InBt">业务办理</span> <span class="InCt">Service process</span>
					</div>
				</a>
				<div class="InSizeBottomLine"></div>
				<!--下载中心入口按钮-->
				<a href="${pageContext.request.contextPath}/filedown" target="_blank">
					<div class="InSize InDownload "> 
						<span class="InBt">下载中心</span> <span class="InCt">投标文件编辑器、数字证书KEY驱动、文件模板等</span>
					</div>
				</a>
				<!--招标文件编辑器入口-->
				<div class="InSizeBottomLine"></div>
				<a href="javascript:void(0) " id="bianjiqi" target="_blank">
					<div class="InSize InEdit "> 
						<span class="InBt">招标文件编辑器入口</span> <span class="InCt">制作招标文件</span>
					</div>
				</a>
				<!--证书办理入口按钮-->
				<!-- <a href="/tm/tongmei/digitalCertificate" target="_blank">
					<div class="InSize InKey ">
						<span class="InBt">CA电子认证证书</span> <span class="InCt">CA Handle</span>
					</div>
				</a> -->
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
		<!--4.2 通知 招标公告   违规公示--------------------------------------------------------------->
		<div class="marginTop">
			<!--通知  招标公告   左内容栏---------------------------------------->
			<div class="boxWidth_840 left">
				<!--滚动通知------------------------->
				<%-- <div class="BreakingNewsController easing" id="breakingnews">
					<div class="bn-title"></div>
					<img src="/resources/portal/yc-images/lb.gif" alt="" />
					<ul>
						<c:forEach items="${articleService.findTop8ByArticleType('inform')}" var="item">
							<li><a href="${pageContext.request.contextPath}/front_article/${item.articleType}/articleDetail/${item.id}" title="${item}" target="_blank">${item}</a></li>
						</c:forEach>
					</ul>
					<div class="bn-arrows">
						<span class="bn-arrows-left"></span><span class="bn-arrows-right"></span>
					</div>
					<script type="text/javascript">
						$("#breakingnews").BreakingNews({
							background : "#FFF",
							title : "通 知",
							titlecolor : "#FFF",
							titlebgcolor : "#1caceb",
							linkcolor : "#333",
							linkhovercolor : "#1caceb",
							fonttextsize : 16,
							isbold : false,
							border : "solid 1px #1caceb",
							width : "840px",
							timer : 3000,
							autoplay : true,
							effect : "fade"
						});
					</script>
				</div> --%>
				<div class="clear"></div>
				<!--招标公告------------------------->
				<div class="marginTop ">
					<div class="headTr">
						<span>招标公告</span>
					<!-- 	<div id="zb" class="tab_in"> -->
							<c:set value="${util:dictionaryTree('PROJECT_ITEM_TYPE',false)}" var="projectItemTypeList"/>
	<%-- 						<c:forEach items="${projectItemTypeList}" var="projectItemType" varStatus="status">
								<a ${status.index==1?"class='tab_in_a'":""}>${projectItemType}</a>
							</c:forEach>
						</div> --%>
						<a class="right" href="${pageContext.request.contextPath}/front_notice/pagingNotice" target="_blank">查看更多&gt;</a>
					</div>
					<c:forEach items="${projectItemTypeList}" var="projectItemType" varStatus="status">
						<!---------${projectItemType}选项---------------------------------------------------------------------------->
						<table class="boxHeight_290" id="zb_${status.index}" cellpadding="0" cellspacing="0" width="840" ${status.index==0?"":"style='display: none;'"}>
							<tr class="bg_bai">
								<th width="340" height="34px" class="hc">公告标题</th>
								<th width="120">类别</th>
								<th width="160">地区</th>
								<th width="160">发布时间</th>
							</tr>
							<c:set value="${tenderNoticeService.findTop7ByProjectItemType(projectItemType.itemCode)}" var="tenderNoticeList"/>
							<c:forEach items="${tenderNoticeList}" var="item" varStatus="status">
								<tr ${status.index%2==0?"class='bg_hui'":"class='bg_bai'" }>
									<td height="34" class="hc"><a href="${pageContext.request.contextPath}/front_notice/noticeDetail/${item.id}" title="${item}" target="_blank">${item}</a></td>
									<td  ${item.ggxzdm==5?'color_again':(item.ggxzdm==6?'color_ctr':'')}">${util:dictionary('GGXZDM',item.ggxzdm)}</td>
									<td ><a>${util:dictionaryPath('REGION',item.projectInstance.region)}</a></td>
									<td ><fmt:formatDate value="${item.ggfbsj}" pattern="yyyy-MM-dd" /></td>
								</tr>
							</c:forEach>
							<c:forEach begin="${fn:length(tenderNoticeList)}" end="7">
								<tr>
									<td height="34" class="hc"><a></a></td>
									<td class="center color_ctr"></td>
									<td class="center"><a></a></td>
									<td class="center"></td>
								</tr>
							</c:forEach>
						</table>
					</c:forEach>
					<script>
						$("#zb a ").bind("click", function() {
							$(this).parent().find("a").removeClass("tab_in_a");
							$(this).addClass("tab_in_a");
							var index = $(this).index();
							$("#zb a ").each(function(i){
								i==index?$("#zb_" + i).show():$("#zb_"+i).hide();
							});
						});
					</script>
				</div>
				<div class="clear"></div>
			</div>
			<!--违规公示   右边栏---------------------------------------------------------->
<%-- 			<div class="boxWidth_290 right boxEdge">
				<div class="boxHeadT box_ico_wggs">
					违规公示<a class="right" href="${pageContext.request.contextPath}/front_article/violation/pagingArticle" target="_blank">更多&gt;</a>
				</div>
				<div class="CtList_width_270 Content_list CtList_height_336">
					<ul class="Content_list_out ContentWidth_254">
						<c:forEach items="${articleService.findTop12ByArticleType('violation')}" var="item">
							<li><a href="${pageContext.request.contextPath}/front_article/${item.articleType}/articleDetail/${item.id}" title="${item}" target="_blank"><span class="list_spot"> · </span>${item}</a></li>
						</c:forEach>
					</ul>
				</div>
			</div> --%>
			<!--公司动态   右边栏---------------------------------------------------------->
			<div class="boxWidth_290 right boxCompanyNews">
				<div class="boxHeadCompanyNews">
					公司动态
				</div>
				<div class="CtList_width_270 Content_list CtList_height_290">
					<ul class="Content_list_out ContentWidth_200">
						<c:forEach items="${articleService.findTop8ByArticleType('platform')}" var="item">
							<li><a href="${pageContext.request.contextPath}/front_article/${item.articleType}/articleDetail/${item.id}" target="_blank" title="${item}"><span class="list_spot"> · </span>${item}</a><span class="right"><fmt:formatDate value="${item.publishTime}" pattern="MM-dd" /></span></li>
						</c:forEach>
					</ul>
					<span><a class="right" href="${pageContext.request.contextPath}/front_article/platform/pagingArticle">更多&gt;</a></span>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
		<!--4.3 评标公示  中标公示  文件 政法 投诉----------------------------------------------------->
		<div class="marginTop ">
			<!-- 评标公示    中标公示---------------------------------------->
			<div class="boxWidth_840 left">
				<!--评标结果公示-->
				<div class="boxEdge1 left">
					<div class="boxHeadT1">
						中标候选人公示<a class="right" href="${pageContext.request.contextPath}/front_notice/pagingCandidatePublicity" target="_blank">更多&gt;</a>
					</div>
					<div class="CtList_width_415 Content_list CtList_height_220">
						<ul class="Content_list_out ContentWidth_254">
							<c:forEach items="${candidatePublicityService.findTop7()}" var="item">
								<li><a href="${pageContext.request.contextPath}/front_notice/candidatePublicityDetail/${item.id}" title="${item}"><span class="list_spot"> · </span>${item}</a><span class="right"><fmt:formatDate value="${item.gskssj}" pattern="MM-dd" /></span></li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<!--中标结果公示-->
				<div class="boxEdge1 right">
					<div class="boxHeadT1">
						中标公告<a class="right" href="${pageContext.request.contextPath}/front_notice/pagingWinBidNotice" target="_blank">更多&gt;</a>
					</div>
					<div class="CtList_width_415 Content_list CtList_height_220">
						<ul class="Content_list_out ContentWidth_254">
							<c:forEach items="${winBidNoticeService.findTop7()}" var="item">
								<li><a href="${pageContext.request.contextPath}/front_notice/winBidNoticeDetail/${item.id}" target="_blank"><span class="list_spot"> · </span>${item}</a><span class="right"><fmt:formatDate value="${item.publishDate}" pattern="MM-dd" /></span></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<!--文件下载   政法解读   投诉举报------------------------------------------------------->
			<%-- <div class="boxWidth_290 right">
				<!--文件下载中心--------------------------------->
				<a href="${pageContext.request.contextPath}/filedown" target="_blank">
					<div class="InSize1 InDown" style="margin:0px;">
						<div>
							<span class="InBt1">文件下载中心</span> <span class="InCt1">投标文件编辑器、数字证书KEY驱动、文件模板等</span>
						</div>
					</div>
				</a>
				<!--文件下载中心--------------------------------->
				<a href="${pageContext.request.contextPath}/front_article/policy/pagingArticle" target="_blank">
					<div class="InSize1 InLaw">
						<div>
							<span class="InBt1">政策法规解读</span> <span class="InCt1">电子招标投标办法、相关实施条例等</span>
						</div>
					</div>
				</a>
				<!--文件下载中心--------------------------------->
				<a href="${pageContext.request.contextPath}/complaints" target="_blank">
					<div class="InSize1 InMail">
						<div>
							<span class="InBt1">投诉举报热线</span> <span class="InCt1">对违法、违规操作可进行投诉或举报等</span>
						</div>
					</div>
				</a>
			</div> --%>
			<!--项目信息   右边栏---------------------------------------------------------->
			<div class="boxWidth_290 right boxProjectInfo">
				<div class="boxHeadCompanyNews">
					项目信息
				</div>
				<div class="CtList_width_270 Content_list CtList_height_220">
					<ul class="Content_list_out ContentWidth_200">
						<%-- <c:forEach items="${projectItemTypeList}" var="projectItemType" varStatus="status"> --%>
						<!---------${projectItemType}选项---------------------------------------------------------------------------->
							<c:set value="${projectInstanceService.findTop7ByProjectItemType()}" var="projectInstancelist"/>
							<c:forEach items="${projectInstancelist}" var="item" varStatus="status">
								<li><a href="${pageContext.request.contextPath}/front_projectInstance/projectInstanceDetail/${item.id}" title="${item.zbxmmc}" target="_blank"><span class="list_spot"> · </span>${item.zbxmmc}</a><span class="right"><fmt:formatDate value="${item.lxsj00}" pattern="MM-dd" /></span></li>
							</c:forEach>
						<%-- </c:forEach> --%>
					</ul>
				</div>
					<span><a class="right" href="${pageContext.request.contextPath}/front_projectInstance/pagingProjectInstance" target="_blank">更多&gt;</a></span>
			</div>
		</div>
		<div class="clear"></div>
		<!--4.4 通栏banner----------------------------------------------------------------------------->
		<!-- <div class="banner_ctr_normal marginTop"></div> -->
		<div class="clear"></div>
		
		<!--4.5 项目信息  热门资讯 -------------------------------------------------------------------->
		<%-- <div class="marginTop">
			<!--项目信息---------->
			<c:set var="projectInstanceList" value="${projectInstanceService.retrieveProjectInstanceTop(7)}" />
			
			<div class="boxWidth_840 left">
				<div class="marginTop ">
					<div class="headTr">
						<span>项目信息</span>
						<div class="tab_in" id="xm">
							<c:forEach items="${projectItemTypeList}" var="projectItemType" varStatus="status">
								<a ${status.index==1?"class='tab_in_a'":""}>${projectItemType}</a>
							</c:forEach>
						</div>
						<a class="right" href="${pageContext.request.contextPath}/front_projectInstance/pagingProjectInstance" target="_blank">更多&gt;</a>
					</div>
					<c:forEach items="${projectItemTypeList}" var="projectItemType" varStatus="status">
						<!---------${projectItemType}选项---------------------------------------------------------------------------->
						<table class="boxHeight_290" id="xm_${status.index}" cellpadding="0" cellspacing="0" width="840" ${status.index==0?"":"style='display: none;'"}>
							<tr class="bg_hui">
								<th width="440" height="34px">项目名称</th>
								<th width="160">地区</th>
								<th width="240">发布时间</th>
							</tr>
							<c:set value="${projectInstanceService.findTop7ByProjectItemType(projectItemType.itemCode)}" var="projectInstancelist"/>
							<c:set value="${projectInstanceService.findTop7ByProjectItemType()}" var="projectInstancelist"/>
							<c:forEach items="${projectInstancelist}" var="item" varStatus="status">
								<tr>
									<td height="34" class="hc"><a href="${pageContext.request.contextPath}/front_projectInstance/projectInstanceDetail/${item.id}" title="${item.zbxmmc}">${item.zbxmmc}</a></td>
									<td class="center"><a>${util:dictionaryPath('REGION',item.region)}</a></td>
									<td class="center"><fmt:formatDate value="${item.lxsj00}" pattern="yyyy-MM-dd" /></td>
								</tr>
							</c:forEach>
							<c:forEach begin="${fn:length(projectInstancelist)}" end="7">
								<tr>
									<td height="34" class="hc"><a></a></td>
									<td class="center"><a></a></td>
									<td class="center"></td>
								</tr>
							</c:forEach>
						</table>
					</c:forEach>
					<script>
						$("#xm a ").bind("click", function() {
							$(this).parent().find("a").removeClass("tab_in_a");
							$(this).addClass("tab_in_a");
							var index = $(this).index();
							$("#xm a ").each(function(i){
								i==index?$("#xm_" + i).show():$("#xm_"+i).hide();
							});
						});
					</script>
				</div>
				<div class="clear"></div>
			</div>
			<!--热门资讯------------>
			<div class="boxWidth_290 right boxEdge">
				<div class="boxHeadT box_ico_rmzx">
					热门资讯<a class="right" href="${pageContext.request.contextPath}/front_article/news/pagingArticle" target="_blank">更多&gt;</a>
				</div>
				<div class="CtList_width_270 Content_list CtList_height_300">
					<ul class="Content_list_out ContentWidth_254">
						<c:forEach items="${articleService.findTop8ByArticleType('news')}" var="item">
							<li><a href="${pageContext.request.contextPath}/front_article/${item.articleType}/articleDetail/${item.id}" title="${item}" target="_blank"><span class="list_spot"> · </span>${item}</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			
			<div class="boxWidth_290 right boxEdge">
				<div class="boxHeadT box_ico_dljg">
					代理机构<a class="right" href="${pageContext.request.contextPath}/front_organ/A/pagingOrgan" target="_blank">更多&gt;</a>
				</div>
				<div class="CtList_width_270 Content_list CtList_height_200">
					<ul class="Content_list_out ContentWidth_254">
						<c:forEach items="${organService.findOrganATop10()}" var="item">
							<li><a href="${pageContext.request.contextPath}/front_organ/A/organIndex/${item.id}" title="${item.ztmc00}" target="_blank"><span class="list_spot"> · </span>${item.ztmc00}</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		 --%>
		
		<div class="clear"></div>
		<!--4.6 banner _small  两个banner-------------------------------------------------------------->
		<div class="marginTop">
			<!-- <div class="boxWidth_840 left banner_ctr_small0"></div>
			<div class="boxWidth_290 right banner_ctr_small1"></div> -->
			<a href="${pageContext.request.contextPath}/front_article/policy/pagingArticle">
				<div class="left banner_ctr_article">
					<div class="bottomBanner">
						<span class="bannerBt">政策法规解读</span> <span class="bannerCt">电子招标投标办法、相关实施条例等</span>
					</div>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/complaints">
				<div class="left banner_ctr_complaint">
					<div class="bottomBanner">
						<span class="bannerBt">投诉举报</span> <span class="bannerCt">对违法、违规操作可进行投诉或举报等</span>
					</div>
				</div>
			</a>
			<div class="left banner_ctr_hotline">
				<div class="bottomBanner">
					<span class="bannerBt">服务热线</span> <span class="bannerBt">${util:property('hotline')}</span>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<!--4.7 产品   代理机构------------------------------------------------------------------------>
		<div class="marginTop">
			<!--产品供应商----------------------------------------------------------->
			<!-- <div class="boxWidth_840 left"> -->
				<!-- <div class="headTr"> -->
		<!--产品推荐暂时隐藏----------------------------------------------------------->
					<%-- <span>产品推荐</span>
					<div class="hot_product">
						<c:set value="${searchRecordService.retrieveKeywordsTop('product',10)}" var="hotProductList" />
						<c:forEach items="${hotProductList}" var="keywords" varStatus="status">
							<a href="javascript:window.location.href='${pageContext.request.contextPath}/front_product/pagingProduct?keywords='+encodeURI('${keywords}')"> ${keywords}</a>  ${fn:length(hotProductList)==status.count?"":"|"}  
			   		</c:forEach>
					</div>
					<a class="right" href="${pageContext.request.contextPath}/front_product/productIndex" target="_blank">更多&gt;</a>
				 --%><!-- </div> -->
				<!-- <div class="clear"></div> -->
		<!--产品图容器暂时隐藏----------------------------------------------------------->		
				<!--产品图容器-->
				<%--<div class="product_content boxHeight_140">
					 <c:forEach items="${productService.findTop4()}" var="item" varStatus="status">
						<div class="product_main left" ${status.index==0?"style='margin-left: 0px;'":""}>
							<div class="P_img">
								<a href="${pageContext.request.contextPath}/front_organ/productDetail/${item.id}" target="_blank"><img src="${util:property('backEnd')}/attachment/download/${item.attachment.path}" width="160" height="160" /></a>
							</div>
							<div class="clear"></div>
							<span class="P_Bt"><a href="${pageContext.request.contextPath}/front_organ/productDetail/${item.id}" target="_blank">${item.productName}</a></span> <span class="P_Lab P_bg0${(status.index mod 3)+1}">${util:dictionary('PRODUCT_TYPE',item.productType)}</span> <span class="P_Whe">${item.organ}</span>
						</div>
					</c:forEach> 
				</div>--%>
				<!-- <div class="clear"></div> -->
				
				<%-- <c:forEach items="${organService.findOrganBTop4()}" var="item" varStatus="status">
					<!--供应商容器${status.count}-->
					<div class="boxHeight_70 boxWidth_418 left sale_bg" ${status.count mod 2==1?"style='margin-left: 0;'":""}>
						<div class="sale_con left ">
							<a href="${pageContext.request.contextPath}/front_organ/B/organIndex/${item.id}" target="_blank"><c:choose><c:when test="${not empty item.logo}"><img src="${util:property('backEnd')}/attachment/download/${item.logo.path}" width="100" height="60"/></c:when><c:otherwise><img src="/resources/portal/yc-images/logo_no.jpg" width="100" height="60"/></c:otherwise></c:choose></a>
						</div>
						<div class="sale_cot right">
							<p class="S_name">
								<a href="${pageContext.request.contextPath}/front_organ/B/organIndex/${item.id}" target="_blank">${item.ztmc00}</a>
							</p>
							<p class="S_cont">主营产品：${util:delHTMLTag(item.businessScope)}</p>
							<p class="S_cont">所在地区：${util:dictionaryPath('REGION',item.region)}</p>
						</div>
					</div>
				</c:forEach> --%>
				
			<!-- </div> -->
			<!--代理机构--------------------------------------------------->
			<%-- <div class="boxWidth_290 right boxEdge">
				<div class="boxHeadT box_ico_dljg">
					代理机构<a class="right" href="${pageContext.request.contextPath}/front_organ/A/pagingOrgan" target="_blank">更多&gt;</a>
				</div>
				<div class="CtList_width_270 Content_list CtList_height_416">
					<ul class="Content_list_out ContentWidth_254">
						<c:forEach items="${organService.findOrganATop14()}" var="item">
							<li><a href="${pageContext.request.contextPath}/front_organ/A/organIndex/${item.id}" title="${item.ztmc00}" target="_blank"><span class="list_spot"> · </span>${item.ztmc00}</a></li>
						</c:forEach>
					</ul>
				</div>
			</div> --%>
		</div>
		<div id="winpop">
        	<div class="title">重要通知<span class="close" onclick="tips_pop()" style="text-align: center;">关闭</span></div>
	        <div style="background: #FFFFFF; width: 100%; height: 200px;">
	            <div class="con"><h1 align="center">友情提示</h1><br/>1、为了确保能正常使用平台所有功能请使用IE浏览器！<br/><br/>2、投标单位的付款形式已有增加，已有原来的电汇+凭证上传 拓展为 电汇+凭证上传 及 线上网银直接支付。<!-- <span style="color:red">（保证金打款账户必须是企业基本户）</span><br/>如有问题请拨打，联系电话：0351-5288092 --></div>
<!-- 	            <div class="bottom"> <label onclick="showPageMsg()">查看全部</label></div>
 -->	        </div>
    		</div>
    	</div>   
	<div> 
		<div class="clear"></div>
		<!--5 友情链接------------------------------------------------------------------------------->
		<!-- <div class="marginTop headTr_yq">
			<span>友情链接</span>
		</div>
		<table>
			<tbody>
				<tr>
					<td>国家发展改革委</td>
				</tr>
			</tbody>
		</table> -->
	</div>
	<div class="clear"></div>
	<br />
	<jsp:include page="/front/include/footer.jsp" />
	<div class="clear"></div>
	<!-- add -->
	<!-- <script type="text/javascript" src="/resources/player1/jquery172.js"></script> -->
	<%-- <script type="text/javascript" src="/resources/player1/action.js"></script>
	<div class="helpbar" style="position:fixed;top:300px;left:20px;width:280px;height:305px;border:1px solid #c00000;">
		<div><h1 style="background:#c70000;color:#fff;font-size: 14px;">平台使用视频教程<a style="color:#fff;float:right" href="#" onclick="$(this).parents('.helpbar:first').remove();">关闭</a></h1></div>
		<div class="video" id="CuPlayer" style="margin-left:2px;">
			<% String videopath=(String)request.getParameter("videopath");if(videopath==null||"".equals(videopath)){videopath="/resources/video/firstRegister.mp4";}%>
			<SCRIPT LANGUAGE=JavaScript>
			//<!--
			/*
			* 跨平台方案X1（基于普通HTTP协议）=============
			* @param {Object} vID        ID
			* @param {Object} vWidth     播放器宽度设置
			* @param {Object} vHeight    播放器高度设置
			* @param {Object} vFile      播放器配置文件
			* @param {Object} vPlayer    播放器文件
			* @param {Object} vPic       视频缩略图
			* @param {Object} vCssurl    移动端CSS应用文件
			* @param {Object} vMp4url    视频文件地址
			
			* 跨平台方案说明=============================
			* 本实例请在IIS/Apache等网站环境下测试
			* 本实例实现HTTP协议下的跨平台
			* 本实例要求[视频文件地址]为mp4格式
			*/
			var vID        = ""; 
			var vWidth     = 278;            //播放器宽度设置
			var vHeight    = 200;               //播放器高度设置
			var vFile      = "/resources/player1/CuSunV2set.xml";  //播放器配置文件
			var vPlayer    = "/resources/player1/player.swf?v=2.5";//播放器文件
			var vPic       = "/resources/player/images/start.jpg";//视频缩略图
			var vCssurl    = "/resources/player/images/mini.css"; //移动端CSS应用文件
			
			//适配PC,安卓,iOS请用mp4文件
			var vMp4url    = "<%=videopath%>";  //视频文件地址
			//-->
			</SCRIPT> 
			<script class="CuPlayerVideo" data-mce-role="CuPlayerVideo" type="text/javascript" src="/resources/player1/CuSunX1.min.js"></script>
		</div>
		<div style="overflow: auto;height:68px;background:#000;color:#fff;font-weight:bold;padding:5px;border-top:1px solid #c00000;">
			<ul>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/firstRegister.mp4">首次注册</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/projectAndAgencySigned.mp4">委托方新建项目和委托合同的签订</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/theAgency.mp4">代理机构的使用</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/tenderingUnits.mp4">投标单位的使用</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/expertsUse.mp4">专家的使用</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/keyBindingUnbundling.mp4">数字证书的绑定和解除</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/tenderFeePayments.mp4">标书费用支付</a></li>
				<li><a style="color:#fff;" href="/?videopath=/resources/video/winningCandidatePublic.mp4">中标候选人公示</a></li>
			</ul>
		</div>
	</div>
	<div class="helpbar" style="position:fixed;top:300px;right:20px;width:200px;height:200px;">
		<div style="position:relative;width:100%;">
			<img src="/resources/images/callcenter.png" style="width:100%;"/>
			<div style="position:absolute;top:235px;color:#fff;margin-left:70px;font-weight: bold;"><a style="color:#fff;" href="http://wpa.qq.com/msgrd?v=3&uin=907121461&site=qq&menu=yes">907121461</a></div>
			<div style="position:absolute;top:270px;color:#fff;margin-left:70px;font-weight: bold;"><a style="color:#fff;" href="http://wpa.qq.com/msgrd?v=3&uin=384580575&site=qq&menu=yes">384580575</a></div>
			<div style="position:absolute;top:330px;color:#fff;margin-left:70px;font-weight: bold;">0351-5288092 </div>
		</div>
	</div>
	<div class="congratulate" style="position:absolute;width:300px;top:200px;z-Index:99999;"><img src="/resources/images/h.png" style="width:100%;"></div>
	<div class="congratulate" style="position:absolute;top:200px;left:80px;z-Index:99999;width:120px;"><img src="/resources/images/v1.jpg" style="width:100%;"></div>
	<div class="congratulate" style="position:absolute;top:200px;right:80px;z-Index:99999;width:120px;"><img src="/resources/images/v2.jpg" style="width:100%;"></div>
	<script type="text/javascript">
	$(function(){
		$(".helpbar").hide();
		$(".congratulate:first").css("marginLeft",($(window).width()-$(".congratulate:first").width())/2);
		$(".congratulate").hide();
		$(".congratulate").fadeIn();
		window.setTimeout(function(){
			$(".congratulate").fadeOut();
			$(".helpbar").fadeIn();
		},5000);
	});
	</script> --%>
</div>
</body>

</html>