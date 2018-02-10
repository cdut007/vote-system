//设置jquery validator 默认值
// $.validator.setDefaults({
//     errorClass:"errorClass",
//     highlight: function(element, errorClass, validClass) {
//         $(element).addClass("layui-form-danger");
//     },
//     unhighlight: function(element, errorClass, validClass) {
//         $(element).removeClass("layui-form-danger");
//     }
// })

/**
 * layui全局配置，加载扩展模块
 */
layui.config({
    base:"/js/modules/"
}).extend({
    metaTemplate:"meta_template",
    invitationDocuments:"invitation_documents",
    renderHtml:"render_html",
    itenderProject:"itender_project",
    formaterUtil:"formater_util",
    tableEditor:"table_editor",
    itenderUser:"itender_user",
    itenderLog:"itender_log",
    itenderDevice:"itender_device",
    itenderRole:"itender_role",
    itenderPrivilege:"itender_privilege",
    multipleSelect:"multipleSelect",
    documentTree:"document_tree",
    formEditorCheckbox:"form_editor_checkbox"
})

var view = {
    goto:function (url) {
        window.location.href = url;
    },
    openNew:function (url) {
        window.open(url,"_blank");
    }
}

$.ajaxSetup({
    statusCode: {403: function() {
            var layer = layui.layer;
            layer.open({
                type: 2,
                title: '用户登录',
                area:['70%','70%'],
                skin:'layui-layer-molv',
                closeBtn: 0,
                shadeClose: false,
                content: ['/']
            });
        }
    }});