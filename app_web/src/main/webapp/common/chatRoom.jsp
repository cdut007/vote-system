<%@page language="java" pageEncoding="UTF-8" import="com.mhb.im.entity.IMessage"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
		
		<script type="text/javascript">
		
		var notSendMsgList = new Array();
	    var cur_id; 
	    var msgType = TYPE_ONE;
	    var TYPE_ONE = "<%=IMessage.TYPE_ONE%>";
	    var TYPE_GROUP = "<%=IMessage.TYPE_GROUP%>";
	    var tabArray = ${tabJson};
	    
		$(function(){
			$("#showBar").click(function(){
				$("#chatDialog").parent().show();
				$("#message").focus();
			});
			$("#chatDialog").window({
				title:"澄清答疑",
				width:700,
				height:570,
				shadow:false,
				closed:false,
				collapsible:true,
				minimizable:true,
				maximizable:true,
				draggable:false,
				closable:false,
				minimized:false,
				left:$(window).width()-700,
				top:($(window).height()-570),
				style:{"position":"fixed","z-index":"1000"}
			});
			
		    $("#msgTab").tabs({
		    	onAdd:function(title){
		    	},
		    	onClose:function(title){
		    		var id = title.substring(title.indexOf("<span class='none'>")+19,title.indexOf("</span>"));
		    		$.cookie("mychat-"+id,null);
		    	},
		    	onSelect:function(title){
		    		//切换窗口的title
		    		if($.trim(title)=="消息首页"){
		    			$("#chatDialog").window("setTitle","澄清答疑");
		    		}else{
			    		var name = title.substring(title.indexOf("</span>")+7);
			    		$("#chatDialog").window("setTitle","澄清答疑       （与"+name+"会话中...）");
		    		}
		    		//切换输入的未发送消息
		    		//首先判断输入框是否有内容，如果有，放到未发送消息数组，如果没有，直接切换tab，
		    		var next_id = title.substring(title.indexOf("<span class='none'>")+19,title.indexOf("</span>"));
		    		if($("#message").val()!=""){
		    			var exist = false;
		    			for(var i=0;i<notSendMsgList.length;i++){
		    				if(notSendMsgList[i].id ==cur_id){
		    					exist = true;
		    					//然后将未发送信息存入
		    					notSendMsgList[i] = {"id":cur_id,"msg":$("#message").val()};
		    				}
		    			}
		    			if(!exist){ //数组里面不存在该用户的未发送消息
		    				notSendMsgList[notSendMsgList.length] = {"id":cur_id,"msg":$("#message").val()};
		    			}
		    		}
	    			
	    			//然后判断切换后的tab是否有未发送消息，如果有，取出放到输入框
	    			exist = false;
	    			for(var i=0;i<notSendMsgList.length;i++){
	    				if(notSendMsgList[i].id ==next_id){
	    					exist = true;
	    					$("#message").val(notSendMsgList[i].msg);
	    				}
	    			}
	    			if(!exist){ //数组里面不存在该用户的未发送消息
	    				$("#message").val("");
	    			}
		    		//
	    			cur_id = next_id;
	    			$("#message").focus();
		    	},
		    	onBeforeClose:function(title){
		    	}
		    });
		    //根据cookie信息初始化聊天窗口
	     	var cookieArray=document.cookie.split(";"); //得到分割的cookie名值对    
		    var cookie=new Object();
		    for (var i=0;i<cookieArray.length;i++){
		     	 var arr=cookieArray[i].split("=");       //将名和值分开   
		      	if($.trim(arr[0]).indexOf("mychat-")==0){ //如果存在chat-的cookie，则初始化tab消息框
		      		$("#msgTab").tabs("add",{
					     title:$.cookie($.trim(arr[0])),
					     content: $.cookie($.trim(arr[0])),
					     closable:true
					});
		      	};
		    }
	     });
	     
		$(document).scroll(function(e){
			$("#chatDialog").parent().css({"position":"fixed","left":$(window).width()-700,"top":($(window).height()-570)});
		});
		
		/**
		 * 页面初始化
		 */
		function init() {
			dwr.engine.setActiveReverseAjax(true); // 激活反转 重要
			ChatManager.setScriptSession(function(data){});
		}
		
		/**
		 * 发送消息
		 */
		function send() {
			if($("#message").val()==""||$("#message").val()==null){
				$.messager.alert("系统提示","发送的内容不能为空！","warning");
				return false;
			}else{
				var sender = '${CURRENT_USER_SESSION_INFO.id}'; // 获得发送者名字
				var receiver = cur_id; // 获得接受者id
				var msg = dwr.util.getValue('message'); // 获得消息内容
				var data = {"senderId":sender,"receiverId":receiver,"content":msg,"signData":chatSign(sender+receiver+msg)};
				ChatManager.send(data,function(retData){
					$("#message").val("");
					$("#message").focus();
				}); // 发送消息
			}
		}
		window.onload = init;//页面加载完毕后执行初始化方法init
		
		//显示推送过来的msg
		function showPushMsg(msg,htmlContent){
		    $("#displayContent").append(htmlContent);
			$("#displayContent").scrollTop($("#displayContent")[0].scrollHeight);

			//根据发送人将消息放到指定的tab
	     	var cookieArray=document.cookie.split(";"); //得到分割的cookie名值对    
		    var cookie=new Object();
		    var notExt = true;
		    for (var i=0;i<cookieArray.length;i++){
		     	 var arr=cookieArray[i].split("=");       //将名和值分开  
		      	 if(msg.type == TYPE_ONE){ //一对一消息
		      	 	if($.trim(arr[0]).substring("mychat-".length)==msg.senderId||$.trim(arr[0]).substring("mychat-".length)==msg.receiverId){ //如果存在mychat-的cookie，则初始化tab消息框
			      		notExt = false;
			      		var n ;
			      		$("#msgTab").find(".tabs-title").each(function(j){
			      			if($(this).find("span:eq(0)").text()== msg.senderId||$(this).find("span:eq(0)").text()== msg.receiverId){
			      				n = j;
			      			}
			      		});
		      //			alert(n);
			  //    		alert($("#msgTab").find(".panel:eq("+n+")").html());
			      		
			      		
			      		$("#msgTab").tabs("update",{
			      			 tab:$("#msgTab").tabs("getTab",$.cookie($.trim(arr[0]))),
						     options:{
						     	content: $("#msgTab").find(".panel:eq("+n+")").find(".panel-body:eq(0)").html() + htmlContent
						     }
						});
						
						if("${CURRENT_USER_SESSION_INFO.id}"==msg.receiverId){ //消息的接收人 是当前登录的用户，发出消息提示音
							playSound();
						}
						
						$("#msgTab").find(".panel:eq("+n+")").find(".panel-body:eq(0)").scrollTop($("#msgTab").find(".panel:eq("+n+")").find(".panel-body:eq(0)")[0].scrollHeight);
			      	}
		      	 }else{
		      	 	if($.trim(arr[0]).substring("mychat-".length)==msg.receiverId){ //如果存在mychat-的cookie，
			      		notExt = false;
			      		var n ;
			      		$("#msgTab").find(".tabs-title").each(function(j){
			      			if($(this).find("span:eq(0)").text()== msg.receiverId){
			      				n = j;
			      			}
			      		});
			      		
			      		$("#msgTab").tabs("update",{
			      			 tab:$("#msgTab").tabs("getTab",$.cookie($.trim(arr[0]))),
						     options:{
						     	content: $("#msgTab").find(".panel:eq("+n+")").find(".panel-body:eq(0)").html() + htmlContent
						     }
						});
						
						if("${CURRENT_USER_SESSION_INFO.id}"!=msg.senderId&&msg.type==TYPE_GROUP){ //如果是群发消息并且当前用户不是发送者，则发出消息提示音
							playSound();
						}
						
						$("#msgTab").find(".panel:eq("+n+")").find(".panel-body:eq(0)").scrollTop($("#msgTab").find(".panel:eq("+n+")").find(".panel-body:eq(0)")[0].scrollHeight);
			      	}
		      	 }
		    }
		    if(notExt){
		    	var id ;
		    	if(msg.type == TYPE_ONE){//一对一弹出发送者的tab
		    		id = msg.senderId;
		    	}else{//群组模式弹出群组的tab
		    		id = msg.receiverId;
		    	}
		    	var name = "<span class='none'>"+id+"</span>"+ tabArray[id];
		    	$("#msgTab").tabs("add",{
	      			 title:name,
				     content: htmlContent,
				     closable:true
				});
				$.cookie("mychat-"+id,name);
				playSound();
		    };
		}
		
		
		</script>
		
		<script type="text/javascript">
		<!--
		function chatSign(originalStr){
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
	   //        alert("调用chatSign方法");
		    return signStr;
	    }
	    
	    function addMsgBox(id,name){
	    	name="<span class='none'>"+id+"</span>"+name;
		    if($.cookie("mychat-"+id)==name){
		    	$("#msgTab").tabs("select",name);
		    }else{
		    	$.cookie("mychat-"+id,name);
		    	$("#msgTab").tabs("add",{
				     title:name,
				     content:"",
				     closable:true
				});
		    }
	     }
	     
	     
	     
	    //消息提示音
		function playSound(){
	    	ddsound.play();
	    }
	    
	    
		//-->
		</script>
		
		<style type="text/css">

			.panel-header, .panel-body{border:0px solid #a30000;}
			button{
			border:1px solid #ccc;font-family: Tahoma, Verdana, '微软雅黑'; font-size: 12px;
			}
			
			.chatMsg{
				width:94%;background-color:#f5f5f5;padding:5px;line-height:20px;display:inline-block;word-wrap:break-word;word-break:break-all;
			}
			
			#message{
				width:99%;height:98%;min-height:115px;font-family: Tahoma, Verdana, '微软雅黑';font-size: 12px;
				background: #ffffff;border: none;overflow-x: hidden;overflow-y:visable;
				/* padding: 2px; */
			}
			#contactList ul li,#groupList ul li{
				line-height:20px;background-color:#fff;margin:3px;border:1px solid #ccc;padding-left:10px;cursor:pointer;vertical-align:middle;
			}
			#contactList ul li:hover,#groupList ul li:hover{
				line-height:20px;background-color:#eee;margin:3px;border:1px solid #c30000;padding-left:10px;cursor:pointer;vertical-align:middle;
			}
			#contactList ul li,#groupList ul li img{
			}
		</style>

	<div class="blank10"></div>
	<div class="block">
	<object classid="clsid:707C7D52-85A8-4584-8954-573EFCE77488"
	            id="JITDSignOcx" size="0" width="0" codebase="/resources/cab/JITDSign.cab" style="display:none">
	</object>
	
	 <EMBED id="ddsound" src="/resources/sound/msg.wav" autoplay="false" hidden="true"  width="1" height="1" loop="false"/>
	<div id="chatDialog">
		<div class="easyui-layout" title="聊天" data-options="fit:true">
		      <div  data-options="region:'east',split:false,width:200,border:true">
	      			<div class="easyui-tabs" data-options="fit:true">
					      <div id="contactList" title="联系人">
					           <c:if test="${userList!=null&&fn:length(userList)>0}">
						            <ul>
						      			<c:forEach items="${userList}" var="user">
						      				<li onclick="addMsgBox('${user.id}','${user.xming0}')"><p><img src="/resources/myicons/user.png"/>  <span>${user.xming0}</span></p></li>
						      			</c:forEach>
						      		</ul>
					      		</c:if>
					      </div>
					      <div id="groupList" title="讨论组" >
					          <c:if test="${groupList!=null&&fn:length(groupList)>0}">	
					          	<ul>
					          		<c:forEach items="${groupList}" var="group">
					      				<li onclick="addMsgBox('${group.id}','${group.groupName}')"><img src="/resources/myicons/group.png"/>  <span>${group.groupName}</span></li>
					      			</c:forEach>
					      		</ul>
					      	 </c:if>
					      </div>  
					 </div>
		      </div>
		      <div  data-options="region:'center',border:true">
		      	<div class="easyui-layout"  data-options="fit:true">
			      	<div data-options="region:'center',border:true">
					      <div id="msgTab" class="easyui-tabs" data-options="fit:true">
					           <div id="displayContent" title="消息首页"></div>
					      </div>
					</div>
					<div  data-options="region:'south',split:true,height:'34%',border:true">
						<div class="easyui-layout" data-options="fit:true">
							<div data-options="region:'north'" style='text-align:right;height:25px;background-color:#c70000;padding:3px;color:#ffffff;'>
								消息记录
							</div>
							<div data-options="region:'center'">
								<textarea id="message"></textarea>
							</div>
							<div data-options="region:'south'" style='text-align:right;height:30px;padding:3px'>
								<input type="button" value="关 闭[c]" onclick="$('#chatDialog').dialog('minimize');">
								<input type="button" value="发 送[s]" id="subBtn" onclick="send()">
							</div>
						</div>
					</div>
				</div>
		     </div>  
		</div>
	</div>
		<div id="showBar" class="fr tc" style="position:fixed;width:100px;bottom:1px;right:5px;border:1px #D3D3D3 solid;height:25px;background-color:#eee;cursor:pointer">澄清答疑</div>
	</div>
