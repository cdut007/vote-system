UE.registerUI('insertVariables', function (editor, uiName) {
    //注册按钮执行时的command命令,用uiName作为command名字，使用命令默认就会带有回退操作
    editor.registerCommand(uiName, {
        execCommand: function (cmdName, value) {
            // editor.execCommand('insertHtml', value);
        }
    });


    //创建下拉菜单中的键值对
    var items = [
        {
            label: "文本变量",
            value: "$${insert}"
        },
        {
            label: "表格变量",
            value: "$${table}"
        },
        {
            label: "评标办法前附表变量",
            value: "$${pbbf_q_table}"
        }, {
            label: "选择项变量",
            value: "choose_items"
        },
        {
            label: "[投标模板]投标报价变量",
            value: "$${insert_bidPrice}"
        },
        {
            label: "[投标模板]投标分布分项报价变量",
            value: "$${insert_bidPartPrice}"
        },
        {
            label: "[投标模板]投标措施报价变量",
            value: "$${insert_bidMeasurePrice}"
        },
        {
            label: "[投标模板]工期(交货期)变量",
            value: "$${insert_bidDeliveryTimeLimit}"
        },
        {
            label: "[投标模板]项目负责人变量",
            value: "$${insert_bidPrincipal}"
        },
        {
            label: "[投标模板]项目负责人ID变量",
            value: "$${insert_bidPrincipalId}"
        },
        {
            label:"[投标模板]投标有效期变量",
            value:"$${insert_bidBidValidity}"
        },
        {
            label:"[投标模板]质量变量",
            value:"$${insert_bidQuality}"
        },
        {
            label:"[投标模板]投标报价大写变量",
            value:"$${insert_bidPriceChinese}"
        },
        {
            label:"[投标模板]投标报价单位变量",
            value:"$${insert_bidPriceUnit}"
        }
    ];

    //创建下拉框
    var combox = new UE.ui.Combox({
        //需要指定当前的编辑器实例
        editor: editor,
        //添加条目
        items: items,
        //当选中时要做的事情
        onselect: function (t, index) {
            //拿到选中条目的值
            var val = this.items[index].value;
            switch (val) {
                case "choose_items":
                    layui.formEditorCheckbox.openChooseItems(function (html) {
                        console.log(typeof  html)
                        editor.execCommand('insertHtml', html)

                    });
                    break;
                default:
                    editor.execCommand('insertHtml', val);
                    break;
            }
            // editor.execCommand(uiName, this.items[index].value);
        },
        //提示
        title: "插入变量",
        //当编辑器没有焦点时，combox默认显示的内容
        initValue: "插入变量"
    });

    editor.addListener('selectionchange', function (type, causeByUi, uiReady) {
        if (!uiReady) {
            var state = editor.queryCommandState(uiName);
            if (state == -1) {
                combox.setDisabled(true);
            } else {
                combox.setDisabled(false);
                var value = editor.queryCommandValue(uiName);
                if (!value) {
                    combox.setValue("插入变量");
                    return;
                }
                //ie下从源码模式切换回来时，字体会带单引号，而且会有逗号
                value && (value = value.replace(/['"]/g, '').split(',')[0]);
                combox.setValue(value);

            }
        }

    });
    return combox;
}/*index 指定添加到工具栏上的那个位置，默认时追加到最后,editorId 指定这个UI是那个编辑器实例上的，默认是页面上所有的编辑器都会添加这个按钮*/);