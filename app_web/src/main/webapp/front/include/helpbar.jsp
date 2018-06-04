<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="firstLevel" value="${linkService.findTop5()}"/>
<!-- <div class="help"> -->
<div class="footNew">
<div class="footNew_">
    <div class="ctr">
    	<!-- 版权 备案信息 -->
        <div class="footNew_Er left">
			<div class="er">
				<ul>
					<li class="bottom_rwm_box">
						<a href="javascript:;"onclick="return false;">
							<img class="img-sina" src="/resources/portal/yc-images/icon-sina.png">
						</a>
						<div class="bottom_rwm">
							<span class="i1">敬请期待~</span>
						</div>
					</li>
					<li class="bottom_rwm_box">
						<a href="javascript:;"onclick="return false;">
							<img src="/resources/portal/yc-images/icon-wechat.png">
						</a>
						<div class="bottom_rwm">
							<img src="/resources/portal/yc-images/yc-weixin.jpg">
						</div>
					</li>
					<li class="bottom_rwm_box">
						<a href="javascript:;"onclick="return false;">
							<img class="img-phone" src="/resources/portal/yc-images/icon-phone.png">
						</a>
						<div class="bottom_rwm">
							<span class="i1">${util:property('hotline')} </span>
						</div>
					</li>
				</ul>
			</div>
			<p>山西${util:property('business.platformName')}</p>
	        <p>Copyright ® 2001-2017 版权所有</p>
			<p>备案/许可证编号为：晋ICP备16006701号</p>
		</div>
      <!--   <table class="helpTab left" cellspacing="0" cellpadding="0"> -->
        <table class="footNewTab left" cellspacing="0" cellpadding="0">
            <tr>
            	<c:forEach begin="0" end="3" varStatus="status">
            		<th>
            			<a target="_blank">${firstLevel[status.index].link_name}</a>
            		</th>
            	</c:forEach>
            </tr>
            <!--<c:forEach begin="0" end="10" varStatus="statis">
            	<tr>
            		<c:forEach begin="0" end="5" varStatus="status">
            			<td>
	            			<a href="${firstLevel[status.index].linkSecondaryList[statis.index].url}" target="_blank" >${firstLevel[status.index].linkSecondaryList[statis.index].secondary_name}</a>
	            		</td>
            		</c:forEach>
            	</tr>
            </c:forEach>-->
            
            <!--1-->
            <tr>
            	<td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/zblc">招标流程</a>
	            </td>
	            <td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/rczp">人才招聘</a>
	            </td>
	            <td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/expert">视频教程</a>
	            </td>
	            <td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/yszc">隐私权政策</a>
	            </td>
<!-- 	            <td>
	            	<a target="_blank" href="http://www.mofcom.gov.cn">国家商务部</a>
	            </td> -->
            </tr>
            
            <!--2-->
            <tr>
            	<td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/tblc">投标流程</a>
	            </td>
	            <td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/jlhz">交流合作</a>
	            </td>
	            <td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/cjwt">常见问题</a>
	            </td>
	            <td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/hyxy">网站会员注册协议</a>
	            </td>
<!-- 	            <td>
	            	<a target="_blank" href="http://www.sdpc.gov.cn">国家发展和改革委员会</a>
	            </td> -->
            </tr>
            
            <!--3-->
            <tr>
            	<td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/ywjs">业务介绍</a>
	            </td>
	            <td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/gsjj">公司介绍</a>
	            </td>
	            <td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/hyzc">注册会员</a>
	            </td>
	            <td>
	            	<a target="_blank" ></a>
	            </td>
<!-- 	            <td>
	            	<a target="_blank" href="http://gjs.mof.gov.cn/mofhome/mof">国家财政部</a>
	            </td> -->
            </tr>
            
            <!--4-->
            <tr>
            	<td>
	            	<a target="_blank"></a>
	            </td>
	            <td>
	            	<a target="_blank"></a>
	            </td>
	            <td>
	            	<a target="_blank" href="${pageContext.request.contextPath}/help/czlc">操作流程</a>
	            </td>
	            <td>
	            	<a target="_blank" ></a>
	            </td>
<!-- 	            <td>
	            	<a target="_blank" href="http://www.mot.gov.cn">国家交通运输部</a>
	            </td> -->
            </tr>
            
        </table>
        <!-- 6.2 电话栏 -->
        <%-- <div class="call right">
            <div>
                <img src="/resources/portal/yc-images/call-ico.png"/>
                <span class="right pos2">热线</span>
                <span class="left"><nobr>${util:property('hotline')}</nobr></span>
            </div>
        </div> --%>
    </div>
</div>
</div>