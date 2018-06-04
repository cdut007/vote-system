<%@page import="com.mhb.common.Constants,java.io.File,com.mhb.tender.entity.*"%>
<%@page import="com.mhb.common.util.ServletUtil"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>

<jsp:include page="/common/link.jsp" />
<c:set value="${recruitFileQuestionService.createRecruitFileQuestionQuery().recruitFileQuestionId(processBusinessKey).singleResult()}" var="question" scope="request" />

<c:set value="${question.recruitFile}" var="recruitFile"  scope="request"/>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	
	<div class="block">
	<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标文件答疑
		</div>
		</div>
		
		<div class="block" style=" margin-bottom:50px;">
	
		<table width="98%" style="margin:0 auto;">
			<input type='hidden' name="id" value="${question.id}" id="id" />
			<input type='hidden' name="recruitFileId" value="${question.recruitFileId}" />
			
		
			<tr>
			<td>标段：</td>
			<td>${recruitFile.projectItem.projectInstance.zbxmmc}-${recruitFile.projectItem.bdmc00}</td>
			</tr>
			<tr>
				<td>招标文件：</td>
				<td>${recruitFile.projectItem.projectInstance.zbxmmc}-${recruitFile.projectItem.bdmc00} 招标文件 &nbsp;&nbsp;(版本号:${recruitFile.rev})</td>
			</tr>
			<tr>
				<td>问题内容：</td>
				<td>
					${question.questionContent}
				</td>
			</tr>
			<tr>
				<td> <label>回复：</label></td>
				<td>
					<textarea rows="10" cols="30" style="width:250px;" id="agencyComment"></textarea>
				</td>
				
			
			</tr>
			
		
		</table>
		
		<div style="margin-top:30px; margin-left:30px;">
			<a class="button red" id='ignore' onclick="ignoreRecruitFileQuestion();">忽略</a>
			<a class="button red" id='transfer' onclick="submitRecruitFileQuestion();">转交招标人</a>
			
		</div>
		
		<script>
	
			function ignoreRecruitFileQuestion() {
		
				
				$.messager.confirm('系统提示', '确认忽略吗?', function(ok) {
					if (ok) {

						$.ajax({
							type : 'post',
							dataType : 'json',
							data : {
								id : $("#id").val(),
								agencyComment: $("#agencyComment").text()
								
							},
							url : ctx + "/question/ignoreQuestion",
							success : function(data) {
								if (data.success) {
									
									window.location.href="/home";
									
									
								}
							},
							error : function(e, s1, s2) {
								$.messager.alert('系统提示', '忽略质疑失败！');
							}
						});
					}
			
				
				});
			}
			
			function submitRecruitFileQuestion() {
			   	$.messager.confirm("系统提示","是否转交招标人?",function(ok){
			   		
			  		if(ok){
						$.ajax({
							type : 'post',
							dataType : 'json',
							data : {
								id : $("#id").val(),
								agencyComment: $("#agencyComment").text()
								
							},
							url : ctx + "/question/submitQuestion",
							success : function(data) {
								if (data.success) {
									window.location.href="/home";
								}
							},
							error : function(e, s1, s2) {
								$.messager.alert('系统提示', '提交招标人失败！');
							}
						});
						
			  		}
				
			 	});
					
			}
		
		</script>

</div>
</body>
</html>