/**
 * 设备管理模块
 */
layui.define(function (exports) {
    layui.use(["layer","form"], function () {

    });

    var DeviceObj = {


        addNewDevice: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/device/addDevice",
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
        ,updateDevice: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/device/updateDevice",
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
                    url: "/device/delDevice",
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
            layui.layer.confirm('您确定要删除该设备?删除后不可恢复!', {icon: 3, title: '删除确认'}, function (index) {
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
                    var isJson = DeviceObj.isJsonString(res);
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
                            skin: 'layui-layer-molv',
                            content: res,
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
    exports("itenderDevice", {
        /**
         * 新增设备
         * @param data
         * @param callback
         */
        addDevice: function (data,callback) {
            console.log(data);
            DeviceObj.addNewDevice(data,callback);
        }

        /**
         * 打开弹出层
         * @param data
         * @param callback
         */
        ,openModal: function (data,callback) {
            console.log(data);
            DeviceObj.openModal(data,callback);
        }

        /**
         * 删除设备
         * @param deviceId
         * @param callback
         */
        ,deleteDevice: function (deviceId, callback) {
            DeviceObj.deleteDevice(deviceId, callback);
        }
        /**
         * 更新设备
         * @param data
         * @param callback
         */
        ,updateDevice: function (data,callback) {
            console.log(data);
            DeviceObj.updateDevice(data,callback);
        }
    });

});

