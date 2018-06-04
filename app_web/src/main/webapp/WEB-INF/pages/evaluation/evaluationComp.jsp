<%@page import="com.mhb.common.Constants,java.io.File,com.mhb.tender.entity.*"%>
<%@page import="com.mhb.common.util.ServletUtil"%>
<%@page pageEncoding="utf-8" import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>评标比对</title>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/ChatManager.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
div .my_word_document{float:left;width:500px;margin:2px;clear:none;word-break:break-all;display:inline-block;word-wrap:break-word;}
</style>
<!--ready事件-->
<style type="text/css">
	 	#comp_box{width:178px;position:fixed;right:20px;top:200px;text-align:center;background-color:#fff;}
	 	#comp_box_title{padding-left:5px;color:#fff;background-color:#d40000;}   /*background-color:#F0974F;  橙色*/
	 	#comp_item{border:1px solid #d40000;line-height:50px;}
	 	#comp_item li{border-bottom:1px solid #d40000;}
	 	.delImg{position:absolute;display:none;right:0;height:15px;width:15px;margin:2px;cursor:pointer;background:url(http://icon.zol-img.com.cn/detail0802/del.gif)}
	 	.comp_foot{height:25px;border:1px solid #d40000;padding:10px 5px 6px;margin-top:2px;}
 </style>
 <script type="text/javascript">
 	$(function(){
 	
 		//根据cookie信息初始化对比栏信息
     	var cookieArray=document.cookie.split(";"); //得到分割的cookie名值对    
	    var cookie=new Object();
	    var exist = false;
	    for (var i=0;i<cookieArray.length;i++){
	     	var arr=cookieArray[i].split("=");      //将名和值分开
	      	if($.trim(arr[0]).indexOf("comp_item-")==0){ //如果存在chat-的cookie，则初始化对比栏
	      		exist = true;
				$("#comp_item").append("<li><em class='delImg'></em>"+$.cookie($.trim(arr[0]))+"<input type='hidden' name='tbid00'  value='"+$.trim(arr[0]).substring(10)+"'/></li>");
	      	}
	    }
      	if(!exist){
      		$("#comp_item").append("<li class='empty'>暂时为空！</li>");
      	}
		    
 		$("#comp_item").on("mouseover","li",function(){
 			$(this).css("background-color","#fafafa");
 			$(this).find(".delImg").css({display:"block"});
 		}).on("mouseout","li",function(){
 			$(this).css("background-color","#fff");
 			$(this).find(".delImg").css({display:"none"});
 		});
 		
 		//加入对比项
 		$("#addComp_item").click(function(){
 			var cookieArray=document.cookie.split(";"); //得到分割的cookie名值对    
		    var cookie=new Object();
		    var exist = false;
		    for (var i=0;i<cookieArray.length;i++){
		     	var arr=cookieArray[i].split("=");      //将名和值分开
		      	if($.trim(arr[0]).indexOf("comp_item-")==0){ //如果存在comp_item-的cookie，则初始化对比栏
		      		if($.trim(arr[0]).substring(10) == $("#tbid00").val()){
			      		exist = true;
		      		}
		      	}
		    }
 			if(!exist){
 				$.cookie("comp_item-"+$("#tbid00").val(),$("#tbdwmc").val());
	 			$("#comp_item  li").remove(".empty");
	 			$("#comp_item").append("<li><em class='delImg'></em>"+$("#tbdwmc").val()+"<input type='hidden' name='tbid00'  value='"+$("#tbid00").val()+"'/></li>");
 			}else{
 				$.messager.alert("系统提示","您已将【"+$("#tbdwmc").val()+"】添加到对比栏！","warning");
 			}
 		});
 		
 		//删除对比项
 		$("#comp_item").on("click",".delImg",function(){
 			var id = $(this).parent("li").find("input[name='tbid00']:eq(0)").val();
 			$.cookie("comp_item-"+id,null);
 			$(this).parent().remove();
 			if(!$("#comp_item").has("li").length){
 				$("#comp_item").append("<li class='empty'>暂时为空！</li>");
 			}
 			$("#webEditor").webEditor("refreshDocument",getHref());
 		});
 		
 		//清空对比栏
 		$("#clearComp_box").click(function(){
	 		var cookieArray=document.cookie.split(";"); //得到分割的cookie名值对    
		    var cookie=new Object();
		    for (var i=0;i<cookieArray.length;i++){
		     	 var arr=cookieArray[i].split("=");      //将名和值分开
		      	if($.trim(arr[0]).indexOf("comp_item-")==0){ //如果存在comp_item-的cookie，则删除该对比项
		      		$.cookie($.trim(arr[0]),null);
		      		$("#comp_item").find("li").remove();
		      		$("#comp_item").append("<li class='empty'>暂时为空！</li>");
		      	}
		    }
 		});

 		$("#comp_box").draggable();
 	});
 </script>
<script type="text/javascript">
function getHref(){
   	/* var cookieArray=document.cookie.split(";"); //得到分割的cookie名值对    
    var cookie=new Object();
    for (var i=0;i<cookieArray.length;i++){
     	var arr=cookieArray[i].split("=");      //将名和值分开
      	if($.trim(arr[0]).indexOf("comp_item-")==0){ //如果存在chat-的cookie，则初始化对比栏
      		var id = $.trim(arr[0]).substring("comp_item-".length);
      		address[address.length] = "${pageContext.request.contextPath}/bidfile/"+id+"/decrypt/"+id+".txt";
      	}
    } */
    var address =${path};
    return address;
}
$(function() {
	$("#webEditor").webEditor({
		user : {
			id : "${CURRENT_USER_SESSION_INFO.id}",
			name : "${CURRENT_USER_SESSION_INFO.userName}"
		},
		zoomPercent:100,
		href : getHref(),
		layout:"V",
		openable:false,
		editable : false,
		reviewable : false
	});
});
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',border:false">
		<div id="webEditor">
		</div>
		<div id="comp_box">
		 	  <div id="comp_box_title">对比栏</div>
		 	  <ul id="comp_item"></ul>
		 	  <div class="comp_foot">
		 	  		<%-- <form id="" method="post">
			 	  		<input type="button" class="button red small" id="addComp_item" value="加入对比"/>
			 	  		<input type="button" class="button red small" id="clearComp_box" value="清空对比栏"/>
			 	   </form>--%>
			 	   <a  class="button red small" href="javascript:$('#webEditor').webEditor('refreshDocument',getHref());">刷新</a>
		 	  </div> 
		 	  <%-- <div class="comp_foot">
			 	  	<a  class="button red small" id="enterComp" href="${pageContext.request.contextPath}/test/evaluationComp" target="_blank">进入对比</a>
		 	  </div> --%>
		 </div>
	<div class="blank10"></div>
	</div>
</body>
</html>
