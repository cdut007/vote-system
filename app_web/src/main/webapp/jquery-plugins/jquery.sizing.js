//设置浏览器元素大小插件
(function($){
	$.fn.extend({
		sizing:function(){
			return $(this).each(function(){
				var $image=$(this);
				var width=$image.width();
				var height=$image.height();
				var $div=$image.wrap($("<div/>").addClass("sizing_box").width(width).height(height)).css("width","100%").css("height","100%").parent();
				$("<div/>").addClass("shelter").appendTo($div).click(function(){
					$sizingbox=$image.parent();
					$sizingbox.before($image.width($image.width()).height($image.height()));
					$sizingbox.remove();
					$image.parents("pre:first").attr("contenteditable","true");
				});
				var $tl=$("<div/>").addClass("t-l").appendTo($div).data("type","tl");
				var $tl=$("<div/>").addClass("t-c").css({left:(width/2-5)}).appendTo($div).data("type","tc");
				var $tr=$("<div/>").addClass("t-r").appendTo($div).data("type","tr");
				var $bl=$("<div/>").addClass("b-l").appendTo($div).data("type","bl");
				var $tl=$("<div/>").addClass("b-c").css({left:(width/2-5)}).appendTo($div).data("type","bc");
				var $bl=$("<div/>").addClass("b-r").appendTo($div).data("type","br");
				var $cl=$("<div/>").addClass("c-l").css({top:(height/2-5)}).appendTo($div).data("type","cl");
				var $cl=$("<div/>").addClass("c-r").css({top:(height/2-5)}).appendTo($div).data("type","cr");
				var $focus_;
				var timer;
				var resize=function($focus){
					if($focus){
						timer=window.setTimeout(function(){
							if($focus.data("type")=="tl"){
								var widthScale=($focus.data("x_")-$focus.data("x"))/$div.width();
								var heightScale=($focus.data("y_")-$focus.data("y"))/$div.height();
								if(widthScale*heightScale>0){
									var scale=widthScale>heightScale?widthScale:heightScale;
									$div.width($div.width()-$div.width()*scale);
									$div.height($div.height()-$div.height()*scale);
								}
							}
							if($focus.data("type")=="tr"){
								var widthScale=($focus.data("x")-$focus.data("x_"))/$div.width();
								var heightScale=($focus.data("y_")-$focus.data("y"))/$div.height();
								if(widthScale*heightScale>0){
									var scale=widthScale>heightScale?widthScale:heightScale;
									$div.width($div.width()-$div.width()*scale);
									$div.height($div.height()-$div.height()*scale);
								}
							}
							if($focus.data("type")=="bl"){
								var widthScale=($focus.data("x_")-$focus.data("x"))/$div.width();
								var heightScale=($focus.data("y")-$focus.data("y_"))/$div.height();
								if(widthScale*heightScale>0){
									var scale=widthScale>heightScale?widthScale:heightScale;
									$div.width($div.width()-$div.width()*scale);
									$div.height($div.height()-$div.height()*scale);
								}
							}
							if($focus.data("type")=="br"){
								var widthScale=($focus.data("x_")-$focus.data("x"))/$div.width();
								var heightScale=($focus.data("y_")-$focus.data("y"))/$div.height();
								if(widthScale*heightScale>0){
									if(widthScale*heightScale>0){
										var scale=widthScale>heightScale?widthScale:heightScale;
										$div.width($div.width()+$div.width()*scale);
										$div.height($div.height()+$div.height()*scale);
									}
								}
							}
							if($focus.data("type")=="tc"){
								$div.height($div.height()-($focus.data("y_")-$focus.data("y")));
							}
							if($focus.data("type")=="bc"){
								$div.height($div.height()+($focus.data("y_")-$focus.data("y")));
							}
							if($focus.data("type")=="cl"){
								$div.width($div.width()-($focus.data("x_")-$focus.data("x")));
							}
							if($focus.data("type")=="cr"){
								$div.width($div.width()+$focus.data("x_")-$focus.data("x"));
							}
							$div.children(".t-c,.b-c").css("left",$div.width()/2-5);
							$div.children(".c-l,.c-r").css("top",$div.height()/2-5);
							$focus.data("x",$focus.data("x_")).data("y",$focus.data("y_"));
							resize($focus);
						},100);
					}
				};
				$div.children("div").filter(function(){return $(this).data("type");}).mousedown(function(e){
					$focus_=$(this);
					$focus_.data("x",e.pageX);
					$focus_.data("y",e.pageY);
					$focus_.data("x_",e.pageX);
					$focus_.data("y_",e.pageY)
					resize($focus_);
				});
				$(document).mousemove(function(e){
					if($focus_){
						$focus_.data("x_",e.pageX);
						$focus_.data("y_",e.pageY)
					}
				});
				$(document).mouseup(function(){
					resize();
					$focus_=undefined;
					clearTimeout(timer);
				});
			});
		}
	});
})(jQuery);