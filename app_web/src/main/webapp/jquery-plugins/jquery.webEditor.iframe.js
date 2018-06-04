/*******************************************************************************
 * 重建布局缓冲待优化
 * 
 * 布局重新计算
 * 
 * 
 */
(function($){
	var _ua = navigator.userAgent.toLowerCase();
	var _IE = _ua.indexOf('msie') > -1 && _ua.indexOf('opera') == -1;// IE10
	var _NEWIE = _ua.indexOf('msie') == -1 && _ua.indexOf('trident') > -1;// IE11
	var _GECKO = _ua.indexOf('gecko') > -1 && _ua.indexOf('khtml') == -1;
	var _WEBKIT = _ua.indexOf('applewebkit') > -1, _OPERA = _ua.indexOf('opera') > -1;
	var _MOBILE = _ua.indexOf('mobile') > -1;
	var _IOS = /ipad|iphone|ipod/.test(_ua);
	var _QUIRKS = document.compatMode != 'CSS1Compat';
	var _IERANGE = !window.getSelection;
	var _matches = /(?:msie|firefox|webkit|opera)[\/:\s](\d+)/.exec(_ua);
	var _V = _matches ? _matches[1] : '0';
	
	/** 布局初始化* */
	function init(){
		var options=$(this).data("webEditor").options;
		options.index=$(".webEditor").length;
		options.styleSheetIndex=document.styleSheets.length-1;
		/*****
		 * 初始化基本布局
		 */
		options.app=$(this).addClass("webEditor").layout({fit:true}).layout("add",{
			region: 'north',
			bodyCls:"toolbar",
		    height: 50
		}).layout("add",{
			region: 'center',
			border:false,
			bodyCls:"viewports viewports-"+options.index
		}).layout("add",{
			region: 'south',
			bodyCls:"statusbar",
			height:24
		}).layout('add',{   
		    region: 'west',    
		    width: 250,    
		    title: '导航',
		    split: true,
		    bodyCls:"navigationbar",
		    onCollapse:function(){
		    	options.navigationDisplay=false;
		    	$(options.toolbar[4].menu).menu("setIcon",{target:options.toolbar[4].menuOptions.root[3].items[2].menuItem.get(),iconCls:"tree-checkbox0"});
		    },
		    onExpand:function(){
		    	options.navigationDisplay=true;
		    	$(options.toolbar[4].menu).menu("setIcon",{target:options.toolbar[4].menuOptions.root[3].items[2].menuItem.get(),iconCls:"tree-checkbox1"});
		    }
		});
		/******
		 * 创建菜单栏
		 */
		createToolBar.call(options,options.app.layout("panel","north"));
		/*****
		 * 创建状态栏
		 */
		createStatusBar.call(options,options.app.layout("panel","south"));
		/******
		 * 创建导航栏
		 */
		createNavigationBar.call(options,options.app.layout("panel","west"));
		/*******
		 * 创建文档内容样式
		 */
		createCurrentCssRule.call(options);
		/******
		 * 加载文档内容
		 */
		$(this).webEditor("refreshDocument",options.href);
	};
	/** 创建文档区域水平布局* */
	function createViewportHorizontal($parent,len){
		if(len>1){
			var width=Math.ceil($parent.width()/len);
			var $layout=$("<div/>").appendTo($parent).layout({fit:true}).layout("add",{
				region:"west",
				split:true,
				width:width,
				border:true,
				split: false   
			}).layout("add",{
				region:"center",
				border:len==2
			});
			createViewportHorizontal.call(this,$layout.layout("panel","west"),1);
			createViewportHorizontal.call(this,$layout.layout("panel","center"),len-1);
		}else{
			$("<div/>").addClass("viewport-panel").appendTo($parent).panel({
				fit:true,
				loadingMessage:"正在加载...",
				border:len==1,
				bodyCls:"viewport"
			});
		}
	};
	/** 创建文档区域垂直布局* */
	function createViewportVertical($parent,len){
		if(len>1){
			var height=Math.ceil($parent.height()/len);
			var $layout=$("<div/>").appendTo($parent).layout({fit:true}).layout("add",{
				region:"north",
				split:false,
				border:true,
				height:height,
				border:true
			}).layout("add",{
				region:"center",
				border:len==2
			});
			createViewportVertical.call(this,$layout.layout("panel","north"),1);
			createViewportVertical.call(this,$layout.layout("panel","center"),len-1);
		}else{
			$("<div/>").addClass("viewport-panel").appendTo($parent).panel({
				fit:true,
				border:len==1,
				bodyCls:"viewport",
				loadingMessage:"正在加载..."
			});
		}
	};
	/** 创建文档区域表格布局* */
	function createViewportGrid($parent,len){
		var rownum=Math.ceil(len/2);
		if(rownum>1){
			var height=Math.ceil($parent.height()/rownum);
			var $layout=$("<div/>").addClass("easyui-layout").appendTo($parent).layout({fit:true}).layout("add",{
				region:"north",
				height:height,
				split:false,
				border:false,
				content:"&nbsp;"
			}).layout("add",{
				region:"center",
				border:false,
				content:"&nbsp;"
			});
			createViewportHorizontal.call(this,$layout.layout("panel","north").html(""),2);
			createViewportGrid.call(this,$layout.layout("panel","center").html(""),len-2);
		}else{
			createViewportHorizontal .call(this,$parent,len==1?len+1:len);
		}
	}
	/** 创建导航栏* */
	function createNavigationBar($parent){
		var $navigationbar=$("<div/>").appendTo($parent).layout({fit:true}).layout("add",{
			region:"north",
			height:40,
			border:false
		}).layout("add",{
			region:"center",
			border:false
		});
		createSearchBox.call(this,$navigationbar.layout("panel","north"));
		createNavigationTree.call(this,$navigationbar.layout("panel","center"));
	};
	/** 创建搜索盒子* */
	function createSearchBox($parent){
		var $searchbox=$("<input/>").css({"width":"100%"}).appendTo($parent.css("overflow","hidden")).searchbox({
			prompt:'请输入',
			searcher:function(value,name){
				//TODO
			}
		});
		this.components.searchbox=$searchbox;
	};
	/** 创建导航* */
	function createNavigationTree($parent){
		var $navigationtree=$("<ul/>").appendTo($parent).tree({
			checkbox : true,
			onClick:function(node){
				for(var i=0,l=node.viewports.length;i<l;i++){
					var $viewport=node.viewports[i];
					var unique=node.reference;
					if($viewport.find("li[unique='"+unique+"']").length==1){
						$viewport.scrollTop($viewport.find("li[unique='"+unique+"']:not('.none')").offset().top-$viewport.children(".my_word_document").offset().top);							
					}
				}
			},
			onCollapse:function(node){
				for(var i=0,l=node.viewports.length;i<l;i++){
					var $viewport=node.viewports[i];
					var unique=node.reference;
					$viewport.find("a[reference='" + unique + "']").parent("div").parent("li").children("ul").find("li[changed!='delete']").addClass("none");
					$viewport.find("li[unique='" + unique + "']").children("ul").find("li:not('[changed=\"delete\"]')").addClass("none");
				}
			},
			onExpand:function(node){
				for(var i=0,l=node.viewports.length;i<l;i++){
					var $viewport=node.viewports[i];
					var unique=node.reference;
					$viewport.find("a[reference='" + unique + "']").parent("div").parent("li").children("ul").find("li[changed!='delete']").removeClass("none");
					$viewport.find("li[unique='" + unique + "']").children("ul").find("li:not('[changed=\"delete\"]')").removeClass("none");
				}
			},
			onCheck:function(node,checked){
				for(var i=0,l=node.viewports.length;i<l;i++){
					var $viewport=node.viewports[i];
					var unique=node.reference;
					if (!checked) {
						$viewport.find("li[unique='"+unique+"']").addClass("none").find("li[changed!='delete']").addClass("none");
						$viewport.find("a[reference='" + unique + "']").parent("div").parent("li[changed!='delete']").addClass("none").find("li[changed!='delete']").addClass("none");
						cascade($viewport.find("li[unique='"+unique+"']"));
					} else {
						$viewport.find("li[unique='"+unique+"']").removeClass("none");
						$viewport.find("li[unique='"+unique+"']").parents("li[changed!='delete']").removeClass("none");
						$viewport.find("li[unique='"+unique+"']").find("li[changed!='delete']").removeClass("none");
						$viewport.find("a[reference='" + unique + "']").parent("div").parent("li").removeClass("none");
						$viewport.find("a[reference='" + unique + "']").parent("div").parent("li").parents("li[changed!='delete']").removeClass("none");
						$viewport.find("a[reference='" + unique + "']").parent("div").parent("li").find("li[changed!='delete']").removeClass("none");
					}
				}
			}
		});
		this.components.navigationtree=$navigationtree;
	}
	/** 创建工具栏* */
	function createToolBar($parent){
		var options=this;
		var $toolbar=$("<div/>").css("padding","5").css("border","1px solid #ddd").appendTo($parent);
		this.toolbar[0]={id:"main_page",text:"主页",iconCls:"myicon-house",plain:true,onClick:function(){
			window.location.href=options.home;
		}};
		this.toolbar[1]={text:"文件",iconCls:"myicon-page_word",plain:true,menuOptions:{root:[{text:"打开",iconCls:"myicon-folder_page",disabled:!options.openable,handler:function(){
			var options=$(this).data("options");
			options.onOpen.call(options);
		}},{separator:true},{text:"保存",iconCls:"myicon-disk",disabled:true},{text:"另存为",iconCls:"myicon-drive_disk",disabled:true},{separator:true},{text:"导出",iconCls:"myicon-page_white_word"},{separator:true},{text:"退出"}]}};
		this.toolbar[2]={text:"编辑",iconCls:"myicon-pencil",plain:true,menuOptions:{root:[{text:"撤销",iconCls:"myicon-arrow_undo"},{text:"恢复",iconCls:"myicon-arrow_redo"},{separator:true},{text:"剪切",iconCls:"myicon-cut_red"},{text:"复制",iconCls:"myicon-page_copy"},{text:"粘贴",iconCls:"myicon-page_paste"}]}};
		this.toolbar[3]={text:"插入",iconCls:"myicon-application_get",plain:true,menuOptions:{root:[{id:"insertImg",text:"图片",iconCls:"myicon-image"},{text:"表格",iconCls:"myicon-table",content:createTableTool.call(this)}/*,{text:"变量",iconCls:"myicon-tag_blue",items:createVariableTool.call(this)}*/]}};
		this.toolbar[4]={text:"视图",iconCls:"myicon-layout",plain:true,menuOptions:{root:[{text:"← →"},{text:"100%"},{separator:true},{text:"布局",iconCls:"myicon-layout",items:[{text:"封面",iconCls:"tree-checkbox1"},{text:"目录",iconCls:"tree-checkbox1"},{text:"导航窗格",iconCls:"tree-checkbox1"}]},{separator:true},{text:"字体颜色",iconCls:"myicon-palette",content:createFontColorSelector.call(this)},{text:"背景颜色",iconCls:"myicon-paintcan",content:createBackgroundColorSelector.call(this)}]}};
		this.toolbar[5]={text:"审阅",iconCls:"myicon-tag_red",plain:true,menuOptions:{root:[{text:"新建批注",iconCls:"myicon-comment_add"},{separator:true},{text:"上一个",iconCls:"myicon-resultset_previous"},{text:"下一个",iconCls:"myicon-resultset_next"},{separator:true},{text:"显示批注"}]}};
		this.toolbar[6]={text:"帮助",iconCls:"myicon-help",plain:true,menuOptions:{root:[{text:"帮助"},{text:"关于"}]}};
		this.toolbar[7]={id:"create_send_file",text:"生成投标文件",iconCls:"myicon-table_edit",plain:true,onClick:function(){
			if($("li[name='send_file']").length==0){
				$.messager.alert("系统提示","请打开招标文件！");
				return;
			}
			$("#create_send_file").hide();
			$(".my_word_document>.my_word_center>.my_word_body>ul").html($("li[name='send_file']"));
			$(options.app).webEditor("setContent",[$(".my_word_document")]);
		}};
		this.toolbar[8]={id:"send_file_form",text:"表单",iconCls:"myicon-table_edit",plain:true,onClick:function(){
			var id=new Date().getTime();
			$("<div/>").attr("id",id).css("padding",5).dialog({
				title:"表单项",
				width:440,
				height:330,
				modal:true,
				onOpen:function(){
					var paramObject={};
					$(".my_word_document>.my_word_properties").children("span").each(function(){
						paramObject[$(this).attr("name")]=$(this).html();
					});
					$("#"+id+" form").form("load",paramObject);
				},
				content:"<form>\
							<table>\
								<tr>\
						 			<td>质量：</td><td><input name='bidQuality' type='name' class='inputxt easyui-validatebox' data-options='required:true'/></td>\
						 		</tr>\
								<tr>\
						 			<td>投标报价金额：</td><td><input name='bidPrice' type='name' class='inputxt easyui-validatebox' data-options='required:true' onblur=\"if(isNaN(this.value)){ this.value='';$(':input[name=bidPriceChinese]').val(''); }else{ $(':input[name=bidPriceChinese]').val(convertCurrency(this.value)); }\"/>元</td>\
						 		</tr>\
								<tr>\
						 			<td>报价金额大写：</td><td><input name='bidPriceChinese' type='name' class='inputxt' readonly='readonly'/></td>\
						 		</tr>\
						 		<tr>\
						 			<td>工期：</td><td><input name='bidDeliveryTimeLimit' type='name' class='inputxt easyui-validatebox' data-options='required:true' onblur=\"this.value=isNaN(this.value)?'':this.value;\"/>天</td>\
						 		</tr>\
						 		<tr>\
						 			<td>投标单位项目负责人：</td><td><input name='bidPrincipal' type='name' class='inputxt easyui-validatebox' data-options='required:true'/></td>\
						 		</tr>\
						 		<tr>\
						 			<td>投标有效期：</td><td><input name='bidBidValidity' type='name' class='inputxt easyui-validatebox' data-options='required:true' onblur=\"this.value=isNaN(this.value)?'':this.value;\" value='90'/>天</td>\
						 		</tr>\
							</table>\
						 </form>",
				buttons:[
				      {text:"保存",color:"red",handler:function(){
				    	  if($("#"+id+" form").form("validate")){
				    		  var paramArray=$("#"+id+" form").serializeArray();
					    	  var paramObject={};
					    	  $(paramArray).each(function(){
					    		 if(!paramObject[this.name]){
					    			 paramObject[this.name]=[];
					    		 }
					    		 paramObject[this.name].push(this.value);
					    	  });
					    	  for(var name in paramObject){
					    		  var value=paramObject[name].join(",");
					    		  if($(".my_word_document>.my_word_properties>span[name='"+name+"']").length==0){
					    			  $(".my_word_document>.my_word_properties").append("<span name='"+name+"'></span>");
					    		  }
					    		  $(".my_word_document>.my_word_properties>span[name='"+name+"']").html(value);
					    		  $("span.need_input[name='"+name+"']").html(value);
					    	  }
					    	  $("#"+id).dialog("destroy");
				    	  }
				      }},
				      {text:"取消",color:"red",handler:function(){
				    	  $("#"+id).dialog("destroy");
				      }}
				]
			});
		}};
		for(var i=0,l=this.toolbar.length;i<l;i++){
			createToolbarButton.call(this,$toolbar,this.toolbar[i]);
		}
		/*****
		 * 投标文件表单内容
		 */
		$("#send_file_form").hide();
		$("#create_send_file").toggle(options.client);
		/******
		 * 是否展示首页按钮
		 */
		$("#main_page").toggle(options.home!=undefined);
		/** 打开* */
		/*this.toolbar[1].menuOptions.root[0].menuItem.data("options",options).click(function(e){
			
		});*/
		/** 保存***/
		this.toolbar[1].menuOptions.root[2].menuItem.data("options",options).click(function(e){
			var options=$(this).data("options");
			options.app.layout("panel","center").find(".my_word_document :focus").blur();
			var paramArray=param.call(options);
			if (paramArray.length==0) {
				$.messager.alert("系统提示", "没有任何修改");
				return;
			}
			options.onSave.call(options,paramArray);
		});
		/** 另存为* */
		this.toolbar[1].menuOptions.root[3].menuItem.data("options",options).click(function(e){
			var options=$(this).data("options");
			var paramArray=param.call(options);
			options.onSaveAs.call(options,paramArray);
		});
		/** 插入图片* */
		if(options.uploadURL){
			/*****
			 * 服务模式
			 */
			var uploader = new plupload.Uploader({
				runtimes : 'html5,flash,silverlight,html4',
				browse_button : 'insertImg',
				//container : document.getElementById('container'),
				url : options.uploadURL,
				flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
				silverlight_xap_url :'/resources/plupload-2.1.2/js/Moxie.xap',
				multi_selection : true,
				file_data_name:"image",
				multipart_params : {
				},
				filters : {
					mime_types : [ //只允许上传图片和zip文件
						{ title : "Image files", extensions : "jpg,gif,png,bmp" },
					],
					prevent_duplicates : true,//不允许选取重复文件
					max_file_size : '32mb'//最大只能上传400kb的文件
				},
				init : {
					PostInit : function() {
					},
					FilesAdded : function(up, files) {
						up.start();
					},
					UploadProgress : function(up, file) {
					},
					FileUploaded : function(up, file, result) {
						var data=$.parseJSON(result.response);
						if (data.success) {
							insertObject.call(options,$("<img/>").attr("src",data.data).load(function(){
								var width=$(this).width();
								var height=$(this).height();
								if(width>640){
									height=height*(640/width);
									width=width*(640/width);
								}
								$(this).width(width*options.scale.oldValue).height(height*options.scale.oldValue).attr("data","{width:"+width+",height:"+height+"}");
							}));
						}
						up.removeFile(file);
					},
					UploadComplete : function(uploader, files) {
					},
					Error : function(up, err) {
						//$.jGrowl(err);
					},
					FilesRemoved:function(up,files){
					}
				}
			});
			uploader.init();
		}else{
			/*****
			 * 本地模式
			 */
			this.toolbar[3].menuOptions.root[0].menuItem.data("options",options).off().append(
				$("<input/>").attr({"name":"image","type":"file","accept":".jpg,.png,.gif,.bmp","multiple":true}).css({"position":"absolute","z-index":999,"font-size":500,"margin-top":-5,"margin-left":-60,"width":200,"line-height":200,"opacity": 0})
			).on("change","input",function(e){
				var options=$(this).parent().data("options");
				insertObject.call(options,$("<img/>").attr("src",this.value+"?t="+new Date()).load(function(){
					var width=$(this).width();
					var height=$(this).height();
					if(width>640){
						height=height*(640/width);
						width=width*(640/width);
					}
					$(this).width(width*options.scale.oldValue).height(height*options.scale.oldValue).attr("data","{width:"+width+",height:"+height+"}");
				}));
				$(this).remove();
				$("<input/>").attr({"type":"file","accept":".jpg,.png,.gif,.bmp","multiple":true}).css({"position":"absolute","z-index":999,"font-size":500,"margin-top":-5,"margin-left":-60,"width":200,"line-height":200,"opacity": 0}).appendTo(options.toolbar[3].menuOptions.root[0].menuItem);
			});
		}
		/** 宽度100%* */
		this.toolbar[4].menuOptions.root[0].menuItem.data("options",this).click(function(e){
			var options=$(this).data("options");
			for(var i=0,l=options.components.viewports.length;i<l;i++){
				var $viewport=options.components.viewports[i];
				var scale=Math.round(($viewport.width()-25)/$.fn.webEditor.methods.cssRules["div.my_word_document"]["width"]*100);
				options.components.slider.slider("setValue",scale<50?50:(scale>300?300:scale));
				break;
			}
		});
		/** 显示比例100%* */
		this.toolbar[4].menuOptions.root[1].menuItem.data("options",this).click(function(e){
			var options=$(this).data("options");
			options.components.slider.slider("setValue",100);
		});
		/** 封面是否显示* */
		this.toolbar[4].menuOptions.root[3].items[0].menuItem.data("options",this).click(function(e){
			var options=$(this).data("options");
			if(options.coverDisplay){
				$(options.toolbar[4].menu).menu("setIcon",{target:this,iconCls:"tree-checkbox0"});
				options.app.layout("panel","center").find(".my_word_cover").addClass("none");
			}else{
				$(options.toolbar[4].menu).menu("setIcon",{target:this,iconCls:"tree-checkbox1"});
				options.app.layout("panel","center").find(".my_word_cover").removeClass("none");
			}
			options.coverDisplay=!options.coverDisplay;
		});
		/** 目录是否显示* */
		this.toolbar[4].menuOptions.root[3].items[1].menuItem.data("options",this).click(function(e){
			var options=$(this).data("options");
			if(options.catalogueDisplay){
				$(options.toolbar[4].menu).menu("setIcon",{target:this,iconCls:"tree-checkbox0"});
				options.app.layout("panel","center").find(".my_word_catalogue").addClass("none");
			}else{
				$(options.toolbar[4].menu).menu("setIcon",{target:this,iconCls:"tree-checkbox1"});
				options.app.layout("panel","center").find(".my_word_catalogue").removeClass("none");
			}
			options.catalogueDisplay=!options.catalogueDisplay;
		});
		/** 导航窗格是否显示* */
		this.toolbar[4].menuOptions.root[3].items[2].menuItem.data("options",this).click(function(e){
			var options=$(this).data("options");
			if(options.navigationDisplay){
				$(options.toolbar[4].menu).menu("setIcon",{target:this,iconCls:"tree-checkbox0"});
			}else{
				$(options.toolbar[4].menu).menu("setIcon",{target:this,iconCls:"tree-checkbox1"});
			}
			options.app.layout(options.navigationDisplay?"collapse":"expand","west");
		});
		/** 新建批注* */
		this.toolbar[5].menuOptions.root[0].menuItem.data("options",this).click(function(e){
			// TODO 添加顺序
			var options=$(this).data("options");
			var $selected = options.app.layout("panel","center").find(".my_word_document pre.datagrid-row-selected");
			if ($selected.length == 0 || $selected.length != $($selected[0]).parent("li").find("pre.datagrid-row-selected").length) {
				$.messager.alert("系统提示", "请选择一处要批注的内容");
				return false;
			}
			if (!options.commentDisplay) {
				options.toolbar[5].menuOptions.root[5].menuItem.click();
			}
			var $pre=$($selected[0]);
			var $li=$pre.parent("li");
			var $document=$li.parents(".my_word_document:first");
			var unique= $li.attr("unique");
			if (!$li.data("comment")) {
				var top = Math.ceil($li.offset().top - $document.offset().top);
				var $div=$("<div/>").attr("unique",unique).attr("tabindex", "-1").attr("changed", "create").addClass("tooltip tooltip-right").append($("<div/>").attr("contenteditable", "true").addClass("tooltip-content")).append($("<div/>").addClass("tooltip-arrow-outer").attr("style", "border-right-color: rgb(149, 184, 231)")).append($("<div/>").addClass("tooltip-arrow").attr("style", "border-right-color: rgb(255,255,255)")).appendTo($document.children(".my_word_comment")).css("top", top).data("li",$li);
				$li.data("comment",$div);
			}
			$li.data("comment").children(".tooltip-content").focus();
		});
		/** 批注是否显示* */
		this.toolbar[5].menuOptions.root[5].menuItem.data("options",this).click(function(e){
			var options=$(this).data("options");
			for(var i=0,l=options.components.viewports.length;i<l;i++){
				var $viewport=options.components.viewports[i];
				$viewport.children(".my_word_document").children(".my_word_comment").toggle(!options.commentDisplay);
				$(this).toggleClass("datagrid-row-selected");
				if(options.commentDisplay){
					options.cssRules["div.my_word_document"]["cssRule"]["style"]["width"]=options.cssRules["div.my_word_document"]["cssStyle"]["width"]+"px";
				}else{
					options.cssRules["div.my_word_document"]["cssRule"]["style"]["width"]=(options.cssRules["div.my_word_document"]["cssStyle"]["width"]+options.cssRules["div.my_word_document > div.my_word_comment"]["cssStyle"]["width"]+1)+"px";
				}
			}
			options.commentDisplay=!options.commentDisplay;
		});
		$("toolbar,.toolbar *,.menu-item,.menu-item *,.menu-content,.menu-content *").mousedown(function(){
			return false;
		}).attr("unselectable","on");
	};
	/** 创建工具栏按钮* */
	function createToolbarButton($parent,options){
		if(options.menuOptions){
			options.menu=menu.call(this,options.menuOptions.root).get();
			options.button=$("<a/>").appendTo($parent).menubutton(options);	
		}else{
			options.button=$("<a/>").appendTo($parent).linkbutton(options);		
		}
	};
	/** 创建状态栏* */
	function createStatusBar($parent){
		var $statusbar=$("<div/>").appendTo($parent).layout({fit:true}).layout("add",{
			region:"west",
			width:300,
			content:"&nbsp;",
			border:false
		}).layout("add",{
			region:"east",
			width:300,
			content:"&nbsp;",
			border:false
		}).layout("add",{
			region:"center",
			content:"&nbsp;",
			border:false
		});
		createScaleTool.call(this,$statusbar.layout("panel","east").html(""));
	};
	/** 创建放缩工具* */
	function createScaleTool($parent){
		var $table=$("<table/>").appendTo($parent).css({
			width:300,
			color:"#ffffff",
			cursor:"pointer",
			textAlign:"center",
			padding:0
		});
		var $tbody=$("<tbody/>").appendTo($table);
		var $tr=$("<tr/>").appendTo($tbody);
		$("<td/>").appendTo($tr).append($("<a id='openEdit'/>").css({color:"#fff",weight:900}).hide().html("<nobr>编辑</nobr>")).width(30);
		$("<td/>").appendTo($tr).append($("<a id='openRead'/>").css({color:"#fff",weight:900}).hide().html("<nobr>阅读</nobr>")).width(30);
		createZoomOutButton.call(this,$("<td/>").appendTo($tr).width(20));
		createSlider.call(this,$("<td/>").appendTo($tr));
		createZoomInButton.call(this,$("<td/>").appendTo($tr).width(20));
		createZoomPercentLabel.call(this,$("<td/>").appendTo($tr).width(40));
	};
	/** 放缩比例* */
	function createZoomPercentLabel($parent){
		var $zoompercentlabel=$("<div/>").html(this.zoomPercent+"%").appendTo($parent);
		this.components.zoompercent=$zoompercentlabel;
	};
	/** 创建放大按钮* */
	function createZoomInButton($parent){
		var $zoominbutton=$("<div/>").html("﹢").appendTo($parent).click(this,function(e){
			e.data.components.slider.slider('setValue',Math.floor(e.data.components.slider.slider('getValue')/10)*10+10);
		});
		this.components.zoominbutton=$zoominbutton;
	};
	/** 创建缩小按钮* */
	function createZoomOutButton($parent){
		var $zoomoutbutton=$("<div/>").html("﹣").appendTo($parent).click(this,function(e){
			e.data.components.slider.slider('setValue',Math.ceil(e.data.components.slider.slider('getValue')/10)*10-10);
		});
		this.components.zoomoutbutton=$zoomoutbutton;
	};
	/** 创建滑动条* */
	function createSlider($parent){
		var options=this;
		options.scale={block:false,oldValue:options.zoomPercent/100,newValue:options.zoomPercent/100};
		var $slider=$("<input/>").appendTo($parent).slider({
			value:options.zoomPercent,
			min:50,
			max:300,
			showTip:false,
			width:160,
			onChange:function(newValue,oldValue){
				options.components.zoompercent.html(newValue+"%");
				options.scale.newValue=newValue/100.0;
				rescale.call(options);
			}
		});
		options.components.slider=$slider;
	};
	/** 创建当前编辑器文档样式* */
	function createCurrentCssRule2(options){
		//TODO
		var rules = this.styleSheets[0].cssRules?this.styleSheets[0].cssRules:this.styleSheets[0].rules;
		for(var key in $.fn.webEditor.methods.cssRules){
			var selector=key;
			var ruleText="";
			var cssStyle={};
			for(var ruleName in $.fn.webEditor.methods.cssRules[key]){
				cssStyle[ruleName]=$.fn.webEditor.methods.cssRules[key][ruleName]*options.zoomPercent/100;
				ruleText+=ruleName+":"+($.fn.webEditor.methods.cssRules[key][ruleName]*options.zoomPercent/100)+"px;";
			}
			if(key=="div.my_word_document"||key=="div.my_word_document a"){
				ruleText+="color:"+options.fontColor+";background-color:"+options.backgroundColor;
			}
			options.cssRules[key]={"cssStyle":cssStyle};
			var ruleIndex=rules.length;
			if(this.styleSheets[0].addRule){
				this.styleSheets[0].addRule(selector,ruleText,ruleIndex);  
			}else{
				this.styleSheets[0].insertRule(selector+"{"+ruleText+"}",ruleIndex);
			}
		}
		for (var j = 0,l=rules.length;j < l; j++) {
			var rule = rules[j];
			var selectorText = rule.selectorText;
			if (selectorText&& selectorText != null) {
				selectorText = selectorText.toLowerCase();
				if($.fn.webEditor.methods.cssRules[selectorText]){
					options.cssRules[selectorText]["cssRule"]=rule;
				}
				
			}
		}
	};
	/** 创建当前编辑器文档样式* */
	function createCurrentCssRule(){
		var options=this;
		var rules = document.styleSheets[options.styleSheetIndex].cssRules?document.styleSheets[options.styleSheetIndex].cssRules:document.styleSheets[options.styleSheetIndex].rules;
		for(var key in $.fn.webEditor.methods.cssRules){
			var selector="div.viewports-"+options.index+" "+key;
			var ruleText="";
			var cssStyle={};
			for(var ruleName in $.fn.webEditor.methods.cssRules[key]){
				cssStyle[ruleName]=$.fn.webEditor.methods.cssRules[key][ruleName]*options.zoomPercent/100;
				ruleText+=ruleName+":"+($.fn.webEditor.methods.cssRules[key][ruleName]*options.zoomPercent/100)+"px;";
			}
			if(key=="div.my_word_document"||key=="div.my_word_document a"){
				ruleText+="color:"+options.fontColor+";background-color:"+options.backgroundColor;
			}
			options.cssRules[key]={"cssStyle":cssStyle};
			var ruleIndex=rules.length;
			if(document.styleSheets[options.styleSheetIndex].addRule){
				document.styleSheets[options.styleSheetIndex].addRule(selector,ruleText,ruleIndex);  
			}else{
				document.styleSheets[options.styleSheetIndex].insertRule(selector+"{"+ruleText+"}",ruleIndex);
			}
		}
		for (var j = 0; j < rules.length; j++) {
			var rule = rules[j];
			var selectorText = rule.selectorText;
			if (selectorText&& selectorText != null) {
				selectorText = selectorText.toLowerCase();
				if(selectorText.indexOf("div.viewports-"+options.index)!=-1){
					selectorText=selectorText.substring((("div.viewports-"+options.index).length+1),selectorText.length);
					if($.fn.webEditor.methods.cssRules[selectorText]){
						options.cssRules[selectorText]["cssRule"]=rule;
					}
				}
			}
		}
	};
	/*function createVariableTool(){
		return [
        	{text:"招标人"},
        	{text:"招标项目名称"},
        	{text:"招标项目编号"},
        	{text:"招标内容与范围"},
        	{text:"资金来源"},
        	{text:"招标组织形式"},
        	{text:"资格审查方式"},
        	{text:"招标方式"},
        	{text:"招标组织形式"},
        	{text:"联系人(招标人)"},
        	{text:"联系方式(招标人)"},
        	{text:"代理机构"},
        	{text:"联系人(代理机构)"},
        	{text:"联系方式(代理机构)"},
        	{text:"交货期"},
        	{text:"交货地点"},
        	{text:"投标有效期"},
        	{text:"文件获取开始时间"},
        	{text:"文件获取截止时间"},
        	{text:"投标文件递交截止时间"},
        	{text:"开标时间"},
        	{text:"开标地点"},
        	{text:"开标方式"},
        	{text:"评标办法"}
        ];
	}*/
	/** 创建插入表格工具* */
	function createTableTool(){
		var $tableTool=$("<div/>");
		createHoverTableTool.call(this,$tableTool);
		return $tableTool;
	};
	/** 创建浮动表格插入工具* */
	function createHoverTableTool($parent){
		var options=this;
		var $hoverTable=$("<table/>").appendTo($parent).addClass("hover_table");
		var $thead=$("<thead/>").appendTo($hoverTable);
		var $tbody=$("<tbody/>").appendTo($hoverTable);
		$("<tr/>").append($("<th/>").attr("colspan",10).html("插入表格")).appendTo($thead);
		for(var i=0;i<8;i++){
			var $tr=$("<tr/>").appendTo($tbody);
			for(var j=0;j<10;j++){
				$("<td/>").append($("<div/>").append($("<div/>"))).appendTo($tr);
			}
		}
		$hoverTable.on("mouseover","tbody>tr>td",function(){
			var $ctd = $(this);
			var $ctr = $ctd.parent("tr");
			var $table = $ctr.parent("tbody").parent("table.hover_table");
			var colnum = $ctd.index();
			var rownum = $ctr.index();
			for (var i = 0; i <= rownum; i++) {
				var $tr = $($tbody.find("tr")[i]);
				for (var j = 0; j <= colnum; j++) {
					$($tr.find("td")[j]).children("div").addClass("hover");
				}
			}
			$table.children("thead").children("tr").children("th").html((colnum+1)+"x"+(rownum+1)+"表格");
		}).on("mouseout","tbody>tr>td",function(){
			var $ctd = $(this);
			var $ctr = $ctd.parent("tr");
			var $table = $ctr.parent("tbody").parent("table.hover_table");
			$table.find("td>div").removeClass("hover");
			$table.children("thead").children("tr").children("th").html("插入表格");
		}).on("click","tbody>tr>td",this,function(e){
			var $ctd = $(this);
			var $ctr = $ctd.parent("tr");
			var $table = $ctr.parent("tbody").parent("table.hover_table");
			var colnum = $ctd.index();
			var rownum = $ctr.index();
			$(options.toolbar[3].menu).menu("hide");
			insertObject.call(e.data,createTable.call(e.data,colnum+1,rownum+1));
		});
	};
	/** 创建字体颜色选择器* */
	function createFontColorSelector(){
		var $fontColorSelector=$("<div/>").width(422);
		var $fontColorInput=$("<input/>").val(this.fontColor).appendTo($fontColorSelector);
		$fontColorInput.change(this,function(e){
			$fontColorInput.spectrum({
				color : $fontColorInput.val(),
				flat : true,
				showInput : true,
				className: "full-spectrum",
				clickoutFiresChange: true,
				showInitial : true,
				showInput: false,
				showPalette : true,
				showSelectionPalette : true,
				maxPaletteSize : 10,
				preferredFormat : "hex",
				change : function(color) {
					e.data.cssRules["div.my_word_document"]["cssRule"]["style"]["color"]=color.toHexString();
					e.data.cssRules["div.my_word_document a"]["cssRule"]["style"]["color"]=color.toHexString();
				},
				palette : $.fn.webEditor.methods.colors
			});
		}).change();
		return $fontColorSelector;
	};
	/** 创建背景颜色选择器* */
	function createBackgroundColorSelector(){
		var $backgroundColorSelector=$("<div/>").width(422);
		var $backgroundColorInput=$("<input/>").val(this.backgroundColor).appendTo($backgroundColorSelector);
		$backgroundColorInput.change(this,function(e){
			$backgroundColorInput.spectrum({
				color : $backgroundColorInput.val(),
				flat : true,
				showInput : true,
				className: "full-spectrum",
				clickoutFiresChange: true,
				showInitial : true,
				showInput: false,
				showPalette : true,
				showSelectionPalette : true,
				maxPaletteSize : 10,
				preferredFormat : "hex",
				change : function(color) {
					e.data.cssRules["div.my_word_document"]["cssRule"]["style"]["backgroundColor"]=color.toHexString();
					e.data.cssRules["div.my_word_document a"]["cssRule"]["style"]["backgroundColor"]=color.toHexString();
				},
				palette : $.fn.webEditor.methods.colors
			});
		}).change();
		return $backgroundColorSelector;
	};
	/** 文档放大缩小* */
	function rescale(){
		var options=this;
		if(!options.scale.block){
			options.scale.block=true;
			window.setTimeout(function() {
				options.scale.block=false;
				if(options.scale.newValue!=options.scale.oldValue){
					for(var i=0,l=options.components.viewports.length;i<l;i++){
						var $viewport=options.components.viewports[i];
						$viewport.data("scrollTop",($viewport.scrollTop()-20)/$viewport.children(".my_word_document").height());
					}
					var num =options.scale.newValue;
					for(var selectorText in options.cssRules){
						for(var key in $.fn.webEditor.methods.cssRules[selectorText]){
							var data=key.split("-");
							var key_=data[0];
							for(var k=1;k<data.length;k++){
								key_+=data[k].charAt(0).toUpperCase()+data[k].substring(1,data[k].length);
							}
							options.cssRules[selectorText]["cssRule"].style[key_]=Math.ceil($.fn.webEditor.methods.cssRules[selectorText][key]*num)+"px";
							options.cssRules[selectorText]["cssStyle"][key]=Math.ceil($.fn.webEditor.methods.cssRules[selectorText][key]*num);
						}
					}
					if(options.commentDisplay){
						options.cssRules["div.my_word_document"]["cssRule"]["style"]["width"]=(options.cssRules["div.my_word_document"]["cssStyle"]["width"]+options.cssRules["div.my_word_document > div.my_word_comment"]["cssStyle"]["width"]+1)+"px";
					}
					// 图片放缩
					options.app.layout("panel","center").find(".my_word_document img").each(function(){
						var data=eval("("+$(this).attr("data")+")");
						var imgWidth=$(this).width();
						var imgHeight=$(this).height();
						var dataWidth=imgWidth/options.scale.oldValue;
						var dataHeight=imgHeight/options.scale.oldValue;
						if(data.width!=dataWidth||data.height!=dataHeight){
							$(this).attr("data","{width:"+dataWidth+",height:"+dataHeight+"}");
						}
						data=eval("("+$(this).attr("data")+")");
						$(this).width(data.width*num);
						$(this).height(data.height*num);
					});
					// 滚动条批注重新定位
					for(var i=0,l=options.components.viewports.length;i<l;i++){
						var $viewport=options.components.viewports[i];
						$viewport.scrollTop($viewport.data("scrollTop")*$viewport.children(".my_word_document").height()+20);
						$viewport.removeData("scrollTop");
						relocateComments.call(options,$viewport);
					}
					options.scale.oldValue=options.scale.newValue;
				}
			}, 200);
		}
	};
	/** 递归目录* */
	function varCatalogue($ul) {
		var $catalogueUl = $("<ul/>");
		$ul.children("li[isTitle='true'][changed!='delete']").each(function(){
			var $li = $(this);
			var levelNo = parseInt($li.attr("levelNo"));
			var retract = (levelNo - 1) < 0 ? 0 : ((levelNo - 1) * 2);
			var $catalogueLi = $("<li/>");
			if ($li.hasClass("none")) {
				$catalogueLi.addClass("none");
			}
			//var $anchor = $li.children("a");
			$catalogueLi.append($("<div/>").append($("<a/>").attr("reference",$li.attr("unique")).css("paddingLeft", retract + "em").html($li.children("pre").text()))).appendTo($catalogueUl);
			$catalogueLi.append(varCatalogue($li.children("ul")));
		});
		return $catalogueUl;
	};
	/** 批注重新定位* */
	function relocateComments($viewport){
		var options=this;
		$viewport.find(".my_word_document>.my_word_comment>.tooltip").each(function(){
			relocateComment.call(options,$(this));
		});
	};
	/** 单个批注重新定位* */
	function relocateComment($comment){
		var $li=$comment.data("li");
		$comment.css("top",$li.offset().top - $comment.parent(".my_word_comment").parent(".my_word_document").offset().top);
	};
	/** 导航选择事件递归* */
	function cascade($li) {
		if ($li.siblings("li[changed!='delete']").filter(function(i) {
			return !$(this).hasClass("none");
		}).length == 0) {
			var $parentLi = $li.parent("ul").parent("li");
			if ($parentLi.length == 1) {
				$parentLi.addClass("none");
				var name = $parentLi.children("a").attr("name");
				$("a[href='#" + name + "']").parent("div").parent("li").addClass("none");
				cascade($parentLi);
			}
		}
	};
	/** 创建指定行列的表格(工具)* */
	function createTable(colnum,rownum){
		return $("<table/>").append(
			$("<tbody/>").each(function(){
				for(var i=0;i<rownum;i++){
					$("<tr/>").each(function(){
						for(var i=0;i<colnum;i++){
							$("<td/>").append($("<br/>")).appendTo($(this));
						}
					}).appendTo($(this));
				}
			})
		);
	};
	function getFirstRange(){
		var sel = rangy.getSelection();
        return sel.rangeCount ? sel.getRangeAt(0) : null;
	}
	/** 插入对象* */
	function insertObject(obj){
		var range = getFirstRange();
        if (range) {
            var el = document.createElement("span");
            range.insertNode(el);
            rangy.getSelection().setSingleRange(range);
            $(el).replaceWith(obj);
        }
	};
	/** 孩子节点序号排序* */
	function sort($ul) {
		var options=this;
		var no=0;
		var unique=$ul.parent("li").attr("unique");
		$ul.children("li").filter(function(){ return !$(this).attr("changed")||$(this).attr("changed")!="delete";}).each(function(i) {
			var $li = $(this);
			$li.attr({orderno:i,unique:unique+"-"+i});
			var data = eval("(" + $li.attr("data") + ")");
			if ($li.data("id") && !$li.attr("changed")) {
				if (i!= data.orderno) {
					$li.attr("changed", "update");
				}
			}
			if($li.attr("noDisplay") == "true"){
				getSequenceNumber.call(options,$li, no++);
			}
			if($li.data("comment")){
				var $comment=$li.data("comment");
				if(!$comment.attr("changed")&&$li.attr("unique")!=$comment.attr("reference")){
					$comment.attr("changed","update");
				}
				relocateComment.call(options,$comment.attr("reference",$li.attr("unique")));
			}
			if ($li.children("ul").length == 1) {
				sort($li.children("ul"));
			}
		});
	};
	/** 获取序号* */
	function getSequenceNumber($li, index){
		var i = index + 1;
		var no = "";
		if ($li.attr("noDisplay") == "true") {
			var $parentLi = $li.parent("ul").parent("li");
			var noType = $parentLi.attr("noType");
			var prefix = $parentLi.attr("no");
			if ("SIMPLE" === noType) {
				no = i;
			} else if ("BRACKET" === (noType)) {
				no = "(" + i + ")";
			} else if ("EXTEND" === noType) {
				no = /^[\d]+(\.[\d]+)*$/.test(prefix) ? (prefix + "." + i) : i;
			} else if ("CHINESE" === noType) {
				no = transfer(i);
			} else if ("PART" === (noType)) {
				no = "第" + transfer(i) + "部分";
			} else if ("CHAPTER" === (noType)) {
				no = "第" + transfer(i) + "章";
			} else if ("ITEM" === (noType)) {
				no = "第" + transfer(i) + "条";
			}
		}
		($li.children("pre").data("index")?$li.children("pre").data("index"):$li.children("pre").children("span.index")).html(no == "" ? "" : (no + "、"));
	};
	/** 数字转中文(工具)* */	
	function transfer(num) {
		var input = "" + num;
		var danwei = [ "", "十", "百", "千", "万", "十", "百", "千", "亿" ];
		var chinese = [ "零", "一", "二", "三", "四", "五", "六", "七", "八", "九" ];
		var l = input.length;
		var result = "";
		for (var i = 0; i < l; i++) {
			var chineseNum = chinese[parseInt(input.charAt(i))];
			var chineseUnit = danwei[l - i - 1];
			result += chineseNum + chineseUnit;
		}
		return result;
	};
	/** 删除数据* */
	function deleteData($li){
		var isTitle = $li.attr("isTitle") == "true";
		var $ul=$li.parent("ul");
		if ($li.data("id")) {
			if($li.data("comment")){
				$li.data("comment").attr("changed", "delete").hide().addClass("none");
			}
			$li.addClass("none").attr("changed", "delete").removeAttr("unique");
			$li.children("ul").find("li").removeAttr("unique").removeAttr("changed");
		} else {
			if($li.data("comment")){
				$li.data("comment").remove();
			}
			$li.remove();
		}
		sort($ul);
		if (isTitle) {
			refreshCatalogue.call(this,$li.parents(".viewport:first"));
			refreshNavigationtree.call(this);
		}
	};
	/** 刷新目录* */
	function refreshCatalogue($viewport){
		$viewport.find(".my_word_document>.my_word_center>.my_word_catalogue").html($("<h1/>").html("目录")).append(varCatalogue($viewport.find(".my_word_document>.my_word_center>.my_word_body>ul>li>ul")));
	};
	/** 刷新导航* */
	function refreshNavigationtree(){
		var array=[];
		this.app.layout("panel","center").parent().find(".viewport").each(function(){
			array=varNavigationtree($(this),$(this).find(".my_word_document>.my_word_center>.my_word_body>ul>li>ul"),array);
		});
		navigationtreeSort.call(this,array);
		this.components.navigationtree.tree("loadData",array);
	};
	/** 递归导航* */
	function varNavigationtree($panel,$ul,array) {
		$ul.children("li[isTitle='true'][changed!='delete']").each(function(i){
			var $li = $(this);
			var keyword=$li.attr("levelno")+$li.children("pre").text().substr($li.children("pre").children(".index").text().length);
			var notHasLi=true;
			var index=0;
			for(var l=array.length;index<l;index++){
				if(keyword==array[index].keyword){
					notHasLi=false;
					break;
				}
			}
			if(notHasLi){
				array[index] = {
					keyword:keyword,
					itemId:$li.data("id")?$li.data("id"):"",
					index:$li.attr("orderno"),
					reference : $li.attr("unique"),
					iconCls : "myicon-note",
					text : ($li.children("pre").data("index")?$li.children("pre").data("index").text():"")+$li.children("pre").text(),
					checked : !$li.hasClass("none"),
					viewports:[$panel]
				};
			}else{
				array[index].viewports.push($panel);
			}
			var $childUl = $li.children("ul");
			if ($childUl.length == 1) {
				array[index].children = varNavigationtree($panel,$childUl,array[index].children?array[index].children:[]);
			}
		});
		return array;
	};
	/** 导航排序* */
	function navigationtreeSort(array){
		array.sort(function(a,b){
			return a.index>=b.index?1:-1;
		});
		if(array.children){
			navigationtreeSort(array.children);
		}
	};
	/** 创建菜单(工具)* */
	function menu(items){
		return varMenu.call(this,items).addClass("easyui-menu").menu({hideOnUnhover:false}).appendTo($("body"));
	};
	/** 递归菜单(工具)* */
	function varMenu(items){
		var $menu=$("<div/>").css({width:180});
		for(var i=0,l=items.length;i<l;i++){
			var item=items[i];
			var $item=$("<div/>");
			if(items[i].id){
				$item.attr("id",item.id);
			}
			var defaults={disabled:false,separator:false};
			var opts = $.extend({},defaults,item);
			if(opts.name&&this.components.menuItems[opts.name]){
				$item=this.components.menuItems[opts.name];
			}else if(opts.items){
				$item.append($("<span/>").html(opts.text)).append(varMenu(opts.items));
			}else if(opts.content){
				$item.append($("<span/>").html(opts.text));
				$item.append(opts.content.addClass("menu-content").css("background-color","#f1f1f1").css("overflow","hidden"));
			}else{
				$item.html(opts.text);
			}
			if(opts.handler){
				$item[0].onclick=opts.handler;
			}
			item.menuItem=$item;
			$item.attr("data-options",(opts.iconCls?"iconCls:'"+opts.iconCls+"',":"")+"disabled:"+opts.disabled+",separator:"+opts.separator);
			$item.appendTo($menu);
		}
		return $menu;	
	};
	/****
	 * 获取内容项数据
	 */
	function getData($li) {
		var $parentLi = $li.parent("ul").parent("li");
		var data = {};
		var $pre = $li.children("pre");
		var $span = $pre.children("span.index").remove();
		data["content"] = $pre.html();
		$pre.prepend($span);
		data["id"] = $li.data("id") ? $li.data("id") : "";
		data["noDisplay"] = $li.attr("noDisplay");
		data["isTitle"] = $li.attr("isTitle");
		data["orderno"] = $li.attr("orderno") ? $li.attr("orderno") : "";
		data["parent"] = $parentLi.data("id") ? $parentLi.data("id") : "";
		data["noType"] = $li.attr("noType");
		if (data["id"] == "") {
			var $comment = $li.data("comment");
			if ($comment) {
				data["reference"] = $li.attr("unique");
				data["comment"] = $comment.children(".tooltip-content").html();
			}
		}
		return data;
	};
	function param(){
		var options=this;
		var paramArray=[];
		$("li[changed='create']").filter(function() {
			return $(this).parent("ul").parent("li").data("id");
		}).each(function(i) {
			var data = getData.call(options,$(this));
			alert(JSON.stringify(data));
			paramArray.push({name:"createFiles[" + i + "].id",value:data["id"]});
			paramArray.push({name:"createFiles[" + i + "].content",value:data["content"]});
			paramArray.push({name:"createFiles[" + i + "].orderno",value:data["orderno"]});
			paramArray.push({name:"createFiles[" + i + "].isTitle",value:data["isTitle"]});
			paramArray.push({name:"createFiles[" + i + "].parentId",value:data["parent"]});
			paramArray.push({name:"createFiles[" + i + "].noDisplay",value:data["noDisplay"]});
			paramArray.push({name:"createFiles[" + i + "].noType",value:data["noType"]});
			if (data["comment"]) {
				paramArray.push({name:"createFiles[" + i + "].comments[0].userId",value:options.user.id});
				paramArray.push({name:"createFiles[" + i + "].comments[0].content",value:data["comment"]});
				paramArray.push({name:"createFiles[" + i + "].comments[0].reference",value:data["reference"]});
			}
			varParam.call(options, $(this), paramArray, "createFiles[" + i + "]");
		});
		$("li[changed='update']").each(function(i) {
			var data = getData($(this));
			paramArray.push({name:"updateFiles[" + i + "].id",value:data["id"]});
			paramArray.push({name:"updateFiles[" + i + "].content",value:data["content"]});
			paramArray.push({name:"updateFiles[" + i + "].orderno",value:data["orderno"]});
			paramArray.push({name:"updateFiles[" + i + "].isTitle",value:data["isTitle"]});
			paramArray.push({name:"updateFiles[" + i + "].parentId",value:data["parent"]});
			paramArray.push({name:"updateFiles[" + i + "].noDisplay",value:data["noDisplay"]});
			paramArray.push({name:"updateFiles[" + i + "].noType",value:data["noType"]});
		});
		$("li[changed='delete']").each(function(i) {
			var data = getData($(this));
			paramArray.push({name:"deleteFiles[" + i + "].id",value:data["id"]});
		});
		$(".tooltip[changed='create']").filter(function() {
			return !$(this).data("li").attr("changed") || $(this).data("li").attr("changed") != "create";
		}).each(function(i) {
			paramArray.push({name:"createComments[" + i + "].itemId",value:$(this).data("li").data("id")});
			paramArray.push({name:"createComments[" + i + "].userId",value:options.user.id});
			paramArray.push({name:"createComments[" + i + "].content",value:$(this).children(".tooltip-content").html()});
			paramArray.push({name:"createComments[" + i + "].reference",value:$(this).data("li").attr("unique")});
		});
		$(".tooltip[changed='update']").each(function(i) {
			paramArray.push({name:"updateComments[" + i + "].itemId",value:$(this).data("li").data("id")});
			paramArray.push({name:"updateComments[" + i + "].id",value:$(this).attr("id")});
			paramArray.push({name:"updateComments[" + i + "].content",value:$(this).children(".tooltip-content").html()});
			paramArray.push({name:"updateComments[" + i + "].reference",value:$(this).data("li").attr("unique")});
		});
		$(".tooltip[changed='delete']").each(function(i) {
			paramArray.push({name:"deleteComments[" + i + "].itemId",value:$(this).data("li").data("id")});
			paramArray.push({name:"deleteComments[" + i + "].id",value:$(this).attr("id")});
		});
		return paramArray;
	};
	function varParam($li, paramArray, prefix) {
		var options = this;
		if ($li.children("ul").length == 1) {
			$li.children("ul").children("li").each(function(i) {
				var data = getData($(this));
				paramArray.push({name:prefix + ".children[" + i + "].id",value:data["id"]});
				paramArray.push({name:prefix + ".children[" + i + "].noType",value:data["noType"]});
				paramArray.push({name:prefix + ".children[" + i + "].orderno",value:data["orderno"]});
				paramArray.push({name:prefix + ".children[" + i + "].content",value:data["content"]});
				paramArray.push({name:prefix + ".children[" + i + "].isTitle",value:data["isTitle"]});
				paramArray.push({name:prefix + ".children[" + i + "].parentId",value:data["parent"]});
				paramArray.push({name:prefix + ".children[" + i + "].noDisplay",value:data["noDisplay"]});
				if (data["comment"]) {
					paramArray.push({name:prefix + ".children[" + i + "].comments[0].content",value:data["comment"]});
					paramArray.push({name:prefix + ".children[" + i + "].comments[0].userId",value:data[options.user.id]});
					paramArray.push({name:prefix + ".children[" + i + "].comments[0].reference",value:data["reference"]});
				}
				varParam.call(options, $(this),paramArray, prefix + ".children[" + i + "]");
			});
		}
	};
	/*******
	 * 插入单元格
	 */
	function insertTrBefore(tr){
		var i=2;
		var $prevTr=$(tr);
		while(true){
			$prevTr=$prevTr.prev();
			if($prevTr.length==0){
				break;
			}
			$prevTr.children("td").each(function(){
				rowspan=$(this).attr("rowspan")?parseInt($(this).attr("rowspan")):1;
				if(rowspan>=i){
					splitTd(this);
				}
			});
			i++;
		}
		var columnArray=[];
		$(tr).parent("tbody").find("tr:first").children().map(function(){
			var colspan=$(this).attr("colspan");
			colspan=colspan?parseInt(colspan):1;
			for(var i=0;i<colspan;i++){
				columnArray.push("<td><br/></td>");
			}
		});
		$(tr).before("<tr>"+columnArray.join("")+"</tr>");
	}
	/********
	 * 选中 单元格
	 */
	function selectTdBetween(begin,end){
		var beginOffset=$(begin).offset(),beginWidth=$(begin).width(),beginHeight=$(begin).height();
		var endOffset=$(end).offset(),endWidth=$(end).width(),endHeight=$(end).height();
		var xArray=[beginOffset.left,beginOffset.left+beginWidth,endOffset.left,endOffset.left+endWidth].sort(function(a,b){return a-b;});
		var yArray=[beginOffset.top,beginOffset.top+beginHeight,endOffset.top,endOffset.top+endHeight].sort(function(a,b){return a-b;});
		var coord={minx:xArray[0],miny:yArray[0],maxx:xArray[3],maxy:yArray[3]};
		with(coord){
			var tdArray=$(begin).parent("tr").parent("tbody").children("tr").children("td").removeClass("hover").filter(function(){
				var offset=$(this).offset(),width=$(this).width(),height=$(this).height();
				return offset.left>=minx&&offset.left<=maxx&&offset.top>=miny&&offset.top<=maxy;
			}).get();
			if(tdArray.length>1){
				$(tdArray).addClass("hover");
			}
		}
	};
	/*****
	 * 是否可合并
	 */
	function mergeAble(tdArray){
		if(tdArray.length==1){
			return false;
		}
		var range=[];
		var firstRowIndex=undefined;
		$(tdArray).each(function(i){
			var rowIndex=$(this).parent().index();
			if(i==0){
				firstRowIndex=rowIndex;
			}
			var rowspan=$(this).attr("rowspan")?parseInt($(this).attr("rowspan")):1;
			for(var i=0;i<rowspan;i++){
				var rowInRange=range[rowIndex-firstRowIndex+i];
				if(!rowInRange){
					rowInRange=[];
					range[rowIndex-firstRowIndex+i]=rowInRange;
				}
				var colspan=$(this).attr("colspan")?parseInt($(this).attr("colspan")):1;
				for(var j=0;j<colspan;j++){
					rowInRange.push(1);
				}
			}
		});
		var standard=(range[0]?range[0]:[]).length;
		var len=range.length;
		if(len>1){
			for(var i=1;i<len;i++){
				if(standard!=(range[i]?range[i]:[]).length){
					return false;
				}
			}
		}
		return true;
	}
	/********
	 * 单元格合并
	 */
	function mergeTd(tdArray){
		if(tdArray.length==1){
			return false;
		}
		var range=[];
		var firstRowIndex=undefined;
		$(tdArray).each(function(i){
			var rowIndex=$(this).parent().index();
			if(i==0){
				firstRowIndex=rowIndex;
			}
			var rowspan=$(this).attr("rowspan")?parseInt($(this).attr("rowspan")):1;
			for(var i=0;i<rowspan;i++){
				var rowInRange=range[rowIndex-firstRowIndex+i];
				if(!rowInRange){
					rowInRange=[];
					range[rowIndex-firstRowIndex+i]=rowInRange;
				}
				var colspan=$(this).attr("colspan")?parseInt($(this).attr("colspan")):1;
				for(var j=0;j<colspan;j++){
					rowInRange.push(1);
				}
			}
		});
		var standard=(range[0]?range[0]:[]).length;
		var len=range.length;
		if(len>1){
			for(var i=1;i<len;i++){
				if(standard!=(range[i]?range[i]:[]).length){
					throw "所选单元格范围有问题,不能合并！";
				}
			}
		}
		$(tdArray).each(function(i){
			if(i==0){
				$(this).attr("rowspan",len);
				$(this).attr("colspan",standard);
			}else{
				$(this).remove();
			}
		});
	};
	/******
	 * 是否可拆分
	 */
	function splitAble(td){
		var rowspan=$(td).attr("rowspan")?parseInt($(td).attr("rowspan")):1;
		var colspan=$(td).attr("colspan")?parseInt($(td).attr("colspan")):1;
		return rowspan>1||colspan>1;
	}
	/***
	 * 拆分单元格
	 */
	function splitTd(td){
		var columnLen=0;;
		$(td).parent("tr").parent("tbody").find("tr:first").children().map(function(){
			var colspan=$(this).attr("colspan");
			colspan=colspan?parseInt(colspan):1;
			for(var i=0;i<colspan;i++){
				columnLen++;
			}
		});
		var rowspan=$(td).attr("rowspan")?parseInt($(td).attr("rowspan")):1;
		var colspan=$(td).attr("colspan")?parseInt($(td).attr("colspan")):1;
		var rowIndex=$(td).parent("tr").index();
		var colIndex=$(td).index();
		for(var i=0;i<rowspan;i++){
			var tr=$(td).parent("tr").parent("tbody").children("tr")[rowIndex+i];
			for(var j=0;j<colspan;j++){
				if($(tr).children("td")[colIndex]){
					$($(tr).children("td")[colIndex]).before("<td><br/></td>");
				}else{
					$(tr).append("<td><br/></td>");
				}
			}
		}
		$(td).remove();
	}
	/** 文档初始化* */
	function initDocument(options){
		var $viewport=$(this);
		//投标文件
		if("send_file"==$viewport.find(".my_word_document>.my_word_center>.my_word_body>ul>li").attr("name")){
			$viewport.find(".my_word_document>.my_word_center>.my_word_cover>h1").html("投标文件");
			var now=new Date();
			$viewport.find(".my_word_document>.my_word_center>.my_word_cover>h2:last").html(now.getFullYear()+"年"+(now.getMonth()+1)+"月"+(now.getDay()+1)+"日");
			$viewport.find(".my_word_document>.my_word_center>.my_word_cover>h2:last").before("<h2>投标单位："+$viewport.find(".my_word_document>.my_word_properties>span.need_input[name='organB.ztmc00']").html()+"</h2>");
			$("#send_file_form").show();
		}
		/*****
		 * 检查开启或关闭编辑
		 */
		var editable=options.editable&&$(".viewport-panel").length==1;
		if(editable){
			/****
			 * 开启编辑模式
			 */
			$("#openEdit").show().click(function(){
				$("#openRead").parent().css("background","none");
				$("#openEdit").parent().css("background","#880000");
				$viewport.find("[editable='true']").attr("contenteditable","true");
				options.mode="edit";
				options.toolbar[2].button.menubutton("enable");
			}).tooltip({
				position: 'top',
				content: '<span style="color:#000">点击打开编辑模式</span>',    
				onShow: function(){
					$(this).tooltip('tip').css({
						backgroundColor: '#fff',
						borderColor: '#ddd'        
					});    
				}
			}).click();
			/****
			 * 开启阅读模式
			 */
			$("#openRead").show().click(function(){
				$("#openRead").parent().css("background","#880000");
				$("#openEdit").parent().css("background","none");
				$(":focus").blur();
				$viewport.find("[editable='true']").removeAttr("contenteditable");
				options.mode="read";
				options.toolbar[2].button.menubutton("disable");
			}).tooltip({
				position: 'top',
				content: '<span style="color:#000">点击打开阅读模式</span>',    
				onShow: function(){
					$(this).tooltip('tip').css({
						backgroundColor: '#fff',
						borderColor: '#ddd'        
					});    
				}
			});
		}else{
			$viewport.find("[editable='true']").removeAttr("contenteditable");
		}
		/****
		 * 检查是否可保存
		 */
		var saveable=options.saveable&&$(".viewport-panel").length==1;
		$(options.toolbar[1].button.menubutton("options").menu).menu((saveable?"enableItem":"disableItem"),options.toolbar[1].menuOptions.root[2].menuItem[0]);
		/****
		 * 检查是否可另存为
		 */
		var saveasable=options.saveasable&&$(".viewport-panel").length==1;
		$(options.toolbar[1].button.menubutton("options").menu).menu((saveasable?"enableItem":"disableItem"),options.toolbar[1].menuOptions.root[3].menuItem[0]);
		/****
		 * 检查开启或关闭批注
		 */
		var reviewable=options.reviewable&&$(".viewport-panel").length==1;
		$viewport.find(".my_word_comment .tooltip-content").removeAttr("contenteditable",reviewable);
		
		$(options.toolbar[5].button.menubutton("options").menu).menu((reviewable?"enableItem":"disableItem"),options.toolbar[5].menuOptions.root[0].menuItem[0]);
		// 刷新目录
		refreshCatalogue.call(options,$viewport);
		// 封面显示
		if(!options.coverDisplay){
			$viewport.find(".my_word_cover").addClass("none");
		}
		// 目录显示
		if(!options.catalogueDisplay){
			$viewport.find(".my_word_catalogue").addClass("none");
		}
		// 图片放缩初始化
		$viewport.find(".my_word_document>.my_word_center>.my_word_body li>pre img").each(function(){						
			var data=eval("("+$(this).attr("data")+")");						
			$(this).width(data.width*options.scale.newValue);
			$(this).height(data.height*options.scale.newValue);		
		});
		// 批注显示 与 定位
		$viewport.find(".my_word_document>.my_word_comment>.tooltip").each(function(){
			var $comment=$(this);
			var $li=$viewport.find(".my_word_document>.my_word_center>.my_word_body li[unique='"+$(this).attr("reference")+"']");
			$comment.data("li",$li);
			$li.data("comment",$comment);
			relocateComment.call(options,$comment);
		});
		// 目录点击事件
		$viewport.on("click",".my_word_document>.my_word_center>.my_word_catalogue a",$viewport[0],function(e){
			var $li=$(e.data).find("li[unique='"+$(this).attr("reference")+"']");
			$(e.data).scrollTop($li.offset().top-$(e.data).children(".my_word_document").offset().top);	
		});
		// 文档空白区域点击事件
		$viewport.on("click", ".my_word_document",$viewport[0],function(e) {
			$(e.data).find(".my_word_document>.my_word_center>.my_word_body li>pre.editable").each(function(){
				$(this).prepend($(this).data("index")).removeClass("editable").removeAttr("contenteditable");
			});			
			$(e.data).find(".my_word_document>.my_word_center>.my_word_body li>pre.datagrid-row-selected").removeClass("datagrid-row-selected");
			$(e.data).find(".my_word_document>.my_word_center>.my_word_body li>pre.datagrid-row-over").removeClass("datagrid-row-over");
		});
		// 文档内容项鼠标悬停事件
		$viewport.on("mouseover", ".my_word_document>.my_word_center>.my_word_body li>pre", function() {
			$(this).addClass("datagrid-row-over");
		});
		// 文档内容项鼠标离开事件
		$viewport.on("mouseout", ".my_word_document>.my_word_center>.my_word_body li>pre", function() {
			$(this).removeClass("datagrid-row-over");
		});
		// 文档内容项点击事件(选中)
		$viewport.on("click", ".my_word_document>.my_word_center>.my_word_body li>pre",$viewport[0], function(e) {
			e.preventDefault();
			if (!$(this).hasClass("editable")){
				var $prev=$(e.data).find(".editable");
				if($prev.length==1){
					$prev.prepend($prev.data("index")).removeClass("editable");//.removeAttr("contenteditable");
				}
				var $ul = $(this).parent("li").children("ul");
				if(!e.ctrlKey^e.shiftKey){// 单选
					$(e.data).find(".my_word_document>.my_word_center>.my_word_body li[shift='shift']").removeAttr("shift");
					$(e.data).find(".my_word_document>.my_word_center>.my_word_body li>pre.datagrid-row-selected").removeClass("datagrid-row-selected");
					$(this).addClass("datagrid-row-selected");
					if($(this).parent("li").data("comment")){
						$(this).parent("li").data("comment").css("z-index",9015).siblings(".tooltip").css("z-index",9014);
					}
					if ($ul.length > 0) {
						$ul.find("li").each(function() {
							$(this).children("pre").addClass("datagrid-row-selected");
						});
					}
				} else if (e.ctrlKey) {// ctrl多选
					if ($(this).hasClass("datagrid-row-selected")) {
						$(this).parents("li").each(function() {
							$(this).children("pre").removeClass("datagrid-row-selected");
						});
						$(this).removeClass("datagrid-row-selected");
						if ($ul.length > 0) {
							$ul.find("li").each(function() {
								$(this).children("pre").removeClass("datagrid-row-selected");
							});
						}
					} else {
						$(this).addClass("datagrid-row-selected");
						if ($ul.length > 0) {
							$ul.find("li").each(function() {
								$(this).children("pre").addClass("datagrid-row-selected");
							});
						}
					}
				} else if (e.shiftKey) {// shift连续选择
					var $fromLi = $(this).parent("li");
					if ($fromLi.attr("shift") == "shift") {
						$(e.data).find(".my_word_document>.my_word_center>.my_word_body li>pre.datagrid-row-selected").removeClass("datagrid-row-selected").removeAttr("shift");
						$fromLi.find("pre").addClass("datagrid-row-selected");
						return false;
					}
					var $toLi = $(this).parent("li").siblings("li[shift='shift']");
					if ($toLi.length == 0) {
						$toLi = $(this).parent("li").siblings("li:has('.datagrid-row-selected'):first").attr("shift", "shift");
					}
					if ($toLi.length == 0 || !$toLi.children("pre").hasClass("datagrid-row-selected")) {
						$(e.data).find(".my_word_document>.my_word_center>.my_word_body li>pre.datagrid-row-selected").removeClass("datagrid-row-selected").removeAttr("shift");
						$fromLi.find("pre").addClass("datagrid-row-selected");
						return false;
					}
					$(e.data).find(".my_word_document>.my_word_center>.my_word_body li>pre.datagrid-row-selected").removeClass("datagrid-row-selected");
					var a = parseInt($fromLi.attr("orderno"));
					var b = parseInt($toLi.attr("orderno"));
					if (a > b) {
						var t = a;
						a = b;
						b = t;
					}
					$toLi.parent("ul").children("li").each(function(i) {
						if (parseInt($(this).attr("orderno")) >= a && parseInt($(this).attr("orderno")) <= b) {
							$(this).find("pre").addClass("datagrid-row-selected");
						}
					});
				}
			}
			return false;
		});
		/*******
		 * 点击批注显示批注归属
		 */
		$viewport.on("click",".my_word_document>.my_word_comment>.tooltip",function(e){
			$(this).data("li").children("pre").click();
			return false;
		});
		/*******
		 * 批注编辑获得焦点事件
		 */
		$viewport.on("focus",".my_word_document>.my_word_comment>.tooltip",function(e){
			if($(this).attr("changed")==undefined){
				$(this).data("content",$(this).children().html());
			}
			return false;
		});
		/*******
		 * 批注编辑时区焦点
		 */
		$viewport.on("blur",".my_word_document>.my_word_comment>.tooltip",function(e){
			if($(this).attr("changed")!="create"){
				if($(this).data("content")==$(this).children().html()){
					$(this).removeAttr("changed");
				}else{
					$(this).attr("changed","update");
				}
			}
			return false;
		});
		// 文档内容项获得焦点事件
		$viewport.on("focus",".my_word_document>.my_word_center>.my_word_body pre",function(e){
			options.selection.element=this;
			var $pre=$(this);
			var $li=$pre.parent("li");
			$pre.data("index",$pre.children("span.index").remove());
			if($li.data("id")&&!$pre.parent("li").data("content")){
				$li.data("content",$pre.html());
			}
			options.toolbar[3].button.menubutton("enable");
		});
		/************************************************** 
		 * 文档内容项失去焦点事件(选中)
		**************************************************/
		$viewport.on("blur",".my_word_document>.my_word_center>.my_word_body pre",$viewport[0],function(e){
			options.toolbar[3].button.menubutton("disable");
			var $li=$(this).parent("li");
			$(this).find("img").each(function(){
				var data=eval("("+$(this).attr("data")+")");
				var imgWidth=$(this).width();
				var imgHeight=$(this).height();
				var dataWidth=imgWidth/options.scale.oldValue;
				var dataHeight=imgHeight/options.scale.oldValue;
				if(data.width!=dataWidth||data.height!=dataHeight){
					$(this).attr("data","{width:"+dataWidth+",height:"+dataHeight+"}");
				}
			});
			if($li.data("content")!=$(this).html()){
				if($li.data("id")){
					$li.attr("changed","update");
				}
				//TODO iframe
				relocateComments.call(options,$(e.data));
			}
			if($li.attr("isTitle")=="true"){
				refreshCatalogue.call(options,$(e.data));
				refreshNavigationtree.call(options);
			}
			$(this).children("p").each(function(){
				//TODO 缩进消失
				$(this).replaceWith($(this).html()+($(this).next().length==0?"":"<br/>"));
			});
			$(this).prepend($(this).data("index"))/*.removeClass("editable")*/.removeData("index");
		});
		$viewport.bind("keydown","backspace",function(e){
			return $(e.target).is("pre:focus");
		});
		/**********************************
		 * 删除字符
		 **********************************/
		$viewport.on('keydown',".my_word_document>.my_word_center>.my_word_body pre:focus:not(:has(table))", 'backspace',function (e){
			/*****
			 * 空段落直接删除
			 */
			if($.trim($(this).html())==""){
				var $prevLi=$(this).parent().prev();
				$(this).parent().remove();
				if($prevLi.length==1){
					$prevLi.children("pre").focus().setEndPos();
					$prevLi.children("pre").setpos($prevLi.children("pre").childNodes.length);
				}
				return false;
			}
			/*****
			 * 非空段落与 上一段 合并
			 */
			if($(this).getpos()==0){
				var $prevLi=$(this).parent().prev();
				if($prevLi.length==1){
					var htmldata=$(this).html();
					$prevLi.children("pre").focus();
					$prevLi.children("pre").append(htmldata);
					$prevLi.children("pre").setpos(2);
				}
				$(this).parent().remove();
				return false;
			}
		});
		/**************************************************
		 * 回车换行处理
		 **************************************************/ 
		$viewport.on('keydown',".my_word_document>.my_word_center>.my_word_body pre:focus:not(:has(table))", 'return',function (e){
			e.preventDefault();
			var $pre=$(this);
			var $li = $pre.parent("li"); // pre所在li
			var $parentUl = $li.parent("ul"); // li所在ul
			var insertLevelNo = parseInt($li.attr("levelNo"));
			var insertRetract = (insertLevelNo - 3 < 0) ? 0 : (insertLevelNo - 3) * 2;
			var appendLevelNo = parseInt($li.attr("levelNo")) + 1;
			var appendRetract = (appendLevelNo - 3 < 0) ? 0 : (appendLevelNo - 3) * 2;
			var $insertLi = $("<li/>").attr({
				noDisplay : $li.attr("noDisplay"),
				isRequired : "false",
				isTitle : $li.attr("isTitle"),
				noType :  $li.attr("noType"),
				levelNo : insertLevelNo,
				changed : "create"
			}).css("textIndent", insertRetract + "em").addClass(($li.attr("isTitle")=="true"?("h"+insertLevelNo):"content"));
			var $insertpre = $("<pre/>").attr({
				contenteditable:"true",
				editable:"true"
			}).appendTo($insertLi);
			$insertpre.append($("<span/>").addClass("index"));
			$li.after($insertLi);
			sort($parentUl);
			//兼容性设置
			if (document.selection) {// IE7
				options.selection.range=document.selection.createRange();
				var htmldata=opts.selection.range.htmlText;
				options.selection.range.pasteHTML(htmldata);
			} 
			if(window.getSelection()){
				var anchorOffset=window.getSelection().anchorOffset;
				var anchorNode=window.getSelection().anchorNode;
				var htmldata=anchorNode.data;
				if(htmldata){
					$pre.html(htmldata.substring(0,anchorOffset));
					$insertpre.focus();
					$insertpre.html(htmldata.substring(anchorOffset,htmldata.length));
				}
			}
			if($li.attr("isTitle")=="true"){
				refreshCatalogue.call(options,$viewport);
				refreshNavigationtree.call(options);
			}
			return false; 
		});
		/*$viewport.on("keydown",".my_word_document>.my_word_center>.my_word_body pre:focus",options,function(e){
			var $pre=$(this);
			var $li = $pre.parent("li"); // div所在li
			if(e.keyCode==13&&!(e.shiftKey^e.ctrlKey^e.altKey)){
				var $parentUl = $li.parent("ul"); // li所在ul
				var insertLevelNo = parseInt($li.attr("levelNo"));
				var insertRetract = (insertLevelNo - 3 < 0) ? 0 : (insertLevelNo - 3) * 2;
				var appendLevelNo = parseInt($li.attr("levelNo")) + 1;
				var appendRetract = (appendLevelNo - 3 < 0) ? 0 : (appendLevelNo - 3) * 2;
				var $insertLi = $("<li/>").attr({
					noDisplay : $li.attr("noDisplay"),
					isRequired : "false",
					isTitle : $li.attr("isTitle"),
					noType :  $li.attr("noType"),
					levelNo : insertLevelNo,
					changed : "create"
				}).css("textIndent", insertRetract + "em").addClass(($li.attr("isTitle")=="true"?("h"+insertLevelNo):"content"));
				var $insertpre = $("<pre/>").attr({
					contenteditable:"true",
					editable:"true"
				}).appendTo($insertLi);
				$insertpre.append($("<span/>").addClass("index"));
				$li.after($insertLi);
				sort($parentUl);
				$insertpre.focus();
				if($li.attr("isTitle")=="true"){
					refreshCatalogue.call(options,$viewport);
					refreshNavigationtree.call(options);
				}
				return false; 
			}else if(e.keyCode==46){
				deleteData.call(options,$li);
				return false;
			}
			return true;
		});*/
		// 针对chrome图片放缩
		if(/chrome/.test(navigator.userAgent.toLowerCase())){
			$viewport.on("click",".my_word_document>.my_word_center>.my_word_body li>pre:focus img",function(){
				$(this).parents("pre:first").removeAttr("contenteditable");
				$(this).sizing();
				return false;
			});
		}
		/**************************************************
		 * 文档空白区域右键菜单
		 **************************************************/
		$viewport.contextmenu(function(e) {
			e.preventDefault();
			return false;
		});
		/**************************************************
		 * 文档内容右键菜单
		 **************************************************/
		$viewport.on("contextmenu", ".my_word_document>.my_word_center>.my_word_body pre",$viewport[0],function(e) {
			e.preventDefault();
			if(editable&&options.mode=='edit'){
				var $viewport=$(e.data);
				var $pre=$(this);
				var $li = $pre.parent("li"); // div所在li
				var $parentUl = $li.parent("ul"); // li所在ul
				var $parentLi = $parentUl.parent("li");
				var $ul = $li.children("ul");
				var insertLevelNo = parseInt($li.attr("levelNo"));
				var insertRetract = (insertLevelNo - 3 < 0) ? 0 : (insertLevelNo - 3) * 2;
				var appendLevelNo = parseInt($li.attr("levelNo")) + 1;
				var appendRetract = (appendLevelNo - 3 < 0) ? 0 : (appendLevelNo - 3) * 2;
				var items = []; // 菜单
				items[items.length] = {
					text : "编　　辑",
					disabled : $pre.attr("editable") == "false",
					handler : function() {
						$pre.focus();
					}
				};
				if ($pre.hasClass("datagrid-row-selected")) {
					items[items.length] = {
						text : "取消选中",
						handler : function() {
							$viewport.find(".my_word_document>.my_word_center>.my_word_body .datagrid-row-selected").removeClass("datagrid-row-selected");
						}
					};
					if ($viewport.find(".my_word_document>.my_word_center>.my_word_body li>.datagrid-row-selected").length >= 2 && $parentUl.children("li:has('.datagrid-row-selected')").length == 2 && $parentUl.find(".datagrid-row-selected").length == $(e.data).find(".my_word_document .my_word_body .datagrid-row-selected").length) {
						items[items.length] = {
							text : "交换选中内容",
							handler : function() {
								var $selecteds = $parentUl.children("li:has('.datagrid-row-selected')");
								var $a = $($selecteds[0]);
								var $b = $($selecteds[1]);
								var $ta = $a.clone();
								var $tb=$b.clone();
								$a.after($ta);
								$b.after($tb);
								$tb.before($a);
								$ta.before($b);
								$ta.remove();
								$tb.remove();
								sort($parentUl);
							}
						};
					}
					items[items.length] = {
						text : "删除选中",
						disabled :$viewport.find(".my_word_document>.my_word_center>.my_word_body .datagrid-row-selected[editable='true']").length == 0,
						handler : function() {
							$viewport.find(".my_word_document>.my_word_center>.my_word_body li[isRequired!='true']>pre.datagrid-row-selected").each(function(i) {
								deleteData.call(options,$(this).removeClass("datagrid-row-selected").parent("li"));
							});
						}
					};
				} else {
					items[items.length] = {
						text : "删　　除",
						disabled : $li.attr("isRequired") == "true",
						handler : function() {
							deleteData.call(options,$li);
						}
					};
				}
				items.push({separator:true});
				items[items.length] = {
					text : "插　　入",
					items : [ {
						text : "标题",
						disabled : $parentLi.attr("isTitle") != "true" || $parentLi.length == 0,
						handler : function() {
							var $insertLi = $("<li/>").attr({
								noDisplay : "true",
								isRequired : "false",
								isTitle : "true",
								noType : "EXTEND",
								levelNo : insertLevelNo,
								changed : "create"
							}).css("textIndent", insertRetract + "em").addClass("h" + insertLevelNo);
							var $insertpre = $("<pre/>").attr({
								contenteditable:"true",
								editable:"true"
							}).appendTo($insertLi);
							$insertpre.append($("<span/>").addClass("index"));
							$li.before($insertLi);
							sort($parentUl);
							$insertpre.focus();
							refreshCatalogue.call(options,$viewport);
							refreshNavigationtree.call(options);
						}
					}, {
						text : "文本",
						disabled : $parentLi.length == 0,
						handler : function() {
							var $insertLi = $("<li/>").attr({
								noDisplay : "true",
								isRequired : "false",
								isTitle : "false",
								noType : "EXTEND",
								levelNo : insertLevelNo,
								changed : "create"
							}).css("textIndent", insertRetract + "em").addClass("content");
							var $insertpre = $("<pre/>").attr({
								contenteditable:"true",
								editable:"true"
							}).appendTo($insertLi);
							$insertpre.append($("<span/>").addClass("index"));
							$li.before($insertLi);
							sort($parentUl);
							$insertpre.focus();
						}
					} ]
				};
				items[items.length] = {
					text : "添加子项",
					items : [ {
						text : "标　　题",
						disabled : ($li.attr("isTitle") != "true"),
						handler : function() {
							if ($ul.length == 0) {
								$ul = $("<ul/>").appendTo($li);
							}
							var $appendLi = $("<li/>").attr({
								noDisplay : "true",
								isRequired : "false",
								isTitle : "true",
								noType : "EXTEND",
								levelNo : appendLevelNo,
								changed : "create"
							}).css("textIndent", appendRetract + "em").addClass("h" + appendLevelNo).appendTo($ul);
							var $appendpre = $("<pre/>").attr({
								contenteditable:"true",
								editable:"true"
							}).appendTo($appendLi);
							$appendpre.append($("<span/>").addClass("index"));
							sort($ul);
							$appendpre.focus();
							refreshCatalogue.call(options,$viewport);
							refreshNavigationtree.call(options);
						}
					}, {
						text : "文　　本",
						handler : function() {
							if ($ul.length == 0) {
								$ul = $("<ul/>").appendTo($li);
							}
							var $appendLi = $("<li/>").attr({
								noDisplay : "true",
								isRequired : "false",
								isTitle : "false",
								noType : "EXTEND",
								levelNo : appendLevelNo,
								changed : "create"
							}).css("textIndent", appendRetract + "em").addClass("content").appendTo($ul);
							var $appendpre = $("<pre/>").attr({
								contenteditable:"true",
								editable:"true"
							}).appendTo($appendLi);
							$appendpre.append($("<span/>").addClass("index"));
							sort.call(options,$ul);
							$appendpre.focus();
						}
					} ]
				};
				items.push({separator:true});
				if ($parentLi.length == 1) {
					items[items.length] = {
						text : "序　　号",
						items : [ {
							text : "第N部分　(中文小写)",
							handler : function() {changeNoType.call(options,$parentLi,"PART");}
						}, {
							text : "第N章　　(中文小写)",
							handler : function() {changeNoType.call(options,$parentLi,"CHAPTER");}
						}, {
							text : "第N条　　(中文小写)",
							handler : function() {changeNoType.call(options,$parentLi,"ITEM");}
						}, {
							text : "N　　　　(中文小写)",
							handler : function() {changeNoType.call(options,$parentLi,"CHINESE");}
						}, {
							text : "n　　　　(阿拉伯数字)",
							handler : function() {changeNoType.call(options,$parentLi,"SIMPLE");}
						}, {
							text : "(n)　　　(阿拉伯数字)",
							handler : function() {changeNoType.call(options,$parentLi,"BRACKET");}
						}, {
							text : "n.n　　　(阿拉伯数字)",
							handler : function() {changeNoType.call(options,$parentLi,"EXTEND");}
						}, {
							text : "无",
							handler : function() {changeNoType.call(options,$parentLi,"NONE");}
						},{
							separator:true
						} ]
					};
					if ($parentLi.attr("noType") != "NONE") {
						if ($li.attr("noDisplay") == "true") {
							items[items.length - 1].items[items[items.length - 1].items.length] = {
								text : "不显本条示序号",
								handler : function() {
									$li.attr("noDisplay", "false");
									var data = eval("(" + $li.attr("data") + ")");
									if ($li.data("id")&& !$li.attr("changed") && ($li.attr("noDisplay") == "true") != data.noDisplay) {
										$li.attr("changed", "update");
									}
									($pre.data("index")?$pre.data("index"):$pre.children("span.index")).html("");
									sort.call(options,$parentUl);
								}
							};
						} else {
							items[items.length - 1].items[items[items.length - 1].items.length] = {
								text : "显　示本条序号",
								handler : function() {
									$li.attr("noDisplay", "true");
									var data = eval("(" + $li.attr("data") + ")");
									if ($li.data("id")&& !$li.attr("changed") && ($li.attr("noDisplay") == "true") != data.noDisplay) {
										$li.attr("changed", "update");
									}
									sort.call(options,$parentUl);
								}
							};
						}
					}
				}
				items.push({separator:true});
				/*items.push({
					text : "重置模板",
					handler : function() {
						$("select[name='id']").change();
					}
				});*/
				menu(items).menu("show",{onHide:function(){},onClick:function(){},left : e.pageX,top : e.pageY});
			}
			return false;
		});
		/**************************************************
		 * 表格操作开始
		 **************************************************/
		$viewport.on("contextmenu", ".my_word_document>.my_word_center>.my_word_body li>pre>table>tbody>tr>td",$viewport[0], function(e) {
			e.preventDefault();
			var td=this;
			var tr=$(td).parent("tr")[0];
			var tbody=$(tr).parent("tbody")[0];
			var table=$(tbody).parent("table")[0];
			var pre=$(table).parent("pre")[0];
			var li=$(pre).parent("li")[0];
			if(editable&&options.mode=='edit'&&$(pre).attr("editable")=='true'){
				var items=[];
				items.push({text:"删除表格",handler:function(){
					$(li).remove();
				}});
				items.push({separator:true});
				items.push({text:"插入行",handler:function(){
					insertTrBefore(tr);
				}});
				items.push({text:"删除行",handler:function(){
					var rowspan=$(td).attr("rowspan")?parseInt($(td).attr("rowspan")):1;
					for(var i=1;i<rowspan;i++){
						$(tr).next().remove();
					}
					var i=2;
					var $prevTr=$(tr);
					while(true){
						$prevTr=$prevTr.prev();
						if($prevTr.length==0){
							break;
						}
						$prevTr.children("td").each(function(){
							rowspan=$(this).attr("rowspan")?parseInt($(this).attr("rowspan")):1;
							if(rowspan>=i){
								splitTd(this);
							}
						});
						i++;
					}
					$(tr).remove();
				}});
				items.push({separator:true});
				items.push({text:"合并单元格",disabled:!mergeAble($(tbody).children("tr").children("td.hover").get()),handler:function(){
					try{
						mergeTd($(tbody).children("tr").children("td.hover").get());
					}catch(e){
						$.jGrowl(e);
					}
				}});
				items.push({text:"拆分单元格",disabled:!splitAble(td),handler:function(){
					splitTd(td);
				}});
				menu(items).menu("show",{onHide:function(){},onClick:function(){},left : e.pageX,top : e.pageY});
			}
			return false;
		}).on("mousedown",".my_word_document>.my_word_center>.my_word_body li>pre>table>tbody>tr>td",$viewport[0], function(e) {
			if(e.button==2) return true;
			$viewport.find(".my_word_document>.my_word_center>.my_word_body li>pre>table>tbody>tr>td").removeClass("hover");
			$(this).parent("tr").parent("tbody").data("mousedown",this);
			$(this).one("mouseout",function(){
				$(this).mouseover();
			});
		}).on("mouseover",".my_word_document>.my_word_center>.my_word_body li>pre>table>tbody>tr>td",$viewport[0], function(e) {
			var begin=$(this).parent("tr").parent("tbody").data("mousedown");
			if(begin){
				selectTdBetween(begin,this);
			}
		}).on("mouseup",".my_word_document>.my_word_center>.my_word_body li>pre>table>tbody>tr>td",$viewport[0], function(e) {
			$(this).parent("tr").parent("tbody").removeData("mousedown");
		}).on("blur",".my_word_document>.my_word_center>.my_word_body li>pre>table>tbody>tr>td",$viewport[0], function(e) {
			if($(this).parent("tr").parent("tbody").data("mousedown")){
				$(this).mouseup();
			}
		});
		/************************************************************
		 * 表格操作结束
		 ************************************************************/
	};
	/** 序号类型变更* */
	function changeNoType($li,noType){
		$li.attr("noType", noType);
		var data = eval("(" + $li.attr("data") + ")");
		if ($li.data("id") && !$li.attr("changed") && data.noType != noType) {
			$li.attr("changed", "update");
		}
		sort.call(this,$li.children("ul"));
	};
	/** MAIN* */
	$.fn.webEditor=function(arg1,arg2){
		if (typeof arg1 == "string") {
			return $.fn.webEditor.methods[arg1].call(this,arg2);
		}
		arg1=arg1||{};
		return $(this).each(function(i){
			var webEditor=$(this).data("webEditor");
			if(webEditor){
				$.extend(webEditor.options,arg1);
			}else{
				var webEditor={options:$.extend({cssRules:{}},$.fn.webEditor.defaults,arg1)};
				$(this).data("webEditor",webEditor);
				init.call(this);
			}
		});
	};
	$.fn.webEditor.methods={
		options:function(){
			return $(this).data("webEditor").options;
		},
		setOpenable:function(openable){
			var options=$(this).webEditor("options");
			options.openable=openable;
			$(options.toolbar[1].button.menubutton("options").menu).menu(openable?"enableItem":"disableItem",options.toolbar[1].menuOptions.root[0].menuItem[0]);
		},
		setSaveable:function(saveable){
			var options=$(this).webEditor("options");
			options.saveable=saveable;
			$(options.toolbar[1].button.menubutton("options").menu).menu((saveable&&$(".viewport-panel").length==1)?"enableItem":"disableItem",options.toolbar[1].menuOptions.root[2].menuItem[0]);
		},
		setSaveasable:function(saveasable){
			var options=$(this).webEditor("options");
			options.saveasable=saveasable;
			$(options.toolbar[1].button.menubutton("options").menu).menu((saveasable&&$(".viewport-panel").length==1)?"enableItem":"disableItem",options.toolbar[1].menuOptions.root[3].menuItem[0]);
		},
		setEditable:function(editable){
			var options=$(this).webEditor("options");
			options.editable=editable;
			options.toolbar[2].button.menubutton(options.editable&&$(".viewport-panel").length==1?"enable":"disable");
			options.toolbar[3].button.menubutton(options.editable&&$(".viewport-panel").length==1?"enable":"disable");
		},
		setReviewable:function(reviewable){
			var options=$(this).webEditor("options");
			options.reviewable=reviewable;
			$(options.toolbar[5].button.menubutton("options").menu).menu(options.reviewable&&$(".viewport-panel").length==1?"enableItem":"disableItem",options.toolbar[5].menuOptions.root[0].menuItem[0]);
		},
		setLayout:function(layout){
			var options=$(this).webEditor("options");
			options.layout=layout;
			$(this).webEditor("refreshDocument",options.href);
		},
		saveDocument:function(){
			var options=$(this).webEditor("options");
			if(options.saveable){
				options.app.layout("panel","center").find(".my_word_document pre:focus").blur();
				var paramArray=param.call(options);
				options.onSave.call(options,paramArray);
			}
		},
		/*******************
		 * 设置文档内容
		 *******************/
		setContent:function(content){
			//TODO
			var options=$(this).webEditor("options");
			
			$(options.toolbar[1].button.menubutton("options").menu).menu("disableItem",options.toolbar[1].menuOptions.root[2].menuItem[0]);
			$(options.toolbar[1].button.menubutton("options").menu).menu("disableItem",options.toolbar[1].menuOptions.root[3].menuItem[0]);
			options.toolbar[2].button.menubutton("disable");
			options.toolbar[3].button.menubutton("disable");
			$(options.toolbar[5].button.menubutton("options").menu).menu("disableItem",options.toolbar[5].menuOptions.root[0].menuItem[0]);
			
			content=$.isArray(content)?content:[content];
			if(content){
				options.content=content;
				options.href=undefined;
			}
			options.components.viewports=[];
			options.app.layout("panel","center").empty();
			options.components.navigationtree.tree("loadData",[]);
			var len=content.length;
			if(options.layout=="H"){
				var $parent=len==1?options.app.layout("panel","center"):$("<div/>").appendTo(options.app.layout("panel","center")).css({width:(80*len)+"%",height:"100%"});
				createViewportHorizontal.call(options,$parent,len);
			}
			if(options.layout=="V"){
				var $parent=len==1?options.app.layout("panel","center"):$("<div/>").appendTo(options.app.layout("panel","center")).css({width:"100%",height:(80*len)+"%"});
				createViewportVertical.call(options,$parent,len);
			}
			if(options.layout=="G"){
				var $parent=len==1?options.app.layout("panel","center"):$("<div/>").appendTo(options.app.layout("panel","center")).css({width:(80*2)+"%",height:(80*Math.ceil(len/2))+"%"});
				createViewportGrid.call(options,$parent,len);
			}
			$(".viewport-panel").each(function(i){
				$(this).panel({"content":content[i],onOpen:function(){
					//初始化文档
					initDocument.call(options,$(this));
					//添加viewport
					options.components.viewports.push($(this));
					// 更新导航
					if(options.components.viewports.length==$(".viewport-panel").length){
						if(options.commentDisplay){
							options.toolbar[5].menuOptions.root[5].menuItem.click();
						}
						refreshNavigationtree.call(options);
					}
				}});
			});
		},
		/************************
		 * 刷新文档链接
		 ************************/
		refreshDocument:function(href){
			//TODO
			var options=$(this).webEditor("options");
		
			$(options.toolbar[1].button.menubutton("options").menu).menu("disableItem",options.toolbar[1].menuOptions.root[2].menuItem[0]);
			$(options.toolbar[1].button.menubutton("options").menu).menu("disableItem",options.toolbar[1].menuOptions.root[3].menuItem[0]);
			options.toolbar[2].button.menubutton("disable");
			options.toolbar[3].button.menubutton("disable");
			$(options.toolbar[5].button.menubutton("options").menu).menu("disableItem",options.toolbar[5].menuOptions.root[0].menuItem[0]);
			
			href=$.isArray(href)?href:[href];
			if(href){
				options.href=href;
				options.content=undefined;
			}
			options.components.viewports=[];
			options.app.layout("panel","center").empty();
			options.components.navigationtree.tree("loadData",[]);
			var len=href.length;
			if(options.layout=="H"){
				var $parent=len==1?options.app.layout("panel","center"):$("<div/>").appendTo(options.app.layout("panel","center")).css({width:(80*len)+"%",height:"100%"});
				createViewportHorizontal.call(options,$parent,len);
			}
			if(options.layout=="V"){
				var $parent=len==1?options.app.layout("panel","center"):$("<div/>").appendTo(options.app.layout("panel","center")).css({width:"100%",height:(80*len)+"%"});
				createViewportVertical.call(options,$parent,len);
			}
			if(options.layout=="G"){
				var $parent=len==1?options.app.layout("panel","center"):$("<div/>").appendTo(options.app.layout("panel","center")).css({width:(80*2)+"%",height:(80*Math.ceil(len/2))+"%"});
				createViewportGrid.call(options,$parent,len);
			}
			$(".viewport-panel").each(function(i){
				//TODO
				/*var data=$.ajax({
					url:href[i],
					async:false
				}).responseText;
				var iframe=$("<iframe/>").css({
					'width':'100%','height':'100%','border':'none'
				});
				$(this).panel({content:iframe});
				var childDocument=iframe.contents()[0];
				childDocument.write("<link href=\"/resources/css/document.css\" type=\"text/css\" rel=\"stylesheet\" />");
				childDocument.write("<script src=\"/resources/easyui/jquery.min.js\" type=\"text/javascript\"></script>");
				childDocument.write("<script src=\"/resources/jquery-plugins/jquery.hotkeys.js\" type=\"text/javascript\"></script>");
				childDocument.write("<script src=\"/resources/rangy/rangy-core.js\" type=\"text/javascript\"></script>");
				childDocument.write(data);
				createCurrentCssRule2.call(childDocument,options);
				options.components.viewports.push($(childDocument).find("body"));
				initDocument.call(childDocument,options);
				return;*/
				$(this).panel({"href":href[i],onLoad:function(){
					//初始化文档
					initDocument.call(options,$(this));
					//添加viewport
					options.components.viewports.push($(this));
					// 更新导航
					if(options.components.viewports.length==href.length){
						if(options.commentDisplay){
							options.toolbar[5].menuOptions.root[5].menuItem.click();
						}
						refreshNavigationtree.call(options);
					}
				}});
			});
		},
		/** 编辑器文档样式* */
		cssRules:{
			"div.my_word_document":{"width":800},
			"div.my_word_document a":{},
			"div.my_word_document > div.my_word_west":{"width":80},
			"div.my_word_document > div.my_word_east":{"width":80},
			"div.my_word_document > div.my_word_center":{"width":640},
			"div.my_word_document > div.my_word_center > div.my_word_north":{"width":640,"height":60},
			"div.my_word_document > div.my_word_center > div.my_word_south":{"width":640,"height":60},
			"div.my_word_document > div.my_word_center > div.my_word_cover":{"padding-top":160,"padding-right":100,"padding-bottom":160,"padding-left":100},
			"div.my_word_document > div.my_word_center > div.my_word_cover > h1":{"font-size":60,"margin-top":36,"margin-bottom":36},
			"div.my_word_document > div.my_word_center > div.my_word_cover > h2":{"font-size":22,"margin-top":40,"margin-bottom":40},
			"div.my_word_document > div.my_word_center > div.my_word_catalogue":{"margin-top":200,"margin-bottom":200},
			"div.my_word_document > div.my_word_center > div.my_word_catalogue > h1":{"font-size":36,"margin-top":22,"margin-bottom":22},
			"div.my_word_document > div.my_word_center > div.my_word_catalogue li > div > a":{"font-size":15,"line-height":30},
			"div.my_word_document > div.my_word_center > div.my_word_body .content > pre":{"font-size":15,"margin-top":5,"margin-bottom":5},
			"div.my_word_document > div.my_word_center > div.my_word_body .h1 > pre":{"font-size":36,"margin-top":36,"margin-bottom":36},
			"div.my_word_document > div.my_word_center > div.my_word_body .h2 > pre":{"font-size":26,"margin-top":26,"margin-bottom":26},
			"div.my_word_document > div.my_word_center > div.my_word_body .h3 > pre":{"font-size":20,"margin-top":20,"margin-bottom":20},
			"div.my_word_document > div.my_word_center > div.my_word_body .h4 > pre":{"font-size":18,"margin-top":18,"margin-bottom":18},
			"div.my_word_document > div.my_word_center > div.my_word_body pre table":{"width":640},
			"div.my_word_document > div.my_word_center > div.my_word_body pre table td":{"height":27,"padding-top":2,"padding-right":6,"padding-bottom":2,"padding-left":6},
			"div.my_word_document > div.my_word_comment":{"width":250},
			"div.my_word_document > div.my_word_comment > div.tooltip":{"left":20,"right":20,"padding-top":5,"padding-right":5,"padding-bottom":5,"padding-left":5},
			"div.my_word_document > div.my_word_comment > div.tooltip > div.tooltip-content":{"font-size":14}
		},
		/** 颜色选择器预设置颜色* */	
		colors:[
       	    ["#000000", "#434343", "#666666", "#999999", "#b7b7b7", "#cccccc", "#d9d9d9", "#efefef", "#f3f3f3", "#ffffff"],
       	    ["#980000", "#ff0000", "#ff9900", "#ffff00", "#00ff00", "#00ffff", "#4a86e8", "#0000ff", "#9900ff", "#ff00ff"],
       	    ["#e6b8af", "#f4cccc", "#fce5cd", "#fff2cc", "#d9ead3", "#d9eaf3", "#c9daf8", "#cfe2f3", "#d9d2e9", "#ead1dc"],
       	    ["#dd7e6b", "#ea9999", "#f9cb9c", "#ffe599", "#b6d7a8", "#a2c4c9", "#a4c2f4", "#9fc5e8", "#b4a7d6", "#d5a6bd"],
       	    ["#cc4125", "#e06666", "#f6b26b", "#ffd966", "#93c47d", "#76a5af", "#6d9eeb", "#6fa8dc", "#8e7cc3", "#c27ba0"],
       	    ["#a61c00", "#cc0000", "#e69138", "#f1c232", "#6aa84f", "#45818e", "#3c78d8", "#3d85c6", "#674ea7", "#a64d79"],
       	    ["#85200c", "#990000", "#b45f06", "#bf9000", "#38761d", "#134f5c", "#1155cc", "#0b5394", "#351c75", "#741b47"],
       	    ["#5b0f00", "#660000", "#783f04", "#7f6000", "#274e13", "#0c343d", "#1c4587", "#073763", "#20124d", "#4c1130"]
       	]
	};
	$.fn.webEditor.defaults={
		components:{viewports:[]},
		toolbar:[],
		styleSheetIndex:document.styleSheets.length-1,
		selection:{},// 编辑区
		// 组件状态
		commentDisplay:false,
		navigationDisplay:true,
		coverDisplay:true,
		catalogueDisplay:true,
		uploadURL:undefined,
		fontColor:"#000000",
		backgroundColor:"#ffffff",
		zoomPercent:100,
		layout:"H",
		// 条件约束
		openable:true,// 能否打开文件
		reviewable:true,// 能否批注
		saveable:true,// 能否保存
		saveasable:true,// 能否另存为
		editable:true,// 能否编辑,
		// 事件
		onOpen:function(){},
		onSave:function(data){},
		onSaveAs:function(data){}
	};
})(jQuery);