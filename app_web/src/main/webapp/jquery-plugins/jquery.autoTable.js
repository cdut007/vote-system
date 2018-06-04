(function($){
	$.fn.extend({
		statistics:function(){
			return $(this).each(function(){
				var $table=$(this);
				$(this).children("tbody.statistics").children("tr").children("td").children(":input[name^='sum'],:input[name^='avg']").each(function(){
					var $input=$(this);
					var name=$input.attr("name");
					var data=name.substring(3+1,name.length-1).split("][");
					var colLimit=data[0].split("-");
					var rowLimit=data[1].split("-");
					var lt=($table.children("tbody.editor").children("tr").length-1);
					var sum=lt>0?0:'';
					var count=0;
					$table.children("tbody.editor").children("tr:lt("+lt+")").each(function(rowIndex){
						if(rowIndex>=parseInt(rowLimit[0])&&(rowLimit[1]=="*"||rowIndex<=parseInt(rowLimit[1]))){
							$(this).children("td").each(function(colIndex){
								if(colIndex>=parseInt(colLimit[0])&&(colLimit[1]=="*"||colIndex<=parseInt(colLimit[1]))){
									$(this).children(":input").each(function(){
										if(/^-?([0-9]|([1-9][0-9]*)|([0-9]\.[0-9]+)|([1-9][0-9]*\.[0-9]+))$/.test($(this).val())){
											sum+=parseFloat($(this).val());
											count++;
										}else{
											$(this).val('');
										}
									});
								}
							});
						}
					});
					var value=name.substring(0,3)=="sum"?sum:(count==0?'':sum/count);
					if(value!=''&&$input.attr("minFractionDigits")){
						var minFractionDigits=parseInt($input.attr("minFractionDigits"));
						var weight=1;
						for(var i=0;i<minFractionDigits;i++){
							weight=weight*10;
						}
						value=(Math.round(value*weight)/weight).toFixed(minFractionDigits);
					}
					$input.val(value);
				});
			});
		},
		sortIndex:function(){
			return $(this).each(function(){
				$(this).children("tbody.editor,tbody.other").children("tr").each(function(i){
					$(this).children("th:first").html(i+1);
				});
				$(this).children("tbody").children("tr:odd").css("background-color","#f5f5f5").children("td").css("background-color","#f5f5f5").children(":input").css("background-color","#f5f5f5");
				$(this).children("tbody").children("tr:even").css("background-color","#ffffff").children("td").css("background-color","#ffffff").children(":input").css("background-color","#ffffff");
			});	
		},
		autoTable:function(){
			return $(this).each(function(i){
				var $table=$(this);
				$table.bind("rowChange",function(){
					$table.sortIndex();
					$table.statistics();
				});
				$table.on("keyup change","tbody.editor>tr>td>:input",function(){//按键弹起或者变更事件
					var $tr=$(this).parent("td").parent("tr");
					if($tr.find(":input:not([type='hidden']):not([type='checkbox']):not([type='radio'])").filter(function(){return $(this).val()!=""&&$(this).attr("defaultValue")==undefined;}).length>0){
						if($tr.next().length==0){
							var $next=$(this).parent("td").parent("tr").clone().removeClass("focusRow");
							$next.find(":input").each(function(){
								if($(this).attr("type")=="checkbox"||$(this).attr("type")=="radio"){
									$(this).prop("checked",false);
								}else if($(this).val()!=""&&$(this).attr("defaultValue")==undefined){
									$(this).val("");
								}
							});
							$tr.after($next);
							$next.children("td").children("table").autoTable();
							$next.find("textarea").autoTextarea({minHeight:18});
							$tr.parent("tbody.editor").parent("table").sortIndex();
						}
						$tr.children("td:last").children(".button").removeClass("none");
					}
					if($tr.find(":input:not([type='hidden'])").filter(function(){return $(this).val()!=""&&$(this).attr("defaultValue")==undefined;}).length==0){
						$tr.children("td:last").children(".insert").addClass("none");
					}
				}).on("focus", "tbody.editor>tr>td>:input",function(){//获得焦点
					var $tr=$(this).parent("td").parent("tr");
					$tr.addClass("focusRow");
					var $focusRow=$tr.siblings(".focusRow");
					if($focusRow.length>0){
						$focusRow.removeClass("focusRow");
						if($focusRow.find(":input:not([type='hidden'])").filter(function(){return $(this).val()!=""&&$(this).attr("defaultValue")==undefined;}).length==0&&$focusRow.next().length!=0){
							$focusRow.remove();
							$tr.parent("tbody.editor").parent("table").sortIndex();
						}
					}	
				}).on("click","tbody.editor>tr>td>.delete",function(){//删除按钮
					var $tr=$(this).parent("td").parent("tr");
					$tr.remove();
					$table.trigger("rowChange");
//					$table.sortIndex();
//					$table.statistics();
				}).on("click", "tbody.editor>tr>td>.insert",function(){//插入事件
					var $tr=$(this).parent("td").parent("tr");
					var $prev=$tr.clone();
					$prev.find(":input").filter(function(){return $(this).val()!=""&&$(this).attr("defaultValue")==undefined;}).val("");
					$prev.find("textarea").autoTextarea({minHeight:18});
					if($tr.prev().length==0){
						$prev.children("td:last").children(".insert").addClass("none");
					}
					$tr.before($prev);
					$prev.find(":input:first").focus();
					$table.trigger("rowChange");
//					$table.sortIndex();
				})/*.on("mousedown","tbody.editor>tr>td:has(':input:not(:focus)')",function(){
					$(this).children(":input:not([type='hidden'])").focus();
					return false;
				})*/.on("blur","tbody.editor>tr>td>:input",function(){
					$table.trigger("rowChange");
//					$table.statistics();
				});
				$table.children("tbody.editor").children("tr").each(function(){
					var $tr=$(this);
					if($tr.find(":input:not([type='hidden'])").filter(function(){return $(this).val()!=""&&$(this).attr("defaultValue")==undefined;}).length==0&&$tr.next().length>0){
						$tr.remove();
					}
					$(this).children("td").each(function(){
						$(this).children("textarea").autoTextarea({minHeight:18}).keyup();
					});
				});
				$table.trigger("rowChange");
			});
		}
	});
})(jQuery);