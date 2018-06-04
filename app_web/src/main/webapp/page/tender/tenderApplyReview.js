/*******************************************************************************
 * vSealName:印章名称 vSealPostion:印章绑定的位置 vSealSignData:印章绑定的数据
 ******************************************************************************/
var sealName="sqbsign";
/*function addseal(objectname) {
	var vSealName = "sqbsign"; // 对申请表的签章
	var vSealPostion = objectname;
	var vSealSignData = $("#content").val();
	return WebSign_AddSeal(vSealName, 580, -350, vSealPostion, vSealSignData) && GetValue_onclick();
}
function GetValue_onclick() {
	var v = document.all.DWebSignSeal.GetStoreData();
	if (v.length < 200) {
		alert("签章失败！");
		return false;
	}
	$("#sealSignData").val(v);
	return true;
}

function SetValue_onclick() {
	document.all.DWebSignSeal.SetStoreData($("#sealSignData").val());
	document.all.DWebSignSeal.ShowWebSeals();
	document.all.DWebSignSeal.SetSealSignData("sqbsign", $("#content").val());
}*/

$(function() {
	//SetValue_onclick();
	//TODO
	/*if($("#id").val()!=""){
		sealUtil.loadAllSealWithBusinessKey($("#id").val());
	}*/

	/**
	 * 审核通过
	 */
	$("#pass").click(function() {
		var id=$("#id").val();
		//$.messager.confirm("系统提示", "确认提交吗？", function(r) {
		//	if (r) {
				$("#pass").attr("disabled","true");
				$.ajax({
					url:ctx+"/tenderApply/startTenderReceiptFlow",
					type:'post',
					dataType:'json',
					data:{id:id},
					success:function(data){
						if(!data.success){
							$.messager.alert("系统提示","代理机构尚未与银行签订银企直通协议，暂时无法审核投标报名！");
							return;
						}else{
							$("#tenderApplyReviewForm").submit();
						}
					}
				});
		//	}
		//});
	});
	$("#nopassReason").dialog({
		open : false,
		title : '审核不通过原因',
		closed:true,
		modal:true,
		width:600,
		height:400,
		buttons:[
			{text:"提交",handler:function(){
				if($("textarea[name='nopassReason']").val()===""){
					$.messager.alert("系统提示", "请填写审核不通过原因！");
					return;
				}
				$.messager.confirm("系统提示", "确认提交吗？", function(r) {
					if (r) {
						$("input[name='pass']").val("false");
						$("#tenderApplyReviewForm").submit();
					}
				});
			}},
			{text:"关闭",handler:function(){
				$('#nopassReason').dialog('close');
			}}
		]
	});
	/**
	 * 审核不通过
	 */
	$("#nopass").click(function() {
		$.ajax({
			url:ctx+"/workflow/bankToEnterprise",
			type:'post',
			dataType:'json',
			success:function(data){
				if(!data.success){
					$.messager.alert("系统提示","代理机构尚未与银行签订银企直通协议，暂时无法审核投标报名！");
					return;
				}else{
					$(document).scrollTop(0);
					$("#nopassReason").dialog("open");
				}
			}
		});		
	});
	/***************************************************************************
	 * 签章
	 */
	/*$("#sign").click(function() {
		if ($("input[name='item_ids']:checked").length == 0) {
			$.messager.alert("系统提示", "请先选择要投标的标段！", "warning");
			return;
		}
		if (addseal("ht_end")) {
			$("#saveBtn").click();
		}
	});*/
});