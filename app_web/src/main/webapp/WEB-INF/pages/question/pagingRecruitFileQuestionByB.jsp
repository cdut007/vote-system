<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<!-- <script type="text/javascript" src="/resources/ca/Loadwebsign.js"></script>
<script type="text/javascript" src="/resources/ca/main1.js"></script> -->
<script type="text/javascript">
	function clarifyQuestion(id) {
		$.messager.confirm('系统提示', '确认忽略吗?', function(ok) {
			if (ok) {
				$.ajax({
					type : 'post',
					dataType : 'json',
					data : {
						id : id
					},
					url : ctx + "/question/clarifyQuestion",
					success : function(data) {
						if (data.success) {
							$('#recruitfilequestion-datagrid').datagrid('reload');
							$('#recruitfilequestion-datagrid').datagrid('unselectAll');
						}
					},
					error : function(e, s1, s2) {
						$.messager.alert('系统提示', '澄清失败！');
					}
				});
			}
		});
	}

	function chengQing(recruitFileId) {
		window.open(ctx+"/question/form2?recruitFileId="+recruitFileId);
		return;
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='"+ id + "'></div>");
		$("#" + id).dialog({
			width : 800,
			height : 320,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "招标文件澄清",
			cache:false,
			href : ctx+"/question/form2",
			queryParams : {
				recruitFileId : recruitFileId
			},
			onLoad:function(){
				var sealName = $("#sealName").val();
				var sealSignData = $("#signatureData").val();
				if ($.trim(document.all.DWebSignSeal.FindSeal(sealName, 2)) != '') {
					document.all.DWebSignSeal.ShowSeal(sealName, 1);
				} else {
					document.all.DWebSignSeal.SetStoreData(sealSignData);
					document.all.DWebSignSeal.ShowWebSeals();
					document.all.DWebSignSeal.SetMenuItem(sealName, 12);
					document.all.DWebSignSeal.LockSealPosition(sealName);
				}
			},
			buttons : [ {
				text : "盖章",
				color : "red",
				handler : function() {
					if ($("#signatureData").val() !="") {
						$.messager.alert('系统提示', "已提交,请核实！");
						return false;
					}
					// 盖章并且设置签名值
					var sealid = seal($("#"+id+" form #sealName").val());
					if (sealid == null || $.trim(sealid) == '') {
						$.messager.alert('系统提示', "盖章失败！");
						return;
					}
					document.all.DWebSignSeal.SetMenuItem(sealid, 12);
					document.all.DWebSignSeal.LockSealPosition(sealid);
					$("#sealName").val(sealName);
					$("#signatureData").val(document.all.DWebSignSeal.GetStoreData());
					$("#" + id + " form").ajaxSubmit({
						success : function(data) {
							$.jGrowl(data.msg);
						}
					});
				}
			}, {
				text : "取消",
				color : "red",
				handler : function() {
					$("#" + id).dialog("destroy");
				}
			} ]
		});
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
		$("#recruitfilequestion-datagrid").datagrid({
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			height : 400,
			title : "澄清文件列表",
			region : "center",
			url : ctx + "/question/pagingRecruitFileQuestionDataByB",
			idField : "id",
			columns : [ [ {
				field : "projectInstance",
				title : "所属招标项目",
				align : "left",
				width : 150
			}, {
				field : "projectItem",
				title : "所属招标标段",
				align : "left",
				width : 100
			}, {
				field : "createTime",
				title : "澄清时间",
				align : "left",
				width : 120
			}, {
				field : "projectItem.tenderNoticeData.bidOpenDate",
				title : "开标时间",
				align : "left",
				width : 100
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
				招标文件/资格预审文件
				<code>&gt;</code>
				招标文件
			</div>
			<div class="block">
				<table id="recruitfilequestion-datagrid" class="easyui-datagird"></table>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>
