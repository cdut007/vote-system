<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="request" value="${pageContext.request}" />
<c:set var="page" value="${request.getParameter('page')}"></c:set>
<jsp:include page="/common/link.jsp" />
<jsp:useBean  class="com.mhb.common.model.Page" id="mypage"/>
<c:catch var="catchException">
	<c:if test="${not empty page&& page>=1}">
		<jsp:setProperty property="page" value="${page}" name="mypage"/>
	</c:if>
</c:catch>
<c:set var="mypage" value="${organService.pagingOrganizationA(mypage)}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		laypage({
			cont : $('#pagingBar'), //容器。值支持id名、原生dom对象，jquery对象,
			pages : ${mypage.pages}, //总页数
			skip : true, //是否开启跳页
			skin : '#AF0000',
			curr:${mypage.page}, //总页数
			groups : 3,
			jump : function(e, first) {
				if (!first) { //一定要加此判断，否则初始时会无限刷新
					location.href = ctx + "/organSearch.jsp?page=" + e.curr;
				}
			}//连续显示分页数
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${pageContext.request.contextPath}/">首页</a>
			<code>&gt;</code>
			委托代理机构
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div style="align:center">
				<div style="width:100%;margin:0 auto;">
					<form action='${pageContext.request.contextPath}/organSearch.jsp' method='post'>
						<div style="width:100%;margin:0 auto;font-size:12px;">
<!-- 							<div style="float:left;"> -->
<!-- 								<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-medal_bronze_1'">人气↓</a> -->
<!-- 								<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-medal_bronze_2'">信用↓</a> -->
<!-- 								<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-medal_bronze_3'">规模↑</a> -->
<!-- 							</div> -->
<!-- 							<div style="float:right;"> -->
<!-- 								关键字:<input class="inputxt" style="width:100px;"/> -->
<!-- 								所在地:<input class="easyui-combotree" data-options="url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=REGION&includeRoot=false'"/> -->
<!-- 							</div>	 -->
<!-- 							<div style="float:left;"> -->
<!-- 							          资质序列： -->
<!-- 								     <select name="zzsequence" value="${aptitude.zzsequence}"> -->
<!-- 							           <option value="">请选择</option> -->
<!-- 							           <c:forEach items="${util:dictionaryTree('ZZSEQUENCE',false)}" var="item"> -->
<!-- 							           		<c:if test=""> -->
							           		
<!-- 							           		</c:if> -->
<!-- 							           		<option value="${item.itemCode}" <c:if test="${aptitude.zzsequence == item.itemCode}">selected=selected</c:if>>${item.itemName}</option> -->
<!-- 							           </c:forEach> -->
<!-- 								     </select> -->
<!-- 							           行业: -->
<!-- 							        <select name="zzindustry"> -->
<!-- 							           <option value="">请选择</option> -->
<!-- 							           <c:forEach items="${util:dictionaryTree('ZZINDUSTRY',false)}" var="item"> -->
<!-- 							           		<option value="${item.itemCode}" <c:if test="${aptitude.zzsequence == item.itemCode}">selected=selected</c:if>>${item.itemName}</option> -->
<!-- 							           </c:forEach> -->
<!-- 								    </select> -->
<!-- 							        专业类别： -->
<!-- 							       <select name="zzprofessional"> -->
<!-- 							           <option value="">请选择</option> -->
<!-- 							           <c:forEach items="${util:dictionaryTree('ZZPROFESSIONAL',false)}" var="item"> -->
<!-- 							           		<option value="${item.itemCode}" <c:if test="${aptitude.zzsequence == item.itemCode}">selected=selected</c:if>>${item.itemName}</option> -->
<!-- 							           </c:forEach> -->
<!-- 								    </select> -->
<!-- 						                    资质等级： -->
<!-- 						            <select name="zzdj00"> -->
<!-- 							           <option value="">请选择</option> -->
<!-- 							           <c:forEach items="${util:dictionaryTree('ZZDJDM',false)}" var="item"> -->
<!-- 							           		<option value="${item.itemCode}" <c:if test="${aptitude.zzsequence == item.itemCode}">selected=selected</c:if>>${item.itemName}</option> -->
<!-- 							           </c:forEach> -->
<!-- 								    </select> -->
<!-- 								<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-magnifier'" onclick="$(this).parents('form:first').submit();">搜索</a>						 -->
<!-- 							</div> -->
							<table>
								<tr>
									<td>
										<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-medal_bronze_1'">人气↓</a>
										<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-medal_bronze_2'">信用↓</a>
										<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-medal_bronze_3'">规模↑</a>
									</td>
								</tr>
								<tr>
									<td>
										所在地:<input name="region" id="region" value="${CURRENT_USER_SESSION_INFO.organ.region}" class="easyui-combotree" data-options="loadFilter:function(data){data[0].text='全国';data[0].id='';return data;},url:'${pageContext.request.contextPath}/dictionary/dynamicDictionaryComboTree?typeCode=REGION&fetchItemCode=${CURRENT_USER_SESSION_INFO.organ.region}&includeRoot=true'"/>
									</td>
									<td>
										资质序列：
									    <select name="zzsequence" value="${aptitude.zzsequence}" style="width: 100px">
								           <option value="">不限制</option>
								           <c:forEach items="${util:dictionaryTree('ZZSEQUENCE',false)}" var="item">
								           		<option value="${item.itemCode}" <c:if test="${aptitude.zzsequence == item.itemCode}">selected=selected</c:if>>${item.itemName}</option>
								           </c:forEach>
									    </select>
									</td>
									<td>
										 行业:
								        <select name="zzindustry" style="width: 100px">
								           <option value="">不限制</option>
								           <c:forEach items="${util:dictionaryTree('ZZINDUSTRY',false)}" var="item">
								           		<option value="${item.itemCode}" <c:if test="${aptitude.zzindustry == item.itemCode}">selected=selected</c:if>>${item.itemName}</option>
								           </c:forEach>
									    </select>
									</td>
									<td>
									        专业类别：
								       <select name="zzprofessional" style="width: 100px">
								           <option value="">不限制</option>
								           <c:forEach items="${util:dictionaryTree('ZZPROFESSIONAL',false)}" var="item">
								           		<option value="${item.itemCode}" <c:if test="${aptitude.zzprofessional == item.itemCode}">selected=selected</c:if>>${item.itemName}</option>
								           </c:forEach>
									    </select>
									</td>
									<td>
										资质等级：
							            <select name="zzdj00" style="width: 100px">
								           <option value="">不限制</option>
								           <c:forEach items="${util:dictionaryTree('ZZDJDM',false)}" var="item">
								           		<option value="${item.itemCode}" <c:if test="${aptitude.zzdj00 == item.itemCode}">selected=selected</c:if>>${item.itemName}</option>
								           </c:forEach>
									    </select>
									</td>
									<td>
										<a class="easyui-linkbutton orange" data-options="iconCls:'myicon-magnifier'" onclick="$(this).parents('form:first').submit();">搜索</a>
									</td>
								</tr>
							</table>
						</div>
					</form>
					<table class="mytable" style="width:100%;font-size:12px;line-height:20px;">
						<tr><td colspan="5"><hr/></td></tr>
						<c:forEach items="${mypage.rows}" var="organ" varStatus="status">
							<tr>
								<td style="padding:3 3 3 3;width:80px;height:80px">
									<a href="${pageContext.request.contextPath}/organDetail.jsp?id=${organ.id}" target="_blank">
										<c:choose>
											<c:when test="${not empty organ.logoId}">
												<img src="${pageContext.request.contextPath}/attachment/download/${organ.logo.path}" style="border:1px solid #ccc; width:70px;height:70px;"></img>
											</c:when>
											<c:otherwise>
												<img src="/resources/img/logo_1.jpg" style="border:1px solid #ccc; width:70px;height:70px;"/>
											</c:otherwise>
										</c:choose>
									</a>
								</td>
								<td style="text-algin:left;padding-left:10px;">
									公司名称:<a href="${pageContext.request.contextPath}/organDetail.jsp?id=${organ.id}" style="font-weight:900;color:#000;" target="_blank">${organ.ztmc00}</a><br /> 
									负责人:${organ.principalName}<br />
									联系电话:${organ.phone}<br />
								</td>
								<td style="text-algin:left;vertical-align: middle;">
									注册资本:${organ.zczb00}${util:dictionary('JEDWDM',organ.zczbdw)}${util:dictionary('CURRENCY',organ.zczbbz)}<br/>
									单位性质:${util:dictionary('OWNERSHIP',organ.dwxz00)}<br/>
									地区:${util:dictionaryPath('REGION',organ.gbdq00)}
								</td>
								<td style="text-algin:left;vertical-align: middle;">
									平台代理项目数量:${organ.projectInstanceNumber}次
								</td>
								<td style="text-algin:left;vertical-align: middle;">
									<a style="float:right;margin-right:20px;" class='red button' href="${pageContext.request.contextPath}/organDetail.jsp?id=${organ.id}" target="_blank">详情</a>
								</td>
							</tr>
							<tr><td colspan="5"><hr/></td></tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<div class="blank10"></div>
			<div id="pagingBar" style="text-align:right"></div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>