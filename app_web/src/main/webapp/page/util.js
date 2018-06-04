$(function() {
	$(document).on("click", "#pager a", function() {
		$(this).parents('form:first').attr("action", $(this).parents('form:first').attr("action") + "?page=" + $(this).attr("page"));
		$(this).parents('form:first').submit();
		return false;
	});
	$(".tableTitle,.tableTitle2").on("click", function() {
		if ($(this).html().indexOf("单击显示") >= 0) {
			$(this).html($(this).html().replace("单击显示", "单击隐藏"));
			$(this).next(".mytableStyle:eq(0)").removeClass("none");
		} else if ($(this).html().indexOf("单击隐藏") >= 0) {
			$(this).html($(this).html().replace("单击隐藏", "单击显示"));
			$(this).next(".mytableStyle:eq(0)").addClass("none");
		}
	});
});
/*******************************************************************************
 * 日期类型格式化支持
 * 
 * @param format
 * @returns
 */
Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours() > 12 ? this.getHours() - 12 : this.getHours(), // hour
		"H+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	};
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
};
/** *文件大小转换*** */
function castSize(size) {
	var sizeString = "";
	if (size != null) {
		if (size < 1024) {
			sizeString = size + "B";
		} else if (size < 1024 * 1024) {
			sizeString = Math.round(size * 10 / 1024) / 10.0 + "K";
		} else if (size < 1024 * 1024 * 1024) {
			sizeString = Math.round(size * 10 / 1024 / 1024) / 10.0 + "M";
		} else if (size < 1024 * 1024 * 1024 * 1024) {
			sizeString = Math.round(size * 10 / 1024 / 1024 / 1024) / 10.0 + "G";
		} else {
			sizeString = Math.round(size * 10 / 1024 / 1024 / 1024 / 1024) / 10.0 + "T";
		}
	}
	return sizeString;
}

function dateCompare(startdate, enddate) {
	var arr = startdate.split("-");
	var starttime = new Date(arr[0], arr[1], arr[2]);
	var starttimes = starttime.getTime();
	var arrs = enddate.split("-");
	var lktime = new Date(arrs[0], arrs[1], arrs[2]);
	var lktimes = lktime.getTime();
	if (starttimes > lktimes) {
		return false;
	} else {
		return true;
	}
}
function timeCompare(startdate, enddate) {
	if (startdate == "" || enddate == "") {
		return true;
	}
	startdate = startdate.replace(/-/g, "/");
	startdate = new Date(startdate);
	enddate = enddate.replace(/-/g, "/");
	enddate = new Date(enddate);
	if (startdate > enddate) {
		return false;
	} else {
		return true;
	}
}
function isGtHowManyDays(startdate, enddate, howManyDays) {
	if (startdate == "" || enddate == "") {
		return true;
	}
	startdate = startdate.replace(/-/g, "/");
	startdate = new Date(startdate);
	enddate = enddate.replace(/-/g, "/");
	enddate = new Date(enddate);
	startdate = new Date(startdate.getUTCFullYear(), startdate.getMonth(), startdate.getDate());
	enddate = new Date(enddate.getUTCFullYear(), enddate.getMonth(), enddate.getDate());
	if (parseInt(Math.abs((enddate.getTime() - startdate.getTime()) / (1000 * 60 * 60 * 24))) < howManyDays) {
		return false;
	} else {
		return true;
	}
}

// 弹出加载层
function loading() {
	$("<div class=\"datagrid-mask\"></div>").css({
		display : "block",
		width : "100%",
		height : $(window).height()
	}).appendTo("body");
	$("<div class=\"datagrid-mask-msg\"></div>").html("正在加载，请稍候...").appendTo("body").css({
		zIndex : 9999,
		display : "block",
		left : ($(document.body).outerWidth(true) - 190) / 2,
		top : ($(window).height() - 45) / 2
	});
}

// 取消加载层
function disLoad() {
	$(".datagrid-mask").remove();
	$(".datagrid-mask-msg").remove();
}

function processNoticeList() {
	$("#processnotice-datagrid").datagrid({
		fit : true,
		singleSelect : true,
		rownumbers : true,
		fitColumns : true,
		striped : true,
		pagination : true,
		// title : "流程通知列表",
		region : "center",
		url : ctx + "/notice/processNoticeListData",
		idField : "id",
		columns : [ [ {
			hidden : false,
			field : "msg",
			title : "消息",
			align : "left",
			width : 230
		}, {
			hidden : false,
			field : "createDate",
			title : "创建时间",
			align : "center",
			width : 120
		} /*
			 * , { title : "操作", field : "id", formatter : function(value,
			 * rowData) { return "操作"; } }
			 */] ],
		toolbar : []
	});
}

function convertCurrency(currencyDigits) {
	// Constants:
	var MAXIMUM_NUMBER = 999999999999.99;
	// Predefine the radix characters and currency symbols for output:
	var CN_ZERO = "零";
	var CN_ONE = "壹";
	var CN_TWO = "贰";
	var CN_THREE = "叁";
	var CN_FOUR = "肆";
	var CN_FIVE = "伍";
	var CN_SIX = "陆";
	var CN_SEVEN = "柒";
	var CN_EIGHT = "捌";
	var CN_NINE = "玖";
	var CN_TEN = "拾";
	var CN_HUNDRED = "佰";
	var CN_THOUSAND = "仟";
	var CN_TEN_THOUSAND = "万";
	var CN_HUNDRED_MILLION = "亿";
	var CN_SYMBOL = "";
	var CN_DOLLAR = "元";
	var CN_TEN_CENT = "角";
	var CN_CENT = "分";
	var CN_INTEGER = "整";
	// Variables:
	var integral; // Represent integral part of digit number.
	var decimal; // Represent decimal part of digit number.
	var outputCharacters; // The output result.
	var parts;
	var digits, radices, bigRadices, decimals;
	var zeroCount;
	var i, p, d;
	var quotient, modulus;
	// Validate input string:
	currencyDigits = currencyDigits.toString();
	if (currencyDigits == "") {
		return "还没有输入数字！";
	}
	if (currencyDigits.match(/[^,.\d]/) != null) {
		return "请输入有效数字!";
	}
	if ((currencyDigits).match(/^((\d{1,3}(,\d{3})*(.((\d{3},)*\d{1,3}))?)|(\d+(.\d+)?))$/) == null) {
		return "请输入有效格式数字！";
	}
	// Normalize the format of input digits:
	currencyDigits = currencyDigits.replace(/,/g, ""); // Remove comma
														// delimiters.
	currencyDigits = currencyDigits.replace(/^0+/, ""); // Trim zeros at the
														// beginning.
	// Assert the number is not greater than the maximum number.
	if (Number(currencyDigits) > MAXIMUM_NUMBER) {
		return "您输入的数字太大了!";
	}
	// Process the coversion from currency digits to characters:
	// Separate integral and decimal parts before processing coversion:
	parts = currencyDigits.split(".");
	if (parts.length > 1) {
		integral = parts[0];
		decimal = parts[1];
		// Cut down redundant decimal digits that are after the second.
		decimal = decimal.substr(0, 2);
	} else {
		integral = parts[0];
		decimal = "";
	}
	// Prepare the characters corresponding to the digits:
	digits = new Array(CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE, CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE);
	radices = new Array("", CN_TEN, CN_HUNDRED, CN_THOUSAND);
	bigRadices = new Array("", CN_TEN_THOUSAND, CN_HUNDRED_MILLION);
	decimals = new Array(CN_TEN_CENT, CN_CENT);
	// Start processing:
	outputCharacters = "";
	// Process integral part if it is larger than 0:
	if (Number(integral) > 0) {
		zeroCount = 0;
		for (i = 0; i < integral.length; i++) {
			p = integral.length - i - 1;
			d = integral.substr(i, 1);
			quotient = p / 4;
			modulus = p % 4;
			if (d == "0") {
				zeroCount++;
			} else {
				if (zeroCount > 0) {
					outputCharacters += digits[0];
				}
				zeroCount = 0;
				outputCharacters += digits[Number(d)] + radices[modulus];
			}
			if (modulus == 0 && zeroCount < 4) {
				outputCharacters += bigRadices[quotient];
			}
		}
		outputCharacters += CN_DOLLAR;
	}
	// Process decimal part if there is:
	if (decimal != "") {
		for (i = 0; i < decimal.length; i++) {
			d = decimal.substr(i, 1);
			if (d != "0") {
				outputCharacters += digits[Number(d)] + decimals[i];
			}
		}
	}
	// Confirm and return the final output string:
	if (outputCharacters == "") {
		outputCharacters = CN_ZERO + CN_DOLLAR;
	}
	if (decimal == "") {
		outputCharacters += CN_INTEGER;
	}
	outputCharacters = CN_SYMBOL + outputCharacters;
	return outputCharacters;
}