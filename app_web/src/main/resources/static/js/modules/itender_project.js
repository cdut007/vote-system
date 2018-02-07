
/**
 * 定义招标项目组件
 */
layui.define(function (exports) {
    layui.use('layer', function () {

    });
    var Projects = {
        /**
         * 获取项目
         * @param callback
         */
        getProjects: function (callback) {
            var index = layui.layer.load(2);
            $.ajax({
                url: "/itender/projects",
                dataType: "json",
                type: "GET",
                success: function (data) {
                    if (callback && typeof callback == "function") {
                        callback(data);
                    }
                },
                error: function (xmlHttpRequest, errMsg, ex) {
                    //TODO 异常处理
                },
                complete: function () {
                    layui.layer.close(index);
                }
            })
        },
        /**
         * 按project id查找招标项目
         * @param projectId
         * @param callback
         */
        getProjectInstances: function (projectId, callback) {
            var index = layui.layer.load(2);
            $.ajax({
                url: "/itender/projects/instance",
                dataType: "json",
                type: "GET",
                data: {projectId: projectId},
                success: function (data) {
                    if (callback && typeof callback == "function") {
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
        getProjectItems: function (instanceId, callback) {
            var index = layui.layer.load(2);
            $.ajax({
                url: "/itender/projects/items",
                dataType: "json",
                type: "GET",
                data: {instanceId: instanceId},
                success: function (data) {
                    if (callback && typeof callback == "function") {
                        callback(data);
                    }
                },
                error: function (req, errmsg, ex) {
                    //TODO 异常处理
                },
                complete: function () {
                    layui.layer.close(index);
                }
            })
        }
    }


    var DomHelper = {
        /**
         * Layui form对象
         */
        form: null,
        /**
         * 项目元素对象
         */
        projectElementId: "",
        /**
         * 招标项目对象
         */
        projectInstanceElementId: "",
        /**
         * 标段对象
         */
        projectItemsElementId: "",
        /**
         * 项目元素对象
         */
        projectId: "",
        /**
         * 招标项目对象
         */
        projectInstanceId: "",
        /**
         * 标段对象
         */
        projectItemsId: "",

        callback:null,
        /**
         * 初始化项目
         * @param params 是包含初始化参数的
         *
         */
        initProjects: function (projectElementId, projectInstanceElementId, projectItemsElementId, form,callback) {
            this.form = form;
            this.projectElementId = projectElementId ? "#" + projectElementId : "";
            this.projectInstanceElementId = projectInstanceElementId ? "#" + projectInstanceElementId : "";
            this.projectItemsElementId = projectItemsElementId ? "#" + projectItemsElementId : "";

            this.projectId = projectElementId ? projectElementId : "";
            this.projectInstanceId = projectInstanceElementId ? projectInstanceElementId : "";
            this.projectItemsId = projectItemsElementId ? projectItemsElementId : "";

            this.callback = callback && typeof callback == "function"?callback:function () {

            };

            DomHelper.renderProjects();

        },
        /**
         * 显示项目
         */
        showProjects: function () {
            $(this.projectElementId).show();
        },
        /**
         * 显示招标项目
         */
        showProjectInstance: function () {
            $(this.projectInstanceElementId).show();
        },
        /**
         * 显示标段
         */
        showProjectItems: function () {
            $(this.projectItemsElementId).show();
        },
        /**
         * 隐藏项目
         */
        hideProjects: function () {
            $(this.projectElementId).hide();
        },
        /**
         * 隐藏招标项目
         */
        hideProjectInstance: function () {
            $(this.projectInstanceElementId).hide();
        },
        /**
         * 隐藏标段
         */
        hideProjectItems: function () {
            $(this.projectItemsElementId).hide();
        },
        /**
         * 生成select选择框
         * @param name select的name
         * @param verify 校验规则
         * @param array 选项数据
         * @param key option中value的key
         * @param value option显示的key
         * @returns {*|jQuery|HTMLElement}
         */
        makeOptions: function (id, array, key, value) {
            if (!array) {
                return null;
            }

            var $select = $(id);
            $select.empty();
            $select.append("<option value=''>请选择或输入</option>")

            for (var i = 0; i < array.length; i++) {
                var project = array[i];
                var $option = $("<option value='" + project[key] + "'>" + project[value] + "</option>")
                $select.append($option);
            }

            DomHelper.form.render('select');
            return $select;
        },
        /**
         * 渲染项目选择框
         */
        renderProjects: function () {

            Projects.getProjects(function (data) {
                var $select = DomHelper.makeOptions(DomHelper.projectElementId, data, "id", "projectName");

                //绑定change事件
                DomHelper.form.on('select('+DomHelper.projectId+')',function (target) {
                    var id = target.value;
                    console.log(id);
                    DomHelper.renderProjectInstance(id);
                });
            })
        },
        /**
         * 渲染招标项目
         * @param projectId
         */
        renderProjectInstance: function (projectId) {

            if (!projectId) {
                return;
            }

            Projects.getProjectInstances(projectId, function (data) {
                var $select = DomHelper.makeOptions(DomHelper.projectInstanceElementId, data, "id", "projectInstanceName");

                //绑定change事件
                DomHelper.form.on('select('+DomHelper.projectInstanceId+')',function (target) {
                    var id = target.value;
                    console.log(id);
                    DomHelper.renderProjectItems(id);
                });
            })
        },
        /**
         * 选择标段选项
         * @param instanceId
         */
        renderProjectItems: function (instanceId) {
            if (!instanceId) {
                return;
            }

            Projects.getProjectItems(instanceId, function (data) {
                var $select = DomHelper.makeOptions(DomHelper.projectItemsElementId, data, "id", "projectItemName");
            })

            //绑定change事件
            DomHelper.form.on('select('+DomHelper.projectItemsId+')',function (target) {
                DomHelper.callback(target);
            });
        }
    }

    exports("itenderProject", {
        initProjects: function (projectElementId, projectInstanceElementId, projectItemsElementId, form,callback) {
            DomHelper.initProjects(projectElementId, projectInstanceElementId, projectItemsElementId, form,callback);
        }
    })
})