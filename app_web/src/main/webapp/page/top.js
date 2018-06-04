function changeTab(obj, tab) {
	var tabs = document.getElementById(tab).getElementsByTagName("li");
	for (var i = 0; i < tabs.length; i++) {
		var id = i + 1;
		if (tabs[i] == obj) {
			tabs[i].className = "ks-active cur";
			document.getElementById(tab + "_con" + id).className = "dis";
		} else {
			tabs[i].className = "nor";
			document.getElementById(tab + "_con" + id).className = "undis";
		}
	}
}
function g(obj) {
	obj.className = (obj.className == "active" ? "" : "active");
}
function setTab1(m, n) {
	var tli = document.getElementById("setnews" + m).getElementsByTagName("li");
	var mli = document.getElementById("contentnews" + m).getElementsByTagName("ul");
	for (var i = 0; i < tli.length; i++) {
		if (typeof (tli[i]) != "undefined") {
			tli[i].className = i == n ? "hover" : "";
		}
		if (typeof (mli[i]) != "undefined") {
			mli[i].style.display = i == n ? "block" : "none";
		}
	}
}
function $id(element) {
	return document.getElementById(element);
}
// 切屏--是按钮，_v是内容平台，_h是内容库
function reg(str) {
	var bt = $id(str + "_b").getElementsByTagName("h2");
	for (var i = 0; i < bt.length; i++) {
		bt[i].subj = str;
		bt[i].pai = i;
		bt[i].style.cursor = "pointer";
		bt[i].onmouseover = function() {
			$id(this.subj + "_v").innerHTML = $id(this.subj + "_h").getElementsByTagName("blockquote")[this.pai].innerHTML;
			for (var j = 0; j < $id(this.subj + "_b").getElementsByTagName("h2").length; j++) {
				var _bt = $id(this.subj + "_b").getElementsByTagName("h2")[j];
				var ison = j == this.pai;
				_bt.className = (ison ? "" : "h2bg");
			}
		};
	}
	$id(str + "_h").className = "none";
	$id(str + "_v").innerHTML = $id(str + "_h").getElementsByTagName("blockquote")[0].innerHTML;
}
function salelog() {
	str = "com";
	var bt = $$(str + "_b").getElementsByTagName("h2")[1];
	bt.subj = str;
	bt.pai = 1;
	bt.style.cursor = "pointer";
	$$(bt.subj + "_v").innerHTML = $$(bt.subj + "_h").getElementsByTagName("blockquote")[bt.pai].innerHTML;
	for (var j = 0; j < $$(bt.subj + "_b").getElementsByTagName("h2").length; j++) {
		var _bt = $$(bt.subj + "_b").getElementsByTagName("h2")[j];
		var ison = (j == bt.pai);
		_bt.className = (ison ? "" : "h2bg");
	}
	$$(str + "_h").className = "none";
	$$(str + "_v").innerHTML = $$(str + "_h").getElementsByTagName("blockquote")[1].innerHTML;
}
$(function() {
	$("#my_main_nav li[class!='cp']").hover(function() {
		$(this).attr("class", "nav_hover");
	}, function() {
		$(this).removeAttr("class");
	});
});
