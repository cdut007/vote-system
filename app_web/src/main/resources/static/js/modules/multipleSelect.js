/**
 * 下拉多选
 */
layui.define(['form','jquery'], function(exports) {
    var form = layui.form, $ = layui.jquery;


    multipleSelect = function () {
        /*
            1、说明:multipleSelect为添加复选框 支持所的版本
            2、添加样式
            .layui-form select[multiple] + .layui-form-select dd { padding: 0;}
            .layui-form select[multiple] + .layui-form-select .layui-form-checkbox[lay-skin="primary"] {width:100%; text-align:left;}
            .layui-form select[multiple] + .layui-form-select .layui-form-checkbox[lay-skin="primary"] span {float: left; padding-left:30px;}
            .layui-form select[multiple] + .layui-form-select .layui-form-checkbox[lay-skin="primary"] i {position: absolute;left:10px;top: 0;}
            .layui-form select[multiple] + .layui-form-select dd.layui-disabled{ padding-left:10px;}
            .multiSelect{ line-height:normal; height:auto; padding:4px 10px; overflow:hidden;min-height:38px; margin-top:-38px; left:0; z-index:99;position:relative;background:none;}
            .multiSelect a{ padding:2px 5px; background:#908e8e; border-radius:2px; color:#fff; display:block; line-height:20px; height:20px; margin:2px 2px 2px 0; float:left;}
            .multiSelect a span{ float:left;}
            .multiSelect a i{ float:left; display:block; margin:2px 0 0 2px; border-radius:2px; width:8px; height:8px; background:url(/Template/image/close.png) no-repeat center; background-size:65%; padding:4px;}
            .multiSelect a i:hover{ background-color:#545556;}

            3、加载和宣染顺序
              $("select[name='baseInfo.marriage']").val(["666","999"]);//赋值
              form.render(); //宣染select
              multipleSelect.render();//宣染带有multiple="multiple"的select变成带checkbox的
            4、取值，直接from 或 $('#div').val()



        */

    }
    ,multipleSelect.prototype.render = function () {
        $(".layui-form select").each(function (index, select) {
            var $this = $(this);
            var disabled = this.disabled;
            var $select = $this.next(".layui-form-select");
            var $dl = $select.find("dl");
            var $selectTitle = $select.find(".layui-select-title");
            var $input = $selectTitle.find("input");
            var optionsFirst = select.options[0];
            var placeholder = optionsFirst ? (optionsFirst.value ? '请选择' : (optionsFirst.innerHTML || '请选择')) : '请选择';
            var html = [], select_value = [];

            //select原始选中参数
            if (typeof $this.attr('multiple') && typeof $this.attr('multiple') === 'string') {
                select_value = $(select).val();
            }
            //我们只考虑多选，其它的已经由layui考虑了
            if (typeof $(this).attr('multiple') && typeof $(this).attr('multiple') === 'string') {
                $input.val(placeholder);//默认
                $dl.empty();// .layui-form-select dl 为空
                //替代元素
                /****************追加标题开始********************************/
                $selectTitle.empty();//把之前的清空
                var TitleHtml = '<input type="text" class="layui-input" placeholder="' + placeholder + '"><div class="layui-input multiSelect" >';
                if (select_value != null && select_value != undefined && select_value.length != 0) {
                    layui.each(select.options, function (index, item) {
                        if (index === 0 && !item.value) {
                        }
                        else {
                            for (var checkedVal = 0; checkedVal < select_value.length; checkedVal++) {
                                if (select_value[checkedVal] == item.value) {
                                    TitleHtml += '<a href="javascript:;"><span lay-value=' + item.value + '>' + item.innerHTML + '</span><i></i></a>';
                                }
                            }
                        }
                    });
                }
                TitleHtml += '<i class="layui-edge"></i></div>';
                $selectTitle.append(TitleHtml);
                /****************追加标题结束********************************/
                layui.each(select.options, function (index, item) {
                    if (index === 0 && !item.value) {
                        html.push('<dd lay-value="" class="layui-select-tips ">' + (item.innerHTML || '请选择') + '</dd>');
                    } else {
                        //选中的参数赋值
                        if (select_value != null && select_value != undefined && select_value.length != 0) {
                            for (var checkedVal = 0; checkedVal < select_value.length; checkedVal++) {
                                //这里的select_value 是上面select的集合
                                if (select_value[checkedVal] == item.value) {
                                    html.push('<dd lay-value="' + item.value + '">' + '<input type="checkbox" ' + (item.disabled ? "disabled" : "") + ' checked  title="' + item.innerHTML + '" lay-skin="primary"></dd>');
                                    return false;
                                }
                            }
                        }
                        html.push('<dd lay-value="' + item.value + '">' + '<input type="checkbox" ' + (item.disabled ? "disabled" : "") + '  title="' + item.innerHTML + '" lay-skin="primary"></dd>');
                    }
                });
                html.length === 0 && html.push('<dd lay-value="" class="layui-disabled">没有选项</dd>');
                html.join('');//去除顿号
                $dl.append(html);
                form.render("checkbox");

                //我们考虑追加事件
                var valueStr = select_value || [];//设置默认值
                $select.delegate('.layui-select-title', 'click', function (e) { //点击 layui-select-title 里面包含input

                    if (!disabled) {//禁用不下拉
                        //重复点击
                        $select.removeClass("layui-form-selected");
                        $select.addClass("layui-form-selected");
                        e.stopPropagation();
                    }
                }).delegate('dl dd', 'click', function (e) {
                    e.stopPropagation();

                }).delegate('dl dd .layui-form-checkbox', 'click', function (e) { //防止冒泡事件
                    var othis = $(this);//这里指dd
                    var lay_value = othis.parents('dd').attr('lay-value');
                    var multiSelect = $selectTitle.find(".multiSelect");
                    if (othis.parents('dd').hasClass('layui-disabled')) return false;
                    //判断dd名下的checkbox
                    if (othis.hasClass('layui-form-checked')) {
                        //判断一下
                        multiSelect.html(multiSelect.html() + "<a href='javascript:;'><span lay-value=" + lay_value + ">" + othis.find("span").text() + "</span><i></i></a>");
                        valueStr.push(lay_value);
                    } else {
                        multiSelect.find("a").each(function () {
                            if ($(this).find("span").attr('lay-value') == lay_value) {
                                $(this).remove();//删除a
                                for (var i = 0; i < valueStr.length; i++) {
                                    if (valueStr[i] == lay_value) {
                                        valueStr.splice(i, 1);
                                    }
                                }
                            }
                        })
                    }
                    $(select).val(valueStr).removeClass('layui-form-danger');//解决select赋值问题
                    e.stopPropagation();
                    //多选删除
                }).delegate(".multiSelect a i", "click", function (e) {
                    var _this = $(this);
                    e.stopPropagation();
                    $select.removeClass("layui-form-selected");
                    $select.find("dd").each(function () {
                        var othis = $(this);
                        var lay_value = $(this).attr('lay-value');
                        if (lay_value == _this.siblings("span").attr('lay-value')) {
                            othis.find("input").removeAttr("checked");
                            othis.find(".layui-form-checkbox").removeClass("layui-form-checked");
                            for (var i = 0; i < valueStr.length; i++) {
                                if (valueStr[i] == lay_value) {
                                    valueStr.splice(i, 1);
                                }
                            }
                            _this.parent("a").remove();
                        }
                    })
                    $(select).val(valueStr);
                    //全部删除显示下拉框
                    if ($select.find(".multiSelect a").length != 0) {
                        $select.removeClass("layui-form-selected");
                    } else {
                        $select.addClass("layui-form-selected");
                    }
                });
            }
        })
    }


    exports("multipleSelect",{
        render: function () {
            multipleSelect.prototype.render();
        }
    });
    
});
