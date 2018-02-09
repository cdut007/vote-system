/**
 * 设备管理模块
 */
layui.define(function (exports) {
    layui.use(["layer"], function () {

    });

    var DeviceObj = {
        addNewDevice: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/device/addDevice",
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
        ,updateDevice: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/device/updateDevice",
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
        ,deleteDevice: function (deviceId, callback) {
            //同步到服务端
            var syncServer = function (deviceId, callback) {
                var index = layui.layer.load(2);
                //TODO 异常处理
                $.ajax({
                    url: "/device/delDevice",
                    type: "DELETE",
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
            Devicebj.addNewDevice(data,callback);
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
            PrivilegeObj.updateDevice(data,callback);
        }
    });

});

