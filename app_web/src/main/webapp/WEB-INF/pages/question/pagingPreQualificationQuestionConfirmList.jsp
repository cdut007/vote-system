<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<!-- <script type="text/javascript" src="/resources/ca/Loadwebsign.js"></script>
<script type="text/javascript" src="/resources/ca/main1.js"></script> -->
<script type="text/javascript">

	function chengQing(PreQualificationQuestionId) {
		window.open(ctx+"/question/PreQualificationQuestionAnswerView?PreQualificationQuestionId="+PreQualificationQuestionId);
	}

	// 盖章
	function seal(sealName) {
		try {
			if ($.trim(document.all.DWebSignSeal.FindSeal(sealName, 2)) != '') {
				$.messager.alert('系统提示', "已盖章,请核实！");
				return false;
			}
			document.all.DWebSignSeal.SetSignData("-");
			document.all.DWebSignSeal.SetSignData("+LIST:modifyContent;");
			document.all.DWebSignSeal.SetCurrUser('${userInfo.id}');
			document.all.DWebSignSeal.SetPosition(500, 10, "modifyContentSealPostion");
			return document.all.DWebSignSeal.AddSeal("", sealName);
		} catch (e) {
			$.messager.alert("系统提示","盖章错误：未加载电子印章控件，请使用IE浏览器！");
		}
	}

	//  0为隐藏印章，1为显示印章
	function hiddenseal(value) {
		try {
			var strObjectName;
			strObjectName = document.all.DWebSignSeal.FindSeal("", 0);
			while (strObjectName != "") {
				document.all.DWebSignSeal.ShowSeal(strObjectName, value); //0为隐藏印章，1为显示印章
				strObjectName = document.all.DWebSignSeal.FindSeal(strObjectName, 0);
			}
		} catch (e) {
			alert("hiddenseal - error" + e);
		}
	}

	$(function() {
		sectionList();
	});

	function sectionList() {
		$("#preQualificationQuestionConfirm-datagrid").datagrid({
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			height:400,
			title : "资格预审结果澄清文件列表",
			region : "center",
			url : ctx + "/question/pagingPreQualificationQuestionConfirmData",
			idField : "id",
			columns : [ [ {
				field : "organTName",
				title : "招标单位",
				align : "left",
				width : 150
			}, {
				field : "projectInstanceName",
				title : "招标项目",
				align : "left",
				width : 100
			}, {
				field : "answerDate",
				title : "澄清时间",
				align : "left",
				width : 120
			}, {
				title : "操作",
				field : "id",
				formatter : function(value, row, index) {
					return "<a class='button red small' onclick=\"chengQing('" + value + "')\">澄清内容查看</a>";
				}
			} ] ]
		});
	}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				资格预审结果澄清文件确认
			</div>
			<div class="block">
				<table id="preQualificationQuestionConfirm-datagrid" class="easyui-datagird"></table>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>
