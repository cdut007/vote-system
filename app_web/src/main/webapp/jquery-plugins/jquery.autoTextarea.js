/*
* @author zoro
* 【jQuery插件】autoTextarea-文本框根据输入内容自适应高度
* 参数 maxHeight:null,//文本框是否自动撑高，默认：null，不自动撑高；如果自动撑高必须输入数值，该值作为文本框自动撑高的最大高度
* 参数 minHeight:$(this).height()//默认最小高度，也就是文本框最初的高度，当内容高度小于这个高度的时候，文本以这个高度显示
*/
(function($){
    $.fn.autoTextarea = function(options) {
        var defaults={
            maxHeight:null,//文本框是否自动撑高，默认：null，不自动撑高；如果自动撑高必须输入数值，该值作为文本框自动撑高的最大高度
            minHeight:$(this).height() //默认最小高度，也就是文本框最初的高度，当内容高度小于这个高度的时候，文本以这个高度显示
        };
        var opts = $.extend({},defaults,options);
        return $(this).each(function() {
            $(this).bind("paste cut keydown keyup focus",function(){
				$(this).css("height",opts.minHeight + 'px');
                if (this.scrollHeight > opts.minHeight) {
                    if (opts.maxHeight && this.scrollHeight > opts.maxHeight) {
						$(this).css("height",opts.maxHeight);
                        $(this).css("overflowY",'scroll');
                    } else {
						$(this).css("height",this.scrollHeight);
                        $(this).css("overflowY","hidden");
                    }
                }
            });
        });
    };
})(jQuery);