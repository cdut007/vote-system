$(function() {
	/* 回到顶部 */
	var isie6 = window.XMLHttpRequest ? false : true;
	function newtoponload() {
		function b() {
			var a = document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop;
			if (a > 280) {
				if (isie6) {
					$("#J_GoTop").css({display:"none"});
					clearTimeout(window.show);
					window.show = setTimeout(function() {
						var d = document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop;
						if (d > 0) {
							$("#J_GoTop").css({display:"block"});
							$("#J_GoTop").css({top:(400 + d) + "px"})
						}
					}, 300);
				} else {
					$("#J_GoTop").css({display:"block"});
				}
			} else {
				$("#J_GoTop").css({display:"none"});
			}
		}
		if (isie6) {
			$("#J_GoTop").css({position:"absolute"});
		}
		window.onscroll = b;
		b();
	}
	if (window.attachEvent) {
		window.attachEvent("onload", newtoponload);
	} else {
		window.addEventListener("load", newtoponload, false);
	}
	$("#J_GoTop").click(function() {
		window.scrollTo(0, 0);
	});
});