/**
 * 日志管理模块
 */
layui.define(function (exports) {
    layui.use(["layer","form"], function () {

    });

    var BookObj = {


        addNewBook: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/book/addBook",
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



        ,cancelBook: function (bookId, callback) {
            //同步到服务端
            var syncServer = function (bookId, callback) {
                var index = layui.layer.load(2);
                //TODO 异常处理
                $.ajax({
                    url: "/book/cancelBook",
                    type: "POST",
                    dataType: "json",
                    data: {bookId:bookId},
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
            layui.layer.confirm('您确定要取消该预订?', {icon: 3, title: '取消确认'}, function (index) {
                syncServer(bookId, function (res, status) {
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
                        var isJson = BookObj.isJsonString(res);
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
    exports("itenderBook", {
        /**
         * 新增预订
         * @param data
         * @param callback
         */
        addBook: function (data,callback) {
            console.log('add book : '+JSON.stringify(data));
            BookObj.addNewBook(data,callback);
        }
        /**
         * 打开弹出层
         * @param data
         * @param callback
         */
        ,openModal: function (data,callback) {
            console.log(data);
            BookObj.openModal(data,callback);
        }


        /**
         * 取消预订房间
         * @param bookId
         * @param callback
         */
        ,cancelBook: function (bookId, callback) {
            BookObj.cancelBook(bookId, callback);
        }



    });

});

