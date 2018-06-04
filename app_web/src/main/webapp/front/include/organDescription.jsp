<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="marginTop contentMain company">
	<div>公司简介</div>
	<div>
		<span class="company_content">${fn:substring(toolBean.delHTMLTag(organ.description),0,350)}${fn:length(organ.description) gt 350?"...":""}</span>
	</div>
</div>