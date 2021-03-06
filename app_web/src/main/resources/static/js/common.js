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
    base:"/js/modules/",
    version: false
}).extend({
    metaTemplate:"meta_template",
    invitationDocuments:"invitation_documents",
    renderHtml:"render_html",
    itenderProject:"itender_project",
    formaterUtil:"formater_util",
    tableEditor:"table_editor",
    itenderUser:"itender_user",
    itenderLog:"itender_log",
    itenderRoom:"itender_room",
    itenderBook:"itender_book",
    itenderDevice:"itender_device",
    itenderRole:"itender_role",
    itenderReview:"itender_review",
    itenderPrivilege:"itender_privilege",
    multipleSelect:"multipleSelect",
    documentTree:"document_tree",
    formEditorCheckbox:"form_editor_checkbox",
    itenderIndustry:"itender_industry",
    itenderSupervision:"itender_supervision"
})

layui.use('layer', function(){
    var layer = layui.layer;

    //全局使用。即所有弹出层都默认采用，但是单个配置skin的优先级更高
    layer.config({
        extend: 'skin/style.css', //加载新皮肤
        skin: 'layer-ext-skin' //一旦设定，所有弹层风格都采用此主题。
    })

});




function isLogin(userName) {
    var isLogin =  userName;
    if(isLogin && isLogin!=''){

        return true;
    }
    return false;
}

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
                closeBtn: 0,
                shadeClose: false,
                content: ['/login']
            });
        }
    }});