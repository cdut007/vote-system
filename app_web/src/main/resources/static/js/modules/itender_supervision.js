/**
 * 现场监控模块
 */
layui.define(function (exports) {

    var SupervisionObj = {
        /******************************************************功能变量、方法*****************************************/
        sdk_viewer : null, // 控件（插件）对象
        isLogin : false,
        StreamType : {  //流类型
            LIVE: 0,    //实况流
            PICTRUE: 1, //抓拍流（jpeg）
            MJPEG: 2,    //照片流
            IMAGE_TYPE_PLATE: 3, //过车图片流
            PIC_VIEW: 4 //图片查看
        },
        PtzCmd :{
            TILTUP:        	     0x0402,       // 向上
            TILTDOWN:            0x0404,       // 向下
            PANRIGHT:            0x0502,       // 向右
            PANLEFT:             0x0504,       // 向左
            LEFTUP:              0x0702,       // 左上
            LEFTDOWN:            0x0704,       // 左下
            RIGHTUP:             0x0802,       // 右上
            RIGHTDOWN:           0x0804,       // 右下
            ALLSTOP:             0x0901        // 全停命令字
        },
        PresetCmd : {
            SET_PRESET:           0,            // 设置预置位
            CLE_PRESET:           1,            // 清除预置位
            GOTO_PRESET:          2             // 转到预置位
        },
        LiveStream : {
            LIVE_STREAM_INDEX_MAIN:    0,       // 主流
            LIVE_STREAM_INDEX_AUX:     1,       // 辅流
            LIVE_STREAM_INDEX_THIRD:   2        // 第三流
        },
        Protocal : {
            TRANSPROTOCAL_RTPTCP:      1,       //TCP
            TRANSPROTOCAL_RTPUDP:      2        // UDP
        },
        MediaFileFormat : {
            MEDIA_FILE_MP4:            0,        // mp4格式的媒体文件
            MEDIA_FILE_TS:             1         // TS格式的媒体文件  TS media file */
        },
        PictureFormat : {
            PICTURE_BMP:               0,        // 图片格式为bmp格式
            PICTURE_JPG:               1         // 图片格式为jpg格式
        },
        EventType :{
            ALL:                       0,        // 所有的存储
            MOTIONDETECTION:           4,        // 运动检测事件存储
            DIGITALINPUT:              5,        // 数字输入事件存储
            VIDEOLOSS:                 7,        // 视频丢失事件存储
            INVALID:                   0xFF      // 无效值
        },
        PlayControl :{
            NETDEV_PLAY_CTRL_PLAY:             0,           /* 开始播放  Play */
            NETDEV_PLAY_CTRL_PAUSE:            1,           /* 暂停播放  Pause */
            NETDEV_PLAY_CTRL_RESUME:           2,           /* 恢复播放  Resume */
            NETDEV_PLAY_CTRL_GETPLAYTIME:      3,           /* 获取播放进度  Obtain playing time */
            NETDEV_PLAY_CTRL_SETPLAYTIME:      4,           /* 设置播放进度  Configure playing time */
            NETDEV_PLAY_CTRL_GETPLAYSPEED:     5,           /* 获取播放速度  Obtain playing speed */
            NETDEV_PLAY_CTRL_SETPLAYSPEED:     6,           /* 设置播放速度  Configure playing speed */
            NETDEV_PLAY_CTRL_SINGLE_FRAME:     7            /* 设置单帧播放  Configure single frame playing speed */
        },
        resultList : [],
        DeviceHandle : -1,
        CloudHandle : -1,
        /**********************************************************************************************************/

        /**
         * 初始化监控数据
         * @param data
         * @param callback
         */
        initSupervisionData: function (data,callback) {
            var syncServer = function (data, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/supervision/roomDevList",
                    type: "GET",
                    dataType: "json",
                    contentType: "application/json",
                    data: {
                        roomId : data.roomId
                    },
                    success: function (res) {
                        console.log(res);
                        layui.layer.close(index);
                        $.each(res.data, function(index, dev){
                            var initData ={
                                id: "player_"+index,
                                container: "playerContainer_"+index,
                                name: "sdk_viewer_"+index,
                                dev: {
                                    devIP: dev.ip,
                                    devPort: dev.port,
                                    username: dev.account,
                                    password: dev.password
                                }
                            };
                            $("#"+data.container).append(
                                "<li class='video'>" +
                                "<div id=playerContainer_"+index+" style='height: 1px;'>"+dev.name+"</div>" +
                                "</li>"
                            );
                            SupervisionObj.init(initData);
                        });
                    },
                    error: function (xmlHttpReq, error, ex) {
                        layui.layer.close(index);
                    }
                });
            };
            syncServer(data,function (res,status) {
                if (typeof callback == "function") {
                    callback(res, status);
                }
            });
        },

        /**
         * 初始化控件
         */
        init: function (data) {
            var cfg = {
                id: data.id,                     //加载的activex控件id
                container: data.container,       //控件/插件的父节点
                name: data.name,                 //实例对象的名称，用于设置napi上报事件的入参
                events: "",                      //控件事件map
                stPortInfo: {
                    szDeviceIp: "",
                    szLocalIp: ""
                },                                //端口信息
                stUserInfo: {                     //用户登录信息
                    User: "",
                    Password: ""
                },
                maxWnd: 64,                       //控件动态创建窗格的个数，不小于最大通道路数,默认64路 (可选)
                focusColor: 'ffcc00',             //窗格获得焦点时的边框颜色，注意：参数形如'xxxxxx'，为颜色的16进制，以b g r 顺序，而不是r g b (可选)
                unfocusColor: '747d7d',           //窗格未获得焦点时的边框颜色，注意：参数形如'xxxxxx'，为颜色的16进制，以b g r 顺序，而不是r g b (可选)
                backgColor: '373737'              //控件背景色，注意：参数形如'xxxxxx'，为颜色的16进制，以b g r 顺序，而不是r g b (可选)
            };

            var initPlayer = function (cfg) {
                var Main = {
                    EventMap : ""
                };
                Main.EventMap = (function(){
                    var closure = {
                        formatExceotionCode: function(u32ExceptionCode){
                            u32ExceptionCode = u32ExceptionCode.split(',');
                            return parseInt(u32ExceptionCode, 10);
                        },
                        formatTaskNo: function(u32Task_No){
                            u32Task_No = u32Task_No.split(',');
                            return parseInt(u32Task_No, 10);
                        }
                    };
                    return {
                        /* 告警事件上报 */
                        __200:function(strAlarmInfo){
                            //alert(strAlarmInfo);
                        }
                    };
                })();
                cfg["events"] = Main.EventMap;
                SupervisionObj.sdk_viewer = new Utils.Player(cfg);                                       //初始化控件
                var retcode = SupervisionObj.sdk_viewer.execFunction("NetSDKSetPlayWndNum" , 1);         //分屏
                if(0!=retcode){
                    layui.layer.alert("实况窗口实例化失败!");
                }
            };
            initPlayer(cfg);
            SupervisionObj.login(data.container,data.dev);
            if(SupervisionObj.isLogin){
                SupervisionObj.startVideo();
            }
        },
        /**
         * 登录
         * @param container 控件父节点
         * @param dev 设备
         */
        login: function (container,dev) {
            var SDKRet = SupervisionObj.sdk_viewer.execFunction("NETDEV_Login", dev.devIP, dev.devPort, dev.username, dev.password);
            if(-1 == SDKRet) {
                console.error("登录摄像机失败！检查IP，及登录名和密码！");
                layer.msg('实况播放失败！', {icon: 5});
            }else{
                var result = JSON.parse(SDKRet);
                SupervisionObj.DeviceHandle = result.UserID;
                $("#"+container).css("height", "600px");
                SupervisionObj.isLogin = true;
                SupervisionObj.logRecord("startVideo");//记录开始预览实况视频
            }
        },
        /**
         * 注销
         */
        logout: function () {
            SupervisionObj.sdk_viewer.execFunction("NETDEV_Logout", SupervisionObj.DeviceHandle);
            SupervisionObj.sdk_viewer.execFunction("NETDEV_Cleanup", SupervisionObj.DeviceHandle);
            SupervisionObj.DeviceHandle = -1;
            SupervisionObj.isLogin = false;
            console.log("NETDEV Logout Sucessfull "+SupervisionObj.DeviceHandle);
            SupervisionObj.logRecord("exitVideo");//记录退出预览实况视频
        },
        /**
         * 启流，开启视频流，开启实况视频
         */
        startVideo: function () {
            var dataMap = {
                dwChannelID:1,
                dwStreamType:SupervisionObj.LiveStream.LIVE_STREAM_INDEX_MAIN,
                dwLinkMode:SupervisionObj.Protocal.TRANSPROTOCAL_RTPTCP,
                dwFluency:0
            }

            var jsonStr = JSON.stringify(dataMap);
            var ResourceId = SupervisionObj.sdk_viewer.execFunction("NetSDKGetFocusWnd");

            var retcode = SupervisionObj.sdk_viewer.execFunction("NETDEV_RealPlay", parseInt(ResourceId), SupervisionObj.DeviceHandle, jsonStr);
            if (0 != retcode) {
                layer.msg('播放实况失败！', {icon: 5});
            } else {

            }
        },
        /**
         * 停流，停止视频流，停止实况视频
         */
        stopVideo: function() {
            var ResourceId = SupervisionObj.sdk_viewer.execFunction("NetSDKGetFocusWnd");
            var retcode = SupervisionObj.sdk_viewer.execFunction("NETDEV_StopRealPlay", parseInt(ResourceId));  //关闭视频流
            if (0 != retcode) {
                layer.msg('停流失败！', {icon: 5});
            }
            else {
            }
        },
        /**
         * 释放资源
         */
        cleanUp: function () {
            SupervisionObj.sdk_viewer.execFunction("NETDEV_Cleanup", SupervisionObj.DeviceHandle);
        },

        /**
         * 记录操作日志
         */
        logRecord: function (option) {
            $.get("/supervision/logRecord?option="+option,function (data) {
                console.log("Record success : "+data.status);
            });
        },

        searchRoom: function (data,container,callback) {
            var syncServer = function (data,container, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: '/supervision/searchRoom',
                    type: "GET",
                    dataType: "json",
                    data: data,
                    success: function (res) {
                        console.log(res);
                        $("#"+container).empty();
                        if(res.data!=null){
                            $.each(res.data, function(index, room){
                                var liCss = "";
                                var spanCss = "";
                                var status = "";
                                var onclinck = "";
                                var hasRoom = true;
                                if(room.status=="cancel" || room.status=="expired"){
                                    hasRoom = false;
                                }else if(room.status=="ordered"){
                                    liCss = "notStartedRoom";
                                    spanCss = "layui-bg-black";
                                    status = "暂未开始";
                                }
                                else if(room.status=="occupy"){
                                    liCss = "startedRoom";
                                    spanCss ="layui-bg-green";
                                    status = "正在进行";
                                    onclinck ="onclick=\"javascript:view.goto('/supervision/startVideo?room="+room.roomId+"')\"";
                                }
                                if(hasRoom){
                                    $("#"+container).append(
                                        "<li class="+liCss+" "+onclinck+">\n" +
                                        "<div style=\"margin-bottom:20px\">"+room.bookTime+"</div>\n" +
                                        "<div><i class=\"layui-icon\" style=\"font-size: 30px; color: #666;\">&#xe68e;</i></div>\n" +
                                        "<div style=\"margin-top:20px\">房间【"+room.room+"】</div>\n" +
                                        "<div>\n" +
                                        "<marquee direction=\"left\"><span class=\"layui-badge "+spanCss+"\">"+status+"</span>"+room.content+"</marquee>\n" +
                                        "</div>\n" +
                                        "</li>");
                                }
                            });
                        }
                        layui.layer.close(index);
                        callback(res);
                    },
                    error: function (xmlHttpReq, error, ex) {
                        layui.layer.close(index);
                    }
                })

            }
            syncServer(data,container,function (res) {
                callback(res);
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
    };
    /**
     * 对外暴露的方法
     */
    exports("itenderSupervision", {
        /**
         * 开始监控
         * @param data
         * @param callback
         */
        beginSupervise: function (data,callback) {
            console.log(data);
            SupervisionObj.initSupervisionData(data,callback);
        },
        /**
         * 初始化
         * @param data
         * @param callback
         */
        init: function (data,callback) {
            console.log(data);
            SupervisionObj.init(data,callback);
        },
        /**
         * 注销
         */
        logout: function () {
            SupervisionObj.logout();
        },

        searchRoom: function (data,container,callback) {
            console.log(data);
            SupervisionObj.searchRoom(data,container,callback);
        }

    });

});