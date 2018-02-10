/**
 * 行业管理模块
 */
layui.define(function (exports) {
    layui.use(["layer"], function () {

    });

    var IndustryObj = {
        addNewIndustry: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/industry/addIndustry",
                    type: "POST",
                    dataType: "json",
                    data: data,
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
        ,updateIndustry: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/industry",
                    type: "PATCH",
                    dataType: "json",
                    data: data,
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
        ,deleteIndustry: function (industryId, callback) {
            //同步到服务端
            var syncServer = function (industryId, callback) {
                var index = layui.layer.load(2);
                //TODO 异常处理
                $.ajax({
                    url: "/industry?id="+industryId,
                    type: "DELETE",
                    dataType: "json",
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
            layui.layer.confirm('您确定要删除该项?删除后不可恢复!', {icon: 3, title: '删除确认'}, function (index) {
                syncServer(industryId, function (res, status) {
                    layui.layer.close(index);
                    if (typeof callback == "function") {
                        callback(res, status);
                    }
                })
            });
        }
    }
    /**
     * 对外暴露的方法
     */
    exports("itenderIndustry", {
        /**
         * 新增权限
         * @param data
         * @param callback
         */
        addIndustry: function (data,callback) {
            IndustryObj.addNewIndustry(data,callback);
        }
        /**
         * 删除权限
         * @param industryId
         * @param callback
         */
        ,deleteIndustry: function (industryId, callback) {
            IndustryObj.deleteIndustry(industryId, callback);
        }
        /**
         * 更新权限
         * @param data
         * @param callback
         */
        ,updateIndustry: function (data,callback) {
            IndustryObj.updateIndustry(data,callback);
        }
    });

});

