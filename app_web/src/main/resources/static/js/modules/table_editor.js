/**
 * 定义表格编辑器
 */
layui.define(function (exports) {
    layui.use(['layer', 'util'], function () {

    })

    var TableEditor = {
        ue: null,
        generateId: function () {
            return layui.util.toDateString(new Date(), "yyyyMMddHHmmss");
        },
        generateWraper: function (id) {
            // var h = $(window).height() * 0.8
            // var w = $(window).width() * 0.8;
            var wrap = $('<div style="width: 100%;"></div>');
            // wrap.css("width",w).css("height",h);
            var html = '<div id="' + id + '" style="width:100%;height:100%;"></div>';
            wrap.append(html);
            return wrap;
        },
        //编辑器参数
        eidtorParams: ['undo', //撤销
            'redo', //重做
            'bold', //加粗
            'italic', //斜体
            'underline', //下划线
            'strikethrough', //删除线
            'selectall', //全选

            'removeformat', //清除格式
            'mergeright', //右合并单元格
            'mergedown', //下合并单元格
            'deleterow', //删除行
            'deletecol', //删除列
            'splittorows', //拆分成行
            'splittocols', //拆分成列
            'splittocells', //完全拆分单元格
            'deletecaption', //删除表格标题
            'inserttitle', //插入标题
            'mergecells', //合并多个单元格
            'edittable', //表格属性
            'edittd', //单元格属性
            // 'deletetable', //删除表格
            '|',
            'fontfamily', //字体
            'fontsize', //字号
            'paragraph', //段落格式
            'lineheight',//行间距

            'justifyleft', //居左对齐
            'justifyright', //居右对齐
            'justifycenter', //居中对齐
            'justifyjustify', //两端对齐
            'forecolor', //字体颜色
            'backcolor', //背景色
            '|',
            'source' //源码
        ],
        initEditor: function (id, defaultValue) {
            // TableEditor.appendElement(id);
            //实例化编辑器
            //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
            var editorH = $(window).height() - 130;
            TableEditor.ue = UE.getEditor(id, {
                initialFrameHeight: editorH,
                toolbars: [TableEditor.eidtorParams],
                autoHeightEnabled: false,
                allHtmlEnabled: true,
                enableAutoSave: false,
                autoSyncData: false
            });

            TableEditor.ue.ready(function () {
                TableEditor.ue.setContent(defaultValue);
            });
            TableEditor.ue.addListener('focus', function (type) {
                // TableEditor.focus();
            })
            TableEditor.ue.addListener('contentChange', function (type) {
                // TableEditor.contentChange();
            })
            id
        },
        open: function (defaultValue, callback) {
            var w = $(window).width() * 0.8;
            var h = $(window).height() * 0.8
            var id = TableEditor.generateId();
            var index = layui.layer.open({
                title: false,
                zIndex: 10055,
                type: 1,
                // area: [w + "px", h + "px"],
                content: TableEditor.generateWraper(id)[0].outerHTML,
                success: function (layero, index) {
                    TableEditor.initEditor(id, defaultValue);
                },
                btn: ['完成编辑'],
                yes: function (index, layero) {
                    var newValue = TableEditor.ue.getContent();
                    if (!newValue || !$(newValue).siblings("table")) {
                        newValue = defaultValue;
                    }
                    callback(newValue);
                    layui.layer.close(index);
                    TableEditor.ue.destroy();
                }
            });

            layui.layer.full(index);
        }
    }


    exports("tableEditor", {
        openTableEditor: function (defaultValue, callback) {
            defaultValue = defaultValue ? defaultValue : "";
            callback = callback && typeof callback == "function" ? callback : function (val) {

            }
            TableEditor.open(defaultValue, callback);
        }
    })
})