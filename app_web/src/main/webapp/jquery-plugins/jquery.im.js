var $ctrl=undefined;
var senderId=undefined;
/*****
 * 推送消息
 * @param msg
 * @param htmlContent
 */
function showPushMsg(msg) {
	$ctrl.im("showMsg",msg);
}
/*****
 * 用户上线
 * @param userId
 */
function userOnLine(userId){
	$ctrl.im("userOnLine",userId);
}
/*****
 * 用户下线
 * @param userId
 */
function userOffLine(userId){
	$ctrl.im("userOffLine",userId);
}
(function($) {
	var messagerIdPool=[];
	window.setInterval(function(){
		if(messagerIdPool.length>0){
			chatManagerService.receiveCallback(messagerIdPool);
			messagerIdPool=[];
		}
	},5000);
	function init(options){
		$("body").append("<embed id=\"ddsound\" src=\""+options.sound+"\" autoplay=\"false\" style=\"display:none\" loop=\"false\" />");
		var $div=$("<div/>").appendTo($("body")).dialog({
			title : options.title,
			shadow : false,
			closed : true,
			minimizable : true,
			maximizable : true,
			width : 600,
			height : 500,
			onMinimize : function() {
				
			},
			onOpen:function(){
				
			}
		});
//		$(window).scroll(function(){
//			if(!$div.parent().is(":hidden")){
//				$div.dialog("move",{top:$(this).scrollTop(),left:$div.parent().offset().left});
//			}
//		});
		options["main"]=$div;
		$(document).on("click","#groupList li,#contactList li",function() {
			$ctrl.im("addMsgBox",{userId:$(this).attr("id"),userName:$(this).text()});
			//addMsgBox.call(options,$(this).attr("id"), $(this).text());
		});
		$(document).on("click",".msg_history",function(){
			var userId=$("#msgTab").tabs("getSelected").panel("options")["userId"];
			//var userName=$("#msgTab").tabs("getSelected").panel("options")["userName"];
			if($("#east_tabs").tabs("exists","消息记录")){
				$("#east_tabs").tabs("close","消息记录");
				$div.children("div:first").layout("panel","east").panel("resize",{width:180});
				$div.dialog("resize",{width:600});
			}else{
				$div.children("div:first").layout("panel","east").panel("resize",{width:380});
				$div.dialog("resize",{width:800});
				$("#east_tabs").tabs("add",{
					id:"tab-history",
					title:"消息记录",
					closable:true,
					content:"<div class='easyui-layout' data-options='fit:true'>\
								<div data-options=\"region:'center'\" style='background:#e9eef8' id='history-content'></div>\
								<div data-options=\"region:'south',height:30,border:false\" style=\"background:#e9eef8;padding:2px;\"><a id='history-datepiker' class='easyui-linkbutton' data-options=\"iconCls:'myicon-date'\"></a>&nbsp;&nbsp;<span id='history-date'>"+new Date().format('yyyy-MM-dd')+"</span></div>\
							</div>",
					onOpen:function(){
						var nowDateStr=new Date().format('yyyy-MM-dd');
						$("#history-date").html(nowDateStr);
						chatManagerService.loadHistories(userId,nowDateStr,function(data){
							$("#history-content").html(data);
						});
						$("#history-datepiker").click(function(){
							WdatePicker({
								el:"history-date",
								dateFmt:'yyyy-MM-dd',
								maxDate:new Date().format('yyyy-MM-dd'),
								onpicking:function(dp){
									if(dp.cal.getNewDateStr()!=$("#history-date").html()){
										chatManagerService.loadHistories(userId,dp.cal.getNewDateStr(),function(data){
											$("#history-content").html(data);
										});
									}
								}
							});
						});
					}
				});
			}
		});
		createMsgBoxLayout.call($div,options);
		$("#contactList,#groupList").children("ul").children("li").each(function(i){
			if(i==0){
				$(this).click();	
			}
			return false;
		});
		dwr.engine.setActiveReverseAjax(true); // 激活反转 重要
		chatManagerService.createScriptSession(function() {
			$ctrl.click(function() {
				$div.dialog("open");
			});
			//
			window.onunload=function(){
				//销毁scriptSession
				dwr.engine.setAsync(false);
				chatManagerService.destroyScriptSession();
			};
			window.setTimeout(function(){
				chatManagerService.getNotReceive(function(messageList){
					for(var i=0,l=messageList.length;i<l;i++){
						$ctrl.im("showMsg",messageList[i]);
					}
				});
			},0);
		});
	};
	/*function addMsgBox(userId, userName) {
		var name ="<span class='"+userId+"'>"+userName+"</span>";
		if ($("#msgTab").tabs("exists", name)) {
			$("#msgTab").tabs("select", name);
		} else {
			$("#msgTab").tabs("add", {
				id : "tab-" + userId,
				onOpen:function(){
					
				},
				userName:userName,
				userId : userId,
				title : name,
				content : "<div class=\"easyui-layout\" data-options=\"fit:true\">" + "<div data-options=\"region:'center',border:true\" class=\"viewBox\" style=\"padding:5px;background:#e9eef8\"></div>" + "<div data-options=\"region:'south',split:true,height:100,border:false\">" + "<div class=\"easyui-layout\" data-options=\"fit:true,border:true\">" + "<div data-options=\"region:'north'\" style='text-align:right;height:25px;background-color:#c70000;padding:2px;color:#ffffff;overflow:hidden;'>" + "<a class='msg_history' style=\"color:#fff;cursor:pointer;\">消息记录</>" + "</div>" + "<div data-options=\"region:'center'\" contenteditable=\"true\" class=\"inputBox\" style=\"padding:5px;background:#e9eef8\">" + "</div>" + "</div>" + "</div>" + "</div>",
				closable : true
			});
		}
	};*/
	function createOptBtn(options){
		$("<a/>").addClass("button").addClass("medium").addClass("red").html("关闭(<em style=\"text-decoration:underline\">C</em>)").appendTo($(this)).click(function(){
			options["main"].dialog("minimize");
		});
		$("<a/>").addClass("button").addClass("medium").addClass("red").html("发 送(<em style=\"text-decoration:underline\">S</em>)").appendTo($(this)).click(function(){
			var $tab = $("#msgTab").tabs("getSelected");
			var $msgInput = $tab.find(".inputBox");
			var msg = $.trim($msgInput.html());
			if (msg == "") {
				$.messager.alert("系统提示", "发送的内容不能为空！", "warning");
				return false;
			} else {
				var receiverId = $("#msgTab").tabs("getSelected").panel("options").userId;
				var toUserName = $("#msgTab").tabs("getSelected").panel("options").userName;
				var signData =undefined;// chatSign(senderId + receiverId + msg);
				var data = {
					senderId : options.userId,
					fromUserName:options.userName,
					receiverId : receiverId,
					toUserName:toUserName,
					content : msg,
					signData : signData
				};
				chatManagerService.send(data, function(retData) {
					$msgInput.empty().focus();
				}); // 发送消息
			}
		});
	}
	function createMsgTabs(options){
		$("<div/>").attr("id","msgTab").appendTo($(this)).tabs({
			fit:true,
			border:false,
			onAdd : function(title) {
				var tab=$(this).tabs("tabs")[0];
				$(this).tabs('update', {
					tab: tab,
					options: {
						closable:$(this).tabs("tabs").length>1
					}
				});
			},
			onClose : function(title) {
				var tab=$(this).tabs("tabs")[0];
				$(this).tabs('update', {
					tab: tab,
					options: {
						closable:$(this).tabs("tabs").length>1
					}
				});
			},
			onSelect : function(title) {
				var name = $(title).text();
				options["main"].dialog("setTitle", options.title+"&nbsp;&nbsp;（与" + name + "会话中...）");
				$(this).tabs("getSelected").find(".inputBox").focus();
			},
			onBeforeClose : function(title) {
			}
		});
	}
	function createMainPanel(options){
		$("<div/>").appendTo($(this)).layout({
			fit:true
		}).layout("add",{
			region:"south",
			border:false,
			height:30,
			onOpen:function(){
				$(this).css({textAlign:"right",overflow:"hidden",padding:3}),
				createOptBtn.call(this,options);
			}
		}).layout("add",{
			region:"center",
			border:false,
			onOpen:function(){
				createMsgTabs.call(this,options);
			}
		});
	};
	function createContactAndGroupPanel(options){
		$("<div>").attr("id","east_tabs").appendTo($(this)).tabs({
			fit:true,
			border:false
		}).tabs("add",{
			id:"contactList",
			title:"联系人",
			content:"&nbsp;"
		});/*.tabs("add",{
			id:"groupList",
			title:"讨论组",
			content:"&nbsp;"
		}).tabs("select",0);*/
		initContactInfo.call(this,options);
		//initGroupInfo.call(this,options);
	};
	function initContactInfo(options){
		if(options.contactData){
			return $("#contactList").html($("<ul/>").append($(contactData).map(function(){
				return "<li id=\""+this.id+"\" status=\""+(this.isLogin==null||this.isLogin==false?"0":"1")+"\" style=\"border: 1px solid #ccc;padding:1px 10px;margin:1px auto;\"><a href=\"#\"><img src=\"/resources/jquery-plugins/im/user_"+(this.isLogin==null||this.isLogin==false?"0":"1")+".png\" /><span>"+this.userName+"</span></a></li>";
			}).get().join("")));
			$("#contactList").children("ul").children("li:first").click();
		}else{
			$.ajax({
				async:true,
				url:options.contactUrl+"?t="+new Date().getTime(),
				type:"post",
				dataType:"json",
				error:function(){
					//alert("获取联系人列表失败！");
				},
				success:function(data){
					data.unshift({id:"0000-0000-0000-0000",userName:"金蝉助理",departmentName:"客服部",isLogin:"1"});
					$("#contactList").html($("<ul/>").append($(data).map(function(){
						return "<li id=\""+this.id+"\" status=\""+(this.isLogin==null||this.isLogin==false?"0":"1")+"\" style=\"border: 1px solid #ccc;padding:1px 10px;margin:1px auto;\"><a href=\"#\"><img src=\"/resources/jquery-plugins/im/user_"+(this.isLogin==null||this.isLogin==false?"0":"1")+".png\" /><span>"+this.userName+"</span></a></li>";
					}).get().join("")));
					$("#0000-0000-0000-0000").click();
				}
			});
		}
	}
	function initGroupInfo(options){
		if(options.groupData){
			return $("#groupList").html($("<ul/>").append($(options.groupData).map(function(){
				return "<li id=\""+this.id+"\" style=\"border: 1px solid #ccc;padding:1px 10px;margin:1px auto;\"><a href=\"#\"><img src=\"/resources/myicons/group.png\" /><span>"+this.groupName+"</span></a></li>";
			}).get().join("")));
		}else{
			$.ajax({
				async:true,
				url:options.groupUrl,
				type:"post",
				dataType:"json",
				error:function(){
					//alert("获取联系人列表失败！");
				},
				success:function(data){
					$("#groupList").html($("<ul/>").append($(data).map(function(){
						return "<li id=\""+this.id+"\" style=\"border: 1px solid #ccc;padding:1px 10px;margin:1px auto;\"><a href=\"#\"><img src=\"/resources/myicons/group.png\" /><span>"+this.groupName+"</span></a></li>";
					}).get().join("")));
				}
			});
		}
	}
	function createMsgBoxLayout(options){
		$("<div/>").appendTo($(this)).layout({
			fit:true
		}).layout("add",{
			region:"east",
			width:180,
			split:false,
			border:false,
			onOpen:function(){
				createContactAndGroupPanel.call($(this).css({borderLeft:"1px solid #c70000"})[0],options);
			}
		}).layout("add",{
			region:"center",
			border:false,
			onOpen:function(){
				createMainPanel.call(this,options);
			}
		});
	};
	/******
	 * 转换消息JSON 为 HTML
	 */
	function parseHTML(message){
		var isSelf=senderId==message.senderId;
		return "<div style=\"margin:5px auto;overflow:hidden;\">\
		<div style='font-size:12px;text-align:" + (isSelf ? "right" : "left") + ";color:" + (isSelf ? "green" : "blue") + "'>\
			"+message.fromUserName + "&nbsp;&nbsp;" +message.sendTime.format("yyyy-MM-dd HH:mm:ss")+"\
		</div>\
		<div style=\"font-size:14px;\" >\
		<div style=\"float:" + (isSelf ? "right" : "left") + ";background:#cdd7e2;padding:10px;border-radius:5px;\">\
			"+message.content+"\
		</div>\
		</div>\
		</div>";
	};
	$.fn.im = function(arg1, arg2) {
		if (typeof arg1 == "string") {
			return $.fn.im.methods[arg1].call(this, arg2);
		}
		arg1 = arg1 || {};
		if($(this).length>1){
			alert("每个页面最多可以初始化1个金蝉科技IM 组件");
			return;
		}
		var im = $(this).data("im");
		if (im) {
			$.extend(im.options, arg1);
		} else {
			var im = {
				options : $.extend({
					cssRules : {}
				}, $.fn.im.defaults, arg1)
			};
			if(!im.options.userId){
				alert("请初始化 userId 参数!");
				return;
			}
			senderId=im.options.userId;
			$(this).data("im", im);
			init.call(this,im.options);
		}
		$ctrl=$(this);
		return $(this);
	};
	$.fn.im.defaults={
		title:"金蝉科技IM",
		sound:"/resources/sound/msg.wav"
	};
	$.fn.im.methods={
		addMsgBox:function(data){
			var userId=data.userId;
			var userName=data.userName;
			var name ="<span class='"+userId+"'>"+userName+"</span>";
			if ($("#msgTab").tabs("exists", name)) {
				$("#msgTab").tabs("select", name);
			} else {
				$("#msgTab").tabs("add", {
					id : "tab-" + userId,
					userName:userName,
					userId : userId,
					title : name,
					content : "<div class=\"easyui-layout\" data-options=\"fit:true\">" + "<div data-options=\"region:'center',border:true\" class=\"viewBox\" style=\"padding:5px;background:#e9eef8\"></div>" + "<div data-options=\"region:'south',split:true,height:100,border:false\">" + "<div class=\"easyui-layout\" data-options=\"fit:true,border:true\">" + "<div data-options=\"region:'north'\" style='text-align:right;height:25px;background-color:#c70000;padding:2px;color:#ffffff;overflow:hidden;'>" + "<a class='msg_history' style=\"color:#fff;cursor:pointer;\">消息记录</>" + "</div>" + "<div data-options=\"region:'center'\" contenteditable=\"true\" class=\"inputBox\" style=\"padding:5px;background:#e9eef8\">" + "</div>" + "</div>" + "</div>" + "</div>",
					closable : true
				});
			}
		},
		showMsg:function(message){
			$(this).im("open");
			var currentUserId=$(this).im("options").userId;
			var htmlContent=parseHTML(message);
			if(message.senderId==currentUserId){
				$(this).im("addMsgBox",{userId:message.receiverId,userName:message.toUserName});
				var $viewBox = $("#tab-"+message.receiverId).find(".viewBox");
				$viewBox.append(htmlContent).scrollTop($viewBox[0].scrollHeight);
			}else{
				$(this).im("addMsgBox",{userId:message.senderId,userName:message.fromUserName});
				var $viewBox = $("#tab-"+message.senderId).find(".viewBox");
				$viewBox.append(htmlContent).scrollTop($viewBox[0].scrollHeight);
				messagerIdPool.push(message.id);
				try{
					$("#ddsound")[0].play();
				}catch(e){
					
				}
			}
		},
		options:function(){
			return $(this).data("im").options;
		},
		userOnLine:function(userId){
			$("#"+userId).attr("status","1").children("a").children("img").attr("src","/resources/jquery-plugins/im/user_1.png");
			$("#contactList").children("ul").html($("#"+userId).parent("ul").children().toArray().sort(function(a,b){
				var cpVal=-(parseInt($(a).attr("status"))-parseInt($(b).attr("status")));
				if(cpVal==0){
					cpVal=$(a).children("a").children("span").text().localeCompare($(b).children("a").children("span").text());
				}
				return cpVal;
			}));
		},
		userOffLine:function(userId){
			$("#"+userId).attr("status","0").children("a").children("img").attr("src","/resources/jquery-plugins/im/user_0.png");
			$("#contactList").children("ul").html($("#"+userId).parent("ul").children().toArray().sort(function(a,b){
				var cpVal=-(parseInt($(a).attr("status"))-parseInt($(b).attr("status")));
				if(cpVal==0){
					cpVal=$(a).children("a").children("span").text().localeCompare($(b).children("a").children("span").text());
				}
				return cpVal;
			}));
		},
		open:function(){
			$(this).im("options")["main"].dialog("open");
		}
	};
})(jQuery);