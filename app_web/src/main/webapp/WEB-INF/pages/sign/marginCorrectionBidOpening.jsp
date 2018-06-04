<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true"/>
<!--ready事件-->
<script type="text/javascript">
	$(function() {
		var keyword;
		$('#sub').click(function() {
			if (confirm('确定提交吗？')) {
				$('#form1').submit();
			}
		});
		$("#marginCorrection-datagrid").datagrid({
			title : "投标保证金预览表",
			url : ctx + "/bidFile/marginCorrectionList",
			pagination : true,
			rownumbers : true,
			striped : true,
			fit : true,
			method : "post",
			toolbar:[{text : "<form class='searchForm' style='padding:5px;width: 100%;'>投标单位关键字:<input name='keywords' id='keywords' class='inputxt'/><a class='button searchBtn red medium' style='float:right;' >查询投标单位</a></form>"
				
			}],
			columns : [[ 
				{field : 'organBName',title : "投标单位",width:160}, 
				{field : 'bdmc00',title : "标段名称",width:70}, 
				{field : 'yingjiao',title : "应缴保证金(元)",width:100}, 
				{field : 'amt',title : "实缴保证金(元)",width:100},
				{field : 'complement',title : "是否足额",width:100,formatter:function(value,row,index){
					if(value > 0){
						return "余额不足";
					}else{
						return "余额充足";
					}
				}},  
				{field : 'fjmc00',title : "附件名称",width:115}, 
				{field : "fpath",title : "保证金凭证",width:130,formatter : function(value, row, index) {
					var img1 = '<a href="'+ctx+'/attachment/download/'+value+'" target="view_window" ><img style="width:150px;height:80px; border:1px solid #D1D1D1" src="'+ctx+'/attachment/download/'+value+'" /><a/>';
					return img1;
				}}, 
				{field : 'isDeposit',title : "是否确认",width:70,formatter : function(value, row, index) {
					if("2" == value){
						console.log(value);
					}
					if ("1" == value) {
						return "已缴费";
					} else if ("2" == value) {
						return "未缴费";
					} else {
						return "待确认";
					}
				}}, 
				{field : 'tenderItemId',title : "操作",width:150,formatter : function(value, row, index) {
					var aa = "<a class='button red small' onclick='disagree(\"" + value + "\",1)'>同意</a><a class='button red small' onclick='disagree(\"" + value + "\",2)'>不同意</a>";
					return aa;
				}} 
			]]
		});
		var $searchForm=$(".searchForm");
		//查询事件
		$searchForm.on("keydown",":input",function(){
			if(event.keyCode==13){
				$(this).blur();
				$("#marginCorrection-datagrid").datagrid('load',{
					keywords: $(this).val(),
				});
				return false;
			}
		}).on("click",".searchBtn",function(){
			$("#marginCorrection-datagrid").datagrid('load',{
				keywords: ""+$("#keywords").val(),
			});
		});
	});
	function disagree(tenderItemId, agree) {
		$.messager.confirm('确认', '请核对您的投标信息，是否正确？', function(ok) {
			if (ok) {
				$.ajax({
					url : ctx+"/verifyDeposit2",
					type : "post",
					data : {"id" : tenderItemId,"agree" : agree},
					dataType : "json",
					beforeSend : function() {
					},
					complete : function(){
					},
					success : function(data) {
						$.messager.alert("系统提示", data.msg);
						$('#marginCorrection-datagrid').datagrid('reload');
					}
				});
			}

		});
	};
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here" >
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			保证金修正
		</div>
		<div class="blank10"></div>
		<div style="width:100%;height:800px;">
			<table id="marginCorrection-datagrid"></table>
		</div>
	</div>
	<div class="tc"></div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>