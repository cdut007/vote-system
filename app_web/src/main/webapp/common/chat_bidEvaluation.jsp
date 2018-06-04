<%@page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<script type="text/javascript">
	var notSendMsgList = new Array();
	var cur_id;
	$(function() {
		dwr.engine.setActiveReverseAjax(true); // 激活反转 重要
		ChatManager.setScriptSession(function(data) {
		});
		$("#showBar").click(function() {
			$("#chatDialog").parent().show();
			$("#message").focus();
		});
		$("#chatDialog").dialog({
			title : "澄清答疑",
			width : 600,
			height : 500,
			shadow : false,
			closed : true,
			//collapsible : true,
			minimizable : true,
			maximizable : true,
			//draggable : false,
			closable : false,
			minimized : false,
			left : getLeftPos(),
			top : getTopPos(),
			onBeforeOpen : function() {
				$("li#${tenderItem.id}").click();
				/* $.ajax({
					url : "${pageContext.request.contextPath}/chat/getChatInfo",
					cache : false,
					dataType : "json",
					data : "expertApplyId=${processBusinessKey}&tbfzr0=${tenderItem.tender.ownerId}",
					success : function(ret) {
						alert($("#chatInfo").html());
						$(ret.data).each(function(){});
						var content = "<li onclick=\"addMsgBox('" + ret.data[0].GROUPID + "','" + ret.data[0].GROUPNAME + "')\"><span><img src='/resources/myicons/group.png'/>" + ret.data[0].GROUPNAME + "</span><ul>";
						for (var i = 0; i < ret.data.length; i++) {
							content += "<li><span>" + ret.data[i].XMING0 + "</span></li>";
						}
						content += "</ul></li>";
						$("#chatInfo").append(content);
					}
				}); */
			}
		});
		$("#msgTab").tabs({
			onAdd : function(title) {

			},
			onClose : function(title) {
				var id = title.substring(title.indexOf("<span class='none'>") + 19, title.indexOf("</span>"));
				$.cookie("mychat-" + id, null);
			},
			onSelect : function(title) {
				//切换窗口的title
				var name = title.substring(title.indexOf("</span>") + 7);
				$("#chatDialog").window("setTitle", "澄清答疑       （与" + name + "会话中...）");
				//切换输入的未发送消息
				//首先判断输入框是否有内容，如果有，放到未发送消息数组，如果没有，直接切换tab，
				var next_id = title.substring(title.indexOf("<span class='none'>") + 19, title.indexOf("</span>"));
				if ($("#message").val() != "") {
					var exist = false;
					for (var i = 0; i < notSendMsgList.length; i++) {
						if (notSendMsgList[i].id == cur_id) {
							exist = true;
							//然后将未发送信息存入
							notSendMsgList[i] = {
								"id" : cur_id,
								"msg" : $("#message").val()
							};
						}
					}
					if (!exist) { //数组里面不存在该用户的未发送消息
						notSendMsgList[notSendMsgList.length] = {
							"id" : cur_id,
							"msg" : $("#message").val()
						};
					}
				}
				//然后判断切换后的tab是否有未发送消息，如果有，取出放到输入框
				exist = false;
				for (var i = 0; i < notSendMsgList.length; i++) {
					if (notSendMsgList[i].id == next_id) {
						exist = true;
						$("#message").val(notSendMsgList[i].msg);
					}
				}
				if (!exist) { //数组里面不存在该用户的未发送消息
					$("#message").val("");
				}
				//
				cur_id = next_id;
				$("#message").focus();
			},
			onBeforeClose : function(title) {

			}
		});
		//根据cookie信息初始化聊天窗口
		/*var cookieArray = document.cookie.split(";"); //得到分割的cookie名值对    
		for (var i=0;i<cookieArray.length;i++){
			var arr=cookieArray[i].split("=");       //将名和值分开   
		 	if($.trim(arr[0]).indexOf("mychat-")==0){ //如果存在chat-的cookie，则初始化tab消息框
		 		$("#msgTab").tabs("add",{
				     title:$.cookie($.trim(arr[0])),
				     content: $.cookie($.trim(arr[0])),
				     closable:true
				});
		 	};
		} */
		$("li.groupItem").click(function() {
			addMsgBox($(this).attr("id"), $(this).text());
		});
		//关闭即时通讯窗口
		$("#closeChat").click(function() {
			$("#chatDialog").dialog("minimize");
		});
		//关闭即时通讯窗口
		$("#sendMessage").click(function() {
			var $tab = $("#msgTab").tabs("getSelected");
			var $msgInput = $tab.find(".inputBox");
			var msg = $.trim($msgInput.html());
			if (msg == "" || $(msg).is("br")) {
				$.messager.alert("系统提示", "发送的内容不能为空！", "warning");
				return false;
			} else {
				var sender = '${CURRENT_USER_SESSION_INFO.id}'; // 获得发送者名字
				var receiver = cur_id; // 获得接受者id
				var data = {
					"senderId" : sender,
					"receiverId" : receiver,
					"content" : msg,
					"projectInstanceId" : "${projectInstance.id}",
					"signData" : chatSign(sender + receiver + msg)
				};
				ChatManager.send(data, function(retData) {
					$msgInput.focus();
					$msgInput.empty();
				}); // 发送消息
				//showPushMsg(data, "<div style='width:95%;text-align:right;margin:10 auto;'>" + msg + "</div>");
			}
		});
		function getLeftPos() {
			return $(window).width() - 620;
		}
		function getTopPos() {
			return ($(window).height() - 500) - 65;
		}
		//即时通讯窗体重新定位
		$(document).scroll(function(e) {
			$("#chatDialog").dialog("move", {
				left : getLeftPos(),
				top : getTopPos()
			});
		});
		//添加消息框
		function addMsgBox(id, name) {
			if ($("#msgTab").tabs("exists", name)) {
				$("#msgTab").tabs("select", name);
			} else {
				$("#msgTab").tabs("add", {
					id : "msgBox-" + id,
					title : name,
					content : "<div class=\"easyui-layout\" data-options=\"fit:true\">" + "<div data-options=\"region:'center',border:true\" class=\"viewBox\" style=\"padding:5px\"></div>" + "<div data-options=\"region:'south',split:true,height:100,border:false\">" + "<div class=\"easyui-layout\" data-options=\"fit:true,border:true\">" + "<div data-options=\"region:'north'\" style='text-align:right;height:25px;background-color:#c70000;padding:3px;color:#ffffff;'>" + "消息记录" + "</div>" + "<div data-options=\"region:'center'\" contenteditable=\"true\" class=\"inputBox\" style=\"padding:5px;\">" + "</div>" + "</div>" + "</div>" + "</div>",
					closable : true
				});
			}
		}
	});
	//显示推送过来的msg
	function showPushMsg(msg, htmlContent) {
		$("#displayContent").append(htmlContent);
		$("#displayContent").scrollTop($("#displayContent")[0].scrollHeight);
		//根据发送人将消息放到指定的tab
		var cookieArray = document.cookie.split(";"); //得到分割的cookie名值对    
		var cookie = new Object();
		var notExt = true;
		for (var i = 0; i < cookieArray.length; i++) {
			var arr = cookieArray[i].split("="); //将名和值分开  
			if ($.trim(arr[0]).substring("mychat-".length) == msg.receiverId) { //如果存在mychat-的cookie，
				notExt = false;
				var n = undefined;
				$("#msgTab").find(".tabs-title").each(function(j) {
					if ($(this).find("span:eq(0)").text() == msg.receiverId) {
						n = j;
					}
				});
				$("#msgTab").tabs("update", {
					tab : $("#msgTab").tabs("getTab", $.cookie($.trim(arr[0]))),
					options : {
						content : $("#msgTab").find(".panel:eq(" + n + ")").find(".panel-body:eq(0)").html() + htmlContent
					}
				});
				if ("${CURRENT_USER_SESSION_INFO.id}" != msg.senderId) { //如果是群发消息并且当前用户不是发送者，则发出消息提示音
					playSound();
				}
				$("#msgTab").find(".panel:eq(" + n + ")").find(".panel-body:eq(0)").scrollTop($("#msgTab").find(".panel:eq(" + n + ")").find(".panel-body:eq(0)")[0].scrollHeight);
			}
		}
		if (notExt) {//
			var id;
			id = msg.receiverId;
			var name = "<span class='none'>" + id + "</span>" + tabArray[id];
			$("#msgTab").tabs("add", {
				title : name,
				content : htmlContent,
				closable : true
			});
			$.cookie("mychat-" + id, name);
			playSound();
		}
	}
</script>
<script type="text/javascript">
	function chatSign(originalStr) {
		//调用JITDSignOcx的选择证书
		JITDSignOcx.SetCert("SC", "", "", "", "CN=ShanXi Digital Certificate Authority,OU=RSA,O=ShanXi Digital Certificate Authority,L=TaiYuan,S=ShanXi,C=CN", "");
		if (JITDSignOcx.GetErrorCode() != 0) {
			alert("错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return;
		}
		//带原文的数字签名
		var signStr = JITDSignOcx.DetachSignStr("", originalStr);
		if (JITDSignOcx.GetErrorCode() != 0) {
			alert("错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return;
		}
		return signStr;
	}

	//消息提示音
	function playSound() {
		ddsound.play();
	}
</script>
<style type="text/css">
#chatDialog .panel-header,#chatDialog .panel-body {
	border: 0px solid #a30000;
}

#chatDialog button {
	border: 1px solid #ccc;
	font-family: Tahoma, Verdana, '微软雅黑';
	font-size: 12px;
}

.chatMsg {
	width: 94%;
	background-color: #f5f5f5;
	padding: 5px;
	line-height: 20px;
	display: inline-block;
	word-wrap: break-word;
	word-break: break-all;
}

#message {
	width: 99%;
	height: 98%;
	min-height: 115px;
	font-family: Tahoma, Verdana, '微软雅黑';
	font-size: 12px;
	background: #ffffff;
	border: none;
	overflow-x: hidden;
	overflow-y: visable;
	/* padding: 2px; */
}

#contactList ul li,#groupList ul li {
	line-height: 20px;
	background-color: #fff;
	margin: 3px;
	border: 1px solid #ccc;
	padding-left: 10px;
	cursor: pointer;
	vertical-align: middle;
}

#contactList ul li:hover,#groupList ul li:hover {
	line-height: 20px;
	background-color: #eee;
	margin: 3px;
	border: 1px solid #c30000;
	padding-left: 10px;
	cursor: pointer;
	vertical-align: middle;
}

#chatInfo ul li,#chatInfo ul li:hover {
	line-height: 20px;
	background-color: #fff;
	margin: 3px;
	border: 1px solid #ccc;
	padding-left: 10px;
	cursor: pointer;
	vertical-align: middle;
}
</style>
<div class="blank10"></div>
<div class="block">
	<object classid="clsid:707C7D52-85A8-4584-8954-573EFCE77488" id="JITDSignOcx" size="0" width="0" codebase="/resources/cab/JITDSign.cab" style="display:none"> </object>
	<embed id="ddsound" src="/resources/sound/msg.wav" autoplay="false" hidden="true" width="1" height="1" loop="false" />
	<div id="chatDialog">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',border:false">
						<div id="msgTab" class="easyui-tabs" data-options="fit:true,border:false"></div>
					</div>
					<div data-options="region:'south',border:false" style='text-align:right;height:30px;padding:3px'>
						<a id="closeChat" class="button medium red">关 闭[c]</a> 
						<a id="sendMessage" class="button medium red">发 送[s]</a>
					</div>
				</div>
			</div>
			<div data-options="region:'east',split:false,width:180,border:false">
				<div class="easyui-tabs" data-options="fit:true,border:false" style="border-left:1px solid #c70000">
					<div id="groupList" title="讨论组">
						<ul>
							<c:forEach items="${groupList}" var="group">
								<li class="groupItem" id="${group.id}">
									<img src="/resources/myicons/group.png" /><span>${group.groupName}</span>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
