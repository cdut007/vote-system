/**
 * 招标编辑器表单控件
 */
layui.define(function (exports) {
    layui.use(['layer'], function () {
    })

    var chooseItemLayer = '<div class="layui-fluid" style="margin-top: 20px;">\n' +
        '    <form class="layu-form" action="javascript:void(0);">\n' +
        '        <div class="layui-form">\n' +
        '            <div class="layui-form-item">\n' +
        '                <div class="layui-inline">\n' +
        '                    <button class="layui-btn layui-btn-sm add-item">添加选项</button>\n' +
        '\n' +
        '                </div>\n' +
        '            </div>\n' +
        '            <div class="layui-form-item">\n' +
        '                <div class="layui-inline">\n' +
        '                    <div class="layui-input-inline" style="width: 80px;">是否选中</div>\n' +
        '                    <div class="layui-input-inline">选项值</div>\n' +
        '                </div>\n' +
        '\n' +
        '            </div>\n' +
        '            <div class="item-wrap"></div>\n' +
        '            <div class="layui-form-item">\n' +
        '                <button class="layui-btn layui-btn-fluid" style="width: 100%" lay-submit\n' +
        '                        lay-filter="confirmChooseItems">确认\n' +
        '                </button>\n' +
        '            </div>\n' +
        '        </div>\n' +
        '    </form>\n' +
        '</div>';

    function createChooseItem($itemWrap) {
        var $inputs = $itemWrap.find(".layui-input");
        var index = $inputs ? $inputs.length : 0;
        var $item = $('<div class="layui-form-item">\n' +
            '                <div class="layui-inline" style="width: 100%;">\n' +
            '                    <div class="layui-input-inline" style="width: 80px;text-align: center;">\n' +
            '                        <input type="radio" name="item_radio" title=" ">\n' +
            '                    </div>\n' +
            '                    <div class="layui-input-inline" style="width: 300px;">\n' +
            '                        <input type="text" class="layui-input" name="item_input_' + index + '">\n' +
            '                    </div>\n' +
            '                    <div class="layui-input-inline" style="width: 50px;">\n' +
            '                        <button class="layui-btn layui-btn-danger item-del">删除</button>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>'
        )
        $itemWrap.append($item);
        layui.form.render("radio");

        var $delBtn = $item.find(".item-del");
        $delBtn.off("click").on("click", function () {
            $item.remove();
        })
    }

    var createItems = function (callback) {
        var index = layui.layer.open({
            title: "新建选项",
            type: 1,
            area: '500px',
            content: chooseItemLayer,
            success: function (layero, index) {
                var $addBtn = layero.find(".add-item");
                var $itemWrap = layero.find(".item-wrap");
                //初始化一个选项
                createChooseItem($itemWrap);

                $addBtn.off("click").on("click", function () {
                    createChooseItem($itemWrap);
                });

                layui.form.on('checkbox', function (data) {
                    console.log(data.elem); //得到checkbox原始DOM对象
                    console.log(data.elem.checked); //是否被选中，true或者false
                    console.log(data.value); //复选框value值，也可以通过data.elem.value得到
                    console.log(data.othis); //得到美化后的DOM对象
                });

                layui.form.on("submit(confirmChooseItems)", function (data) {
                    console.log(data);
                    var fields = data.field;
                    var $chooseWrap = $("<div class='choose-wrap'></div>");
                    for (var key in fields) {
                        var val = fields[key];
                        var $chooseItem = $("<input type='checkbox' class='choose-item'><span>" + val + "</span>");
                        $chooseWrap.append($chooseItem);
                    }

                    if (callback && typeof callback == "function") {
                        callback($chooseWrap[0].outerHTML);
                    }

                    layui.layer.close(index);
                    return false;
                })
            }
        })
    }

    exports("formEditorCheckbox", {
        openChooseItems: function (callback) {
            createItems(callback);
        }
    })


})