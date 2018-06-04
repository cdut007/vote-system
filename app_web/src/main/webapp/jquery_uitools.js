/**
 * 注册全选 checkbox 的点击事件
 * 
 * 使用途径：1：如果在标准的table 样式里，直接在thead 头里放 checkbox 就可以了 2：如果不在标准的
 * table样式里，需要给注册全选的元素设置name属性为 checkall . 设置checkname为将需要全选的
 * checkbox的name,如果不设置，默认作用于整个页面
 */
var allchecked = false;
$(function() {
	// 低版本IE处理界面问题
	if ($.browser.msie && parseFloat($.browser.version) < 9) {
		$(".mytable tbody tr:odd,.mytable tbody tr:odd td,.mytable tbody tr:odd :input[type='text'],.mytable tbody tr:odd textarea").removeClass("eventr").addClass("oddtr");
		$(".mytable tbody tr:even,.mytable tbody tr:even td,.mytable tbody tr:even :input[type='text'],.mytable tbody tr:even textarea").removeClass("oddtr").addClass("eventr");
		$(".mytable tbody").live("keyup", function() {
			if (!$(this).attr("rows")) {
				$(this).attr("rows", $(this).find("tr").length);
			}
			if ($(this).attr("rows") != $(this).find("tr").length) {
				$(".mytable tbody tr:odd,.mytable tbody tr:odd td,.mytable tbody tr:odd :input[type='text'],.mytable tbody tr:odd textarea").removeClass("eventr").addClass("oddtr");
				$(".mytable tbody tr:even,.mytable tbody tr:even td,.mytable tbody tr:even :input[type='text'],.mytable tbody tr:even textarea").removeClass("oddtr").addClass("eventr");
			}
		});
	}
	$("table.mytable thead tr th input[type='checkbox']").live("change", function() {
		if (allchecked) {
			$(this).parents("table").find("input[type='checkbox']:enabled").removeAttr("checked");
		} else {
			$(this).parents("table").find("input[type='checkbox']:enabled").attr("checked", "checked");
		}
		allchecked = !allchecked;
	});
	$("table.mytable tbody tr td input[type='checkbox']").live("change", function() {
		if ($(this).parents("table.mytable:first").find("tbody tr td input[type='checkbox']:enabled").length > $(this).parents("table.mytable:first").find("tbody tr td input[type='checkbox']:enabled:checked").length) {
			allchecked = false;
			$(this).parents("table.mytable:first").find("thead tr th input[type='checkbox']").removeAttr("checked");
		} else {
			allchecked = true;
			$(this).parents("table.mytable:first").find("thead tr th input[type='checkbox']").attr("checked", "checked");
		}
	});
});