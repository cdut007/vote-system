/**
 * 日志管理模块
 */
layui.define(function (exports) {
    layui.use(["layer","form"], function () {

    });

    var RoomObj = {


        addNewRoom: function (data,callback) {
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
        ,updateRoom: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/room/updateRoom",
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


        ,deleteRoom: function (roomId, callback) {
            //同步到服务端
            var syncServer = function (roomId, callback) {
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
            layui.layer.confirm('您确定要删除该房间?删除后不可恢复!', {icon: 3, title: '删除确认'}, function (index) {
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
        },

        openModal: function (data,callback) {
            var layer = layui.layer;
            var synServer = function (data,callback) {
                $.ajax({
                    url: data.queryUrl,
                    type: "GET",
                    data: {id: data.queryId},
                    success: function (res) {
                        var isJson = RoomObj.isJsonString(res);
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
    exports("itenderRoom", {
        /**
         * 新增房间
         * @param data
         * @param callback
         */
        addRoom: function (data,callback) {
            console.log(data);
            RoomObj.addNewRoom(data,callback);
        }
        /**
         * 打开弹出层
         * @param data
         * @param callback
         */
        ,openModal: function (data,callback) {
            console.log(data);
            RoomObj.openModal(data,callback);
        }


        /**
         * 删除房间
         * @param roomId
         * @param callback
         */
        ,deleteRoom: function (roomId, callback) {
            RoomObj.deleteRoom(roomId, callback);
        }

        /**
         * 更新房间
         * @param data
         * @param callback
         */
        ,updateDevice: function (data,callback) {
            console.log(data);
            RoomObj.updateRoom(data,callback);
        }

    });

});

