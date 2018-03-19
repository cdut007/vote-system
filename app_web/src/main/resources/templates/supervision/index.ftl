<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>综改区监督平台</title>
    <#include "../resource.ftl">
</head>
<style>
    .startedRoom {display: inline-block;background-image: url("/css/img/img_room_viewable.jpg"); border-radius: 6px; vertical-align: middle; width: 300px; line-height: 25px; padding: 20px 0; margin-right: -1px; margin-bottom: -1px;margin-top: 5px; border: 1px solid #e2e2e2; font-size: 14px; text-align: center; color: #fff; transition: all .3s; -webkit-transition: all .3s;}
    .startedRoom:hover {display: inline-block;background-image: url("/css/img/img_room_hover.jpg");border-radius: 8px; vertical-align: middle; width: 300px; line-height: 25px; padding: 20px 0; margin-right: -1px; margin-bottom: -1px;margin-top: 5px; border: 1px solid #e2e2e2; font-size: 14px; text-align: center; color: #fff; transition: all .3s; -webkit-transition: all .3s;}
    .notStartedRoom {display: inline-block;background-image: url("/css/img/img_room_unviewable.jpg");border-radius: 6px; vertical-align: middle; width: 300px; line-height: 25px; padding: 20px 0; margin-right: -1px; margin-bottom: -1px;margin-top: 5px; border: 1px solid #e2e2e2; font-size: 14px; text-align: center; color: #000; transition: all .3s; -webkit-transition: all .3s;}
</style>
<body>
<#include "../dashboard_top_menus.ftl">

<div class="layui-container">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>现场监督</legend>
    </fieldset>
    <div class="layui-form-item">
        <div class="searchTable">
            <div class="layui-inline">
                <label class="layui-form-label">时间范围</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input date" id="record_begin_time" placeholder="">
                </div>
                <div class="layui-form-mid">至</div>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input date" id="record_end_time" placeholder="">
                </div>
            </div>
            <div class="layui-inline">
                <form class="layui-form" action="">
                    <label class="layui-form-label">房间名</label>
                    <div class="layui-input-inline">
                        <select name="roomId" id="roomId" lay-verify="required" lay-filter="room_select" lay-search="">
                            <option value=""></option>
                            <#if roomList??>
                             <#list roomList as room>
                             <option value='${room.roomId!}'>${room.room!}</option>
                             </#list>
                            </#if>
                        </select>
                    </div>
                </form>
            </div>
            <button class="layui-btn" data-type="reload" id="search_book_record">查询</button>
        </div>
        <div class="layui-row">
            <div class="layui-col-md1 margin-top"></div>
            <div class="layui-col-md10 margin-top">
                <ul id="roomList">
                    <#if visibleRoomList??>
                    <#list visibleRoomList as openRoom>
                        <li class="startedRoom" onclick="javascript:view.goto('/supervision/startVideo?roomId=${openRoom.roomId!}')">
                            <div class="" style="margin-bottom: 20px">${openRoom.beginTime?string('yyyy-MM-dd HH:mm:ss')}~${openRoom.endTime?string('yyyy-MM-dd HH:mm:ss')}</div>
                            <#--<div><i class="layui-icon" style="font-size: 30px; color: #666;">&#xe68e;</i></div>-->
                            <div class="" style="margin-top: 78px">房间【${openRoom.room!}】</div>
                            <div>
                                <marquee direction="left"><span class="layui-badge layui-bg-green">正在进行</span>${openRoom.content!}</marquee>
                            </div>
                        </li>
                    </#list>
                    </#if>
                    <#if unvisibleRoomList??>
                        <#list unvisibleRoomList as closedRoom>
                        <li class="notStartedRoom">
                            <div class="" style="margin-bottom: 20px">${closedRoom.beginTime?string('yyyy-MM-dd HH:mm:ss')}~${closedRoom.endTime?string('yyyy-MM-dd HH:mm:ss')}</div>
                            <#--<div><i class="layui-icon" style="font-size: 30px; color: #666;">&#xe68e;</i></div>-->
                            <div class="" style="margin-top: 78px">房间【${closedRoom.room!}】</div>
                            <div>
                                <marquee direction="left"><span class="layui-badge layui-bg-black">暂未开始</span>${closedRoom.content!}</marquee>
                            </div>
                        </li>
                        </#list>
                    </#if>
                </ul>
            </div>
            <div class="layui-col-md1 margin-top"></div>
        </div>
    </div>
</div>


</body>
<script>
    layui.use(['laydate','form','itenderSupervision'], function() {
        var laydate = layui.laydate;
        var form = layui.form;
        var itenderSupervision = layui.itenderSupervision;
        
        form.render('select');
        laydate.render({
            elem: '#record_begin_time'
            ,type: 'datetime'
        });
        laydate.render({
            elem: '#record_end_time'
            ,type: 'datetime'
        });

        $("#search_book_record").click(function () {
            var roomId = $("#roomId").val();
            var beginTimeStr = $("#record_begin_time").val();
            var endTimeStr = $("#record_end_time").val();
            var beginTime = null;
            var endTime = null;
            if(beginTimeStr=="" || endTimeStr==""){

            }else{
                beginTime = Date.parse(new Date(beginTimeStr));
                endTime = Date.parse(new Date(endTimeStr));
            }

            var data = {
                beginTime: beginTime,
                endTime: endTime,
                roomId: roomId
            };

            if(data.endTime < data.beginTime){
                layer.msg("结束日期不能早于开始日期");
                return ;
            }

            itenderSupervision.searchRoom(data,"roomList",function (res) {
                
            });
            return false;
        });
    });
</script>


</html>