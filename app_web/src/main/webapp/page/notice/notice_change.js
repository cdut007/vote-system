$(function() { 
	var gb = new Array();
$("#deliveryPlace").change( function() {
	 var gb14="${notice.tenderNoticeData.deliveryPlace}"!=$("#deliveryPlace").val()?$(this).parent().prev().html()+"由  ${notice.tenderNoticeData.deliveryPlace}  更改为  "+$("#deliveryPlace").val():"";
	gb[13]=gb14;
	zhuang();
});
$("#quality").change( function() {
	 var gb15="${notice.tenderNoticeData.quality}"!=$("#quality").val()?$(this).parent().prev().html()+"由  ${notice.tenderNoticeData.quality}  更改为  "+$("#quality").val():"";
	 gb[14]=gb15;
	zhuang();
});
$("#payWay").change( function() {
	 var gb16="${notice.tenderNoticeData.payWay}"!=$("#payWay").val()?$(this).parent().prev().html()+"由  ${notice.tenderNoticeData.payWay}  更改为  "+$("#payWay").val():"";
	 gb[15]=gb16;
	 zhuang();
});
$("#applyPlace").change( function() {
	 var gb17="${notice.tenderNoticeData.applyPlace}"!=$("#applyPlace").val()?$(this).parent().prev().html()+"由  ${notice.tenderNoticeData.applyPlace}  更改为  "+$("#applyPlace").val():"";
	gb[16]=gb17;
	zhuang();
});
$("#bidPlace").change( function() {
	 var gb19="${notice.tenderNoticeData.bidPlace}"!=$("#bidPlace").val()?$(this).parent().prev().html()+"由  ${notice.tenderNoticeData.bidPlace}  更改为  "+$("#bidPlace").val():"";
	gb[18]=gb19;
	zhuang();
});
$("#noticeTitle").change( function() {
	 var gb18="${notice.noticeTitle}"!=$("#noticeTitle").val()?$(this).parent().prev().html()+"由  ${notice.noticeTitle}  更改为  "+$("#noticeTitle").val():"";
	gb[17]=gb18;
	zhuang();
});
$("#bidOpenPlace").change( function() {
	 var gb1="${notice.tenderNoticeData.bidOpenPlace}"!=$("#bidOpenPlace").val()?$(this).parent().prev().html()+"由 ${notice.tenderNoticeData.bidOpenPlace}  更改为  "+$("#bidOpenPlace").val():"";
	gb[0]=gb1;
	zhuang();
});
$("#applyDateEnd").blur( function() {
	 var gb2="<fmt:formatDate value='${notice.tenderNoticeData.applyDateEnd}' pattern='yyyy-MM-dd HH:mm:ss' type='both' dateStyle='default' timeStyle='default' />"!=$("#applyDateEnd").val()?$(this).parent().prev().html()+"由 <fmt:formatDate value='${notice.tenderNoticeData.applyDateEnd}' pattern='yyyy-MM-dd HH:mm:ss' type='both' dateStyle='default' timeStyle='default' />  更改为  "+$("#applyDateEnd").val():"";
	gb[1]=gb2;
	zhuang();
	$("#bstzsj").html($(this).val());
});
$("#bidFileObtainWay").change( function() {
	 var gb3="${notice.tenderNoticeData.bidFileObtainWay}"!=$("#bidFileObtainWay").val()?$(this).parent().prev().html()+"由 ${notice.tenderNoticeData.bidFileObtainWay}  更改为  "+$("#bidFileObtainWay").val():"";
	gb[2]=gb3;
	zhuang();
});
//时间
$("#bidDeadline").blur( function() {
	 var gb4="<fmt:formatDate value='${notice.tenderNoticeData.bidDeadline}' type='both' pattern='yyyy-MM-dd HH:mm:ss' dateStyle='default' timeStyle='default' />"!=$("#bidDeadline").val()?$(this).parent().prev().html()+"由 <fmt:formatDate value='${notice.tenderNoticeData.bidDeadline}' type='both' pattern='yyyy-MM-dd HH:mm:ss' dateStyle='default' timeStyle='default' />  更改为  "+$("#bidDeadline").val():"";
	gb[3]=gb4;
	zhuang();
});
$("#bidSendForm").change( function() {
	 var gb5="${notice.tenderNoticeData.bidSendForm}"!=$("#bidSendForm").val()?$(this).parent().prev().html()+"由 ${notice.tenderNoticeData.bidSendForm}  更改为  "+$("#bidSendForm").val():"";
	gb[4]=gb5;
	zhuang();
});
$("#bidOpenDate").blur( function() {
	 var gb6="<fmt:formatDate value='${notice.tenderNoticeData.bidOpenDate}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />"!=$("#bidOpenDate").val()?$(this).parent().prev().html()+"由 <fmt:formatDate value='${notice.tenderNoticeData.bidOpenDate}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />  更改为  "+$("#bidOpenDate").val():"";
	gb[5]=gb6;
	zhuang();
	$("#kbsj").html($(this).val());
});
$("#applyProjectNumber").change( function() {
	 var gb7="${notice.applyProjectNumber}"!=$("#applyProjectNumber").val()?$(this).parent().prev().html()+"由 ${notice.applyProjectNumber}  更改为  "+$("#applyProjectNumber").val():"";
	gb[6]=gb7;
	zhuang();
});
$("#isWorkHoliday").change( function() {
	 var gb8="${notice.isWorkHoliday}"!=$("#isWorkHoliday").val()?$(this).parent().prev().html()+"由 ${notice.isWorkHoliday=='0'?'否':'是'}  更改为  "+($("#isWorkHoliday").val()=='0'?'否':'是'):"";
	gb[7]=gb8;
	zhuang();
});
$("#isComboBid").change( function() {
	 var gb9="${notice.isComboBid}"!=$("#isComboBid").val()?$(this).parent().prev().html()+"由 ${notice.isComboBid=='0'?'否':'是'}  更改为  "+($("#isComboBid").val()=='0'?'否':'是'):"";
	gb[8]=gb9;
	zhuang();
});
$("#ggfbsj").blur( function() {
	var gb10="<fmt:formatDate value='${notice.ggfbsj}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />"!=$("#ggfbsj").val()?$(this).parent().prev().html()+"由 <fmt:formatDate value='${notice.ggfbsj}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />  更改为  "+$("#ggfbsj").val():"";
	gb[9]=gb10;
	zhuang();
	$("#bmkssj").html($(this).val());
});
$("#ggjssj").blur( function(){
	 var gb11="<fmt:formatDate value='${notice.ggjssj}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />"!=$("#ggjssj").val()?$(this).parent().prev().html()+"由 <fmt:formatDate value='${notice.ggjssj}' type='both' pattern='yyyy-MM-dd HH:mm:ss' timeStyle='default' />  更改为  "+$("#ggjssj").val():"";
	 gb[10]=gb11;
	zhuang();
	$("#bmjssj").html($(this).val());
});
$("#fbzrr0").change( function() {
	 var gb12="${notice.fbzrr0}"!=$("#fbzrr0").val()?$(this).parent().prev().html()+"由 ${notice.fbzrr0}  更改为  "+$("#fbzrr0").val():"";
	gb[11]=gb12;
	zhuang();
});
$("#yzzrr0").change( function() {
	 var gb13="${notice.yzzrr0}"!=$("#yzzrr0").val()?$(this).parent().prev().html()+"由 ${notice.yzzrr0}  更改为  "+$("#yzzrr0").val():"";
	gb[12]=gb13;
	zhuang();
});
function zhuang(){
	var ngb = new Array();
	var j=0;
	$.each(gb, function(i, n){
			if(n){
				  ngb[j++]="<br/>"+n;
			}
		});
	$("#changeContent").val(ngb);
}
}); 