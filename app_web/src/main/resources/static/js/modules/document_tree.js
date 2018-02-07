/**
 * 定义树形结构操作
 */
layui.define(function (exports) {
    layui.use(["layer", "form", 'util', 'element'], function () {
        /**
         * 监听tab切换
         */
        layui.element.on("tab", function (data) {
            var index = data.index;
            DocTree.setCurrentIndex(index);
            DocTree.renderContent();
        })

        var OriginData = {
            data: [],
            findById: function (id) {
                var origin = null;
                for (var i = 0; i < this.data.length; i++) {
                    if (id == OriginData.data[i].id) {
                        origin = OriginData.data[i];
                        break;
                    }
                }
                return origin;
            }
        };

        /**
         * 文档树对象
         * @type {{treeId: string, showLoading: showLoading, hideLoading: hideLoading, showNoNodesTip: showNoNodesTip, removeNoNodesTip: removeNoNodesTip, getDataFromServer: getDataFromServer, convertToTree: convertToTree, initTree: initTree, getSelectedNode: getSelectedNode, selectedCreate: selectedCreate, addNode: addNode, deleteNode: deleteNode, getNodes: getNodes}}
         */
        var DocTree = {
            itemTypes: ["INVITATION", "TENDER"],
            treeId: "",
            treeObj: null,
            treeIdArray: [],
            treeArray: [],
            currentIndex: 0,
            currentTree: null,
            treeSetting: function () {
                return {
                    view: {
                        selectedMulti: false
                    },
                    edit: {
                        enable: DocTree.settings.editable,
                        showRemoveBtn: false,
                        showRenameBtn: false
                    },
                    callback: {
                        onClick: function (event, treeId, treeNode) {
                            DocTree.renderContent(treeNode);
                        },
                        onDrop: function (event, treeId, treeNodes, targetNode, moveType) {
                            var currentNode = treeNodes[0];
                            var itemId = currentNode.id;
                            var parentId = null;

                            if (targetNode && targetNode.getParentNode()) {
                                parentId = targetNode.getParentNode().id;
                            }

                            console.log("current node :", currentNode, ",new index:", currentNode.getIndex());
                            console.log("target node :", targetNode, ",new index:", targetNode.getIndex());

                            //同步父级ID方法
                            var syncParent = function (itemId, parentId) {
                                var data = {itemId: itemId};
                                if (parentId) {
                                    data.parentId = parentId;
                                }
                                $.ajax({
                                    url: "/meta/template/item/parent",
                                    type: "PATCH",
                                    dataType: "json",
                                    data: data,
                                    success: function (res) {
                                        var origin = OriginData.findById(currentNode.id);
                                        origin.parentId = targetNode ? targetNode.id : null;
                                    },
                                    error: function (xmlHttpRequest, errMsg, ex) {
                                        //TODO 异常处理
                                    }
                                })

                            }

                            //批量同步节点序号
                            var batchSyncSeqNo = function () {
                                var nodes = DocTree.getNodes();
                                var nodeArray = DocTree.treeObj.transformToArray(nodes);
                                var items = [];
                                for (var i = 0; i < nodeArray.length; i++) {
                                    items.push({id: nodeArray[i].id, seqNo: nodeArray[i].getIndex()});
                                }
                                $.ajax({
                                    url: "/meta/template/item/batch/seqno",
                                    type: "PATCH",
                                    dataType: "json",
                                    contentType: "application/json; charset=utf-8",
                                    data: JSON.stringify(items),
                                    success: function (rows) {

                                    },
                                    error: function (xmlHttpRequest, errMsg, ex) {
                                        //TODO 异常处理
                                    }
                                })
                            }

                            //如果不是相同父级则不同步
                            // var currentNodeParent = currentNode.getParentNode();
                            // var currentNodeParentId = currentNodeParent?currentNodeParent.id:null;
                            // if (currentNodeParentId != parentId) {
                            // }
                            syncParent(itemId, parentId);

                            batchSyncSeqNo();

                        }
                    }
                }
            },
            settings: {
                editable: true,
                renderHandler: function (html) {

                },
                ajax: {
                    url: "/meta/template/item",
                    method: "get",
                    data: {}
                }
            },
            /**
             * 初始化树形结构
             * @param templateId 模板ID
             */
            initTree: function (id) {
                //保存树形ID
                DocTree.putTreeId(id);

                //获取数据并初始化树
                DocTree.getDataFromServer(function (data) {
                    var treeData = DocTree.convertToTree(data);
                    var treeObj = $.fn.zTree.init($(DocTree.getCurrentTreeId()), DocTree.treeSetting(), treeData);
                    DocTree.putTree(treeObj);

                    if (treeData.length == 0) {
                        DocTree.showNoNodesTip();
                    }
                })
            },
            initTabTree: function (invitationTreeId, tenderTreeId, callback) {
                DocTree.putTreeId(invitationTreeId);
                DocTree.putTreeId(tenderTreeId);

                //获取数据并初始化树
                DocTree.getDataFromServer(function (data) {
                    var dataWrap = DocTree.splitDataByType(data);

                    var invitationData = dataWrap.invitationArray;
                    var tenderData = dataWrap.tenderArray;

                    //转换招标文件列表并初始化树
                    var invitationTreeObj = $.fn.zTree.init($(invitationTreeId), DocTree.treeSetting(), DocTree.convertToTree(invitationData));
                    DocTree.putTree(invitationTreeObj);
                    if (invitationData.length == 0) {
                        DocTree.showNoNodesTip(0);
                    }

                    //转换投标文件列表并初始化树
                    var tenderTreeObj = $.fn.zTree.init($(tenderTreeId), DocTree.treeSetting(), DocTree.convertToTree(tenderData));
                    DocTree.putTree(tenderTreeObj);
                    if (tenderData.length == 0) {
                        DocTree.showNoNodesTip(1);
                    }

                    layui.layer.msg("加载成功!");
                    if (typeof callback == "function") {
                        callback(data);
                    }
                })
            },
            /**
             * 回填ue editor 内容
             * @param treeNode
             */
            renderContent: function (treeNode) {
                var currentNode = treeNode;
                if (!currentNode) {
                    currentNode = DocTree.getSelectedNode(false);
                }
                var origin = null;
                if (currentNode) {
                    origin = OriginData.findById(currentNode.id);
                }
                //交给调用者出路
                DocTree.settings.renderHandler(origin);
            },
            setCurrentIndex: function (index) {
                DocTree.currentIndex = index ? index : 0;
            },
            getCurrentIndex: function () {
                return this.currentIndex;
            },
            putTreeId: function (id) {
                this.treeIdArray.push(id);
            },
            getTreeId: function (index) {
                return this.treeIdArray[index && index <= this.treeIdArray.length ? index : 0];
            },
            getTreeIds: function () {
                return this.treeIdArray;
            },
            getCurrentTreeId: function () {
                if (this.treeIdArray.length > 0) {
                    return DocTree.treeIdArray[DocTree.currentIndex];
                }

                return this.treeId;
            },
            getCurrentTree: function () {
                return this.treeArray[this.currentIndex];
            },
            getCurrentItemType: function () {
                return this.itemTypes[this.getCurrentIndex()];
            },
            putTree: function (treeObj) {
                this.treeArray.push(treeObj);
            },

            /**
             * 分割成2个数据
             * @param data
             * @returns {{invitationArray: Array, tenderArray: Array}}
             */
            splitDataByType: function (data) {
                var invitationArray = [];
                var tenderArray = [];

                for (var i = 0; i < data.length; i++) {
                    var item = data[i];
                    if (!item.itemType || item.itemType == "INVITATION") {
                        invitationArray.push(item);
                    } else {
                        tenderArray.push(item);
                    }
                }

                return {
                    invitationArray: invitationArray,
                    tenderArray: tenderArray
                }
            },
            /**
             * 显示Loading
             */

            showLoading: function (index) {
                var htmlTmp = '<i class="layui-icon layui-anim layui-anim-loop layui-anim-rotate">&#xe63e;</i>';

                if (index) {
                    $(this.getTreeId(index)).append($(htmlTmp));
                } else {
                    for (var i = 0; i < this.getTreeIds().length; i++) {
                        $(this.getTreeId(i)).append($(htmlTmp));
                    }
                }
            },

            /**
             * 隐藏Loading
             */
            hideLoading: function (index) {
                if (index) {
                    $(this.getTreeId(index)).empty();
                } else {
                    for (var i = 0; i < this.getTreeIds().length; i++) {
                        $(this.getTreeId(i)).empty();
                    }
                }
            },
            /**
             * 显示无节点提示
             */
            showNoNodesTip: function (index) {
                var html = '<p>暂无项目，请新建一个"根节点"</p>';

                if (index) {
                    $(this.getTreeId(index)).append(html);
                } else {
                    for (var i = 0; i < this.getTreeIds().length; i++) {
                        $(this.getTreeId(i)).append(html);
                    }
                }
            },

            /**
             * 移除无节点提示
             */
            removeNoNodesTip: function (index) {
                if (typeof index != "undefined") {
                    $(this.getTreeId(index)).find("p").remove();
                } else {
                    for (var i = 0; i < this.getTreeIds().length; i++) {
                        $(this.getTreeId(i)).find("p").remove();
                    }
                }
            },

            //TODO 异常情况后面处理
            /**
             * 从服务端获取数据
             * @param templateId
             * @param callback
             */
            getDataFromServer: function (callback) {
                this.showLoading();
                $.ajax({
                    url: DocTree.settings.ajax.url,
                    type: DocTree.settings.ajax.method,
                    dataType: "json",
                    data: DocTree.settings.ajax.data,
                    success: function (res) {
                        DocTree.hideLoading();
                        OriginData.data = res;
                        callback(res);
                    }
                })
            },

            /**
             * 转换成treeview结构,使用递归实现
             * @param dataArray
             * @returns {Array}
             */
            convertToTree: function (dataArray) {
                var treeviewArray = [];

                var getChildren = function (parent, node) {
                    for (var i = 0; i < dataArray.length; i++) {
                        var origin = dataArray[i];
                        if (origin.parentId && origin.parentId == parent.id) {
                            var child = {
                                id: origin.id,
                                name: origin.itemName,
                                open: true,
                                index: origin.seqNo
                            }
                            getChildren(origin, child);
                            if (!node.children) {
                                node.children = [];
                            }
                            node.children.push(child);
                        }
                    }

                    //排序子节点
                    if (node.children) {
                        node.children.sort(function (a, b) {
                            return a.index - b.index;
                        })
                    }
                }

                var getRoots = function () {
                    for (var i = 0; i < dataArray.length; i++) {
                        var origin = dataArray[i];
                        if (!origin.parentId) {
                            var node = {
                                id: origin.id,
                                name: origin.itemName,
                                index: origin.seqNo,
                                open: true,
                                children: []
                            }
                            getChildren(origin, node);
                            treeviewArray.push(node);
                        }
                    }

                    //对根节点进行排序
                    if (treeviewArray.length > 0) {
                        treeviewArray.sort(function (a, b) {
                            return a.index - b.index;
                        })
                    }

                }

                getRoots();

                return treeviewArray;
            },

            /**
             * 获得选中的节点
             * @param showAlert true为显示，false为不显示
             * @returns {*}
             */
            getSelectedNode: function () {
                //获取选中的节点
                var selectedItems = DocTree.getCurrentTree().getSelectedNodes();
                if (selectedItems.length == 0) {
                    return null;
                }
                var select = selectedItems[0];
                // console.debug("父节点:", select)
                return select;
            },

            /**
             * 选中节点
             * @param itemName
             * @returns {*}
             */
            selectNode: function (node) {
                DocTree.getCurrentTree().selectNode(node);
            },

            /**
             * 添加节点
             * @param itemName
             * @param parentNode
             */
            addNode: function (itemName, parentNode) {
                //左侧树状添加节点
                var addNodes = DocTree.getCurrentTree().addNodes(parentNode ? parentNode : null, {name: itemName});
                return addNodes[0];
            },
            /**
             * treeview删除节点
             * @param select
             */
            deleteNode: function (select) {
                DocTree.getCurrentTree().removeNode(select);
            },
            /**
             * 更新节点
             * @param currentNode
             * @param newNode
             */
            updateNode: function (currentNode) {
                DocTree.getCurrentTree().updateNode(currentNode);
            },
            /**
             * 获取所有节点
             * @returns {*|jQuery}
             */
            getNodes: function () {
                return DocTree.getCurrentTree().getNodes();
            }
        }

        exports("documentTree", {
            initTree: function (id, callback) {
                DocTree.initTree(id, callback);
            },
            initTabTree: function (invitationTreeId, tenderTreeId, callback) {
                DocTree.initTabTree(invitationTreeId, tenderTreeId, callback);
            },
            selectNode: function (node) {
                DocTree.selectNode(node);
            },
            addNode: function (itemName, parentNode) {
                return DocTree.addNode(itemName, parentNode);
            },
            deleteNode: function (select) {
                DocTree.deleteNode(select);
            },
            updateNode: function (currentNode) {
                DocTree.updateNode(currentNode);
            },
            getNodes: function () {
                return DocTree.getNodes();
            },
            showNoNodesTip: function (index) {
                DocTree.showNoNodesTip(index);
            },
            removeNoNodesTip: function (index) {
                DocTree.removeNoNodesTip(index);
            },
            getSelectedNode: function (showAlert) {
                return DocTree.getSelectedNode(showAlert);
            },
            pushOriginItem: function (item) {
                OriginData.data.push(item);
            },
            findOriginItem: function (id) {
                return OriginData.findById(id);
            },
            getCurrentItemType: function () {
                return DocTree.getCurrentItemType();
            },
            getCurrentTree: function () {
                return DocTree.getCurrentTree();
            },
            getCurrentIndex: function () {
                return DocTree.getCurrentIndex();
            },
            settings: function (options) {
                var settings = {};
                $.extend(true, settings, DocTree.settings, options);
                DocTree.settings = settings;
            }

        })

    });
})