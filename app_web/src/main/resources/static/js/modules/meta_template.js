/**
 扩展一个layui模块
 元模板模块
 **/

layui.define(function (exports) { //提示：模块也可以依赖其它模块，如：layui.define('layer', callback);
        layui.use(["layer", "form", 'util', 'element', 'documentTree'], function () {
            var DocumentTree = layui.documentTree;

            /**
             * 元模板对象
             * @type {{deleteMetaTemplate: deleteMetaTemplate}}
             */
            var MetaTemplateObj = {
                updateTemplateNameTmp: function (defaultValue) {
                    var val = defaultValue ? defaultValue : "";
                    return '<form class="layui-form" style="margin-top: 20px;">\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <div class="layui-inline">\n' +
                        '            <label class="layui-form-label" style="width: 60px;">模板名称</label>\n' +
                        '            <div class="layui-input-inline" style="width: 300px;">\n' +
                        '                <input type="text" class="layui-input" name="templateName" placeholder="请输入模板名称"\n' +
                        '                       lay-verify="required" lay-verType="tips" value="' + val + '">\n' +
                        '            </div>\n' +
                        '            <div class="layui-input-inline" style="width: 80px;">\n' +
                        '                <button class="layui-btn" lay-submit lay-filter="updateTemplateConfirm">确定</button>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</form>';
                },
                /**
                 * 更新模板名称
                 * @param templateId
                 * @param templateName
                 * @param callback
                 */
                updateTemplateName: function (templateId, defaultValue, callback) {
                    var syncTemplateNameToServer = function (templateId, templateName, callback) {
                        $.ajax({
                            url: "/meta/template/name",
                            type: "PATCH",
                            dataType: "json",
                            data: {templateId: templateId, templateName: templateName},
                            success: function (res) {
                                callback(res);
                            },
                            error: function (xmlHttpRequest, errMsg, ex) {
                                //TODO 异常处理
                                // errorCallback(xmlHttpRequest);
                            }
                        })
                    }

                    //打开弹窗
                    var index = layui.layer.open({
                        title: "修改元模板名称",
                        type: 1,
                        area: '500px',
                        content: MetaTemplateObj.updateTemplateNameTmp(defaultValue)
                    });

                    //提交表单事件
                    layui.form.on('submit(updateTemplateConfirm)', function (data) {
                        //获取所填的值
                        var templateName = data.field.templateName;

                        //关闭弹窗
                        layui.layer.close(index);
                        //同步节点到服务端
                        syncTemplateNameToServer(templateId, templateName, function (res) {
                            if (typeof callback == "function") {
                                callback(templateName);
                            }
                        });

                        return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                    });
                },
                /**
                 * 删除元模板
                 * @type {string}
                 */
                deleteMetaTemplate: function (templateId, callback) {
                    //同步到服务端
                    var syncServer = function (templateId, callback) {
                        var index = layui.layer.load(2);
                        //TODO 异常处理
                        $.ajax({
                            url: "/meta/template?templateId=" + templateId,
                            type: "DELETE",
                            dataType: "json",
                            success: function (res) {
                                layui.layer.close(index);
                                callback(res, true);
                            },
                            error: function (xmlHttpReq, error, ex) {
                                layui.layer.close(index);
                                if (xmlHttpReq.status == 400) {
                                    var errObj = xmlHttpReq.responseJSON;
                                    if (errObj.code == "100600") {
                                        layui.layer.alert('该元模板含有子项，不能删除!');
                                        callback(errObj, false);
                                    }
                                }

                            }
                        })

                    }

                    //删除确认窗口
                    layui.layer.confirm('您确定要删除该项?删除后不可恢复!', {icon: 3, title: '删除确认'}, function (index) {
                        syncServer(templateId, function (res, status) {
                            layui.layer.close(index);
                            if (typeof callback == "function") {
                                callback(res, status);
                            }

                        })
                    });
                }
            }


            /**
             * 操作栏
             * @type {{htmlTmp: htmlTmp, addItemInner: addItemInner, deleteItemInner: deleteItemInner}}
             */
            var MetaTemplateItemObj = {
                addItemHtmlTmp: function () {
                    return '<form class="layui-form" style="margin-top: 20px;">\n' +
                        '        <div class="layui-form-item">\n' +
                        '            <label class="layui-form-label">内容类型</label>\n' +
                        '            <div class="layui-input-block">\n' +
                        '                <input type="radio" name="itemContentType" value="text" title="文本类型" checked>\n' +
                        '                <input type="radio" name="itemContentType" value="file" title="文件类型">\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div class="layui-form-item">\n' +
                        '\n' +
                        '            <label class="layui-form-label">节点名称</label>\n' +
                        '            <div class="layui-input-block">\n' +
                        '                <input type="text" class="layui-input" name="templateItemName" placeholder="请输入节点名称"\n' +
                        '                       lay-verify="required" lay-verType="tips" style="width: 90%;">\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div class="layui-form-item">\n' +
                        '            <div class="layui-input-block">\n' +
                        '                <button class="layui-btn" lay-submit lay-filter="addItemConfirm">确定</button>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </form>';
                },
                updateItemHtmlTmp: function (defaultValue) {
                    return '<form class="layui-form" style="margin-top: 20px;">\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <div class="layui-inline">\n' +
                        '            <label class="layui-form-label" style="width: 60px;">节点名称</label>\n' +
                        '            <div class="layui-input-inline" style="width: 300px;">\n' +
                        '                <input type="text" class="layui-input" name="templateItemName" placeholder="请输入节点名称"\n' +
                        '                       lay-verify="required" lay-verType="tips" value="' + defaultValue + '">\n' +
                        '            </div>\n' +
                        '            <div class="layui-input-inline" style="width: 80px;">\n' +
                        '                <button class="layui-btn" lay-submit lay-filter="updateItemConfirm">确定</button>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</form>';
                },
                /**
                 * 更新节点html
                 * @param id 节点ID
                 * @param html html内容
                 */
                updateItemHtml: function (id, html, callback, errorCallback) {
                    $.ajax({
                        url: "/meta/template/item",
                        type: "PATCH",
                        dataType: "json",
                        data: {
                            itemId: id,
                            html: html,
                            itemType: DocumentTree.getCurrentItemType()
                        },
                        success: function (res) {
                            callback(res);
                        },
                        error: function (xmlHttpRequest, errMsg, ex) {
                            //TODO 异常处理
                            errorCallback(xmlHttpRequest);
                        }
                    })
                },

                /**
                 * 新建子项内部方法
                 * @param templateId 模板ID
                 * @param parent 父节点对象
                 * @param callback 回调函数
                 */
                addItem: function (templateId, parent, callback) {
                    var parentNode = parent ? parent : false;
                    var parentId = parent ? parent.id : "";

                    //同步ITEM到服务端方法
                    var syncItemToServer = function (current, parentId, innerCallback) {
                        $.ajax({
                            url: '/meta/template/item/add',
                            type: "POST",
                            data: {
                                templateId: templateId,
                                metaTemplateItemName: current.name,
                                seqNo: current.getIndex(),
                                parentId: parentId,
                                itemType: DocumentTree.getCurrentItemType(),
                                itemContentType: current.itemContentType
                            },
                            dataType: "json",
                            success: function (res) {
                                if (res && res.id) {
                                    current.id = res.id;
                                    layui.layer.msg('保存成功');
                                    innerCallback(res);
                                }
                            }
                        })
                    }

                    //打开弹窗
                    var index = layui.layer.open({
                        title: "新建节点",
                        type: 1,
                        area: '600px',
                        content: MetaTemplateItemObj.addItemHtmlTmp(),
                        success: function () {
                            layui.form.render("radio");
                        }
                    });

                    //提交表单事件
                    layui.form.on('submit(addItemConfirm)', function (data) {
                        //获取所填的值
                        var itemName = data.field.templateItemName;
                        var itemContentType = data.field.itemContentType;

                        //关闭弹窗
                        layui.layer.close(index);

                        //左侧树状添加节点
                        var current = DocumentTree.addNode(itemName, parentNode);
                        current.itemContentType = itemContentType;

                        //选中新增节点
                        DocumentTree.selectNode(current);

                        //同步节点到服务端
                        syncItemToServer(current, parentId, function (res) {
                            DocumentTree.pushOriginItem(res);
                            EditorDraw.ue.execCommand("cleardoc");

                            if (typeof callback == "function") {
                                callback(res);
                            }
                        });

                        //如果有提示则移除
                        DocumentTree.removeNoNodesTip(DocumentTree.getCurrentIndex());
                        return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                    });
                },
                /**
                 * 按ID删除ITEM内部方法
                 * @param id
                 * @param callback
                 */
                deleteItem: function (callback) {
                    //获得选中的节点
                    var select = DocumentTree.getSelectedNode();
                    if (!select) return;

                    //同步到服务端
                    var syncServer = function (id, callback) {
                        var index = layui.layer.load(2);
                        //TODO 异常处理
                        $.ajax({
                            url: "/meta/template/item?itemId=" + id,
                            type: "DELETE",
                            dataType: "json",
                            success: function (res) {
                                layui.layer.close(index);
                                callback(res);
                            }
                        })

                    }

                    //删除确认窗口
                    layui.layer.confirm('您确定要删除该项?删除后不可恢复!', {icon: 3, title: '删除确认'}, function (index) {
                        syncServer(select.id, function (res) {
                            layui.layer.close(index);
                            layui.documentTree.deleteNode(select);
                            var allNodes = DocumentTree.getNodes();
                            if (allNodes.length == 0) {
                                DocumentTree.showNoNodesTip(DocumentTree.getCurrentIndex());
                            }
                            if (typeof callback == "function") {
                                callback(res);
                            }
                        })
                    });
                },

                /**
                 * 更新项目名称
                 * @param itemId
                 * @param itemName
                 * @param innerCallback
                 */
                updateItem: function (itemId, itemName, innerCallback) {
                    var select = layui.documentTree.getSelectedNode();
                    if (!select) return;

                    //同步ITEM到服务端方法
                    var syncItemToServer = function (itemId, itemName, innerCallback) {
                        $.ajax({
                            url: '/meta/template/item/name',
                            type: "PATCH",
                            data: {
                                itemId: itemId,
                                itemName: itemName
                            },
                            dataType: "json",
                            success: function (res) {
                                if (res) {
                                    layui.layer.msg('保存成功');
                                    innerCallback(res);
                                }
                            }
                        })
                    }

                    //打开弹窗
                    var index = layui.layer.open({
                        title: "修改节点名称",
                        type: 1,
                        area: '500px',
                        content: MetaTemplateItemObj.updateItemHtmlTmp(select.name)
                    });

                    //提交表单事件
                    layui.form.on('submit(updateItemConfirm)', function (data) {
                        //获取所填的值
                        var itemName = data.field.templateItemName;

                        //关闭弹窗
                        layui.layer.close(index);

                        //修改节点
                        select.name = itemName;
                        DocumentTree.updateNode(select);

                        //同步节点到服务端
                        syncItemToServer(select.id, itemName, function (res) {
                            var origin = DocumentTree.findOriginItem(select.id);
                            // var origin = OriginData.findById(select.id);
                            origin.itemName = itemName;
                        });

                        return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                    });
                }

            }


            /**
             * Editor 对象
             * @type {{ue: null, syncData: syncData, appendElement: appendElement, eidtorParams: string[], initEditor: initEditor, focus: focus, contentChange: contentChange}}
             */
            var EditorDraw = {
                ue: null,
                syncData: function (id, content) {
                    var origin = DocumentTree.findOriginItem(id);
                    origin = origin ? origin : {};
                    if (origin.html || content) {
                        //同步DOM
                        origin.html = content;

                        //同步到服务端
                        MetaTemplateItemObj.updateItemHtml(id, content, function (res) {
                            if (res) {
                                console.log(id, "保存成功")
                            } else {
                                console.log(id, "保存失败")
                                //TODO 保存失败处理
                            }
                        }, function (xmlHttpReq, errMsg, ex) {
                            //TODO 异常处理
                        })

                    }

                    //如果切换项目或取消选择则清空编辑器
                    var select = DocumentTree.getSelectedNode();
                    if (!select || select.id != id) {
                        EditorDraw.ue.execCommand('cleardoc');
                    }
                },
                //添加元素
                appendElement: function (id) {
                    var html = '<div id="editor" style="width:100%;height:100%;"></div>';
                    $(id).append(html);
                },
                //编辑器参数
                eidtorParams: ['undo', //撤销
                    'redo', //重做
                    'bold', //加粗
                    // 'indent', //首行缩进
                    'italic', //斜体
                    'underline', //下划线
                    'strikethrough', //删除线
                    // 'subscript', //下标
                    // 'fontborder', //字符边框
                    // 'superscript', //上标
                    // 'blockquote', //引用
                    // 'pasteplain', //纯文本粘贴模式
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
                    'deletetable', //删除表格
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
                    'fullscreen', //全屏
                    '|',
                    'preview', //预览
                    'print', //打印
                    'source', //源码
                    '|'],
                //初始化编辑器
                initEditor: function (id) {
                    EditorDraw.appendElement(id);
                    //实例化编辑器
                    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
                    var editorH = $(window).height();
                    EditorDraw.ue = UE.getEditor('editor', {
                        initialFrameHeight: editorH,
                        toolbars: [EditorDraw.eidtorParams],
                        autoHeightEnabled: false,
                        allHtmlEnabled: true,
                        enableAutoSave: false,
                        autoSyncData: false
                    });
                    EditorDraw.ue.addListener('focus', function (type) {
                        EditorDraw.focus();
                    })
                    EditorDraw.ue.addListener('contentChange', function (type) {
                        EditorDraw.contentChange();
                    })

                },
                focus: function () {
                    // console.log("执行focus方法") // this是注册的事件的编辑器实例
                },
                contentChange: function () {
                    var select = DocumentTree.getSelectedNode();
                    if (!select) {
                        layui.layer.alert("请从左侧选择一个节点!", {icon: 0});
                        return;
                    }

                    console.debug("当前选中:", select.text);
                    this.syncData(select.id, this.ue.getContent());
                    console.debug("内容发生变化:", EditorDraw.ue.getContent())

                }
            }

            function initDocTreeConf(templateId) {
                DocumentTree.settings({
                    renderHandler: function (origin) {
                        var html = "";
                        if (origin) {
                            html = origin.html ? origin.html : "";
                        }
                        EditorDraw.ue.setContent(html);
                    },
                    ajax: {
                        data: {templateId: templateId}
                    }
                })
            }

            /**
             * 对外暴露方法
             */
            exports('metaTemplate', {
                /**
                 * 渲染树形
                 * @param invitationId
                 * @param tenderId
                 * @param templateId
                 */
                drawTabTree: function (invitationId, tenderId, templateId) {
                    initDocTreeConf(templateId);
                    DocumentTree.initTabTree(invitationId, tenderId);
                },
                /**
                 * 删除指定元模板
                 * @param templateId
                 * @param callback 回调函数，包含2个参数，res为返回对象；status为操作状态,true代表成功/false代表失败
                 */
                deletMetaTemplate: function (templateId, callback) {
                    MetaTemplateObj.deleteMetaTemplate(templateId, callback);
                },
                /**
                 * 添加根节点
                 * @param templateId 模板ID
                 * @param callback 回调函数，返回服务端的数据
                 */
                addRootItem: function (templateId, callback) {
                    MetaTemplateItemObj.addItem(templateId, "", callback);
                },
                /**
                 * 添加子节点
                 * @param templateId 模板I
                 * @param callback
                 */
                addChildItem: function (templateId, callback) {
                    var select = DocumentTree.getSelectedNode();
                    if (select) {
                        MetaTemplateItemObj.addItem(templateId, select, callback);
                    }
                },
                /**
                 * 添加节点，如果没有父节点，则直接添加到根节点
                 * @param templateId
                 * @param callback
                 */
                addItem: function (templateId, callback) {
                    var parent = null;
                    var select = DocumentTree.getSelectedNode(false);
                    if (select) {
                        parent = select.getParentNode();
                    }
                    MetaTemplateItemObj.addItem(templateId, parent, callback);
                },
                /**
                 * 删除选中的子项
                 * @param id
                 * @param callback
                 */
                deleteItem: function (callback) {
                    MetaTemplateItemObj.deleteItem(callback);
                },
                updateItem: function (callback) {
                    MetaTemplateItemObj.updateItem(callback);
                },
                initEditor: function (id) {
                    EditorDraw.initEditor(id);
                },
                convertToTree: function (dataArray) {
                    return DocumentTree.convertToTree(dataArray);
                },
                updateTemplateName: function (templateId, defaultValue, callback) {
                    return MetaTemplateObj.updateTemplateName(templateId, defaultValue, callback);
                }
            });

        });
    }
)
;