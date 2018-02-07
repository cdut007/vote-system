/**
 * 招标文件模块
 */
layui.define(function (exports) {
    layui.use(['layer', 'metaTemplate', 'renderHtml', 'documentTree', 'itenderProject', 'form'], function () {
        var DocumentTree = layui.documentTree;

        var Status = {
            canOperate: false
        }

        // var invitationDocumentId = null;

        /**
         * 招标文件对象
         * @type {{deleteInvitationDocument: deleteInvitationDocument, deploy: deploy, undeploy: undeploy}}
         */
        var InvitationDocumentsObj = {
            findById: function (documentId, callback) {
                $.ajax({
                    url: "/invitation/documents/document",
                    dataType: "json",
                    type: "GET",
                    data: {id: documentId},
                    success: function (data) {
                        if (typeof callback == "function") {
                            callback(data);
                        }
                    }
                })
            },
            /**
             * 删除招标文件
             * @type {string}
             */
            deleteInvitationDocument: function (invitationDocumentId, callback) {
                //同步到服务端
                var syncServer = function (invitationDocumentId, callback) {
                    var index = layui.layer.load(2);
                    //TODO 异常处理
                    $.ajax({
                        url: "/invitation/documents?id=" + invitationDocumentId,
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
                                    layui.layer.alert('该招标文件暂不能删除');
                                    callback(errObj, false);
                                }
                            }

                        }
                    })

                }

                //删除确认窗口
                layui.layer.confirm('您确定要删除该项?删除后不可恢复!', {icon: 3, title: '删除确认'}, function (index) {
                    syncServer(invitationDocumentId, function (res, status) {
                        layui.layer.close(index);
                        if (typeof callback == "function") {
                            callback(res, status);
                        }
                    })
                });
            },

            showProjectInfo: function () {

            },

            deploy: function (invitationDocumentId, callback) {
                var index = layui.layer.load(2);
                $.ajax({
                    url: "/invitation/documents/deploy",
                    dataType: "json",
                    type: "PATCH",
                    data: {documentId: invitationDocumentId},
                    success: function (data) {
                        if (data) {
                            layui.layer.msg("发布成功");
                        }

                        if (callback && typeof  callback == "function") {
                            callback(data);
                        }
                    },
                    error: function (req, errMsg, ex) {
                        //TODO 异常处理
                    },
                    complete: function () {
                        layui.layer.close(index);
                    }
                })
            },
            undeploy: function (invitationDocumentId, callback) {
                $.ajax({
                    url: "/invitation/documents/undeploy",
                    dataType: "json",
                    type: "PATCH",
                    data: {documentId: invitationDocumentId},
                    success: function (data) {
                        if (data) {
                            layui.layer.msg("取消成功");
                        }

                        if (callback && typeof  callback == "function") {
                            callback(data);
                        }
                    },
                    error: function (req, errMsg, ex) {
                        //TODO 异常处理
                    }
                })
            },
            updateProjectInfo: function (documentId, projectId, projectInstanceId, projectItemId, callback, failCallback) {
                var loadIndex = layui.layer.load(2);
                $.ajax({
                    url: "/invitation/documents/project",
                    dataType: "json",
                    type: "PATCH",
                    data: {
                        documentId: documentId,
                        itenderProjectId: projectId,
                        itenderInstanceId: projectInstanceId,
                        itenderProjectItemId: projectItemId
                    },
                    success: function (rows) {
                        if (typeof callback == "function") {
                            callback(rows);
                        }
                    },
                    error: function (req, errMsg, ex) {
                        if (typeof callback == "function") {
                            callback(req, errMsg, ex);
                        }
                    },
                    complete: function () {
                        layui.layer.close(loadIndex);
                    }
                })
            },
            showUpdateProjectInfo: function (documentId, callback) {
                var html = '<div class="layui-fluid"  style="padding: 10px;">\n' +
                    '    <form class="layui-form layui-form-pane" action="/invitation/documents/project" method="post"\n' +
                    '          id="updateProjectInfoForm">\n' +
                    '        <div class="layui-row  layui-col-space10">\n' +
                    '            <div class="layui-col-md12">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label for="metaTemplateName" class="layui-form-label">项目</label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <select id="itenderProjectId" name="itenderProjectId" lay-verify="required" lay-verType="tips"\n' +
                    '                                lay-filter="itenderProjectId" lay-search></select>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '\n' +
                    '        <div class="layui-row  layui-col-space10">\n' +
                    '            <div class="layui-col-md12">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label for="metaTemplateName" class="layui-form-label">招标项目</label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <select id="itenderInstanceId" name="itenderInstanceId" lay-verify="required" lay-verType="tips"\n' +
                    '                                lay-filter="itenderInstanceId" lay-search></select>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '\n' +
                    '        <div class="layui-row  layui-col-space10">\n' +
                    '            <div class="layui-col-md12">\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    注:如果有多个标段都使用相同的招标文件，则标段选项不用选择！\n' +
                    '                </div>\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label for="metaTemplateName" class="layui-form-label">标段</label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <select id="itenderProjectItemId" name="itenderProjectItemId" lay-verify="" lay-verType="tips"\n' +
                    '                                lay-filter="itenderProjectItemId" lay-search></select>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '\n' +
                    '        <div class="layui-row  layui-col-space10">\n' +
                    '            <div class="layui-col-md12">\n' +
                    '                <button class="layui-btn layui-btn-success" lay-submit lay-filter="confirm" style="width: 100%">确认发布\n' +
                    '                </button>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </form>\n' +
                    '</div>';

                layui.layer.open({
                    type: 1,
                    title: "关联项目信息",
                    area: '500px',
                    content: html,
                    btn: false,
                    success: function (layero, index) {
                        layui.form.render('select')
                        layui.itenderProject.initProjects("itenderProjectId", "itenderInstanceId", "itenderProjectItemId", layui.form);

                        layui.form.on('submit(confirm)', function (data) {
                            var params = data.field;
                            InvitationDocumentsObj.updateProjectInfo(documentId, params.itenderProjectId, params.itenderInstanceId
                                , params.itenderProjectItemId, function (resp) {
                                    if (resp.status && resp.status != 200) {
                                        layui.layer.msg(resp.responseJSON.message);
                                        return;
                                    }
                                    //关联失败
                                    if (resp == 0) {
                                        layui.layer.msg("关联失败,请稍后尝试!");
                                        return;
                                    }
                                    //关联成功
                                    layui.layer.close(index);

                                    InvitationDocumentsObj.deploy(documentId, callback);
                                }, function (req, errMsg, ex) {

                                })
                            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                        });
                    }
                })

            }
        }

        /**
         * 招标文件子项对象
         * @type {{syncHtmlParseToServer: syncHtmlParseToServer, syncPbbfQTableToServer: syncPbbfQTableToServer, syncItemDataToServer: syncItemDataToServer, getNodesArray: getNodesArray}}
         */
        var InvitationDocumentItem = {
            /**
             * 同步子项的html到服务端
             * @param itemId
             * @param htmlParse
             */
            syncHtmlParseToServer: function (itemId, htmlParse) {
                $.ajax({
                    url: "/invitation/documents/item/html",
                    type: "PATCH",
                    dataType: "json",
                    data: {itemId: itemId, htmlParse: htmlParse},
                    success: function (res) {
                        console.log("update rows:", res);
                    },
                    error: function (xmlHttpRequest, errMsg, ex) {
                        //TODO 后面统一处理
                    }
                })
            },
            /**
             * 同步评标办法前附表内容到服务端
             * @param itemId
             * @param htmlParse
             */
            syncPbbfQTableToServer: function (documentId, tableParse) {
                var $table = $(tableParse);
                var tableArray = [];

                var $trs = $table.find("tr");
                $trs.each(function (trIndex) {
                    var $tr = $(this);
                    var trArray = [];

                    var $tds = $tr.find("td");
                    $tds.each(function (tdIndex) {
                        $td = $(this);
                        trArray.push($td.text());
                    })
                    tableArray.push(trArray);
                })

                var jsonStr = JSON.stringify(tableArray);
                console.log("table array json str:", jsonStr);
                console.log("table array:", JSON.parse(jsonStr));
                // $.ajax({
                //     url: "/invitation/documents/item/html",
                //     type: "PATCH",
                //     dataType: "json",
                //     data: {itemId: itemId, htmlParse: htmlParse},
                //     success: function (res) {
                //         console.log("update rows:", res);
                //     },
                //     error: function (xmlHttpRequest, errMsg, ex) {
                //         //TODO 后面统一处理
                //     }
                // })
            },
            /**
             * 同步子项数据到服务端
             * @param itemId
             * @param itemData
             */
            syncItemDataToServer: function (itemId, itemDataStr) {
                $.ajax({
                    url: "/invitation/documents/item/data",
                    type: "PATCH",
                    dataType: "json",
                    data: {itemId: itemId, data: itemDataStr},
                    success: function (res) {
                        console.log("update rows:", res);
                    },
                    error: function (xmlHttpRequest, errMsg, ex) {
                        //TODO 后面统一处理
                    }
                })
            },
            getNodesArray: function () {
                var nodes = DocumentTree.getNodes();
                return DocumentTree.getCurrentTree().transformToArray(nodes);
            }
        }


        // var DocTree = {
        //     documentId:"",
        //     itemTypes: ["INVITATION", "TENDER"],
        //     treeId: "",
        //     treeObj: null,
        //     treeIdArray: [],
        //     treeArray: [],
        //     currentIndex: 0,
        //     currentTree: null,
        //     treeSetting: {
        //         view: {
        //             selectedMulti: false
        //         },
        //         edit: {
        //             enable: false,
        //             showRemoveBtn: false,
        //             showRenameBtn: false
        //         },
        //         callback: {
        //             onClick: function (event, treeId, treeNode) {
        //                 var origin = OriginData.findById(treeNode.id);
        //                 if (!origin) {
        //                     return;
        //                 }
        //                 var originDataStr = origin.invitationDocumentItemData.data;
        //                 var covertData = originDataStr ? JSON.parse(originDataStr) : null;
        //                 var html = origin.html ? origin.html : "";
        //
        //                 //渲染编辑内容区
        //                 layui.renderHtml.renderParse(origin.id, covertData, html, origin.documentName, function (type, itemData,val) {
        //                     //TODO 处理当前item的data数据
        //                     // console.log("type:", type, ",item data:", itemData);
        //                     // console.log("current val:", val);
        //                     origin.invitationDocumentItemData.data = JSON.stringify(itemData);
        //                     DocTree.syncItemDataToServer(origin.id, origin.invitationDocumentItemData.data);
        //
        //                     //获得该项处理后的html
        //                     var pureContent = layui.renderHtml.getPureContent();
        //                     DocTree.syncHtmlParseToServer(origin.id, pureContent.contentHtml());
        //
        //                     //同步评标办法前附表
        //                     if("pbbf-q-table" == type) {
        //                         DocTree.syncPbbfQTableToServer(DocTree.documentId,val);
        //                     }
        //                 });
        //
        //                 console.debug("index:", treeNode.getIndex())
        //             }
        //         }
        //     },
        //
        //     //TODO 异常情况后面处理
        //     /**
        //      * 从服务端获取数据
        //      * @param templateId
        //      * @param callback
        //      */
        //     getDataFromServer: function (invitationDocumentId, callback) {
        //         this.showLoading();
        //         $.ajax({
        //             url: "/invitation/documents/item",
        //             type: "GET",
        //             dataType: "json",
        //             data: {invitationDocumentId: invitationDocumentId},
        //             success: function (res) {
        //                 DocTree.hideLoading();
        //                 OriginData.data = res;
        //                 callback(res);
        //             }
        //         })
        //     },
        //
        //
        //     /**
        //      * 初始化树形结构
        //      * @param templateId 模板ID
        //      */
        //     initTree: function (targetId, invitationDocumentId, callback) {
        //         DocTree.putTreeId(targetId);
        //         DocTree.documentId = invitationDocumentId;
        //         //获取数据并初始化树
        //         DocTree.getDataFromServer(invitationDocumentId, function (data) {
        //             var treeData = layui.metaTemplate.convertToTree(data);
        //             DocTree.treeObj = $.fn.zTree.init($(DocTree.getCurrentTreeId()), DocTree.treeSetting, treeData);
        //             if (treeData.length == 0) {
        //                 DocTree.showNoNodesTip();
        //             }
        //
        //             Status.canOperate = true;
        //
        //             layui.layer.msg("加载成功!");
        //
        //             if (callback && typeof callback == "function") {
        //                 callback(data);
        //             }
        //         })
        //     },
        //     initTabTree: function (invitationTreeId, tenderTreeId, templateId) {
        //         DocTree.putTreeId(invitationTreeId);
        //         DocTree.putTreeId(tenderTreeId);
        //
        //         //获取数据并初始化树
        //         DocTree.getDataFromServer(templateId, function (data) {
        //             var dataWrap = DocTree.splitDataByType(data);
        //
        //             var invitationData = dataWrap.invitationArray;
        //             var tenderData = dataWrap.tenderArray;
        //
        //             //转换招标文件列表并初始化树
        //             var invitationTreeObj = $.fn.zTree.init($(invitationTreeId), DocTree.treeSetting, DocTree.convertToTree(invitationData));
        //             DocTree.putTree(invitationTreeObj);
        //             if (invitationData.length == 0) {
        //                 DocTree.showNoNodesTip(0);
        //             }
        //
        //             //转换投标文件列表并初始化树
        //             var tenderTreeObj = $.fn.zTree.init($(tenderTreeId), DocTree.treeSetting, DocTree.convertToTree(tenderData));
        //             DocTree.putTree(tenderTreeObj);
        //             if (tenderData.length == 0) {
        //                 DocTree.showNoNodesTip(1);
        //             }
        //         })
        //     },
        //     /**
        //      * 显示Loading
        //      */
        //
        //     showLoading: function () {
        //         var htmlTmp = '<i class="layui-icon layui-anim layui-anim-loop layui-anim-rotate">&#xe63e;</i>';
        //         $(this.treeId).append($(htmlTmp));
        //     },
        //
        //     /**
        //      * 隐藏Loading
        //      */
        //     hideLoading: function () {
        //         $(this.treeId).empty();
        //     },
        //     /**
        //      * 显示无节点提示
        //      */
        //     showNoNodesTip: function () {
        //         $(this.treeId).append('<p>暂无项目,请确认元模板是否有项目</p>');
        //     },
        //
        //     /**
        //      * 移除无节点提示
        //      */
        //     removeNoNodesTip: function () {
        //         $(this.treeId).find("p").remove();
        //     },
        //
        //     /**
        //      * 获得选中的节点
        //      * @param showAlert true为显示，false为不显示
        //      * @returns {*}
        //      */
        //     getSelectedNode: function (showAlert) {
        //         //获取选中的节点
        //         var selectedItems = DocTree.treeObj.getSelectedNodes();
        //         if (selectedItems.length == 0) {
        //             if (showAlert != false) {
        //                 layui.layer.alert("请从左侧选择一个节点!", {icon: 0});
        //                 return;
        //             }
        //         }
        //         var select = selectedItems[0];
        //         // console.debug("父节点:", select)
        //         return select;
        //     },
        //
        //     /**
        //      * 选中节点
        //      * @param itemName
        //      * @returns {*}
        //      */
        //     selectNode: function (node) {
        //         DocTree.treeObj.selectNode(node);
        //     },
        //
        //     /**
        //      * 添加节点
        //      * @param itemName
        //      * @param parentNode
        //      */
        //     addNode: function (itemName, parentNode) {
        //         var addNodes = DocTree.treeObj.addNodes(parentNode ? parentNode : null, {name: itemName});
        //         //左侧树状添加节点
        //         // $(this.treeId).treeview("addNode", [{text: itemName}, parentNode, false, {silent: true}]);
        //         return addNodes[0];
        //     },
        //     /**
        //      * treeview删除节点
        //      * @param select
        //      */
        //     deleteNode: function (select) {
        //         DocTree.treeObj.removeNode(select);
        //         // $(this.treeId).treeview('removeNode', [select, {silent: true}]);
        //     },
        //     /**
        //      * 更新节点
        //      * @param currentNode
        //      * @param newNode
        //      */
        //     updateNode: function (currentNode) {
        //         DocTree.treeObj.updateNode(currentNode);
        //         // $(this.treeId).treeview('updateNode', [currentNode, newNode, {silent: true}]);
        //     },
        //     /**
        //      * 获取所有节点
        //      * @returns {*|jQuery}
        //      */
        //     getNodes: function () {
        //         return DocTree.treeObj.getNodes();
        //     },
        //     getNodesArray: function () {
        //         var nodes = DocTree.getNodes();
        //         return DocTree.treeObj.transformToArray(nodes);
        //     }
        // }

        var ExportUtil = {
            print: function () {
                var $html = ExportUtil.getHtml();
                $html.printArea();
            },
            getHtml: function () {
                var nodesArray = InvitationDocumentItem.getNodesArray();
                var printNodes = [];
                for (var i = 0; i < nodesArray.length; i++) {
                    var node = nodesArray[i];
                    var nodeData = layui.documentTree.findOriginItem(node.id);
                    var data = nodeData.invitationDocumentItemData.data;
                    printNodes.push({
                        id: node.id,
                        recoverData: data ? JSON.parse(data) : null,
                        html: nodeData.html
                    })
                }

                return layui.renderHtml.renderMergeHtml(printNodes);
            },
            downloadPdf: function (documentId) {
                var form = $("<form>");//定义一个form表单
                form.attr("style", "display:none");
                form.attr("target", "_blank");
                form.attr("method", "post");
                form.attr("action", "/invitation/documents/download/pdf");

                var documentInput = $("<input>");
                documentInput.attr("type", "hidden");
                documentInput.attr("name", "documentId");
                documentInput.attr("value", documentId);
                $("body").append(form);//将表单放置在web中
                form.append(documentInput);

                form.submit();//表单提交
            }
        }

        var ValidUtil = {
            valid: function ($html) {
                //检查输入框
                var valid = true;
                var $inserts = $html.find(".insert-text");
                $inserts.each(function (index) {
                    var $that = $(this);
                    if ($that.text() == "" || $that.text() == "点击输入") {
                        layui.layer.msg("您还有未填写的字段!");
                        valid = false;
                        return false;
                    }
                })
                return valid;
            },
            validCheckbox:function ($html) {
                //检查输入框
                var valid = true;
                var $wraps = $html.find(".choose-wrap");
                $wraps.each(function (index) {
                    var $wrap = $(this);

                    var $items = $wrap.find(".choose-item");

                    var checked = 0;
                    $items.each(function () {
                        var $item = $(this);

                        if ($item.hasClass("checked")) {
                            checked = 1;
                        }
                    })

                    if (checked == 0) {
                        layui.layer.msg("您还有未填写的字段!");
                        valid = false;
                        return false;
                    }

                })
                return valid;
            }
        }

        //配置参数
        var settingDocTree = function (invitationDocumentId) {
            DocumentTree.settings({
                editable: false,
                renderHandler: function (origin) {
                    if (!origin) {
                        return;
                    }

                    var html = origin.html ? origin.html : "";
                    var originDataStr = origin.invitationDocumentItemData.data;
                    var covertData = originDataStr ? JSON.parse(originDataStr) : null;

                    //渲染编辑内容区
                    layui.renderHtml.renderParse(origin.id, covertData, html, origin.documentName, function (type, itemData, val) {
                        //TODO 处理当前item的data数据
                        origin.invitationDocumentItemData.data = JSON.stringify(itemData);
                        InvitationDocumentItem.syncItemDataToServer(origin.id, origin.invitationDocumentItemData.data);

                        //获得该项处理后的html
                        var pureContent = layui.renderHtml.getPureContent();
                        InvitationDocumentItem.syncHtmlParseToServer(origin.id, pureContent.contentHtml());

                        //同步评标办法前附表
                        if ("pbbf-q-table" == type) {
                            InvitationDocumentItem.syncPbbfQTableToServer(invitationDocumentId, val);
                        }
                    });
                },
                ajax: {
                    url: "/invitation/documents/item",
                    data: {invitationDocumentId: invitationDocumentId},
                }
            })
        }

        exports("invitationDocuments", {
            /**
             * 渲染树形结构
             * @param id
             */
            // drawTree: function (id, invitationDocmentId) {
            //     invitationDocumentId = invitationDocmentId;
            //     DocumentTree.initTree(id, invitationDocmentId);
            // },
            drawTabTree: function (invitationRootId, tenderRootId, invitationDocumentId) {
                settingDocTree(invitationDocumentId);
                DocumentTree.initTabTree(invitationRootId, tenderRootId, function () {
                    Status.canOperate = true;
                });
            },
            deleteDocument: function (invitationDocumentId, callback) {
                InvitationDocumentsObj.deleteInvitationDocument(invitationDocumentId, callback)
            },
            print: function () {
                if (Status.canOperate) {
                    ExportUtil.print();
                } else {
                    layui.layer.msg("正在加载，请稍后...");
                }
            },
            downloadPdf: function (documentId) {
                if (Status.canOperate) {
                    ExportUtil.downloadPdf(documentId);
                } else {
                    layui.layer.msg("正在加载，请稍后...");
                }
            },
            deploy: function (documentId, callback) {
                InvitationDocumentsObj.findById(documentId, function (invitationDocument) {
                    if (!invitationDocument) {
                        layui.layer.msg("招标文件找不到!");
                        return;
                    }

                    //检查是否填写所有的表单项
                    var $html = ExportUtil.getHtml();

                    if (!ValidUtil.valid($html) || !ValidUtil.validCheckbox($html) ) {
                        return;
                    }

                    //关联项目
                        InvitationDocumentsObj.showUpdateProjectInfo(documentId, callback);
                    // if (!invitationDocument.projectId) {
                    //     return;
                    // }

                    // InvitationDocumentsObj.deploy(documentId, callback);
                })
            },
            undeploy: function (documentId, callback) {
                InvitationDocumentsObj.undeploy(documentId, callback);
            }
        })

    });
})