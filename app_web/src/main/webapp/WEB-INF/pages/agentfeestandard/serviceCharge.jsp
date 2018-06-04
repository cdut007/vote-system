<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<jsp:include page="/common/link.jsp" />
		<script type="text/javascript">
			$(function(){
				$("#jisuan").click(function(){
					//获取输入的值
					var id="${id}";
					//alert(id);
					var money=$("#money").val();
					var serve_code=$("#serve_code").val();
					var zhekou=$("#zhekou").val();
					$.ajax({
						url:"${pageContext.request.contextPath}/agentfeestandard/countAgentCharge",
						type:"post",
						data:{"id":id,"money":money,"serve_code":serve_code},
						dataType:"json",
						success:function(result){
							var resultCount=result.data;
							if(zhekou==""){
								$("#result").val(resultCount);
							}else{
								$("#result").val(resultCount*(zhekou/100));
							}
						}
					});//ajax
				});
			});
		</script>
	</head>
	<body>
		<jsp:include page="/common/top.jsp"/>
		<div class="blank10"></div>
		<div class="block ">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				合同管理
				<code>&gt;</code>
				招标代理服务费计算
			</div>
		</div>
		</div>
		<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<form action="${pageContext.request.contextPath}/agentfeestandard/countAgentRule" method="post">
					中标金额：<input type="text" id="money"/>万&nbsp;&nbsp;
					服务类型：<select id="serve_code">
								<option value="A">工程招标</option>
								<option value="B">货物招标</option>
								<option value="C">服务招标</option>
						   </select>&nbsp;&nbsp;
					  折扣率：&nbsp;<input type="text" id="zhekou"/>折&nbsp;&nbsp;<input type="button" value="计算" id="jisuan"/><input type="text" id="result"/>万					  
				</form>			
			</div>
		</div>	
	</body>
</html>