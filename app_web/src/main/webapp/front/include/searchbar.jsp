<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="searchType" value="${empty searchType?'notice':searchType}"></c:set>
<div id="search">
    <div class="searchBox">
        <ul class="border1">
        	<%-- <c:forEach items="${util:dictionaryTree('SEARCH_TYPE',false)}" var="item">
        		<li><a ${searchType eq item.itemCode?"class='style1'":""}>${item}</a></li>
        	</c:forEach> --%>
        </ul>
		<div class="BodySelect">
			<select id="searchSelect">
				<c:forEach items="${util:dictionaryTree('SEARCH_TYPE',false)}" var="item" varStatus="status">
				<option value="${status.index} ">${item}</option>
        		
        		</c:forEach>
			</select>
		</div>
        <div class="BodyS">
        	<c:forEach items="${util:dictionaryTree('SEARCH_TYPE',false)}" var="item">
        		<p ${searchType!=item.itemCode?"style='display:none'":""}>
        			<input type="text" value="" class="one">
	                <button class="one1"  winhref="${pageContext.request.contextPath}/${item.description}?keywords=" >搜索</button>
	            </p>
        	</c:forEach>
        </div>
    </div>
    <c:forEach items="${util:dictionaryTree('SEARCH_TYPE',false)}" var="item">
	   <div class="hot" ${searchType!=item.itemCode?"style='display:none'":""}>
	   		<span>热门搜索：</span>
	   		<c:forEach items="${searchRecordService.retrieveKeywordsTop(item.itemCode,4)}" var="keywords">
	   			<a href="javascript:window.location.href='${pageContext.request.contextPath}/${item.description}?keywords='+encodeURI('${keywords}')">${fn:length(keywords)>5?fn:substring(keywords,0,5):keywords}${fn:length(keywords)>5?'...':''}</a>
	   		</c:forEach>
	   </div>
    </c:forEach>
    <div class="clear"></div>
</div>
<script type="text/javascript">
	$(".one1").click(function(){
		 var SCRIPT_REGEX = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi;
		 while (SCRIPT_REGEX.test($(this).prev().val())) {//传入文档对象，获取整体内容
			$(this).prev().val($(this).prev().val().replace(SCRIPT_REGEX, ""));
		 }
		 window.location.href=$(this).attr("winhref")+encodeURI($(this).prev().val());
	});
	$("#searchSelect").change(function(){
		var index = $(this).val();
		$(".BodyS p").eq(index).show().siblings().hide();
		$(".hot").each(function(i){
			$(this).toggle(i==index);
		});
	});
</script>