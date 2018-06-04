/**
 * 日志管理模块
 */
layui.define(function (exports) {
    layui.use(["layer","form"], function () {

    });

    var LogObj = {


        addNewLog: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/log/addLog",
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(data),
                    success: function (res) {
                        layui.layer.close(index);
                        if(res.status){
                            callback(res, true);
                        }else{
                            callback(res.msg,false);
                        }
                    },
                    error: function (xmlHttpReq, error, ex) {
                        layui.layer.close(index);
                    }
                })
            }
            syncServer(data,function (res,status) {
                if (typeof callback == "function") {
                    callback(res, status);
                }
            });
        }

        ,deleteLog: function (logId, callback) {
            //同步到服务端
            var syncServer = function (logId, callback) {
                var index = layui.layer.load(2);
                //TODO 异常处理
                $.ajax({
                    url: "/log/delLog",
                    type: "POST",
                    dataType: "json",
                    data: {logId:logId},
                    success: function (res) {
                        layui.layer.close(index);
                        callback(res, true);
                    },
                    error: function (xmlHttpReq, error, ex) {
                        layui.layer.close(index);
                    }
                })
            }

            //删除确认窗口
            layui.layer.confirm('您确定要删除该日志?删除后不可恢复!', {icon: 3, title: '删除确认'}, function (index) {
                syncServer(logId, function (res, status) {
                    layui.layer.close(index);
                    if (typeof callback == "function") {
                        callback(res, status);
                    }
                })
            });
        },
        isJsonString: function(str) {
            try {
                if (typeof JSON.parse(str) == "object") {
                    return true;
                }
            } catch(e) {
            }
            return false;
        }


    }
    /**
     * 对外暴露的方法
     */
    exports("itenderLog", {
        /**
         * 新增log
         * @param data
         * @param callback
         */
        addLog: function (data,callback) {
            console.log(data);
            LogObj.addNewLog(data,callback);
        }

        /**
         * 删除log
         * @param logId
         * @param callback
         */
        ,deleteLog: function (logId, callback) {
            LogObj.deleteLog(logId, callback);
        }

    });

});

