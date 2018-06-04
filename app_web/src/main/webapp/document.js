//中文序数字转换
function transfer(num) {
	var input = "" + num;
	var danwei = [ "", "十", "百", "千", "万", "十", "百", "千", "亿" ];
	var chinese = [ "零", "一", "二", "三", "四", "五", "六", "七", "八", "九" ];
	var l = input.length;
	var result = "";
	for (var i = 0; i < l; i++) {
		var chineseNum = chinese[parseInt(input.charAt(i))];
		var chineseUnit = danwei[l - i - 1];
		result += chineseNum + chineseUnit;
	}
	return result;
}
// 重新排序
function sortLi($ul) {
	var index = 0;
	$ul.children("li:not('.none')").each(function(i) {
		var $li = $(this).attr("orderno", i);
		if ("" != $li.attr("id") && !$li.attr("changed")) {
			var data = eval("(" + $li.attr("data") + ")");
			if (i != data.orderno) {
				$li.attr("changed", "update");
			}
		}
		if (getNo($li, index) != "") {
			index++;
		}
		if ($li.children("ul").length == 1) {
			sortLi($li.children("ul"));
		}
	});
}
// 获取序号
function getNo($li, index) {
	var i = index + 1;
	var no = "";
	if ($li.attr("noDisplay") == "true") {
		var $parentLi = $li.parent("ul").parent("li");
		if ($parentLi.length == 1) {
			noType = $parentLi.attr("noType");
			prefix = $parentLi.attr("no");
		}
		if ("SIMPLE" === noType) {
			no = i;
		} else if ("BRACKET" === (noType)) {
			no = "(" + i + ")";
		} else if ("EXTEND" === noType) {
			no = /^[\d]+(\.[\d]+)*$/.test(prefix) ? (prefix + "." + i) : i;
		} else if ("CHINESE" === noType) {
			no = transfer(i);
		} else if ("PART" === (noType)) {
			no = "第" + transfer(i) + "部分";
		} else if ("CHAPTER" === (noType)) {
			no = "第" + transfer(i) + "章";
		} else if ("ITEM" === (noType)) {
			no = "第" + transfer(i) + "条";
		}
	}
	$li.attr("no", no).children("pre").children("span.index").html((no == "" ? "" : (no + "、")));
	return no;
}
// 获取li中的数据
function getData($li) {
	var data = {};
	var $pre = $li.children("pre");
	var $span = $pre.children("span.index").remove();
	data["content"] = $pre.html();
	$pre.prepend($span);
	data["id"] = $li.attr("id") ? $li.attr("id") : "";
	data["noDisplay"] = $li.attr("noDisplay");
	data["isTitle"] = $li.attr("isTitle");
	data["orderno"] = $li.attr("orderno") ? $li.attr("orderno") : "";
	data["parent"] = $li.attr("pid") ? $li.attr("pid") : "";
	data["noType"] = $li.attr("noType");
	return data;
}
// 删除的数据
function deleteData($li) {
	var $ul = $li.parent("ul");
	var $parentLi = $ul.parent("li");
	var isTitle = $li.attr("isTitle") == "true";
	var referenceTag=$parentLi.attr("orderno") + "-" + $parentLi.attr("levelNo") + "-" + $li.attr("orderno");
	if ($li.attr("id") == "") {
		$("[reference='" + referenceTag + "']").remove();
		$li.remove();
	} else {
		$("[reference='" + referenceTag + "']").attr("changed", "delete").hide().addClass("none");
		$li.addClass("none").attr("changed", "delete");
	}
	sortLi($ul);
	if (isTitle) {
		refreshNavigationAndCatalogue();
	}
}
function checkData() {
	var $prevEditable = $(".my_word_document>.my_word_center>.my_word_body .editable[editable='true']");
	var $li = $prevEditable.parent("li");
	if ($prevEditable.length == 1) {
		$prevEditable.removeClass("editable");
		var $prevLi = $prevEditable.parent("li");
		$prevEditable.removeAttr("contenteditable");
		if ($prevEditable.html() === "") {// 清空
			deleteData($prevLi);
		} else if ($prevLi.attr("changed") == "update" && $prevEditable.html() === $prevEditable.next().html()) {
			$prevEditable.next().remove();
			$prevLi.removeAttr('changed');
		}
		var $prevSpan = $prevEditable.children("span.index");
		if ($prevSpan.length == 0) {
			$prevSpan = $("<span/>").addClass("index");
			$prevEditable.prepend($prevSpan);
		}
		$prevSpan.html($prevLi.attr("no") == "" ? "" : ($prevLi.attr("no") + "、"));
		if ($li.attr("isTitle") == "true" && $li.attr("changed")) {
			refreshNavigationAndCatalogue();
		}
	}
	$(".my_word_document>.my_word_body>.datagrid-row-selected").removeClass("datagrid-row-selected");
}
// 递归文档树形
function varNavigation($ul) {
	var array = [];
	$ul.children("li[isTitle='true'][changed!='delete']").each(function(i){
		var $li = $(this);
		array[i] = {
			id : $li.attr("id"),
			pid : $li.attr("pid"),
			href : $li.attr("unique"),
			iconCls : "myicon-note",
			text : $li.children("pre").text(),
			checked : !$li.hasClass("none")
		};
		var $childUl = $li.children("ul");
		if ($childUl.length == 1) {
			array[i].children = varNavigation($childUl);
		}
	});
	return array;
}
// 获取导航数据
function refreshNavigation() {
	$("#document_navigation").tree("loadData", varNavigation($(".my_word_document>.my_word_center>.my_word_body>ul>li>ul")));
}

// 递归目录结构
function varCatalogue($ul) {
	var $catalogueUl = $("<ul/>");
	$ul.children("li[isTitle='true'][changed!='delete']").each(function(){
		var $li = $(this);
		var levelNo = parseInt($li.attr("levelNo"));
		var retract = (levelNo - 1) < 0 ? 0 : ((levelNo - 1) * 2);
		var $catalogueLi = $("<li/>");
		if ($li.hasClass("none")) {
			$catalogueLi.addClass("none");
		}
		var $anchor = $li.children("a");
		$catalogueLi.append($("<div/>").append($("<a/>").css("paddingLeft", retract + "em").attr("href", "#" + $anchor.attr("name")).html($li.children("pre").text()))).appendTo($catalogueUl);
		$catalogueLi.append(varCatalogue($li.children("ul")));
	});
	return $catalogueUl;
}
// 刷新目录
function refreshCatalogue() {
	$(".my_word_document>.my_word_center>.my_word_catalogue").html($("<h1/>").html("目录"));
	$(".my_word_document>.my_word_center>.my_word_catalogue").append(varCatalogue($(".my_word_document>.my_word_center>.my_word_body>ul>li>ul")));
}
// 刷新目录与导航
function refreshNavigationAndCatalogue() {
	refreshCatalogue();
	refreshNavigation();
}
// 文档放缩
function rescale() {
	if (!$(".easyui-slider").attr("schedule")) {
		$(".easyui-slider").attr("schedule", "have");
		timer = window.setTimeout(function() {
			var num = $(".easyui-slider").slider("getValue") / 100.0;
			for (var i = 0; i < document.styleSheets.length; i++) {
				var rules = [];
				if (document.styleSheets[i].cssRules) {
					rules = document.styleSheets[i].cssRules;
				} else {
					rules = document.styleSheets[i].rules;
				}
				$(".my_word_document").width(Math.ceil(800 * num) + ($(".my_word_comment").hasClass("none") ? 0 : (Math.ceil(250 * num) + 1)));
				for (var j = 0; j < rules.length; j++) {
					var rule = rules[j];
					var selectorText = rule.selectorText;
					if (selectorText != undefined && selectorText != null) {
						var selectorText = selectorText.toUpperCase();
						/* 文档全局 */
						if (selectorText == "div.my_word_document".toUpperCase()) {
							rule.style["width"] = Math.ceil(800 * num) + "px";
						}
						/* 左边距 */
						if (selectorText == "div.my_word_document > div.my_word_west".toUpperCase()) {
							rule.style["width"] = Math.ceil(80 * num) + "px";
						}
						/* 右边距 */
						if (selectorText == "div.my_word_document > div.my_word_east".toUpperCase()) {
							rule.style["width"] = Math.ceil(80 * num) + "px";
						}
						/* 中心区域 */
						if (selectorText == "div.my_word_document > div.my_word_center".toUpperCase()) {
							rule.style["width"] = (Math.ceil(800 * num) - (Math.ceil(80 * num) * 2)) + "px";
						}
						/* 页眉页脚 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_north".toUpperCase()) {
							rule.style["width"] = (Math.ceil(800 * num) - (Math.ceil(80 * num) * 2)) + "px";
							rule.style["height"] = Math.ceil(60 * num) + "px";
						}
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_south".toUpperCase()) {
							rule.style["width"] = (Math.ceil(800 * num) - (Math.ceil(80 * num) * 2)) + "px";
							rule.style["height"] = Math.ceil(60 * num) + "px";
						}
						/* 封面 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_cover".toUpperCase()) {
							rule.style["paddingTop"] = Math.ceil(160 * num) + "px";
							rule.style["paddingRight"] = Math.ceil(100 * num) + "px";
							rule.style["paddingBottom"] = Math.ceil(160 * num) + "px";
							rule.style["paddingLeft"] = Math.ceil(100 * num) + "px";
						}
						/* 封面大标题 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_cover > h1".toUpperCase()) {
							rule.style["fontSize"] = Math.ceil(60 * num) + "px";
							rule.style["marginBottom"] = Math.ceil(36 * num) + "px";
						}
						/* 封面小标题 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_cover > h2".toUpperCase()) {
							rule.style["fontSize"] = Math.ceil(22 * num) + "px";
							rule.style["marginTop"] = Math.ceil(40 * num) + "px";
							rule.style["marginBottom"] = Math.ceil(40 * num) + "px";
						}
						/* 目录 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_catalogue ".toUpperCase()) {
							rule.style["marginBottom"] = Math.ceil(200 * num) + "px";
						}
						/* 目录标题 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_catalogue > h1".toUpperCase()) {
							rule.style["fontSize"] = Math.ceil(26 * num) + "px";
							rule.style["marginTop"] = Math.ceil(22 * num) + "px";
							rule.style["marginBottom"] = Math.ceil(22 * num) + "px";
						}
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_catalogue li > div > a".toUpperCase()) {
							rule.style["lineHeight"] = Math.ceil(30 * num) + "px";
							rule.style["fontSize"] = Math.ceil(15 * num) + "px";
						}
						/* 文本样式 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_body .content > pre".toUpperCase()) {
							rule.style["fontSize"] = Math.ceil(15 * num) + "px";
							rule.style["marginTop"] = Math.ceil(5 * num) + "px";
							rule.style["marginBottom"] = Math.ceil(5 * num) + "px";
							rule.style["fontSize"] = Math.ceil(15 * num) + "px";
						}
						/* 一级标题样式 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_body .h1 > pre".toUpperCase()) {
							rule.style["fontSize"] = Math.ceil(36 * num) + "px";
							rule.style["marginTop"] = Math.ceil(36 * num) + "px";
							rule.style["marginBottom"] = Math.ceil(36 * num) + "px";
						}
						/* 二级标题样式 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_body .h2 > pre".toUpperCase()) {
							rule.style["fontSize"] = Math.ceil(26 * num) + "px";
							rule.style["marginTop"] = Math.ceil(26 * num) + "px";
							rule.style["marginBottom"] = Math.ceil(26 * num) + "px";
						}
						/* 三级标题样式 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_body .h3 > pre".toUpperCase()) {
							rule.style["fontSize"] = Math.ceil(20 * num) + "px";
							rule.style["marginTop"] = Math.ceil(20 * num) + "px";
							rule.style["marginBottom"] = Math.ceil(20 * num) + "px";
						}
						/* 四级标题样式 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_body .h4 > pre".toUpperCase()) {
							rule.style["fontSize"] = Math.ceil(18 * num) + "px";
							rule.style["marginTop"] = Math.ceil(18 * num) + "px";
							rule.style["marginBottom"] = Math.ceil(18 * num) + "px";
						}
						/* 内容表格样式 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_body pre table".toUpperCase()) {
							rule.style["width"] = Math.ceil(18 * num) + "px";
						}
						/* 内容单元格样式 */
						if (selectorText == "div.my_word_document > div.my_word_center > div.my_word_body pre table td".toUpperCase()) {
							rule.style["height"] = Math.ceil(17 * num) + "px";
							rule.style["paddingTop"] = Math.ceil(2 * num) + "px";
							rule.style["paddingRight"] = Math.ceil(6 * num) + "px";
							rule.style["paddingBottom"] = Math.ceil(2 * num) + "px";
							rule.style["paddingLeft"] = Math.ceil(6 * num) + "px";
						}
						/* 批注全局 */
						if (selectorText == "div.my_word_document > div.my_word_comment".toUpperCase()) {
							rule.style["width"] = Math.ceil(250 * num) + "px";
						}
						/* 批注 */
						if (selectorText == "div.my_word_document > div.my_word_comment > div.tooltip".toUpperCase()) {
							rule.style["left"] = Math.ceil(20 * num) + "px";
							rule.style["right"] = Math.ceil(20 * num) + "px";
							rule.style["paddingTop"] = Math.ceil(5 * num) + "px";
							rule.style["paddingRight"] = Math.ceil(5 * num) + "px";
							rule.style["paddingBottom"] = Math.ceil(5 * num) + "px";
							rule.style["paddingLeft"] = Math.ceil(5 * num) + "px";
						}
						/* 批注内容 */
						if (selectorText == "div.my_word_document > div.my_word_comment > div.tooltip > div.tooltip-content".toUpperCase()) {
							rule.style["fontSize"] = Math.ceil(14 * num) + "px";
						}
					}
				}
			}
			tooltipPosition();
			$(".easyui-slider").removeAttr("schedule");
		}, 1000);
	}
}
function tooltipPosition() {
	$("div.my_word_comment>div.tooltip").each(function() {
		var $tooltip = $(this);
		var referenceTag = $tooltip.attr("reference");
		var data = referenceTag.split("-");
		$tooltip.css("top", $("li[orderno='" + data[0] + "'][levelNo='" + data[1] + "']").children("ul").children("li[orderno='" + data[2] + "']").offset().top - $(".my_word_document").offset().top);
	});
}
$(function() {
	/* 初始化招标文件导航树 */
	$("#document_navigation").tree({
		checkbox : true,
		onCheck : function(node, checked) {
			if (!checked) {
				$("#" + node.id).addClass("none");
				$("#" + node.id).find("li").addClass("none");
				$("a[href='#" + node.href + "']").parent("div").parent("li[changed!='delete']").addClass("none");
				$("a[href='#" + node.href + "']").parent("div").parent("li").find("li[changed!='delete']").addClass("none");
				cascade($("#" + node.id));
			} else {
				$("#" + node.id).removeClass("none");
				$("#" + node.id).parents("li[changed!='delete']").removeClass("none");
				$("#" + node.id).find("li[changed!='delete']").removeClass("none");
				$("a[href='#" + node.href + "']").parent("div").parent("li").removeClass("none");
				$("a[href='#" + node.href + "']").parent("div").parent("li").parents("li[changed!='delete']").removeClass("none");
				$("a[href='#" + node.href + "']").parent("div").parent("li").find("li[changed!='delete']").removeClass("none");
			}
		},
		onClick : function(node) {
			if(!$("a[name='"+node.href+"']").parent("li").hasClass("none")){
				location.hash = node.href;
			}
		},
		onCollapse : function(node) {
			$("a[href='#" + node.href + "']").parent("div").parent("li").children("ul").find("li[changed!='delete']").addClass("none");
			$("a[name='" + node.href + "']").parent("li").children("ul").find("li:not('[changed=\"delete\"]')").addClass("none");
		},
		onExpand : function(node) {
			$("a[href='#" + node.href + "']").parent("div").parent("li").children("ul").find("li[changed!='delete']").removeClass("none");
			$("a[name='" + node.href + "']").parent("li").children("ul").find("li:not('[changed=\"delete\"]')").removeClass("none");
		}
	});
	// 禁用鼠标右击事件
	$(document).contextmenu(function(e) {
		e.preventDefault();
	}).keydown(function(e) {
		// 快捷键刷新目录
		if (e.keyCode == 120) {
			$(".my_word_document>.my_word_center>.my_word_body .editable").blur();
			refreshCatalogue();
			return false;
		}
		// 快捷键保存
		if (e.keyCode == 83 && e.ctrlKey) {
			if ($("#save").length == 1) {
				$("#save").click();
			}
			return false;
		}
		if (e.keyCode == 90 && e.ctrlKey) {
			return false;
		}
	});
	// 目录右键
	$(document).on("contextmenu", ".my_word_document>.my_word_center>.my_word_catalogue", function(e) {
		var items = [ {
			text : "更新目录",
			handler : function() {
				refreshCatalogue();
			}
		} ];
		menu(items, e);
	});
	$(document).on("click", ".my_word_document", function(e) {
		checkData();
	});
	// 单击选中/取消事件
	$(document).on("click", ".my_word_document>.my_word_center>.my_word_body li>pre", function(e) {
		if (!$(this).hasClass("editable")) {// 排除正在编辑的内容
			var $ul = $(this).parent("li").children("ul");
			if ((!e.ctrlKey && !e.shiftKey) || (e.ctrlKey && e.shiftKey)) {// 单选
				$(".my_word_document>.my_word_center>.my_word_body li[shift='shift']").removeAttr("shift");
				$(".my_word_document>.my_word_center>.my_word_body li>pre.datagrid-row-selected").removeClass("datagrid-row-selected");
				$(this).addClass("datagrid-row-selected");
				$(".my_word_document>.my_word_comment>.tooltip[reference='"+$(this).parent("li").attr("unique")+"']").css("z-index",9015).siblings(".tooltip").css("z-index",9014);
				if ($ul.length > 0) {
					$ul.find("li").each(function() {
						$(this).children("pre").addClass("datagrid-row-selected");
					});
				}
			} else if (e.ctrlKey) {// ctrl多选
				if ($(this).hasClass("datagrid-row-selected")) {
					$(this).parents("li").each(function() {
						$(this).children("pre").removeClass("datagrid-row-selected");
					});
					$(this).removeClass("datagrid-row-selected");
					if ($ul.length > 0) {
						$ul.find("li").each(function() {
							$(this).children("pre").removeClass("datagrid-row-selected");
						});
					}
				} else {
					$(this).addClass("datagrid-row-selected");
					if ($ul.length > 0) {
						$ul.find("li").each(function() {
							$(this).children("pre").addClass("datagrid-row-selected");
						});
					}
				}
			} else if (e.shiftKey) {// shift连续选择
				var $fromLi = $(this).parent("li");
				if ($fromLi.attr("shift") == "shift") {
					$(".my_word_document>.my_word_center>.my_word_body li>pre.datagrid-row-selected").removeClass("datagrid-row-selected").removeAttr("shift");
					$fromLi.find("pre").addClass("datagrid-row-selected");
					return false;
				}
				var $toLi = $(this).parent("li").siblings("li[shift='shift']");
				if ($toLi.length == 0) {
					$toLi = $(this).parent("li").siblings("li:has('.datagrid-row-selected'):first").attr("shift", "shift");
				}
				if ($toLi.length == 0 || !$toLi.children("pre").hasClass("datagrid-row-selected")) {
					$(".my_word_document>.my_word_center>.my_word_body li>pre.datagrid-row-selected").removeClass("datagrid-row-selected").removeAttr("shift");
					$fromLi.find("pre").addClass("datagrid-row-selected");
					return false;
				}
				$(".my_word_document>.my_word_center>.my_word_body li>pre.datagrid-row-selected").removeClass("datagrid-row-selected");
				var a = parseInt($fromLi.attr("orderno"));
				var b = parseInt($toLi.attr("orderno"));
				if (a > b) {
					var t = a;
					a = b;
					b = t;
				}
				$toLi.parent("ul").children("li").each(function(i) {
					if (parseInt($(this).attr("orderno")) >= a && parseInt($(this).attr("orderno")) <= b) {
						$(this).find("pre").addClass("datagrid-row-selected");
					}
				});
			}
		}
		return false;
	});
	// 鼠标悬停
	$(document).on("mouseover", ".my_word_document>.my_word_center>.my_word_body li>pre", function() {
		$(this).addClass("datagrid-row-over");
	});
	// 鼠标离开
	$(document).on("mouseout", ".my_word_document>.my_word_center>.my_word_body li>pre", function() {
		$(this).removeClass("datagrid-row-over");
	});
	// 双击编辑
	$(document).on("dblclick", ".my_word_document>.my_word_center>.my_word_body [editable='true'],.my_word_document .my_word_body [editable='true'] *", function() {
		var $editable = ($(this).attr("editable") == "true") ? $(this) : $(this).parents("[editable='true']:first");
		if (!$editable.hasClass("editable")) {
			// 检查上一个编辑框数据
			checkData();
			var $li = $editable.parent("li");
			$editable.find("span.index").remove();
			if ($li.attr("id") != "" && $li.attr('changed') != 'create' && $li.attr('changed') != 'update') {
				$editable.after($editable.clone().addClass("none"));
				$li.attr("changed", "update");
			}
			$editable.removeClass("datagrid-row-selected").addClass("editable");
			$editable.attr("contenteditable", "true").focus();
		}
	});

	// 右键菜单
	$(document).on("contextmenu", ".my_word_document>.my_word_center>.my_word_body  pre", function(e) {
		e.preventDefault();
		var $pre = $(this);
		var $li = $pre.parent("li"); // div所在li
		var $parentUl = $li.parent("ul"); // li所在ul
		var $parentLi = $parentUl.parent("li");
		var $ul = $li.children("ul");
		var insertLevelNo = parseInt($li.attr("levelNo"));
		var insertRetract = (insertLevelNo - 3 < 0) ? 0 : (insertLevelNo - 3) * 2;
		var appendLevelNo = parseInt($li.attr("levelNo")) + 1;
		var appendRetract = (appendLevelNo - 3 < 0) ? 0 : (appendLevelNo - 3) * 2;
		var items = []; // 菜单
		items[items.length] = {
			text : "编　　辑",
			disabled : $pre.attr("editable") == "false",
			handler : function() {
				$pre.dblclick();
			}
		};
		if ($parentLi.length == 1) {
			items[items.length] = {
				text : "序　　号",
				items : [ {
					text : "第N部分　(中文小写)",
					handler : function() {
						$parentLi.attr("noType", "PART");
						var data = eval("(" + $parentLi.attr("data") + ")");
						if ($parentLi.attr("id") != "" && !$parentLi.attr("changed") && data.noType != $parentLi.attr("noType")) {
							$parentLi.attr("changed", "update");
						}
						sortLi($parentUl);
					}
				}, {
					text : "第N章　　(中文小写)",
					handler : function() {
						$parentLi.attr("noType", "CHAPTER");
						var data = eval("(" + $parentLi.attr("data") + ")");
						if ($parentLi.attr("id") != "" && !$parentLi.attr("changed") && data.noType != $parentLi.attr("noType")) {
							$parentLi.attr("changed", "update");
						}
						sortLi($parentUl);
					}
				}, {
					text : "第N条　　(中文小写)",
					handler : function() {
						$parentLi.attr("noType", "ITEM");
						var data = eval("(" + $parentLi.attr("data") + ")");
						if ($parentLi.attr("id") != "" && !$parentLi.attr("changed") && data.noType != $parentLi.attr("noType")) {
							$parentLi.attr("changed", "update");
						}
						sortLi($parentUl);
					}
				}, {
					text : "N　　　　(中文小写)",
					handler : function() {
						$parentLi.attr("noType", "CHINESE");
						var data = eval("(" + $parentLi.attr("data") + ")");
						if ($parentLi.attr("id") != "" && !$parentLi.attr("changed") && data.noType != $parentLi.attr("noType")) {
							$parentLi.attr("changed", "update");
						}
						sortLi($parentUl);
					}
				}, {
					text : "n　　　　(阿拉伯数字)",
					handler : function() {
						$parentLi.attr("noType", "SIMPLE");
						var data = eval("(" + $parentLi.attr("data") + ")");
						if ($parentLi.attr("id") != "" && !$parentLi.attr("changed") && data.noType != $parentLi.attr("noType")) {
							$parentLi.attr("changed", "update");
						}
						sortLi($parentUl);
					}
				}, {
					text : "(n)　　　(阿拉伯数字)",
					handler : function() {
						$parentLi.attr("noType", "BRACKET");
						var data = eval("(" + $parentLi.attr("data") + ")");
						if ($parentLi.attr("id") != "" && !$parentLi.attr("changed") && data.noType != $parentLi.attr("noType")) {
							$parentLi.attr("changed", "update");
						}
						sortLi($parentUl);
					}
				}, {
					text : "n.n　　　(阿拉伯数字)",
					handler : function() {
						$parentLi.attr("noType", "EXTEND");
						var data = eval("(" + $parentLi.attr("data") + ")");
						if ($parentLi.attr("id") != "" && !$parentLi.attr("changed") && data.noType != $parentLi.attr("noType")) {
							$parentLi.attr("changed", "update");
						}
						sortLi($parentUl);
					}
				}, {
					text : "无",
					handler : function() {
						$parentLi.attr("noType", "NONE");
						var data = eval("(" + $parentLi.attr("data") + ")");
						if ($parentLi.attr("id") != "" && !$parentLi.attr("changed") && data.noType != $parentLi.attr("noType")) {
							$parentLi.attr("changed", "update");
						}
						$parentUl.children("li").each(function() {
							$(this).children("pre").children("span.index").html("");
						});
						sortLi($parentUl);
					}
				} ]
			};
			if ($parentLi.attr("noType") != "NONE") {
				if ($li.attr("noDisplay") == "true") {
					items[items.length - 1].items[items[items.length - 1].items.length] = {
						text : "不显本条示序号",
						handler : function() {
							$li.attr("noDisplay", "false");
							var data = eval("(" + $li.attr("data") + ")");
							if ($li.attr("id") != "" && !$li.attr("changed") && ($li.attr("noDisplay") == "true") != data.noDisplay) {
								$li.attr("changed", "update");
							}
							$pre.children("span.index").html("");
							sortLi($parentUl);
						}
					};
				} else {
					items[items.length - 1].items[items[items.length - 1].items.length] = {
						text : "显　示本条序号",
						handler : function() {
							$li.attr("noDisplay", "true");
							var data = eval("(" + $li.attr("data") + ")");
							if ($li.attr("id") != "" && !$li.attr("changed") && ($li.attr("noDisplay") == "true") != data.noDisplay) {
								$li.attr("changed", "update");
							}
							sortLi($parentUl);
						}
					};
				}
			}
		}
		items[items.length] = {
			text : "插　　入",
			items : [ {
				text : "标题",
				disabled : $parentLi.attr("isTitle") != "true" || $parentLi.length == 0,
				handler : function() {
					var $insertLi = $("<li/>").attr({
						"id" : "",
						"pid" : $parentLi.attr("id"),
						"noDisplay" : "true",
						"required" : "false",
						"isTitle" : "true",
						"noType" : "EXTEND",
						"levelNo" : insertLevelNo,
						"changed" : "create"
					}).css("textIndent", insertRetract + "em").addClass("h" + insertLevelNo);
					var $a = $("<a/>")
					$insertLi.append($a);
					var $insertpre = $("<pre/>").attr("editable", "true").appendTo($insertLi);
					$insertpre.append($("<span/>").addClass("index"));
					$li.before($insertLi);
					sortLi($parentUl);
					$a.attr("name", ($parentLi.length == 1 ? $parentLi.attr("orderno") : 0) + "-" + $li.attr("levelNo") + "-" + $li.attr("orderno"));
					$insertpre.dblclick();
				}
			}, {
				text : "文本",
				disabled : $parentLi.length == 0,
				handler : function() {
					var $insertLi = $("<li/>").attr({
						"id" : "",
						"pid" : $parentLi.attr("id"),
						"noDisplay" : "true",
						"required" : "false",
						"isTitle" : "false",
						"noType" : "EXTEND",
						"levelNo" : insertLevelNo,
						"changed" : "create"
					}).css("textIndent", insertRetract + "em").addClass("content");
					var $insertpre = $("<pre/>").attr("editable", "true").appendTo($insertLi);
					$insertpre.append($("<span/>").addClass("index"));
					$li.before($insertLi);
					sortLi($parentUl);
					$insertpre.dblclick();
				}
			} ]
		};
		items[items.length] = {
			text : "添加子项",
			items : [ {
				text : "标　　题",
				disabled : ($li.attr("isTitle") != "true"),
				handler : function() {
					if ($ul.length == 0) {
						$ul = $("<ul/>").appendTo($li);
					}
					var $appendLi = $("<li/>").attr({
						"id" : "",
						"pid" : $li.attr("id"),
						"noDisplay" : "true",
						"required" : "false",
						"isTitle" : "true",
						"noType" : "EXTEND",
						"levelNo" : appendLevelNo,
						"changed" : "create"
					}).css("textIndent", appendRetract + "em").addClass("h" + appendLevelNo).appendTo($ul);
					var $a = $("<a/>");
					$appendLi.append($a);
					var $appendpre = $("<pre/>").attr("editable", "true").appendTo($appendLi);
					$appendpre.append($("<span/>").addClass("index"));
					sortLi($ul);
					$a.attr("name", ($parentLi.length == 1 ? $parentLi.attr("orderno") : 0) + "-" + $li.attr("levelNo") + "-" + $li.attr("orderno"));
					$appendpre.dblclick();
				}
			}, {
				text : "文　　本",
				handler : function() {
					if ($ul.length == 0) {
						$ul = $("<ul/>").appendTo($li);
					}
					var $appendLi = $("<li/>").attr({
						"id" : "",
						"pid" : $li.attr("id"),
						"noDisplay" : "true",
						"required" : "false",
						"isTitle" : "false",
						"noType" : "EXTEND",
						"levelNo" : appendLevelNo,
						"changed" : "create"
					}).css("textIndent", appendRetract + "em").addClass("content").appendTo($ul);
					var $appendpre = $("<pre/>").attr("editable", "true").appendTo($appendLi);
					$appendpre.append($("<span/>").addClass("index"));
					sortLi($ul);
					$appendpre.dblclick();
				}
			} ]
		};
		if ($pre.hasClass("datagrid-row-selected")) {
			items[items.length] = {
				text : "取消选中",
				handler : function() {
					$(".my_word_document>.my_word_center>.my_word_body .datagrid-row-selected").removeClass("datagrid-row-selected");
				}
			};
			if ($(".my_word_document>.my_word_center>.my_word_body li>.datagrid-row-selected").length >= 2 && $parentUl.children("li:has('.datagrid-row-selected')").length == 2 && $parentUl.find(".datagrid-row-selected").length == $(".my_word_document .my_word_body .datagrid-row-selected").length) {
				items[items.length] = {
					text : "交换选中内容",
					handler : function() {
						var $selecteds = $parentUl.children("li:has('.datagrid-row-selected')");
						var $a = $($selecteds[0]);
						var $b = $($selecteds[1]);
						var $t = $a.clone();
						var $ul = $a.parent("ul");
						$a.replaceWith($b.clone());
						$b.replaceWith($t);
						sortLi($ul);
					}
				};
			}
			items[items.length] = {
				text : "删除选中",
				disabled : $(".my_word_document>.my_word_center>.my_word_body .datagrid-row-selected[editable='true']").length == 0,
				handler : function() {
					$(".my_word_document>.my_word_center>.my_word_body li[isRequired!='true']:has('.datagrid-row-selected')").each(function(i) {
						$(this).find(".datagrid-row-selected").removeClass("datagrid-row-selected");
						deleteData($(this));
					});
				}
			};
		} else {
			items[items.length] = {
				text : "删　　除",
				disabled : $li.attr("isRequired") == "true",
				handler : function() {
					deleteData($li);
				}
			};
		}
		items[items.length] = {
			text : "重置模板",
			handler : function() {
				$("select[name='id']").change();
			}
		};
		menu(items, e);
		return false;
	});
	// 插入表格工具开始
	$(".hover_table td").hover(function() {
		var $ctd = $(this);
		var $ctr = $ctd.parent("tr");
		var $table = $ctr.parent("tbody").parent("table.hover_table");
		var colnum = $ctd.index();
		var rownum = $ctr.index();
		for (var i = 0; i <= rownum; i++) {
			var $tr = $($table.find("tr")[i]);
			for (var j = 0; j <= colnum; j++) {
				$($tr.find("td")[j]).children("div").addClass("datagrid-row-selected");
			}
		}
	}, function() {
		$(this).parents("table.hover_table:first").find("td>div").removeClass("datagrid-row-selected");
	});
	$(".hover_table td").click(function() {
		var $ctd = $(this);
		var $ctr = $ctd.parent("tr");
		var $table = $ctr.parent("tbody").parent("table.hover_table");
		var colnum = $ctd.index();
		var rownum = $ctr.index();
		var $insertTable = $("<table/>");
		var $insertTbody = $("<tbody/>").appendTo($insertTable);
		for (var i = 0; i <= rownum; i++) {
			var $tr = $("<tr/>").appendTo($insertTbody);
			for (var j = 0; j <= colnum; j++) {
				$tr.append($("<td/>"));
			}
		}
		if ($(".editable[editable='true']").length == 1) {
			$(".editable[editable='true']").append($insertTable);
		}
	});

	$(document).on("mousedown", ".my_word_document .my_word_body [editable='true'] table td", function(e) {
		if (e.button == 0 || e.button == 1) {
			var $begin = $(this);
			var $table = $begin.parent("tr").parent("tbody").parent("table");
			$table.find("td.datagrid-row-selected").removeClass("datagrid-row-selected");
			$begin.attr("begin", "true");
		}
	});
	$(document).on("mouseup", ".my_word_document .my_word_body [editable='true'] table td", function(e) {
		if (e.button == 0 || e.button == 1) {
			var $end = $(this);
			var $table = $end.parent("tr").parent("tbody").parent("table");
			var $begin = $table.find("td[begin='true']").removeAttr("begin");
			if ($begin.length == 1) {
				var beginColIndex = $begin.index();
				var beginRowIndex = $begin.parent().index();
				var endColIndex = $end.index();
				var endRowIndex = $end.parent().index();
				if (beginColIndex > endColIndex) {
					var t = beginColIndex;
					beginColIndex = endColIndex;
					endColIndex = t;
				}
				if (beginRowIndex > endRowIndex) {
					var t = beginRowIndex;
					beginRowIndex = endRowIndex;
					endRowIndex = t;
				}
				if (beginColIndex != endColIndex || beginRowIndex != endRowIndex) {
					for (var i = beginRowIndex; i <= endRowIndex; i++) {
						for (var j = beginColIndex; j <= endColIndex; j++) {
							var $td = $($($table.find("tr")[i]).find("td")[j]);
							$td.addClass("datagrid-row-selected");
						}
					}
				}
			}
		}
	});
	$(document).on("contextmenu", ".my_word_document .my_word_body [editable='true'] table td.datagrid-row-selected", function(e) {
		var $td = $(this);
		var $table = $td.parent("tr").parent("tbody").parent("table");
		var $trs = $table.find("tr:has('td.datagrid-row-selected')");
		e.stopPropagation();
		var items = [ {
			text : "删除单元格",
			handler : function() {

			}
		}, {
			text : "合并单元格",
			handler : function() {
				var $table = $td.parent("tr").parent("tbody").parent("table");
				var $tdFirst = $table.find("td.datagrid-row-selected:first").removeClass("datagrid-row-selected");
				var $tdLast = $table.find("td.datagrid-row-selected:last");
				var firstColspan = $tdFirst.attr("colspan") ? parseInt($tdFirst.attr("colspan")) : 1;
				var firstRowspan = $tdFirst.attr("rowspan") ? parseInt($tdFirst.attr("rowspan")) : 1;
				var lastColspan = $tdLast.attr("colspan") ? parseInt($tdLast.attr("colspan")) : 1;
				var lastRowspan = $tdLast.attr("rowspan") ? parseInt($tdLast.attr("rowspan")) : 1;
				$tdFirst.attr("colspan", $tdLast.index() - $tdFirst.index() + lastColspan).attr("rowspan", $tdLast.parent("tr").index() - $tdFirst.parent("tr").index() + lastRowspan);
				$table.find("td.datagrid-row-selected,td.none").removeClass("datagrid-row-selected").addClass("none");
			}
		} ];
		menu(items, e);
		return false;
	});
	// 插入表格工具结束
	
	// 批注工具开始
	$("#commentDisplay").click(function() {
		if ($(this).hasClass("datagrid-row-selected")) {
			$(".my_word_document").width($(".my_word_document").width() - $(".my_word_comment").addClass("none").width() - 1);
			$(this).removeClass("datagrid-row-selected");
		} else {
			$(".my_word_document").width($(".my_word_document").width() + $(".my_word_comment").removeClass("none").width() + 1);
			$(this).addClass("datagrid-row-selected");
		}
	});
	$("#createComment").click(function() {
		var $selected = $("pre.datagrid-row-selected");
		if ($selected.length == 0 || $selected.length != $($selected[0]).parent("li").find("pre.datagrid-row-selected").length) {
			$.messager.alert("系统提示", "请选择一处要批注的内容");
			return false;
		}
		if (!$("#commentDisplay").hasClass("datagrid-row-selected")) {
			$("#commentDisplay").click();
		}
		var $li = $($selected[0]).parent("li");
		var unique= $li.attr("unique");
		var $div = $("[reference='" + unique + "']");
		if ($div.length == 0) {
			var top = Math.ceil($($selected[0]).offset().top - $(".my_word_document").offset().top);
			$div = $("<div/>").attr("reference", unique).attr("tabindex", "-1").attr("changed", "create").addClass("tooltip tooltip-right").append($("<div/>").attr("contenteditable", "true").addClass("tooltip-content")).append($("<div/>").addClass("tooltip-arrow-outer").attr("style", "border-right-color: rgb(149, 184, 231)")).append($("<div/>").addClass("tooltip-arrow").attr("style", "border-right-color: rgb(255,255,255)")).appendTo($(".my_word_comment")).css("top", top);
		}
		$div.children(".tooltip-content").focus();
	});
	$(document).on("click",".my_word_document>.my_word_comment>.tooltip",function(){
		$(this).css("z-index",9015).siblings(".tooltip").css("z-index",9014);
		$(".my_word_document>.my_word_center>.my_word_body").find("li[unique='"+$(this).attr("reference")+"']").children("pre").click();
	});
	// 批注工具结束
	
	// 布局工具开始
	$("#navigationDisplay").click(function() {
		$("body").layout($(this).is(":checked") ? "expand" : "collapse", "west");
	});
	$("#catalogueDisplay").click(function() {
		if ($(this).is(":checked")) {
			$(".my_word_document>.my_word_catalogue").removeClass("none");
		} else {
			$(".my_word_document>.my_word_catalogue").addClass("none");
		}
	});
	$("#coverDisplay").click(function() {
		if ($(this).is(":checked")) {
			$(".my_word_document>.my_word_cover").removeClass("none");
		} else {
			$(".my_word_document>.my_word_cover").addClass("none");
		}
	});
	// 布局工具结束
	
	$(".easyui-searchbox").searchbox({
		prompt : "请输入...",
		searcher : function(value, name) {
			var rng = document.body.createTextRange();
			if (rng.findText(value)) {
				rng.select();
			}
		}
	});
	var palettes = { };
	palettes.newGmail =  [["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]];
	palettes.common = [
	    ["#000000", "#434343", "#666666", "#999999", "#b7b7b7", "#cccccc", "#d9d9d9", "#efefef", "#f3f3f3", "#ffffff"],
	    ["#980000", "#ff0000", "#ff9900", "#ffff00", "#00ff00", "#00ffff", "#4a86e8", "#0000ff", "#9900ff", "#ff00ff"],
	    ["#e6b8af", "#f4cccc", "#fce5cd", "#fff2cc", "#d9ead3", "#d9eaf3", "#c9daf8", "#cfe2f3", "#d9d2e9", "#ead1dc"],
	    ["#dd7e6b", "#ea9999", "#f9cb9c", "#ffe599", "#b6d7a8", "#a2c4c9", "#a4c2f4", "#9fc5e8", "#b4a7d6", "#d5a6bd"],
	    ["#cc4125", "#e06666", "#f6b26b", "#ffd966", "#93c47d", "#76a5af", "#6d9eeb", "#6fa8dc", "#8e7cc3", "#c27ba0"],
	    ["#a61c00", "#cc0000", "#e69138", "#f1c232", "#6aa84f", "#45818e", "#3c78d8", "#3d85c6", "#674ea7", "#a64d79"],
	    ["#85200c", "#990000", "#b45f06", "#bf9000", "#38761d", "#134f5c", "#1155cc", "#0b5394", "#351c75", "#741b47"],
	    ["#5b0f00", "#660000", "#783f04", "#7f6000", "#274e13", "#0c343d", "#1c4587", "#073763", "#20124d", "#4c1130"]
	];
	palettes.snagit = [
	    ["#ffffff", "#000000", "#c00000", "#f79646", "#f5f445", "#7fd13b", "#4bacc6", "#1f497d", "#8064a2", "#ff0000"],
	    ["#f2f2f2", "#7f7f7f", "#f8d1d3", "#fdeada", "#fafdd7", "#e5f5d7", "#dbeef3", "#c6d9f0", "#e5e0ec", "#ffcc00"],
	    ["#d7d7d7", "#595959", "#f2a3a7", "#fbd5b5", "#fbfaae", "#cbecb0", "#b7dde8", "#8db3e2", "#ccc1d9", "#ffff00"],
	    ["#bebebe", "#414141", "#eb757b", "#fac08f", "#eef98e", "#b2e389", "#92cddc", "#548dd4", "#b2a2c7", "#00ff00"],
	    ["#a3a3a3", "#2a2a2a", "#a3171e", "#e36c09", "#dede07", "#5ea226", "#31859b", "#17365d", "#5f497a", "#0000ff"],
	    ["#7e7e7e", "#141414", "#6d0f14", "#974806", "#c0c00d", "#3f6c19", "#205867", "#0f243e", "#3f3151", "#9900ff"]
	];
	palettes.newton = ["#ffffff", "#000000", "#ff0000", "#ff8000", "#ffff00", "#008000", "#0000ff", "#4b0082", "#9400d3"];
	palettes.aol = [
	    ["#ffffff", "#fff7de", "#ffffce", "#ffffbd", "#ffffd6", "#b5ff84", "#c6efde", "#efffff", "#efe7f7", "#dea5d6"],
	    ["#ded6c6", "#ffc6bd", "#ffe7b5", "#ffe7a5", "#efef7b", "#adf77b", "#5abd9c", "#a5d6f7", "#8494e7", "#ef7be7"],
	    ["#cec6b5", "#e78473", "#efad52", "#f7b500", "#efef9c", "#a5ff00", "#7bd6bd", "#a5d6de", "#8c5ae7", "#de6bce"],
	    ["#8c8473", "#ef0018", "#ef4210", "#f79400", "#ffff00", "#63d600", "#a5c684", "#5a63d6", "#7b52c6", "#c642ce"],
	    ["#736b63", "#d60039", "#d67310", "#f7844a", "#f7de00", "#429400", "#4a944a", "#4200ff", "#9c00de", "#a500c6"],
	    ["#39524a", "#b51821", "#944a08", "#a55229", "#8c8c00", "#318c00", "#429484", "#3100c6", "#523984", "#940084"],
	    ["#000000", "#940008", "#840008", "#ad2929", "#637321", "#296b00", "#29006b", "#21007b", "#52007b", "#84007b"]
	];
	palettes.oldGmail = [
	    ["#ffffff", "#cecece", "#c6c6c6", "#9c9c9c", "#636363", "#313131", "#000000"],
	    ["#ffcece", "#ff6363", "#ff0000", "#ce0000", "#9c0000", "#630000", "#310000"],
	    ["#ffce9c", "#ff9c63", "#ff9c00", "#ff6300", "#ce6300", "#9c3100", "#633100"],
	    ["#ffff9c", "#ffff63", "#ffce63", "#ffce31", "#ce9c31", "#9c6331", "#633131"],
	    ["#ffffce", "#ffff31", "#ffff00", "#ffce00", "#9c9c00", "#636300", "#313100"],
	    ["#9cff9c", "#63ff9c", "#31ff31", "#31ce00", "#009c00", "#006300", "#003100"],
	    ["#9cffff", "#31ffff", "#63cece", "#00cece", "#319c9c", "#316363", "#003131"],
	    ["#ceffff", "#63ffff", "#31ceff", "#3163ff", "#3131ff", "#00009c", "#000063"],
	    ["#ceceff", "#9c9cff", "#6363ce", "#6331ff", "#6300ce", "#31319c", "#31009c"],
	    ["#ffceff", "#ff9cff", "#ce63ce", "#ce31ce", "#9c319c", "#633163", "#310031"]
	];
	palettes.hotmail = [
	    ["#ffffff", "#000000", "#efefe7", "#184a7b", "#4a84bd", "#c6524a", "#9cbd5a", "#8463a5", "#4aadc6", "#f79442"],
	    ["#f7f7f7", "#7b7b7b", "#dedec6", "#c6def7", "#dee7f7", "#f7dede", "#eff7de", "#e7e7ef", "#deeff7", "#ffefde"],
	    ["#dedede", "#5a5a5a", "#c6bd94", "#8cb5e7", "#bdcee7", "#e7bdb5", "#d6e7bd", "#cec6de", "#b5deef", "#ffd6b5"],
	    ["#bdbdbd", "#393939", "#948c52", "#528cd6", "#94b5d6", "#de9494", "#c6d69c", "#b5a5c6", "#94cede", "#ffc68c"],
	    ["#a5a5a5", "#212121", "#4a4229", "#10315a", "#316394", "#943131", "#739439", "#5a4a7b", "#31849c", "#e76b08"],
	    ["#848484", "#080808", "#181810", "#082139", "#214263", "#632121", "#4a6329", "#393152", "#215a63", "#944a00"],
	    ["#c60000", "#ff0000", "#ffc600", "#ffff00", "#94d652", "#00b552", "#00b5f7", "#0073c6", "#002163", "#7331a5"],
	];
	palettes.yahoo = [
	    ["#000000", "#111111", "#2d2d2d", "#434343", "#5b5b5b", "#737373", "#8b8b8b", "#a2a2a2", "#b9b9b9", "#d0d0d0", "#e6e6e6", "#ffffff"],
	    ["#7f7f00", "#bfbf00", "#ffff00", "#ffff40", "#ffff80", "#ffffbf", "#525330", "#898a49", "#aea945", "#c3be71", "#e0dcaa", "#fcfae1"],
	    ["#407f00", "#60bf00", "#80ff00", "#a0ff40", "#c0ff80", "#dfffbf", "#3b5738", "#668f5a", "#7f9757", "#8a9b55", "#b7c296", "#e6ebd5"],
	    ["#007f40", "#00bf60", "#00ff80", "#40ffa0", "#80ffc0", "#bfffdf", "#033d21", "#438059", "#7fa37c", "#8dae94", "#acc6b5", "#ddebe2"],
	    ["#007f7f", "#00bfbf", "#00ffff", "#40ffff", "#80ffff", "#bfffff", "#033d3d", "#347d7e", "#609a9f", "#96bdc4", "#b5d1d7", "#e2f1f4"],
	    ["#00407f", "#0060bf", "#0080ff", "#40a0ff", "#80c0ff", "#bfdfff", "#1b2c48", "#385376", "#57708f", "#7792ac", "#a8bed1", "#deebf6"],
	    ["#00007f", "#0000bf", "#0000ff", "#4040ff", "#8080ff", "#bfbfff", "#212143", "#373e68", "#444f75", "#585e82", "#8687a4", "#d2d1e1"],
	    ["#40007f", "#6000bf", "#8000ff", "#a040ff", "#c080ff", "#dfbfff", "#302449", "#54466f", "#655a7f", "#726284", "#9e8fa9", "#dcd1df"],
	    ["#7f007f", "#bf00bf", "#ff00ff", "#ff40ff", "#ff80ff", "#ffbfff", "#4a234a", "#794a72", "#936386", "#9d7292", "#c0a0b6", "#ecdae5"],
	    ["#7f003f", "#bf005f", "#ff007f", "#ff409f", "#ff80bf", "#ffbfdf", "#451528", "#823857", "#a94a76", "#bc6f95", "#d8a5bb", "#f7dde9"],
	    ["#800000", "#c00000", "#ff0000", "#ff4040", "#ff8080", "#ffc0c0", "#441415", "#82393c", "#aa4d4e", "#bc6e6e", "#d8a3a4", "#f8dddd"],
	    ["#7f3f00", "#bf5f00", "#ff7f00", "#ff9f40", "#ffbf80", "#ffdfbf", "#482c1b", "#855a40", "#b27c51", "#c49b71", "#e1c4a8", "#fdeee0"]
	];
	palettes.sixteen = [
	    ["#000000", "#000084", "#0000ff", "#840000"],
	    ["#840084", "#008200", "#ff0000", "#008284"],
	    ["#ff00ff", "#848200", "#848284", "#00ff00"],
	    ["#ffa600", "#00ffff", "#c6c3c6", "#ffff00"],
	    ["#ffffff"]
	];
	palettes.websafe = [
	    ["#000", "#300", "#600", "#900", "#c00", "#f00"],
	    ["#003", "#303", "#603", "#903", "#c03", "#f03"],
	    ["#006", "#306", "#606", "#906", "#c06", "#f06"],
	    ["#009", "#309", "#609", "#909", "#c09", "#f09"],
	    ["#00c", "#30c", "#60c", "#90c", "#c0c", "#f0c"],
	    ["#00f", "#30f", "#60f", "#90f", "#c0f", "#f0f"],
	    ["#030", "#330", "#630", "#930", "#c30", "#f30"],
	    ["#033", "#333", "#633", "#933", "#c33", "#f33"],
	    ["#036", "#336", "#636", "#936", "#c36", "#f36"],
	    ["#039", "#339", "#639", "#939", "#c39", "#f39"],
	    ["#03c", "#33c", "#63c", "#93c", "#c3c", "#f3c"],
	    ["#03f", "#33f", "#63f", "#93f", "#c3f", "#f3f"],
	    ["#060", "#360", "#660", "#960", "#c60", "#f60"],
	    ["#063", "#363", "#663", "#963", "#c63", "#f63"],
	    ["#066", "#366", "#666", "#966", "#c66", "#f66"],
	    ["#069", "#369", "#669", "#969", "#c69", "#f69"],
	    ["#06c", "#36c", "#66c", "#96c", "#c6c", "#f6c"],
	    ["#06f", "#36f", "#66f", "#96f", "#c6f", "#f6f"],
	    ["#090", "#390", "#690", "#990", "#c90", "#f90"],
	    ["#093", "#393", "#693", "#993", "#c93", "#f93"],
	    ["#096", "#396", "#696", "#996", "#c96", "#f96"],
	    ["#099", "#399", "#699", "#999", "#c99", "#f99"],
	    ["#09c", "#39c", "#69c", "#99c", "#c9c", "#f9c"],
	    ["#09f", "#39f", "#69f", "#99f", "#c9f", "#f9f"],
	    ["#0c0", "#3c0", "#6c0", "#9c0", "#cc0", "#fc0"],
	    ["#0c3", "#3c3", "#6c3", "#9c3", "#cc3", "#fc3"],
	    ["#0c6", "#3c6", "#6c6", "#9c6", "#cc6", "#fc6"],
	    ["#0c9", "#3c9", "#6c9", "#9c9", "#cc9", "#fc9"],
	    ["#0cc", "#3cc", "#6cc", "#9cc", "#ccc", "#fcc"],
	    ["#0cf", "#3cf", "#6cf", "#9cf", "#ccf", "#fcf"],
	    ["#0f0", "#3f0", "#6f0", "#9f0", "#cf0", "#ff0"],
	    ["#0f3", "#3f3", "#6f3", "#9f3", "#cf3", "#ff3"],
	    ["#0f6", "#3f6", "#6f6", "#9f6", "#cf6", "#ff6"],
	    ["#0f9", "#3f9", "#6f9", "#9f9", "#cf9", "#ff9"],
	    ["#0fc", "#3fc", "#6fc", "#9fc", "#cfc", "#ffc"],
	    ["#0ff", "#3ff", "#6ff", "#9ff", "#cff", "#fff"]
	];
	palettes.named = [
	    ["White", "Ivory", "Snow", "LightYellow", "MintCream", "Azure", "FloralWhite", "Honeydew", "GhostWhite", "Seashell", "Cornsilk", "AliceBlue", "LemonChiffon", "LightCyan"],
	    ["OldLace", "LightGoldenrodYellow", "LavenderBlush", "WhiteSmoke", "Beige", "Linen", "PapayaWhip", "BlanchedAlmond", "AntiqueWhite", "MistyRose", "Bisque", "Lavender", "Moccasin", "PaleGoldenrod"],
	    ["NavajoWhite", "Yellow", "PeachPuff", "Wheat", "Khaki", "Gainsboro", "PaleTurquoise", "Pink", "Aquamarine", "LightGray", "PowderBlue", "PaleGreen", "GreenYellow", "LightPink"],
	    ["LightBlue", "Gold", "Thistle", "LightGreen", "LightSteelBlue", "Silver", "LightSkyBlue", "BurlyWood", "SkyBlue", "Chartreuse", "Plum", "LawnGreen", "Tan", "LightSalmon"],
	    ["SandyBrown", "Cyan", "Aqua", "DarkKhaki", "Violet", "Turquoise", "Orange", "YellowGreen", "DarkSalmon", "MediumAquamarine", "DarkSeaGreen", "DarkGray", "MediumTurquoise", "Goldenrod"],
	    ["MediumSpringGreen", "SpringGreen", "Salmon", "LightCoral", "Coral", "DarkOrange", "HotPink", "RosyBrown", "Orchid", "Lime", "PaleVioletRed", "Peru", "DarkTurquoise", "CornflowerBlue"],
	    ["Tomato", "DeepSkyBlue", "LimeGreen", "CadetBlue", "MediumSeaGreen", "DarkGoldenrod", "MediumPurple", "LightSeaGreen", "LightSlateGray", "MediumOrchid", "Gray", "Chocolate", "IndianRed", "SlateGray"],
	    ["MediumSlateBlue", "DodgerBlue", "OliveDrab", "SteelBlue", "OrangeRed", "Olive", "SlateBlue", "RoyalBlue", "Magenta", "Fuchsia", "SeaGreen", "DimGray", "DeepPink", "Sienna"],
	    ["DarkOrchid", "DarkCyan", "ForestGreen", "DarkOliveGreen", "BlueViolet", "Teal", "MediumVioletRed", "Crimson", "SaddleBrown", "Brown", "FireBrick", "Red", "Green", "DarkSlateBlue"],
	    ["DarkSlateGray", "DarkViolet", "DarkGreen", "DarkMagenta", "Purple", "DarkRed", "Maroon", "Indigo", "MidnightBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "Black"]
	];
	initFontColorSelect();
	initBackgroundColorSelect();
	function initFontColorSelect(){
		$("#fontColorSelect").spectrum({
			color : $("#fontColorSelect").val(),
			flat : true,
			showInput : true,
			className: "full-spectrum",
			showInitial : true,
			showInput: false,
			showPalette : true,
			showSelectionPalette : true,
			maxPaletteSize : 10,
			preferredFormat : "hex",
			move : function(color) {},
			show : function(color) {},
			beforeShow : function(color) {},
			hide : function(color) {},
			change : function(color) {
				for (var i = 0; i < document.styleSheets.length; i++) {
					var rules = [];
					if (document.styleSheets[i].cssRules) {
						rules = document.styleSheets[i].cssRules;
					} else {
						rules = document.styleSheets[i].rules;
					}
					for (var j = 0; j < rules.length; j++) {
						var rule = rules[j];
						var selectorText = rule.selectorText;
						if (selectorText != undefined && selectorText != null) {
							var selectorText = selectorText.toUpperCase();
							/* 文档全局 */
							if (selectorText == "div.my_word_document".toUpperCase()||selectorText == "div.my_word_document a".toUpperCase()) {
								rule.style["color"] = color.toHexString();
							}
						}
					}
				}
				initFontColorSelect();
			},
			palette : palettes.common
		});
	}
	function initBackgroundColorSelect(){
		$("#backgroundColorSelect").spectrum({
			color : $("#backgroundColorSelect").val(),
			flat : true,
			showInput : true,
			className: "full-spectrum",
			showInitial : true,
			showInput: false,
			showPalette : true,
			showSelectionPalette : true,
			maxPaletteSize : 10,
			preferredFormat : "hex",
			move : function(color) {},
			show : function(color) {},
			beforeShow : function(color) {},
			hide : function(color) {},
			change : function(color) {
				for (var i = 0; i < document.styleSheets.length; i++) {
					var rules = [];
					if (document.styleSheets[i].cssRules) {
						rules = document.styleSheets[i].cssRules;
					} else {
						rules = document.styleSheets[i].rules;
					}
					for (var j = 0; j < rules.length; j++) {
						var rule = rules[j];
						var selectorText = rule.selectorText;
						if (selectorText != undefined && selectorText != null) {
							var selectorText = selectorText.toUpperCase();
							/* 文档全局 */
							if (selectorText == "div.my_word_document".toUpperCase()||selectorText == "div.my_word_document a".toUpperCase()) {
								rule.style["backgroundColor"] = color.toHexString();
							}
						}
					}
				}
				initBackgroundColorSelect();
			},
			palette : palettes.common
		});
	}
});
