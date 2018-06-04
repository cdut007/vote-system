<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<style>
.feedback {
 position: fixed;
 _position: absolute;
 right: 10px;
 bottom: 10px;
 border: 1px solid #d9d9d9
}

.feedback .btn {
 height: 35px;
 line-height: 38px;
 overflow: hidden;
 *zoom: 1;
 display: inline;
 float: left;
 cursor: pointer;
 clear: both;
 width: 38px;
 text-align: center;
 background: #f5f5f5
}

.feedback .btn span {
 font-size: 12px;
 color: #9c9c9c;
 margin-top: 5px;
}

.feedback .btn em {
 display: none;
 margin: 3px auto 0;
 width: 24px;
 font-size: 12px;
 line-height: 16px
}

.feedback .btn:hover {
 color: #fff;
 background: #999;
 border-color: #999
}

.feedback .btn:hover span {
 display: none;
}

.feedback .btn:hover em {
 display: block
}

.feedback .go-top {
 display: none;
 border-bottom: 1px solid #d9d9d9
}

.update {
 border-bottom: 1px solid #d9d9d9
}

.iconfont {
 
}
</style>
<div id="J_Feedback" class="feedback" data-spm="754905385">
	<a href="javascript:;" target="_self" id="J_GoTop" class="btn go-top" title="回到顶部"><span class="iconfont">TOP</span> <em>回到顶部</em> </a> <a href="javascript:;" target="_blank" id="J_Update" class="btn update" title="更新日志"> <span class="iconfont">日志</span> <em>更新日志</em>
	</a> <a href="//ur.taobao.com/survey/view.htm?id=2022" class="btn" target="_blank" title="我要反馈"> <span class="iconfont">反馈</span> <em>我要反馈</em>
	</a>
</div>
<script>
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
</script>
<div style="text-align:center;width:1000px; margin:0 auto;background-color:#fff;">
	<div class="ylCopy">
		<div class="ylBotNav">
			<a href="article_-732377866.html">免责条款</a> | <a href="article_-732377866.html">隐私保护</a> | <a href="article_-732377866.html">咨询热点</a> | <a href="article_-732377866.html">联系我们</a> | <a href="article_-732377866.html">公司简介</a> | <a href="wholesale.html">招标方案</a> | <a href="myship.html">会员服务</a>
		</div>
		<div class="blank"></div>
		<div id="footer">
			<div class="text">
				&copy; 2005-2014 JCEBID 版权所有，并保留所有权利。 <br /> <br />
				<div id="subFooter">
					<span title="苏宁易付宝"><img src="/resources/tender/images/morelogo5.png" /></span> <span title="银联特约商户"><img alt="银联特约商户" src="/resources/tender/images/morelogo1.png" /></span> <a target="_blank" title="可信网站示范单位" href="#"><img src="/resources/tender/images/morelogo2.png" /></a> <a title="诚信网站" target="_blank" href="#"><img src="/resources/tender/images/morelogo6.png" /></a> <a title="电子营业执照" target="_blank" href="#"> <img src="/resources/tender/images/morelogo7.png" /></a>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	/*回到顶部*/
	var isie6 = window.XMLHttpRequest ? false : true;
	function newtoponload() {
		var c = document.getElementById("J_GoTop");
		function b() {
			var a = document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop;
			if (a > 280) {
				if (isie6) {
					c.style.display = "none";
					clearTimeout(window.show);
					window.show = setTimeout(function() {
						var d = document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop;
						if (d > 0) {
							c.style.display = "block";
							c.style.top = (400 + d) + "px";
						}
					}, 300);
				} else {
					c.style.display = "block";
				}
			} else {
				c.style.display = "none";
			}
		}
		if (isie6) {
			c.style.position = "absolute";
		}
		window.onscroll = b;
		b();
	}
	if (window.attachEvent) {
		window.attachEvent("onload", newtoponload);
	} else {
		window.addEventListener("load", newtoponload, false);
	}
	document.getElementById("J_GoTop").onclick = function() {
		window.scrollTo(0, 0);
	};
</script>