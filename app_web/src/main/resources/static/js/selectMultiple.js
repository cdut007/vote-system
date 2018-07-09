var form, $;
layui.use(['form','layer'],function(){
    form = layui.form;
    var layer = parent.layer === undefined ? layui.layer : parent.layer;
    $ = layui.jquery;


    form.render();
})