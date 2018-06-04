(function($){
	/**
	 * args：印章对象ID,被签名数据
	 * 
	 * return：签名值
	 **/
	$.fn.addSeal=function(sealElementId,data){
		WebSign_AddSeal(sealElementId, 650, -300, $(this).attr("id"), data);
		return document.all.DWebSignSeal.GetStoreData();
	}
	/**
	 * args：印章对象ID,签名值,被签名数据
	 * 
	 * return void
	 **/
	$.fn.verifySeal=function(sealElementId,signatureData,data){
		document.all.DWebSignSeal.SetStoreData(signatureData);
		document.all.DWebSignSeal.ShowWebSeals();
		document.all.DWebSignSeal.SetSealSignData(sealElementId,data);
	}
})(jQuery);