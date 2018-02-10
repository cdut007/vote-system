/**
 * 用户模块
 */
layui.define(function (exports) {
    layui.use(["layer","element"], function () {

    });

    var UserObj = {
        userLogin: function(data){
            var index = layer.load(2);
            $.ajax({
                url:"/management/user/login",
                type:"POST",
                data:data,
                success:function(result){
                    layui.layer.close(index);
                    if(result.status == true){
                        var indexFrame = parent.layer.getFrameIndex(window.name);//关闭登录弹出层
                        parent.layer.close(indexFrame);
                        view.goto('/dashboard');
                    }else{
                        layui.layer.msg('登录失败，用户名或密码错误！', {icon: 5});
                    }
                },
                error: function (xmlHttpReq, error, ex) {
                    layui.layer.close(index);
                }
            });
        },

        userLogout: function () {
            var syncServer = function (callback) {
                $.ajax({
                    url:"/management/user/logout",
                    type:"GET",
                    success:function(result){
                        if(result.status == true){
                           callback(result,true);
                        }else{
                            callback(result,false);
                        }
                    },
                    error: function (xmlHttpReq, error, ex) {

                    }

                });
            }

            layui.layer.confirm('您确定要退出!', {icon: 3, title: '退出确认'}, function (index) {
                syncServer(function (res, status) {
                    layui.layer.close(index);
                    if(status){
                        view.goto('/');
                    }else{
                        layer.msg('系统繁忙,请稍后再试！', {icon: 5});
                    }
                })
            });
        }

        ,addNewTab: function(id,uri,title,filter) {

            console.log(id+""+uri+""+title+""+filter);
            //服务端获取页面
            var syncServer = function (url, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: url,
                    type:"GET",
                    success: function (res) {
                        layui.layer.close(index);
                        callback(res,true);
                    },
                    error: function (xmlHttpReq, error, ex) {
                        layui.layer.close(index);
                    }
                })
            }

            syncServer(uri, function (data, status) {
                if(status){
                    layui.element.tabAdd(filter, {//添加新Tap
                        title: title
                        ,content: data
                        ,id: id
                    });
                    layui.element.tabChange(filter, id); //选中新Tap
                }else{
                    layui.layer.msg('获取数据失败！', {icon: 5});
                }
            })
        }

        ,openModal: function (data,callback) {
            var layer = layui.layer;
            var synServer = function (data,callback) {
                $.ajax({
                    url: data.queryUrl,
                    type: "GET",
                    data: {id: data.queryId},
                    success: function (res) {
                        var isJson = UserObj.isJsonString(res);
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

        ,addUser: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: '/management/user/register',
                    type: "POST",
                    dataType: "json",
                    data: data,
                    success: function (res) {
                        layui.layer.close(index);
                        callback(res, res.status);
                    },
                    error: function (xmlHttpReq, error, ex) {
                        layui.layer.close(index);
                    }
                })

            }
            syncServer(data,function (res,status) {
                callback(res,status);
            })
        }

        ,deleteUser: function (data, callback) {
            //同步到服务端
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                //TODO 异常处理
                $.ajax({
                    url: "/management/user/delUser",
                    type: "POST",
                    data: {userId:data.userId,operator:data.operator},
                    dataType: "json",
                    success: function (res) {
                        layui.layer.close(index);
                        callback(res, res.status);
                    },
                    error: function (xmlHttpReq, error, ex) {
                        layui.layer.close(index);
                    }
                })
            }

            //删除确认窗口
            layui.layer.confirm('您确定要冻结该用户？', {icon: 3, title: '确认'}, function (index) {
                syncServer(data, function (res, status) {
                    layui.layer.close(index);
                    callback(res, status);
                })
            });
        }
        ,updateUser: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: data.url,
                    type: "POST",
                    dataType: "json",
                    data: data.formData,
                    success: function (res) {
                        layui.layer.close(index);
                        callback(res, res.status);
                    },
                    error: function (xmlHttpReq, error, ex) {
                        layui.layer.close(index);
                        callback(error, false);
                    }
                })

            }
            syncServer(data,function (res,status) {
                callback(res,status);
            })
        }
        ,editUserRole: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: '/management/role/authUser',
                    type: "POST",
                    dataType: "json",
                    data: data,
                    traditional : true,
                    success: function (res) {
                        layui.layer.close(index);
                        callback(res, res.status);
                    },
                    error: function (xmlHttpReq, error, ex) {
                        layui.layer.close(index);
                        callback(error, false);
                    }
                })

            }
            syncServer(data,function (res,status) {
                callback(res,status);
            })
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
    exports("itenderUser", {
        /**
         * 用户登录
         * @param data
         */
        userLogin: function (data) {
            UserObj.userLogin(data);
        }

        /**
         * 用户注销
         * @param callback
         */
        ,userLogout: function () {
            UserObj.userLogout();
        }

        /**
         * 打开弹出层
         * @param data
         * @param callback
         */
        ,openModal: function (data,callback) {
            console.log(data);
            UserObj.openModal(data,callback);
        }

        /**
         * 添加用户
         * @param data
         * @param callback
         */
        ,addNewUser: function (data,callback) {
            UserObj.addUser(data,callback);
        }

        /**
         * 删除用户
         * @param templateId
         * @param callback
         */
        ,deleteUser: function (userId, callback) {
            UserObj.deleteUser(userId, callback);
        }

        /**
         * 新建标签页
         * @param id
         * @param uri 标签页uri
         * @param title 导航栏标题
         * @param filter
         */
        ,addNewTab: function (id,uri,title,filter) {
            UserObj.addNewTab(id,uri,title,filter);
        }

        /**
         * 更新用户信息
         * @param data
         * @param callback
         */
        ,updateUser: function (data,callback) {
            UserObj.updateUser(data,callback);
        }

        /**
         * 给用户设置角色
         * @param data
         * @param callback
         */
        ,editUserRole: function (data,callback) {
            UserObj.editUserRole(data,callback);
        }
    });

});

