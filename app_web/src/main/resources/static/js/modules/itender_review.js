/**
 * 设备管理模块
 */
layui.define(function (exports) {
    layui.use(["layer","form"], function () {

    });

    var ReviewObj = {


        addNewReview: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/review/addReview",
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
        ,updateReview: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/review/updateReview",
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
        ,deleteDevice: function (deviceId, callback) {
            //同步到服务端
            var syncServer = function (deviceId, callback) {
                var index = layui.layer.load(2);
                //TODO 异常处理
                $.ajax({
                    url: "/review/delReview",
                    type: "POST",
                    dataType: "json",
                    data: {deviceId:deviceId},
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
            layui.layer.confirm('您确定要删除该任务?删除后不可恢复!', {icon: 3, title: '删除确认'}, function (index) {
                syncServer(deviceId, function (res, status) {
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
        },

        openModal: function (data,callback) {
        var layer = layui.layer;
        var synServer = function (data,callback) {
            $.ajax({
                url: data.queryUrl,
                type: "GET",
                cache:false,
                data: {id: data.queryId},
                success: function (res) {
                    var isJson = ReviewObj.isJsonString(res);
                    if(isJson){
                        var result = JSON.parse(res);
                        console.log(result);
                        if(result.status==false){
                            layer.msg(result.msg);
                        }
                    }else{
                        layer.open({
                            type: 1,
                            title: data.title,
                            area: data.area,
                            content: res,
                            resize:false,
                            scrollbar: true,
                            closeBtn: data.closeBtn,
                            shadeClose: data.shadeClose,
                            success: function (layerDom,index) {
                                layui.form.render();
                                callback(layerDom, index);
                            },
                            end: function () {
                                callback();
                            }
                        });
                    }
                },
                error: function (xmlHttpReq, error, ex) {
                }
            });
        }
        synServer(data,function (layerDom,index) {
            callback(layerDom, index);
        })
    }

    }
    /**
     * 对外暴露的方法
     */
    exports("itenderReview", {
        /**
         * 新增设备
         * @param data
         * @param callback
         */
        addReview: function (data,callback) {
            console.log(data);
            ReviewObj.addNewReview(data,callback);
        }

        /**
         * 打开弹出层
         * @param data
         * @param callback
         */
        ,openModal: function (data,callback) {
            console.log(data);
            ReviewObj.openModal(data,callback);
        }

        /**
         * 删除设备
         * @param deviceId
         * @param callback
         */
        ,deleteReview: function (reviewId, callback) {
            ReviewObj.deleteReview(reviewId, callback);
        }
        /**
         *
         * @param data
         * @param callback
         */
        ,updateReview: function (data,callback) {
            console.log(data);
            ReviewObj.updateReview(data,callback);
        }
    });

});

