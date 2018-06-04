<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>报名申请补充或修改</title>
<jsp:include page="/common/link.jsp" />
<script src="/resources/ca/Loadwebsign.js" type="text/javascript"></script>
<script src="/resources/ca/main1.js" type="text/javascript"></script>
<script language=javascript>	
<!--
  function addseal(objectname){
  	/* vSealName:印章名称
  	   vSealPostion:印章绑定的位置
  	   vSealSignData:印章绑定的数据
    */
    var vSealName = "sqbsign";  //对申请表的签章
    var vSealPostion = objectname;
    var vSealSignData = $("#content").val();
  	WebSign_AddSeal(vSealName,580,-350,vSealPostion,vSealSignData);
  	GetValue_onclick();
  }
	
	function GetValue_onclick(){
		var v = document.all.DWebSignSeal.GetStoreData();
		if(v.length < 200){
			alert("必须先盖章才可以提交");
			return false;
		}
		document.all.sealSignData.value = v;
	}
	
	function SetValue_onclick(){
		document.all.DWebSignSeal.SetStoreData("${tender.sealSignData}"); 
		document.all.DWebSignSeal.ShowWebSeals();
		document.all.DWebSignSeal.SetSealSignData("sqbsign",$("#content").val());
	}
	
	window.onload = SetValue_onclick;
	
	$(function() {
		$("#sign").click(function() {
			addseal("ht_end");
			$.ajax({
				url:"${pageContext.request.contextPath}/tenderApply/saveSealSignData",
				type:"post",
				datatype:"json",
				data:{id:"${tender.id}",signData:$("#sealSignData").val()},
				success:function(data){
					alert(data.msg);
				}
			});
		});
	});
</script>
<style type="text/css">
.queryDiv{width:1002px;border:1px solid #ccc;line-height:22px;}
.queryHead{width:997height:23px;border-bottom:1px solid #ccc;font-size:13px;font-weight:bold;padding-left:5px;padding-top:5px;}
</style>
<script type="text/javascript">
	$(function(){
		//页面初始化时，如果项目所有标段都选中，也将全选checkbox设置选中;并且将name赋值到申请表中
		var all = true;
		$("input[name='item_ids']").each(function(){
			if($(this).prop("checked")==true){
			}else{
				all = false;
			}
		});
		if(all)
			$("input[name='all']").prop("checked",true);
			
			
			
		/**
		*  保存
		**/
		$("#saveBtn").click(function(){
			if($("input[name='item_ids']:checked").length>0){
				$("#content").val($("#tender_application").html());
				$("#tenderApplicationForm").attr("action","${pageContext.request.contextPath}/tenderApply/saveOrUpdate");
				$("#tenderApplicationForm").submit();
			}else{
				$.messager.alert("系统提示","请先选择要投标的标段！","warning");
				return false;
			}
		});
		
		/**
		*  撤销
		**/
		$("#cancelBtn").click(function(){
			$.messager.prompt("系统提示","此操作不可回退，确定要撤销申请吗？<br/>原因：",function(value){
				if(value!=undefined){
					$("input[name='cancelReason']").val(value);
					$("#tenderApplicationForm").attr("action","${pageContext.request.contextPath}/tenderApply/cancelTender");
					$("#tenderApplicationForm").submit();
				}
			});
		});
		
		/**
		*  提交
		**/
		$("#subBtn").click(function(){
			if($("input[name='item_ids']:checked").length>0){
				$.messager.confirm("系统提示","确定提交申请表信息吗？",function(r){
					if(r){
						//判断是否签章
						strObjectName = document.all.DWebSignSeal.FindSeal("sqbsign",2);
						if(strObjectName  == "sqbsign"){
							$("#content").val($("#tender_application").html());
							$("#tenderApplicationForm").attr("action","${pageContext.request.contextPath}/flow/completeTask");
							$("#tenderApplicationForm").submit();
						}else{
							$.messager.alert("系统提示","提交申请表之前请先加盖电子印章！","warning");
						}
					}else{
						return false;
					}
				});
			}else{
				$.messager.alert("系统提示","请先选择要投标的标段！","warning");
				return false;
			}
		});
	});
	
	function checkAll(){
		var itemNames = "";
		var itemIds = "";
		if($("input[name='all']:checked").length>0){
			$("input[name='item_ids']").each(function(){
				$(this).prop("checked",true);
				itemNames = itemNames +" "+ $(this).parent("td").siblings().filter(".itemName").text()+" ";
				itemIds = itemIds +$(this).val()+";";
			});
			//全选的话，将所有标段的名称赋值到申请表
			$("#projectItemName").html(itemNames);
		}else{
			$("input[name='item_ids']").each(function(){
				$(this).prop("checked",false);
			}); 
			//取消，清空对应申请表标段的内容 
			$("#projectItemName").html("____");
		}
		$("input[name='bdzjjh']").val(itemIds);
	}
	
	
	function check(){
		var isAll = true;
		var itemNames = "";
		var itemIds = "";
		$("input[name='item_ids']").each(function(){
			if($(this).prop("checked")==true){
				itemNames = itemNames + "  " + $(this).parent("td").siblings().filter(".itemName").text()+" ";
				itemIds = itemIds +$(this).val()+";";
			}else{
				isAll = false;
			}
		});
		if(isAll){
			$("input[name='all']").prop("checked",true);
		}else{
			$("input[name='all']").prop("checked",false);
		}
		if(itemNames==""){
			$("#projectItemName").html("____");
		}else{
			$("#projectItemName").html(itemNames);
		}
		$("input[name='bdzjjh']").val(itemIds);
	}
	
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			报名申请补充或修改
		</div>
		<div class="blank10"></div>
		<div class="tableTitle2" style="cursor:pointer;" onclick="$('#projectInfo').toggle();">项目信息</div>
		<table class='mytableStyle' id="projectInfo">
					<tr>
						<th width="120px">所属项目</th>
						<td colspan='3'>${projectInstance.project.xmmc00}</td>
					</tr>
					<tr>
						<th>招标项目编号:</th>
						<td>${projectInstance.zbxmbh}</td>
						<th>招标项目名称:</th>
						<td>${projectInstance.zbxmmc}</td>
					</tr>
					<tr>
						<th width="120px">招标人</th>
						<td>${projectInstance.project.organ.ztmc00}</td>
						<th width="120px">代理机构</th>
						<td>${projectInstance.organ.ztmc00}</td>
					</tr>
					<tr>
						<th width="120px">招标方式</th>
						<td></td>
						<th width="120px">组织形式</th>
						<td></td>
					</tr>
					<tr>
						<th width="120px">招标内容与范围</th>
						<td colspan='3'><pre>${projectInstance.nryfw0}</pre></td>
					</tr>
				</table>

			<div class='tableTitle'>项目标段列表</div>
			<table class='mytableStyle'>
				<tr>
					<th width='40px'><input type='checkbox' name='all' onclick="checkAll()"/></th>
					<th width='40px'>序号</th>
					<th>标段编号</th>
					<th>标段名称</th>
					<th>状态</th>
				</tr>
				<c:set var="itemIDs" value=""/>
				<c:forEach items="${projectInstance.projectItems}" var="item" varStatus="status">
					<tr>
						<td><input type='checkbox' name='item_ids' onclick="check();" value="${item.id}"
							<c:forEach items="${tender.tenderItem}" var="tenderItem">
								<c:if test="${tenderItem.projectItem.id==item.id}" >
									<c:set var="itemIDs" value="${itemIDs}${item.id};"/>
									checked="checked"
								</c:if>
							</c:forEach>
						/></td>
						<td style='text-align: center'>${status.count}</td>
						<td>${item.bdbh00}</td>
						<td class="itemName">${item.bdmc00}</td>
						<td style='text-align:center;'>
							</td>
					</tr>
				</c:forEach>
				<c:if test="${empty projectInstance.projectItems}">
					<tr>
						<td colspan='5'>标段为空！</td>
					</tr>
				</c:if>
			</table>
		<div class="blank10"></div>
			<div class="tableTitle2">投标要求</div>
		<div class="queryDiv">
			<div id="tender_application" style="width:650px;border:1px solid #ccc;line-height:30px;padding:70px;margin-top:10px;margin-bottom:10px;">
				<c:if test="${tender.content==null}">
					<h1 style="text-align:center;" align="center">
						<br /> <b><span style="font-family:宋体;font-size:18pt;">投标报名申请表<span></span></span></b>
						<br />
					</h1>
					<br />
					<div style="font-family:FangSong_GB2312;font-size:14px;">
						<p>
							<u><span>${projectInstance.organ.ztmc00}：</span></u>
						</p>
						<p style="text-indent:22pt;">
							<span>根据贵单位</span><u> <span>${projectInstance.zbxmmc}</span>
							</u><span>的招标公告，我单位拟参与该工程</span><u><span id="projectItemName">
								<c:forEach items="${tender.tenderItem}" var="tenderItem">
									<c:forEach items="${projectInstance.projectItems}" var="item">
										<c:if test="${tenderItem.id==item.id}">
											<c:out value="${item.bdmc00}"></c:out>&nbsp;
										</c:if>
									</c:forEach>
								</c:forEach>
							</span></u><span>标段的投标报名。特此申请。</span>
						</p>
						<p>
						<br />
					</p>
						<p>
							<span>基本情况：</span>
						</p>
						<span></span>
						<p>
							<span>1.</span><span>企业营业执照：</span> <span>${currentUser.organ.yyzzhm}</span>
						</p>
						<p>
							<span>2.</span><span>注册资本：</span> <span>${currentUser.organ.zczb00}</span>
						</p>
						<p>
							<span>3.</span> <span>组织机构代码证号： <span>${currentUser.organ.ztdm00}</span></span>
						</p>
						<p>
							<span>4.</span> <span>我单位将对本次投标中所有材料的真实性负全部责任，如有不实将承担由此造成的一切后果。</span>
						</p>
						<p>
							<span>5.</span> <span>如果我单位中标，将按有关规定和招标人的要求在规定时间内办理好开工前的相关手续。</span>
						</p>
						<p>
							<span>6.</span> <span>首次投标报名提供以下资料：营业执照、税务登记证明、组织机构代码证、银行登记信用证明、有效法人授权委托书、近三年财务报表、公司简介（包括规模简介、产品简介、业绩简介）。</span>
						</p>
						<p style="text-indent:0cm;"></p>
						<br/>
						<div style="text-indent:65pt;" id="tborgansealposition"></div>
						<br/>
						<br/>
						<br/>
						<br/>
						<p style="text-indent:35pt;">
							<span>申请单位名称： （公章）</span>
						</p>
						<p style="text-indent:35pt;">
							<span>法定代表人：（签章）</span>
						</p>
						<p style="text-indent:35pt;">
							<span>联 系 人：</span> <span id="lxr000" contenteditable="true">${currentUser.userName}</span>
						</p>
						<p style="text-indent:35pt;">
							<span>联系电话：</span> <span id="lxdh00" contenteditable="true">${currentUser.phone}</span>
						</p>
						<p style="text-indent:35pt;">
							<span>传&nbsp;&nbsp;&nbsp;&nbsp;真：</span><span id="faxNo" contenteditable="true">${currentUser.organ.faxNo}</span>
						</p>
						<p style="text-indent:35pt;">
							<span>地&nbsp;&nbsp;&nbsp;&nbsp;址：</span><span id="address" contenteditable="true">${currentUser.organ.address}</span>
						</p>
						<p>&nbsp;</p>
					</div>
				</c:if>
				
			<c:if test="${tender.content!=null}">
				${tender.content}
			</c:if>
			</div>
			<div id="ht_end"></div>
		</div>
		<div class="blank10"></div>
		<div class="tableTitle2">报名附件</div>
		<y:uploadify fjsszt="${projectInstance.id}" fjgslx="39" />
		<div class="blank10"></div>
		<form:form id="tenderApplicationForm" method="post" commandName="tender">
			<div style="text-align:right;position:fixed;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:999;border: #ccc 1px solid;">
					<input type='hidden' name="taskId" value="${task.id}" />
					<input type='hidden' name="id" value="${tender.id}" />
					<input type='hidden' name="tbxmzj" value="${projectInstance.id}" />
					<input type='hidden' name="bdzjjh"  value="${itemIDs}"/>
					<input type='hidden' name="bmshr0" value="${projectInstance.dlrzj0}" />
					<form:textarea id="content" path="content" cssClass="none"/>
					<form:hidden path="sealSignData" id="sealSignData"/>
					<input type='hidden' name="cancelReason"/>
					<input type="button" class='red button' id="saveBtn" value="保存" />
					<input type="button" class="red button" id="sign" value="签章"/>
					<input type="button" class='red button' id="subBtn" value="提交" />
					<input type="button" class='red button' id="cancelBtn" value="撤销申请" />
			</div>
		</form:form>
		
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		
	</div>
</body>
</html>
