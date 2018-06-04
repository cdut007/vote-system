<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!-- <div class="ylLink ">
	<h6>友情链接</h6>
	<ul class="yllinks_li">
		<li><a target="_blank" title="ECSHOP模板中心" href="http://www.sxbid.com.cn/">山西招投标网</a></li>
		<li><a title="68ecshop模板中心" target="_blank" href="http://www.infobidding.com">中国招投标网</a></li>
		<li><a title="免费申请网店" target="_blank" href="http://www.bjztb.gov.cn/">北京市招投标公共服务平台</a></li>
	</ul>
</div> -->
<div id="service" class="clearfix">
	<dl class="fore1">
		<dt>
			<b></b> <strong>新手上路 </strong>
		</dt>
		<dd>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/zblc">招标流程</a>
			</div>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/tblc">投标流程</a>
			</div>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/ywjs">业务介绍</a>
			</div>
		</dd>
	</dl>
	<dl class="fore2">
		<dt>
			<b></b> <strong>公司信息 </strong>
		</dt>
		<dd>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/gsjj">公司介绍</a>
			</div>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/rczp">人才招聘</a>
			</div>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/jlhz">交流合作</a>
			</div>
		</dd>
	</dl>
	<dl class="fore3">
		<dt>
			<b></b> <strong>使用指南</strong>
		</dt>
		<dd>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/cjwt">常见问题</a>
			</div>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/czlc">操作流程</a>
			</div>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/hyzc">注册会员</a>
			</div>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/expert">视频教程</a>
			</div>
		</dd>
	</dl>
	<dl class="fore4">
		<dt>
			<b></b> <strong>安全隐私</strong>
		</dt>
		<dd>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/hyxy">网站会员注册协议</a>
			</div>
			<div>
				<a target="_blank" href="${pageContext.request.contextPath}/help/yszc">隐私权政策</a>
			</div>			
		</dd>
	</dl>
	<dl class="fore5">
		<dt>
			<b></b> <strong>友情链接</strong>
		</dt>
		<dd>
			<div>
				<a target="_blank" href="http://www.sdpc.gov.cn">国家发展和改革委员会</a>
			</div>
			<div>
				<a target="_blank" href="http://gjs.mof.gov.cn/mofhome/mof">国家财政部</a>
			</div>
			<div>
				<a target="_blank" href="http://www.mohurd.gov.cn">国家住房城乡建设部</a>
			</div>
			<div>
				<a target="_blank" href="http://www.mot.gov.cn">国家交通运输部</a>
			</div>
			<div>
				<a target="_blank" href="http://www.mwr.gov.cn">国家水利部</a>
			</div>
			<div>
				<a target="_blank" href="http://www.mofcom.gov.cn">国家商务部</a>
			</div>
		</dd>
	</dl>
	<div class="fr">
		<img src="/resources/tender/images/phpfooter.gif" />
	</div>
</div>
<div id="J_Feedback" class="feedback" data-spm="754905385">
	<a href="javascript:;" target="_self" id="J_GoTop" class="btn go-top" title="回到顶部">
		<span class="iconfont">TOP</span> <em>回到顶部</em> 
	</a> 
	<!-- <a href="javascript:;" target="_self" id="J_Update" class="btn update" title="更新日志">
		<span class="iconfont">日志</span> <em>更新日志</em>
	</a>  -->
	<!-- <a href="//ur.taobao.com/survey/view.htm?id=2022" class="btn" title="我要反馈"> 
		<span class="iconfont">反馈</span> <em>我要反馈</em>
	</a> -->
	<c:if test="${not empty CURRENT_USER_SESSION_INFO}">
		<a id="showBar" class="btn" title="我要反馈"> 
			<span class="iconfont">通讯</span> <em>即时通讯</em>
		</a>
	</c:if>
</div>
<!-- <script type="text/javascript">
	if ((window.innerWidth || document.documentElement.clientWidth + 21) >= 1366) {
		(function() {
			function i(d) {
				this.run = function() {
					var b = d.length, a = Math.floor(Math.random() * b);
					document.write('<script charset="gbk" src="http://p.tanx.com/ex?i=' + d[a] + '"><\/script>');
				};
			}
			new i([ 'mm_12852562_1778064_9118786', 'mm_12852562_1778064_9118787' ]).run();
		})();
	}
</script> -->
<div style=" width:1000px; margin:0 auto;background-color:#fff;">
	<div class="ylCopy">
		<div class="ylBotNav">
			<a href="#">免责条款</a> | <a href="#">隐私保护</a> | <a href="#">咨询热点</a> | <a href="#">联系我们</a> | <a href="#">公司简介</a> | <a href="#">招标方案</a> | <a href="#">会员服务</a>
		</div>
		<div class="blank"></div>
		<div id="footer">
			<div class="text">
				&copy; 2005-2014 JCEBID 版权所有，并保留所有权利。 <br /> <br />
				<div id="subFooter">
					<span title="苏宁易付宝"><img src="/resources/tender/images/morelogo5.png" /></span> <span title="银联特约商户"><img alt="银联特约商户" src="/resources/tender/images/morelogo1.png" /></span> <a target="_blank" title="可信网站示范单位" href="#"><img src="/resources/tender/images/morelogo2.png" /></a> <a title="诚信网站" target="_blank" href="#"><img src="/resources/tender/images/morelogo6.png" /></a> <a title="电子营业执照" target="_blank" href="#"> <img src="/resources/tender/images/morelogo7.png" />
					</a>
				</div>
			</div>
		</div>
	</div>
</div>