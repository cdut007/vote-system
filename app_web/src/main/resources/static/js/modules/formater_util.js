layui.define(function (exports) {

    var Util = {
        parseStatus: function (statusCode) {
            switch (statusCode) {
                case "DEPLOYED":
                    return "已发布";
                case "UNDEPLOYED":
                    return "未发布";
                case "COMPLETE":
                    return "已完成";
            }
        },
        markStatus: function (status, color) {
            return '<span style="color: ' + color + ';">' + status + '</span000>';
        }
    }

    exports("formaterUtil", {
        parseAndMarkStatus: function (statusCode, colorAlias) {
            switch (colorAlias) {
                case "gray":
                    return Util.markStatus(Util.parseStatus(statusCode), "#e2e2e2");
                case "yellow":
                    return Util.markStatus(Util.parseStatus(statusCode), "#FFB800");
                case "blue":
                    return Util.markStatus(Util.parseStatus(statusCode), "#01AAED");

            }
        },
        autoParseAndMarkStatus: function (statusCode) {
            var that = this;
            switch (statusCode) {
                case "DEPLOYED":
                    return that.parseAndMarkStatus(statusCode, "yellow");
                case "UNDEPLOYED":
                    return that.parseAndMarkStatus(statusCode, "blue");
                case "COMPLETE":
                    return that.parseAndMarkStatus(statusCode, "gray");
            }
        }

    })
})