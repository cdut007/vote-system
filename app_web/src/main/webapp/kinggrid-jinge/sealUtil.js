var sealUtil={
	/****
	 * 根据对象添加电子印章
	 * 
	 * @param businessKey 业务对象ID
	 * @param sealName 印章内容
	 * @param nameArray 表单 name 数据
	 * @param relativeId 相对位置ID
	 * @param positionX 相对水平偏移
	 * @param positionY 相对垂直偏移
	 * @returns
	 */
	addSealWithBusinessKey:function(businessKey,sealName,nameArray,relativeId,positionX,positionY){
		if($("#"+sealName).length>0){
			$.messager.alert('系统提示',"已盖章,请核实！");
			return;
		}
		//alert(m_ISign);
		/*alert(m_ISign);
		return;
		//var imgData=m_ISign.XJCAGetSignImg();
		//alert(imgData);
		var imgData=CertInfo.getSignPicture("");
		if(imgData==""){
			$.messager.alert('系统提示',"请插入数字证书！");
			return;
		}*/
		var randomStr = new Date().getTime()+"";
		//调用JITDSignOcx的选择证书
		JITDSignOcx.SetCertChooseType(1);
		JITDSignOcx.SetCert("SC", "", "", "", "CN=ShanXi Digital Certificate Authority,OU=RSA,O=ShanXi Digital Certificate Authority,L=TaiYuan,S=ShanXi,C=CN", "");
		if (JITDSignOcx.GetErrorCode() != 0) {
			$.messager.alert("系统提示","错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return false;
		}
		//带原文的数字签名
		var signStr = JITDSignOcx.AttachSignStr("", randomStr);
		if (JITDSignOcx.GetErrorCode() != 0) {
			$.messager.alert("系统提示","错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return false;
		}
		var imgData = $.ajax({url: ctx+"/signatureData/loadSealImage",type:"post",data:{signvalue:signStr},async: false}).responseText;
		
		var x=positionX;
		var y=positionY;
		if(relativeId){
			var relativeEle=$("#"+relativeId);
			if(relativeEle.length>0){
				var offset=relativeEle.offset();
				x=offset.left+positionX;
				y=offset.top+positionY;
			}
		}
		var offset=$("#"+relativeId).offset();
		var annoForm=[];
		var dataForm=[];
		for(var i=0,l=nameArray.length;i<l;i++){
			var inputName=nameArray[0];
			$(":input[name='"+inputName+"']").each(function(){
				dataForm.push("\""+inputName+"\":\""+encodeURIComponent($(this).val())+"\"");//annoForm.append($("<input/>").attr("name",nameArray[i]).val($(this).val()));
			});
		}
		annoForm.push("\""+"jc-seal-input-data"+"\":{"+dataForm.join(",")+"}");
		annoForm.push("\""+"jc-seal-relative-id"+"\":\""+relativeId+"\"");
		annoForm.push("\""+"jc-seal-img-data"+"\":\""+imgData+"\"");
		annoForm.push("\""+"jc-seal-position-x"+"\":"+positionX+"");
		annoForm.push("\""+"jc-seal-position-y"+"\":"+positionY+"");
		annoForm.push("\""+"jc-seal-name"+"\":\""+sealName+"\"");
		//TODO
		//JITDSignOcx.SetCertChooseType(1);
		//JITDSignOcx.SetCertEx("MY", "SC", "", "", "", "", "");
		/*if(JITDSignOcx.GetErrorCode()!=0){
			alert("错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return ;
		}*/
		//alert("{"+annoForm.join(",")+"}");
		var signData=JITDSignOcx.AttachSignStr("","{"+annoForm.join(",")+"}");
		if(signData!=undefined&&signData!=""){
			$.ajax({
				url:ctx+"/signatureData/addSignatureData",
				data:{signatureData:signData,sealName:sealName,objectId:businessKey},
				type:"post",
				dataType:"json",
				success:function(data){
					if(data.success){
						$("body").append($("<div/>").attr("id",sealName).addClass("jc-seal").css({position:"absolute",top:y,left:x,width:150,height:150,zIndex:999}).append($("<img/>").css("width","100%").attr("src","data:image/png;base64,"+imgData)));
					}
				},
				error:function(){
					
				}
			});
		}
		return signData;
	},
	/******
	 * 验证印章
	 * @param sealName
	 * @param nameArray
	 * @param relativeId
	 * @param positionX
	 * @param positionY
	 * @returns
	 */
	addSeal:function(sealName,nameArray,relativeId,positionX,positionY){
		if($("#"+sealName).length>0){
			$.messager.alert('系统提示',"已盖章,请核实！");
			return;
		}
		//alert(m_ISign);
		/*alert(m_ISign);
		return;
		//var imgData=m_ISign.XJCAGetSignImg();
		//alert(imgData);
		var imgData=CertInfo.getSignPicture("");
		if(imgData==""){
			$.messager.alert('系统提示',"请插入数字证书！");
			return;
		}*/
		var randomStr = new Date().getTime()+"";
		//调用JITDSignOcx的选择证书
		JITDSignOcx.SetCertChooseType(1);
		JITDSignOcx.SetCert("SC", "", "", "", "CN=ShanXi Digital Certificate Authority,OU=RSA,O=ShanXi Digital Certificate Authority,L=TaiYuan,S=ShanXi,C=CN", "");
		if (JITDSignOcx.GetErrorCode() != 0) {
			$.messager.alert("系统提示","错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return false;
		}
		//带原文的数字签名
		var signStr = JITDSignOcx.AttachSignStr("", randomStr);
		if (JITDSignOcx.GetErrorCode() != 0) {
			$.messager.alert("系统提示","错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return false;
		}
		var imgData = $.ajax({url: ctx+"/signatureData/loadSealImage",type:"post",data:{signvalue:signStr},async: false}).responseText;
		
		var x=positionX;
		var y=positionY;
		if(relativeId){
			var relativeEle=$("#"+relativeId);
			if(relativeEle.length>0){
				var offset=relativeEle.offset();
				x=offset.left+positionX;
				y=offset.top+positionY;
			}
		}
		var offset=$("#"+relativeId).offset();
		var annoForm=[];
		var dataForm=[];
		for(var i=0,l=nameArray.length;i<l;i++){
			var inputName=nameArray[0];
			$(":input[name='"+inputName+"']").each(function(){
				dataForm.push("\""+inputName+"\":\""+encodeURIComponent($(this).val())+"\"");//annoForm.append($("<input/>").attr("name",nameArray[i]).val($(this).val()));
			});
		}
		annoForm.push("\""+"jc-seal-input-data"+"\":{"+dataForm.join(",")+"}");
		annoForm.push("\""+"jc-seal-relative-id"+"\":\""+relativeId+"\"");
		annoForm.push("\""+"jc-seal-img-data"+"\":\""+imgData+"\"");
		annoForm.push("\""+"jc-seal-position-x"+"\":"+positionX+"");
		annoForm.push("\""+"jc-seal-position-y"+"\":"+positionY+"");
		annoForm.push("\""+"jc-seal-name"+"\":\""+sealName+"\"");
		$("body").append($("<div/>").attr("id",sealName).addClass("jc-seal").css({position:"absolute",top:y,left:x,width:150,height:150,zIndex:999}).append($("<img/>").css("width","100%").attr("src","data:image/png;base64,"+imgData)));
		//TODO
		//JITDSignOcx.SetCertChooseType(1);
		//JITDSignOcx.SetCertEx("MY", "SC", "", "", "", "", "");
		/*if(JITDSignOcx.GetErrorCode()!=0){
			alert("错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return ;
		}*/
		//alert("{"+annoForm.join(",")+"}");
		var signData=JITDSignOcx.AttachSignStr("","{"+annoForm.join(",")+"}");
		return signData;
	},
	removeSeal:function(sealName){
		$("#"+sealName).remove();
	},
	/*****
	 * 验证印章
	 * @param signData
	 */
	verifySeal:function(signData){	
		var temp_DSign_Check_Result = JITDSignOcx.VerifyAttachedSign(signData);
		if(JITDSignOcx.GetErrorCode()!=0 && JITDSignOcx.GetErrorCode()!=-10101029){
			if(JITDSignOcx.GetErrorCode()!=0 && JITDSignOcx.GetErrorCode()!=-10101037){
		  		//V_STATUS.value = "错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode());
		      	$.messager.alert("系统提示","错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
		      	return ;	
			}
			else{
				//Modified by lihe:2005.02.05
		        //V_STATUS.value = "错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode());
				$.messager.alert("系统提示","错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
		        return ;
			}	
		}else{
		   	if(temp_DSign_Check_Result<0){
		   		$.messager.alert("系统提示"," 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
		   	}
		  	var ORG_DATA = JITDSignOcx.getData();
		  	//alert(ORG_DATA);
		  	var data=$.parseJSON(ORG_DATA);
		  	var sealName=data['jc-seal-name'];
		  	var relativeId=data['jc-seal-relative-id'];
		  	var x=data['jc-seal-position-x'];
		  	var y=data['jc-seal-position-y'];
		  	//TODO
		  	var inputData=data['jc-seal-input-data'];
		  	for(var inputName in inputData){
		  		$(":input[name='"+inputName+"']").each(function(){
					if(encodeURIComponent($(this).val())!=inputData[inputName]){
						$.messager.alert("系统提示","数据电文验证失败!");
						return;
					}
				});
		  	}
			if(relativeId){
				var relativeEle=$("#"+relativeId);
				if(relativeEle.length>0){
					var offset=relativeEle.offset();
					x=offset.left+x;
					y=offset.top+y;
				}
			}
		 	var imgData=data['jc-seal-img-data'];
		 	$("body").append($("<div/>").attr("id",sealName).addClass("jc-seal").css({position:"absolute",top:y,left:x,width:150,height:150,zIndex:999}).append($("<img/>").css("width","100%").attr("src","data:image/png;base64,"+imgData)));
			//$("#"+relativeId).after($("<img/>").attr("src","data:image/png;base64,"+imgData).attr("id",sealName).addClass("jc-seal").css({position:"absolute",top:positionY,left:positionX,width:150,height:150}));
		}
	},
	isExists:function(sealName){
		return $("#"+sealName).length==1;
	},
	/*****
	 * 印章数量
	 * @returns
	 */
	sealCount:function(){
		return $(".jc-seal").length;
	},
	/*****
	 * 加载所有印章
	 * @param objectId
	 */
	loadAllSealWithBusinessKey:function(objectId){
		$.ajax({
			url:ctx+"/signatureData/loadSignatureData",
			data:{objectId:objectId},
			type:"post",
			dataType:"json",
			success:function(data){
				for(var i=0,l=data.length;i<l;i++){
					try{
						sealUtil.verifySeal(data[i].signatureData);
					}catch(e){
						
					}
				}
			}
		});
	}
};
	