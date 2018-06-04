<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@page import="java.text.*,java.util.*" session="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>欢迎使用${util:property('business.platformName')}电子交易平台</title>
    <link href="/resources/portal/yc-css/yc-public.css" type="text/css" rel="stylesheet"/>
    <link href="/resources/portal/yc-css/yc-main.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/resources/portal/yc-js/jquery-1.4.2.min.js"></script>
    <!--  SuperSlide为多选项搜索栏 -----BreakingNews为动态通知栏-->
    <script type="text/javascript" src="/resources/portal/yc-js/jquery.SuperSlide.2.1.1.js"></script>
    <script type="text/javascript" src="/resources/portal/yc-js/BreakingNews.js"></script>
</head>
<body>
<jsp:include page="/front/include/header.jsp"/>
<div class="clear"></div>
<!--4 内容全部------------------------------------------------------------------------------------------------------------------------------------------->
<div class="ctr content marginTop">
    <!--4.1  产品分类导航    轮播banner    登录操作栏 ------------------------------------------------->
    <div class="marginTop">
        <!--4.1.1  产品分类导航------------------------------------->
        <div class="boxWidth_290 boxHeight_470 left">
            <div class="wrap">
                <div class="all-sort-list">
                    <div class="border-top4"></div>
                    <div class="all-sort-Bt">产品分类</div>
                    <c:forEach var="customProductBigType" items="${util:dictionaryTree('PRODUCT_TYPE_2',false)}" end="7">
                    	<div class="item">
	                        <span class="sort-bt"><a>${customProductBigType}</a></span>
	                        <span class="sort-lab"><c:forEach items="${customProductBigType.children}" end="3" var="dictionary" varStatus="childItemStatus"> <a href="${pageContext.request.contextPath}/front_product/pagingProduct?productType=${fn:split(dictionary.itemCode,'-')[0]}">${dictionary}</a>&nbsp;&nbsp;&nbsp;</c:forEach></span>
	                        <div class="item-list clearfix">
	                            <div class="close">x</div>
	                            <div class="subitem">
	                            	<c:forEach items="${customProductBigType.children}" var="dictionary" varStatus="foreStatus">
		                                <dl class="fore${foreStatus.count}">
		                                    <dt><a>${dictionary}</a></dt>
		                                    <dd>
		                                    	<c:forEach items="${dictionary.children}" var="childItem" varStatus="childItemStatus"><em><a href="${pageContext.request.contextPath}/front_product/pagingProduct?productType=${childItem.itemCode}">${childItem}</a></em></c:forEach>
		                                    </dd>
		                                </dl>
	                                </c:forEach>
	                            </div>
	                        </div>
	                    </div>
                    </c:forEach>
                    <%-- <c:forEach var="productTypeItem" items="${productService.retrieveProductTypeTop(6)}">
                    	<div class="item">
	                        <span class="sort-bt"><a>${productTypeItem}</a></span>
	                        <span class="sort-lab"><c:forEach items="${productService.retrieveProductTypeTop(productTypeItem.itemCode,3)}" var="childItem" varStatus="childItemStatus"><a href="">${childItem}</a>${childItemStatus.count==3?"":"、"}</c:forEach></span>
	                        <div class="item-list clearfix">
	                            <div class="close">x</div>
	                            <div class="subitem">
	                            	<c:forEach begin="1" end="1" varStatus="foreStatus">
		                                <dl class="fore${foreStatus.count}">
		                                    <dt><a href="#">${productTypeItem}</a></dt>
		                                    <dd>
		                                    	<c:forEach items="${productService.retrieveProductTypeTop(productTypeItem.itemCode,1000)}" var="childItem" varStatus="childItemStatus"><em><a href="${pageContext.request.contextPath}/front_product/pagingProduct?productType=${childItem.itemCode}">${childItem}</a></em></c:forEach>
		                                    </dd>
		                                </dl>
	                                </c:forEach>
	                            </div>
	                        </div>
	                    </div>
                    </c:forEach> --%>
                    <div class="all-sort-all"><a href="${pageContext.request.contextPath}/front_product/productClass">查看所有分类</a></div>
                </div>
            </div>
            <!--所有分类 End-->
            <script type="text/javascript">
                $('.all-sort-list > .item').hover(function(){
                    var eq = $('.all-sort-list > .item').index(this),				//获取当前滑过是第几个元素
                            h = $('.all-sort-list').offset().top,						//获取当前下拉菜单距离窗口多少像素
                            s = $(window).scrollTop(),									//获取游览器滚动了多少高度
                            i = $(this).offset().top,									//当前元素滑过距离窗口多少像素
                            item = $(this).children('.item-list').height(),				//下拉菜单子类内容容器的高度
                            sort = $('.all-sort-list').height();						//父类分类列表容器的高度
                    if ( item < sort ){												//如果子类的高度小于父类的高度
                        if ( eq == 0 ){
                            $(this).children('.item-list').css('top', (i-h));
                        } else {
                            $(this).children('.item-list').css('top', (i-h)-80);
                        }
                    } else {
                        if ( s > h ) {												//判断子类的显示位置，如果滚动的高度大于所有分类列表容器的高度
                            if ( i-s > 0 ){											//则 继续判断当前滑过容器的位置 是否有一半超出窗口一半在窗口内显示的Bug,
                                $(this).children('.item-list').css('top', (s-h)+2 );
                            } else {
                                $(this).children('.item-list').css('top', (s-h)-(-(i-s))+2 );
                            }
                        } else {
                            $(this).children('.item-list').css('top', 3 );
                        }
                    }
                    $(this).children('.item-list').css('display','block');
                },function(){
                    $(this).children('.item-list').css('display','none');
                });
                $('.item > .item-list > .close').click(function(){
                    $(this).parent().parent().removeClass('hover');
                    $(this).parent().hide();
                });
            </script>
        </div>
        <!--4.1.2   轮播banner---------------------------------->
        <div class="banner_ctr left">
            <div id="slideBox" class="slideBox">
                <c:set var="imageList" value="${imageService.findAll()}"/>
                <div class="hd">
                    <ul><c:forEach varStatus="status" items="${imageList}" var="image"><li>${status.count}</li></c:forEach></ul>
                </div>
                <div class="bd">
                    <ul>
                    	<c:forEach varStatus="status" items="${imageList}" var="image">
                    		<li><a href="${image.url}" target="_blank"><img src="${pageContext.request.contextPath}/attachment/download/${image.attachment.path}" title="${image.name}"/></a></li>
                    	</c:forEach>
                    </ul>
                </div>
            </div>
            <script type="text/javascript">
                jQuery(".slideBox").slide({mainCell:".bd ul",effect:"fold",autoPlay:true});
            </script>
        </div>
        <!--4.1.3    登录 快捷栏--------------------------------->
        <div class="boxWidth_270 boxHeight_280 right  ">
            <!--登录  注册按钮-->
            <jsp:include page="/front/include/loginbar.jsp"/>
            <!--检索栏-->
            <div class="boxWidth_290 right boxEdge marginTop">
                <div class="boxHeadT box_ico_xxjs">产品信息检索</div>
                <div class="Content_list1 CtList_height_188">
                    <form class="select_if1" action="${pageContext.request.contextPath}/front_product/pagingProduct" method="get">
                        <span>产品类目：</span>
                        <select class="select_main1" name="productType">
                        	<option value="">所有分类</option>
                        	<c:forEach items="${util:dictionaryTree('PRODUCT_TYPE',false)}" var="item">
                        		<option value="${item.itemCode}">${item}</option>
                        	</c:forEach>
                        </select>
                        <br/>
                        <span>所在地区：</span>
                        <select class="select_main1" name="yieldly">
                            <option value="">所有地区</option>
                            <c:forEach items="${util:dictionaryTree('REGION',false)}" var="item">
                            	<option value="${item.itemName}">${item}</option>
                            </c:forEach>
                        </select>
                        <br/>
                        <span>所属行业：</span>
                        <select class="select_main1" name="industry">
                            <option value="">所有行业</option>
                            <c:forEach items="${util:dictionaryTree('PRODUCT_TYPE',false)}" var="item">
                            	<option value="${item.itemCode}">${item}</option>
                            </c:forEach>
                        </select>
                        <br/>
                        <span>发布时间：</span>
                        <select class="select_main1" name="interval">
                            <option value="">全部</option>
                            <c:forEach items="${util:dictionaryTree('INTERVAL',false)}" var="item">
                            	<option value="${item.itemCode}">${item}</option>
                            </c:forEach>
                        </select>
                    </form>
                    <div class="search_iptBtn1" onclick="$(this).prev().submit();">搜索</div>
                </div>
            </div>
        </div>
        <!--供应商-->
        <div class="boxWidth_850 boxHeight_174 right boxEdge marginTop">
            <c:forEach items="${organService.findOrganBTop4()}" var="item" varStatus="status">
            	<!--供应商容器${status.count}-->
            	<div class="boxHeight_70 boxWidth_418 left sale_bg" ${status.count mod 2==1?"style='margin-left: 0;'":""}>
	                <div class="sale_con left ">
	                    <a href="${pageContext.request.contextPath}/front_organ/B/organIndex/${item.id}" target="_blank"><img src="${util:property('backEnd')}/attachment/download/${item.logo.path}" width="100" height="60" onerror="this.src='/resources/portal/yc-images/logo_no.jpg'"/></a>
	                </div>
	                <div class="sale_cot right">
	                    <p class="S_name"><a href="${pageContext.request.contextPath}/front_organ/B/organIndex/${item.id}" target="_blank">${item.ztmc00}</a></p>
	                    <p class="S_cont">主营产品：${util:delHTMLTag(item.businessScope)}</p>
	                    <p class="S_cont">所在地区：${util:dictionaryPath('REGION',item.region)}</p>
	                </div>
	            </div>
            </c:forEach>
            <div class="hot_product pro_name">
            	<c:set value="${searchRecordService.retrieveKeywordsTop('product',15)}" var="hotProductList"/>
               	<c:forEach items="${hotProductList}" var="keywords" varStatus="status">
		   			<a href="javascript:window.location.href='${pageContext.request.contextPath}/front_product/pagingProduct?keywords='+encodeURI('${keywords}')"> ${keywords}</a>  ${fn:length(hotProductList)==status.count?"":"|"}  
		   		</c:forEach>
		   	</div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
    <!--4.2 产品楼层--------------------------------------------------------------->
    <!--4.2.1  1F 机械设备-->
    <c:forEach items="${productService.retrieveProductTypeTree()}" end="2" var="productTypeItem" varStatus="productTypeStatus">
    	<div class="boxWidth_1140  marginTop">
	        <div class="boxHeight_60 ">
	            <div class="pro_head_fl ${productTypeStatus.count==1?'color_bl':productTypeStatus.count==2?'color_re':'color_gr'} left">${productTypeStatus.count}F</div>
	            <div class="pro_head_name ${productTypeStatus.count==1?'InLaw':productTypeStatus.count==2?'InMail':'InDown'} left">${productTypeItem}</div>
	            <div class="pro_head_logo bl_bottom left ">
	            	<c:forEach items="${organService.retrieveOrganBTop(productTypeItem.itemCode,8)}" var="item" varStatus="status">
	            		<a href="${pageContext.request.contextPath}/front_organ/B/organIndex/${item.id}"  target="_blank"><img class="left" src="${util:property('backEnd')}/attachment/download/${item.logo.path}" width="116" height="46" onerror="this.src='/resources/portal/yc-images/logo_no.jpg'"/></a>
	            	</c:forEach>
	            </div>
	        </div>
	        <div class="boxHeight_300 marginTop ">
	            <div class="boxWidth_200 boxEdge left">
	                <div class="boxHeight_80">
	                	<c:set var="productTypeList" value="${productTypeItem.children}"/>
                    	<c:set var="index" value="0"></c:set>
	                    <table width="200" class="pro_fl_box ${productTypeStatus.count==1?'color_bl':productTypeStatus.count==2?'color_re':'color_gr'}">
                    		<c:forEach begin="1" end="3">
                    			<tr>
                    				<c:forEach begin="1" end="3">
                    					<td title="${productTypeList[index]}"><a href="${pageContext.request.contextPath}/front_product/pagingProduct?productType=${productTypeList[index].itemCode}" target="_blank">${fn:substring(productTypeList[index].itemName,0,4)}</a></td>
                    					<c:set var="index" value="${index+1}"/>
                    				</c:forEach>
                    			</tr>
                    		</c:forEach>
	                    </table>
	                </div>
	                <div class="boxHeight_200">
	                    <div class="boxHeadT2 box_ico_hxgys">核心供应商</div>
	                    <div class="pro_list Content_list1 CtList_height_416">
	                        <ul>
	                        	<c:forEach items="${organService.retrieveOrganBTop(productTypeItem.itemCode,10)}" var="item">
	                        		<li><a href="${pageContext.request.contextPath}/front_organ/B/organIndex/${item.id}" title="${item.ztmc00}"  target="_blank">${item.ztmc00}</a></li>
	                        	</c:forEach>
	                        </ul>
	                    </div>
	                </div>
	            </div>
	            <c:set value="${productService.retrieveProductByProductBigTypeTop(productTypeItem.itemCode,5)}" var="productList"/>
	            <div class="boxWidth_336 boxEdge left marginLeft">
	                <a href="${pageContext.request.contextPath}/front_organ/productDetail/${productList[0].id}"><img src="${util:property('backEnd')}/attachment/download/${productList[0].attachment.path}" height="278" /></a>
	            </div>
	            <div class="boxWidth_590 right ">
	            	<c:forEach items="${productList}" var="item" varStatus="status" begin="1">
	               		<div class="boxWidth_290 boxHeight_138  boxEdge right">
			                <a href="${pageContext.request.contextPath}/front_organ/productDetail/${item.id}" target="_blank">
			                    <img class="left pro_small_img" src="${util:property('backEnd')}/attachment/download/${item.attachment.path}" width="90" height="90"/>
			                    <span class="left pro_small_name"><p>${item.organ}</p><p>${item.productName}</p></span>
		                    </a>
	                	</div>
	               	</c:forEach>
	            </div>
	        </div>
	    </div>	
    </c:forEach>
    <%-- <div class="boxWidth_1140  marginTop">
        <div class="boxHeight_60 ">
            <div class="pro_head_fl color_bl left">1F</div>
            <div class="pro_head_name InLaw left">机械设备</div>
            <div class="pro_head_logo bl_bottom left ">
            	<c:forEach items="${organService.retrieveOrganBTop(8)}" var="item" varStatus="status">
            		<a><img class="left" src="${util:property('backEnd')}/attachment/download/${item.logo.path}" width="116" height="46" /></a>
            	</c:forEach>
            </div>
        </div>
        <div class="boxHeight_300 marginTop ">
            <div class="boxWidth_200 boxEdge left">
                <div class="boxHeight_80">
                    <table width="200" class="pro_fl_box color_bl">
                        <tr><td><a>过滤设备</a></td><td><a>化工设备</a></td><td><a>涂装设备</a></td></tr>
                        <tr><td><a>清洗设备</a></td><td><a>五金电子</a></td><td><a>切割设备</a></td></tr>
                        <tr><td><a>机床附件</a></td><td><a>仪器仪表</a></td><td><a>液压气动</a></td></tr>
                    </table>
                </div>
                <div class="boxHeight_200">
                    <div class="boxHeadT2 box_ico_hxgys">核心供应商</div>
                    <div class="pro_list Content_list1 CtList_height_416">
                        <ul>
                        	<c:forEach items="${organService.retrieveOrganBTop(10)}" var="item">
                        		<li><a href="#" title="${item.ztmc00}">${item.ztmc00}</a></li>
                        	</c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="boxWidth_336 boxEdge left marginLeft">
                <a href="#"><img src="/resources/portal/yc-images/Product_big_001.jpg" width="336" height="278" /></a>
            </div>
            <div class="boxWidth_590 right ">
            	<c:forEach items="${productService.retrieveProductTop(4)}" var="item" varStatus="status">
               		<div class="boxWidth_290 boxHeight_138  boxEdge right">
		                <a href="#">
		                    <img class="left pro_small_img" src="${util:property('backEnd')}/attachment/download/${item.attachment.path}" width="90" height="90"/>
		                    <span class="left pro_small_name"><p>${item.organ}</p><p>${item.productName}</p></span>
	                    </a>
                	</div>
               	</c:forEach>
            </div>
        </div>
    </div>
    <div class="clear"></div>
    <!--4.2.1  2F 化工能源-->
    <div class="boxWidth_1140  marginTop">
        <div class="boxHeight_60 ">
            <div class="pro_head_fl color_re left">2F</div>
            <div class="pro_head_name InMail left">化工能源</div>
            <div class="pro_head_logo re_bottom left ">
               <c:forEach items="${organService.retrieveOrganBTop(8)}" var="item" varStatus="status">
            		<a><img class="left" src="${util:property('backEnd')}/attachment/download/${item.logo.path}" width="116" height="46" /></a>
            	</c:forEach>
            </div>
        </div>
        <div class="boxHeight_300 marginTop ">
            <div class="boxWidth_200 boxEdge left">
                <div class="boxHeight_80">
                    <table width="200" class="pro_fl_box color_re">
                        <tr><td><a>过滤设备</a></td><td><a>化工设备</a></td><td><a>涂装设备</a></td></tr>
                        <tr><td><a>清洗设备</a></td><td><a>五金电子</a></td><td><a>切割设备</a></td></tr>
                        <tr><td><a>机床附件</a></td><td><a>仪器仪表</a></td><td><a>液压气动</a></td></tr>
                    </table>
                </div>
                <div class="boxHeight_200">
                    <div class="boxHeadT2 box_ico_hxgys">核心供应商</div>
                    <div class="pro_list Content_list1 CtList_height_416">
                        <ul>
                            <c:forEach items="${organService.retrieveOrganBTop(10)}" var="item">
                        		<li><a href="#" title="${item.ztmc00}">${item.ztmc00}</a></li>
                        	</c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="boxWidth_336 boxEdge left marginLeft">
                <a href="#"><img src="/resources/portal/yc-images/Product_big_001.jpg" width="336" height="278" /></a>
            </div>
            <div class="boxWidth_590 right ">
                <c:forEach items="${productService.retrieveProductTop(4)}" var="item" varStatus="status">
               		<div class="boxWidth_290 boxHeight_138  boxEdge right">
		                <a href="#">
		                    <img class="left pro_small_img" src="${util:property('backEnd')}/attachment/download/${item.picId}" width="90" height="90"/>
		                    <span class="left pro_small_name"><p>${item.organ}</p><p>${item.productName}</p></span>
	                    </a>
                	</div>
               	</c:forEach>
            </div>
        </div>
    </div>
    <div class="clear"></div>
    <!--4.2.1  1F 工程服务-->
    <div class="boxWidth_1140  marginTop">
        <div class="boxHeight_60 ">
            <div class="pro_head_fl color_gr left">3F</div>
            <div class="pro_head_name InDown left">工程服务</div>
            <div class="pro_head_logo gr_bottom left ">
                <c:forEach items="${organService.retrieveOrganBTop(8)}" var="item" varStatus="status">
            		<a><img class="left" src="${util:property('backEnd')}/attachment/download/${item.logo.path}" width="116" height="46" /></a>
            	</c:forEach>
            </div>
        </div>
        <div class="boxHeight_300 marginTop ">
            <div class="boxWidth_200 boxEdge left">
                <div class="boxHeight_80">
                    <table width="200" class="pro_fl_box color_gr">
                        <tr><td><a>过滤设备</a></td><td><a>化工设备</a></td><td><a>涂装设备</a></td></tr>
                        <tr><td><a>清洗设备</a></td><td><a>五金电子</a></td><td><a>切割设备</a></td></tr>
                        <tr><td><a>机床附件</a></td><td><a>仪器仪表</a></td><td><a>液压气动</a></td></tr>
                    </table>
                </div>
                <div class="boxHeight_200">
                    <div class="boxHeadT2 box_ico_hxgys">核心供应商</div>
                    <div class="pro_list Content_list1 CtList_height_416">
                        <ul>
                            <c:forEach items="${organService.retrieveOrganBTop(10)}" var="item">
                        		<li><a href="#" title="${item.ztmc00}">${item.ztmc00}</a></li>
                        	</c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="boxWidth_336 boxEdge left marginLeft">
                <a href="#"><img src="/resources/portal/yc-images/Product_big_001.jpg" width="336" height="278" /></a>
            </div>
            <div class="boxWidth_590 right ">
                <c:forEach items="${productService.retrieveProductTop(4)}" var="item" varStatus="status">
               		<div class="boxWidth_290 boxHeight_138  boxEdge right">
		                <a href="#">
		                    <img class="left pro_small_img" src="${util:property('backEnd')}/attachment/download/${item.attachment.path}" width="90" height="90"/>
		                    <span class="left pro_small_name"><p>${item.organ}</p><p>${item.productName}</p></span>
	                    </a>
                	</div>
               	</c:forEach>
            </div>
        </div>
    </div>
    <div class="clear"></div> --%>
    <!--5 友情链接------------------------------------------------------------------------------->
</div>
<div class="clear"></div>
<br/>
<jsp:include page="/front/include/footer.jsp"/>
<div class="clear"></div>
</body>
</html>