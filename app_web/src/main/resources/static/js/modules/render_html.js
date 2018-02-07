/**
 * 定义渲染组件
 */
layui.define(function (exports) {

    layui.use(['tableEditor'], function () {

    })

    var Parser = {
        tags: {
            // insert: "<input type='text' class='word-style' name=''/>",
            insert: "<span class='insert-text word-style' style='position: relative;'></span>",
            img: '<button class="layui-btn layui-btn-xs">上传图片</button>',
            file: '<button class="layui-btn layui-btn-xs">上传文件</button>',
            table: '<button class="layui-btn layui-btn-xs edit-table">编辑表格</button>',
            pbbf_q_table: '<button class="layui-btn layui-btn-xs edit-table pbbf-q-table">编辑表格</button>',
            //投标模板变量
            insert_bidPrice: '<input type="text" name="bidPrice"  style="border: none;border-bottom: 1px #000000 solid;box-shadow: none;outline: none;width: 150px;font-size: 14pt;min-width: 100px;padding: 0px 5px;"/>',
            insert_bidPartPrice: '<input type="text" name="bidPartPrice"  style="border: none;border-bottom: 1px #000000 solid;box-shadow: none;outline: none;width: 150px;font-size: 14pt;min-width: 100px;padding: 0px 5px;"/>',
            insert_bidMeasurePrice: '<input type="text" name="bidMeasurePrice"  style="border: none;border-bottom: 1px #000000 solid;box-shadow: none;outline: none;width: 150px;font-size: 14pt;min-width: 100px;padding: 0px 5px;"/>',
            insert_bidDeliveryTimeLimit: '<input type="text" name="bidDeliveryTimeLimit"  style="border: none;border-bottom: 1px #000000 solid;box-shadow: none;outline: none;width: 150px;font-size: 14pt;min-width: 100px;padding: 0px 5px;"/>',
            insert_bidPrincipal: '<input type="text" name="bidPrincipal"  style="border: none;border-bottom: 1px #000000 solid;box-shadow: none;outline: none;width: 150px;font-size: 14pt;min-width: 100px;padding: 0px 5px;"/>',
            insert_bidPrincipalId: '<input type="text" name="bidPrincipalId"  style="border: none;border-bottom: 1px #000000 solid;box-shadow: none;outline: none;width: 150px;font-size: 14pt;min-width: 100px;padding: 0px 5px;"/>',
            insert_bidBidValidity: '<input type="text" name="bidBidValidity"  style="border: none;border-bottom: 1px #000000 solid;box-shadow: none;outline: none;width: 150px;font-size: 14pt;min-width: 100px;padding: 0px 5px;"/>',
            insert_bidQuality: '<input type="text" name="bidQuality"  style="border: none;border-bottom: 1px #000000 solid;box-shadow: none;outline: none;width: 150px;font-size: 14pt;min-width: 100px;padding: 0px 5px;"/>',
            insert_bidPriceChinese: '<input type="text" name="bidPriceChinese"  style="border: none;border-bottom: 1px #000000 solid;box-shadow: none;outline: none;width: 150px;font-size: 14pt;min-width: 100px;padding: 0px 5px;"/>',
            insert_bidPriceUnit: '<input type="text" name="bidPriceUnit"  style="border: none;border-bottom: 1px #000000 solid;box-shadow: none;outline: none;width: 150px;font-size: 14pt;min-width: 100px;padding: 0px 5px;"/>'
        },
        textWidth: function (e) {
            var length = $(e).val().length;
            var fontSize = $(e).css("font-size");
            var fz = fontSize ? fontSize.replace("px", "") : 20;

            // var sensor = $('<pre>' + text + '</pre>').css({display: 'none'});
            // Render.getBody().append(sensor);
            // var width = sensor.width();
            // sensor.remove();
            return length * fz;
        },
        autoWith: function (e) {
            var w = Parser.textWidth(e);
            if (w == 0 || w < 150) {
                $(e).width(50);
            } else {
                $(e).width(w);
            }
        },
        /**
         * 只解析基础模板
         * @param html
         * @param beforeCB
         * @returns {*}
         */
        parsePure: function (html, beforeCB) {
            if (!html) {
                return null;
            }

            var compiled_tpl = juicer(html);
            var htmlParse = compiled_tpl.render(Parser.tags);
            if (beforeCB && typeof beforeCB == "function") {
                return beforeCB(htmlParse);
            }
            return htmlParse;
        },
        /**
         * 解析并带有基本的事件交互
         * @param id
         * @param recoverData
         * @param html
         */
        parseBasic: function (id, recoverData, html, callback) {
            if (!html) {
                return null;
            }

            return Parser.parsePure(html, function (htmlParse) {
                //定义子项数据对象
                var itemData = {};
                if (recoverData) {
                    itemData = recoverData;
                }

                var $html = $("<div></div>");
                $html.append(htmlParse);

                /**
                 * 查找所有文本输入框
                 */
                var inputs = $html.find(".insert-text");
                inputs.each(function (index) {
                    var lastTime = 0;
                    var that = this;
                    var currentId = id + "_" + index;
                    $(that).attr("id", currentId).text(itemData[currentId]);

                    //绑定编辑事件
                    $(that).editable(function (val, settings) {
                        return val;
                    }, {
                        rows: 4,
                        cols: 60,
                        tooltip: "请点击输入",
                        onblur: "submit",
                        type: "textarea",
                        placeholder: "点击输入",
                        callback: function (value, settings) {
                            //将改变的值设置回item数据对象
                            itemData[currentId] = value;
                            //执行回调函数
                            if (callback && typeof callback == "function") {
                                callback("insert_text", itemData)
                            }

                        }
                    })

                    // $(that).on("keyup", function (e) {
                    //     lastTime = e.timeStamp;
                    //     setTimeout(function () {
                    //         if (lastTime - e.timeStamp == 0) {
                    //             console.debug(currentId + ":" + $(that).val());
                    //             //将改变的值设置回item数据对象
                    //             itemData[currentId] = $(that).val();
                    //
                    //             //执行回调函数
                    //             if (callback && typeof callback == "function") {
                    //                 callback("input", itemData)
                    //             }
                    //         }
                    //     }, 300);
                    // })
                });


                /**
                 * 查找所有table
                 */
                var tables = $html.find("table");
                tables.each(function (index) {
                    var $currentTable = $(this);

                    var tableBtn = $currentTable.find(".edit-table");
                    if (tableBtn.length == 0) {
                        return true;
                    }

                    var tableId = id + "_table_" + index;

                    var $btn = null;
                    tableBtn.each(function (index) {
                        if (index == 0) {
                            $btn = $(this).clone();
                        }
                        $(this).remove();
                    })

                    //设置样式
                    $currentTable.wrap("<div class='edit-table-wrapper' id='" + tableId + "'></div>");
                    var $tableWraper = $currentTable.parent(".edit-table-wrapper");
                    $tableWraper.append($btn);
                    $tableWraper.css("position", "relative");
                    $btn.css("position", "absolute").css("top", "0").css("left", "0");

                    //回填表格数据
                    var recoverTableDom = itemData[tableId];
                    if (recoverTableDom) {
                        $tableWraper.find('table').replaceWith(recoverTableDom);
                    }


                    //表格绑定事件
                    $tableWraper.hover(function () {
                        //鼠标移入事件
                        $btn.show();
                    }, function () {
                        //鼠标移出事件
                        $btn.hide();
                    })

                    //按钮绑定事件
                    $btn.off("click").on("click", function () {
                        var $thatBtn = $(this);
                        var newTable = $tableWraper.find("table");
                        var tableHtml = newTable[0].outerHTML;
                        layui.tableEditor.openTableEditor(tableHtml, function (val) {
                            newTable.replaceWith(val);
                            itemData[tableId] = val;

                            //执行回调函数
                            if (callback && typeof callback == "function") {
                                var type = "table";
                                //如果是评标办法前附表则修改type
                                if ($thatBtn.hasClass("pbbf-q-table")) {
                                    type = "pbbf-q-table";
                                }
                                callback(type, itemData, val);
                            }
                        });
                    })
                })

                /**
                 * 查找checkbox选项事件
                 */
                var $chooseItems = $html.find(".choose-item");
                $chooseItems.each(function (index) {
                    var $item = $(this);


                    // var $items = $that.find(".choose-item");
                    // if (!$items || $items.length == 0) {
                    //     return true;
                    // }

                    // $items.each(function (itemIndex) {
                    // var $item = $(this);
                    // var $itemClass = $item.parent("div");

                    //渲染新的多选组件
                    var $newItem = RenderFilter.replaceUncheckedCheckbox($item);

                    //设置属性
                    var currentId = id + "_choose-item_" + index;
                    var imgCheck = itemData[currentId];
                    $newItem.attr("id", currentId);
                    if (imgCheck && imgCheck == "checked") {
                        $newItem.attr("src", RenderFilter.getCheckedCheckboxImg());
                        $newItem.removeClass("unchecked").addClass("checked");
                    }

                    //绑定事件
                    $newItem.off("click").on("click", function () {
                        //如果是未选中则选中
                        if ($newItem.hasClass("unchecked")) {
                            //替换成选中图片
                            $newItem.attr("src", RenderFilter.getCheckedCheckboxImg());
                            //设置父级class已选中
                            $newItem.removeClass("unchecked").addClass("checked");

                            itemData[currentId] = "checked";
                        } else {
                            //已选中则取消选中
                            $newItem.attr("src", RenderFilter.getUncheckedCheckboxImg());
                            //设置父级class未选中
                            $newItem.removeClass("checked").addClass("unchecked");

                            itemData[currentId] = "unchecked";
                        }

                        //执行回调函数
                        if (callback && typeof callback == "function") {

                            var type = "checkbox";
                            callback(type, itemData);
                        }
                    })
                    // })

                })

                return Parser.adjustA4($html);
            });
        },

        /**
         * 适应A4格式
         * @param html
         */
        adjustA4: function ($html) {
            if (!$html) {
                return null;
            }

            //处理设置表格宽度为650
            var $tables = $html.find("table");
            $tables.each(function (tableIndex) {
                var $that = $(this);
                $that.attr("width", 620);
            })

            return $html;

        }
    }

    var Render = {
        renderId: null,
        renderBody: null,
        renderTitle: null,
        getId: function () {
            return Render.renderId.substring(1, Render.renderId.length);
        },
        replace: function (targetId) {
            Render.renderId = targetId;
            var parent = $(targetId).parent();
            $(Render.renderId).remove();
            var $renderIframe = $('<iframe id="' + Render.getId() + '" width="100%" height="100%" src="/render" style="border: none;"></iframe>');
            parent.append($renderIframe);
        },
        getBody: function () {
            if (!Render.renderBody) {
                Render.renderBody = $(Render.renderId).contents().find("body");
            }
            return Render.renderBody;
        },
        getTitle: function () {
            if (!Render.renderTitle) {
                Render.renderTitle = $(Render.renderId).contents().find("title");
            }
            return Render.renderTitle;
        },
        render: function (html) {
            Render.getBody().html(html);
        },

        /**
         * 渲染解析后的html
         * @param id 当前Item的ID
         * @param recoverData 需要复写的data对象
         * @param html 待渲染的html
         * @param title 当前item的名字
         * @param callback 回调函数,有2个参数,type是当前触发事件的类型,itemData是当前item最新的data
         */
        renderParse: function (id, recoverData, html, title, callback) {
            if (title) {
                Render.getTitle().text(title);
            }

            var $html = Parser.parseBasic(id, recoverData, html, callback);
            Render.getBody().html($html);
        },
        /**
         * 渲染合并html
         * @param nodesArray 待合并渲染的节点内容
         */
        renderMergeHtml: function (nodesArray) {
            var $html = $(Render.renderId).contents().find("html");
            var $tmpHtml = $html.clone();
            var $body = $tmpHtml.find("body");
            $body.empty();

            for (var i = 0; i < nodesArray.length; i++) {
                var node = nodesArray[i];
                var content = Parser.parseBasic(node.id, node.recoverData, node.html);

                if (content) {
                    $body.append(content);
                }
            }

            return $tmpHtml;
        },
        /**
         * 得到去掉事件和选项的纯净内容
         * @returns {{content, inputs, contentHtml: contentHtml}}
         */
        getPureContent: function () {
            var cloneBody = Render.getBody().clone();
            var content = cloneBody.contents();

            //替换所有的input
            content.replaceAll("")
            var inputs = content.find(".insert-text");
            // inputs.each(function (index) {
            //     var val = $(this).val();
            //     var wrap = "<span class='word-style'>" + val + "</span>";
            //     $(this).replaceWith(wrap);
            // })

            //替换选择框
            // var $chooseItems = content.find(".choose-item");
            // $chooseItems.each(function (index) {
            //     var $that = $(this);
            //     if ($that.prop('checked')) {
            //         RenderFilter.replaceCheckedCheckbox($that);
            //     } else {
            //         RenderFilter.replaceUncheckedCheckbox($that);
            //     }
            // })

            //去掉表格的编辑按钮
            content.find(".edit-table").remove();
            return {
                content: content,
                inputs: inputs,
                contentHtml: function () {
                    var html = "";
                    for (var i = 0; i < this.content.length; i++) {
                        html += this.content[i].outerHTML;
                    }
                    return html;
                }
            };
        }

    }

    /**
     * 渲染过滤器
     * @type {{getUncheckedCheckbox: getUncheckedCheckbox, getCheckedCheckbox: getCheckedCheckbox}}
     */
    var RenderFilter = {
        getUncheckedCheckboxImg: function () {
            return 'data:image/png;base64,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';
        },
        getCheckedCheckboxImg: function () {
            return 'data:image/png;base64,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';
        },
        getUncheckedCheckbox: function () {
            return "<img class='choose-item unchecked'  style='width: 14px;height: 14px;cursor: pointer;' src='" + RenderFilter.getUncheckedCheckboxImg() + "'/>";
        },
        getCheckedCheckbox: function () {
            // return "<span style=\"font-size: 16px;font-family: &#39;Wingdings 2&#39;\">R</span>";
            return "<img class='choose-item checked' style='width: 14px;height: 14px;cursor: pointer;' src='" + RenderFilter.getCheckedCheckboxImg() + "'/>";
        },
        replaceCheckedCheckbox: function (that) {
            var $replace = $(RenderFilter.getCheckedCheckbox());
            that.replaceWith($replace);
            return $replace;
        },
        replaceUncheckedCheckbox: function (that) {
            var $replace = $(RenderFilter.getUncheckedCheckbox());
            that.replaceWith($replace);
            return $replace;
        }
    }

    exports("renderHtml", {
        init: function (targetId) {
            Render.replace(targetId);
        },
        render: function (html) {
            Render.render(html);
        },
        renderParse: function (id, recoverData, html, title, callback) {
            Render.renderParse(id, recoverData, html, title, callback);
        },
        renderMergeHtml: function (nodesArray) {
            return Render.renderMergeHtml(nodesArray);
        },
        getPureContent: function () {
            return Render.getPureContent();
        }
    })
})