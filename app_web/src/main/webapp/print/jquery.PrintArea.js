(function ($) { 
    $.fn.printArea = function () {  
    	var printAreaCount = 0;  
        var ele = $(this);  
        var idPrefix = "printArea_";  
        removePrintArea(idPrefix + printAreaCount);  
        printAreaCount++;  
        var iframeId = idPrefix + printAreaCount;  
        var iframeStyle = 'position:absolute;width:0px;height:0px;left:-500px;top:-500px;';  
        iframe = document.createElement('IFRAME');  
        $(iframe).attr({  
            style: iframeStyle,  
            id: iframeId  
        });  
        document.body.appendChild(iframe);  
        var doc = iframe.contentWindow.document;  
        $(document).find("link").filter(function () {  
            return $(this).attr("rel").toLowerCase() == "stylesheet";  
        }).each(  
                function () {  
                    doc.write('<link type="text/css" rel="stylesheet">');  
                });  
        doc.write('<div class="' + $(ele).attr("class") + '">' + $(ele).html()  + '</div>');  
        doc.close();  
        var frameWindow = iframe.contentWindow;  
        frameWindow.close();  
        frameWindow.focus();  
        frameWindow.print();  
    }; 
    var removePrintArea = function (id) {  
        $("iframe#" + id).remove();  
    }; 
    $.fn.exportEasyUIDataGridArea=function(title){
    	var options=$(this).datagrid("options");
		if(options==undefined){
			$.messager.alert("系统提示","打印导出!");
			return;
		}
		var columns=$(options.columns[0]).filter(function(){
			return this["title"]!=undefined&&this["hidden"]!=true;
		});
		var rows=$(this).datagrid("getRows");
		var table=$("<table/>").css({
			"border-collapse": "collapse"
		});
		var thead=$("<thead/>").appendTo(table);
		var tr=$("<tr/>").appendTo(thead);
		if(options.rownumbers){
			$("<th/>").css("border","1px solid #000").html("序号").appendTo(tr);
		}
		$(columns).each(function(){
			$("<th/>").css({
				"border":"1px solid #000",
				 width:this["width"]
			}).html(this["title"]).appendTo(tr);
		});
		var tbody=$("<tbody/>").appendTo(table);
		for(var i=0,l=rows.length;i<l;i++){
			var row=rows[i];
			var tbodyTr=$("<tr/>").appendTo(tbody);
			if(options.rownumbers){
				$("<th/>").css("border","1px solid #000").html(i+1).appendTo(tbodyTr);
			}
			for(var j=0,jl=columns.length;j<jl;j++){
				var column=columns[j];
				var value=row[column["field"]];
				if(column["formatter"]!=undefined){
					value=column["formatter"].call(undefined,value,row,i);
				}
				$("<td/>").css("border","1px solid #000").attr("align",(column["align"]==undefined?"left":column["align"])).html(value).appendTo(tbodyTr);
			}
		}
		form = $("<form/>").attr("action",ctx + "/attachment/expertXLS").attr("method", "POST").css("display", "none").appendTo($("body"));
		form.append($("<input/>").attr("name", "html").val($("<div/>").append(table).html()));
		form.append($("<input/>").attr("name", "exportName").val((title?title:(options.title?options.title:"导出表"))+".xls"));
		form.submit();
    },
    $.fn.exportEasyUIDataGridArea=function(title,beforTable){
    	var options=$(this).datagrid("options");
		if(options==undefined){
			$.messager.alert("系统提示","打印导出!");
			return;
		}
		var columns=$(options.columns[0]).filter(function(){
			return this["title"]!=undefined&&this["hidden"]!=true;
		});
		var rows=$(this).datagrid("getRows");
		var table=$("<table/>").css({
			"border-collapse": "collapse"
		});
		var thead=$("<thead/>").appendTo(table);
		var tr=$("<tr/>").appendTo(thead);
		if(options.rownumbers){
			$("<th/>").css("border","1px solid #000").html("序号").appendTo(tr);
		}
		$(columns).each(function(){
			$("<th/>").css({
				"border":"1px solid #000",
				 width:this["width"]
			}).html(this["title"]).appendTo(tr);
		});
		var tbody=$("<tbody/>").appendTo(table);
		for(var i=0,l=rows.length;i<l;i++){
			var row=rows[i];
			var tbodyTr=$("<tr/>").appendTo(tbody);
			if(options.rownumbers){
				$("<th/>").css("border","1px solid #000").html(i+1).appendTo(tbodyTr);
			}
			for(var j=0,jl=columns.length;j<jl;j++){
				var column=columns[j];
				var value=row[column["field"]];
				if(column["formatter"]!=undefined){
					value=column["formatter"].call(undefined,value,row,i);
				}
				$("<td/>").css("border","1px solid #000").attr("align",(column["align"]==undefined?"left":column["align"])).html(value).appendTo(tbodyTr);
			}
		}
		form = $("<form/>").attr("action",ctx + "/attachment/expertXLS").attr("method", "POST").css("display", "none").appendTo($("body"));
		form.append($("<input/>").attr("name", "html").val($("<div/>").append(beforTable).append(table).html()));
		form.append($("<input/>").attr("name", "exportName").val((title?title:(options.title?options.title:"导出表"))+".xls"));
		form.submit();
    },
    $.fn.printEasyUIDataGridArea=function(){
		var options=$(this).datagrid("options");
		if(options==undefined){
			$.messager.alert("系统提示","不支持该对象打印!");
			return;
		}
		var columns=$(options.columns[0]).filter(function(){
			return this["title"]!=undefined&&this["hidden"]!=true;
		});
		var rows=$(this).datagrid("getRows");
		var table=$("<table/>").css({
			"border-collapse": "collapse"
		});
		var thead=$("<thead/>").appendTo(table);
		var tr=$("<tr/>").appendTo(thead);
		if(options.rownumbers){
			$("<th/>").css("border","1px solid #000").html("序号").appendTo(tr);
		}
		$(columns).each(function(){
			$("<th/>").css({
				"border":"1px solid #000",
				 width:this["width"]
			}).html(this["title"]).appendTo(tr);
		});
		var tbody=$("<tbody/>").appendTo(table);
		for(var i=0,l=rows.length;i<l;i++){
			var row=rows[i];
			var tbodyTr=$("<tr/>").appendTo(tbody);
			if(options.rownumbers){
				$("<th/>").css("border","1px solid #000").html(i+1).appendTo(tbodyTr);
			}
			for(var j=0,jl=columns.length;j<jl;j++){
				var column=columns[j];
				var value=row[column["field"]];
				if(column["formatter"]!=undefined){
					value=column["formatter"].call(undefined,value,row,i);
				}
				$("<td/>").css("border","1px solid #000").attr("align",(column["align"]==undefined?"left":column["align"])).html(value).appendTo(tbodyTr);
			}
		}
		$("<div/>").append(table).printArea();
	};
})(jQuery);  