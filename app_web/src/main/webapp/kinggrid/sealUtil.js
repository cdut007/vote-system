var sealUtil={
    use_fake_seal:false,
	getSignatureControl:function(){
		return document.getElementById("SignatureControl");
	},

    /****
     * 根据对象添加电子印章（数字签名）
     *
     * @param businessKey 业务对象ID
     * @param sealName 印章名称
     * @param signStr 被签名保护的内容（1."id=domID",domID代表需要保护内容的dom文档id；2."data='str',被保护的字符串内容;
	 *                                3."domBind='domname'",domname是input标签下的name）
     *        暂时不支持html文档域绑定
     * @param relativeId 相对位置dom文档ID
     * @param posX 相对水平偏移
     * @param posY 相对垂直偏移
     * @author xieyang
     * @time  2017-07-13
     * @returns
     */
    addSealWithBKey:function(businessKey,sealName,signObjStr,relativeId,posX,posY){
        if(this.isExists(sealName)){
            $.messager.alert('系统提示',"已盖章,请核实！");
            return;
        }
        if(signObjStr == ""){
            $.messager.alert('系统提示',"签章内容参数为空,请核实！");
            return;
        }else{
            //清空原绑定内容
            document.all.DWebSignSeal.SetSignData("-");
        }
        var str = sealUtil.getSignStr(signObjStr);

        if(str == ""){
            $.messager.alert('系统提示',"签章内容为空,请核实！");
            return;
        }

        var mt = signObjStr.split('=');
		if("domBind" == mt[0]){
			document.all.DWebSignSeal.SetSignData("+LIST:"+str);
		}else{
			document.all.DWebSignSeal.SetSignData("+DATA:"+str);
		}

        //固定印章的位置
        document.all.DWebSignSeal.SetPosition(posX,posY,relativeId);
        //调用盖章的接口
        var sealid=document.all.DWebSignSeal.AddSeal("",sealName);
        //获取当前页面的全部签章数据
        signData=document.all.DWebSignSeal.GetStoreData();
        if(signData!=undefined&&signData!=""){
            $.ajax({
                url:ctx+"/signatureData/addSignatureData",
                data:{signatureData:signData,sealName:sealName,objectId:businessKey,posX:posX,posY:posY},
                type:"post",
                dataType:"json",
                success:function(data){
                	if(!data.success){
                        document.all.DWebSignSeal.DelSeal(sealName);
                        $.messager.alert('系统提示',data.msg);
					}
                    //console.log("签章成功");
                },
                error:function(){
                    $.messager.alert('系统提示',"签章保存异常,请核实！");
                }
            });
        }
        return signData;
    },

	/****
	 * 根据对象添加电子印章（数字签名）
	 *
	 * @param businessKey 业务对象ID
	 * @param sealName 印章名称
	 * @param signStr 被签名保护的内容（1."id=domID",domID代表需要保护内容的dom文档id；2."data='str',被保护的字符串内容;
	 *                                3."domBind='domname'",domname是input标签下的name）
	 *        暂时不支持html文档域绑定
	 * @param relativeId 相对位置dom文档ID
	 * @param posX 相对水平偏移
	 * @param posY 相对垂直偏移
	 * @author xieyang
	 * @time  2017-07-13
	 * @returns
	 */
	addSealWithBKeyNoSave:function(sealName,signObjStr,relativeId,posX,posY){
		if(this.isExists(sealName)){
			$.messager.alert('系统提示',"已盖章,请核实！");
			return;
		}
		if(signObjStr == ""){
			$.messager.alert('系统提示',"签章内容参数为空,请核实！");
			return;
		}else{
			//清空原绑定内容
			document.all.DWebSignSeal.SetSignData("-");
		}
		var str = sealUtil.getSignStr(signObjStr);

		if(str == ""){
			$.messager.alert('系统提示',"签章内容为空,请核实！");
			return;
		}

		var mt = signObjStr.split('=');
		if("domBind" == mt[0]){
			document.all.DWebSignSeal.SetSignData("+LIST:"+str);
		}else{
			document.all.DWebSignSeal.SetSignData("+DATA:"+str);
		}

		//固定印章的位置
		document.all.DWebSignSeal.SetPosition(posX,posY,relativeId);
		//调用盖章的接口
		var sealid=document.all.DWebSignSeal.AddSeal("",sealName);
		//获取当前页面的全部签章数据
		signData=document.all.DWebSignSeal.GetStoreData();
		return signData;
	},

    getSignStr:function (signObjStr) {
        var signStr = signObjStr.split('=');
        var rStr = "";
        if("id" == signStr[0]){
            rStr = document.getElementById(signStr[1]).innerHTML;
        }else if("data" == signStr[0]){
            rStr = signStr[1];
        }else if("domBind" == signStr[0]){
			rStr = signStr[1];
		}else{
			$.messager.alert("签章参数signObjStr错误："+signObjStr);
        }
        return rStr;
    },
    /****
     * 显示与验证电子印章（数字签名）
     *
     * @param rSignData 签章数据对象
     * @param signObjStr 如果参数为空，那么进行html域绑定验证
     * @param domID 显示印章位置的原点
     * @author xieyang
     * @time  2017-07-13
     * @returns
     */
    showAndVerifySeal:function(rSignData,signObjStr,domID) {
        document.all.DWebSignSeal.SetStoreData(rSignData.signatureData);

		var sealName = rSignData.sealName;
        document.all.DWebSignSeal.MoveSealPosition(sealName, rSignData.posX, rSignData.posY, domID)

        //显示印章
        document.all.DWebSignSeal.ShowWebSeals();

		if(signObjStr != ""){
			var signStr = sealUtil.getSignStr(signObjStr);
			document.all.DWebSignSeal.SetSealSignData(sealName,signStr);
		}

		if(document.all.DWebSignSeal.VerifySeal(sealName)!=0){
            $.messager.alert('系统提示',"验证印章【"+sealName+"】失败!");
            return;
        }
		if(document.all.DWebSignSeal.VerifyDoc(sealName)!=0){
			$.messager.alert('系统提示',"验证文档【"+sealName+"】失败!");
			return;
		}
		document.all.DWebSignSeal.LockSealPosition(sealName);
    },
	/***
	 *
	 * 检查章的位置是否有改变，如果改变则更新到数据库
	 *
	 * **/
	checkAndUpdateSealPos:function(sealName,businessKey,posXOld,posYOld) {
		if(this.use_fake_seal){
			return;
		}
		var posX = document.all.DWebSignSeal.GetSealPosX (sealName);
		var posY = document.all.DWebSignSeal.GetSealPosY (sealName);
		if((posXOld == posX)&&(posYOld == posY)){//章的位置没有变，不做处理
			return;
		}else{
			$.ajax({
				url:ctx+"/signatureData/updateSignatureData",
				data:{sealName:sealName,objectId:businessKey,posX:posX,posY:posY},
				type:"post",
				dataType:"json",
				success:function(data){
					//console.log("更新签章位置成功");
				},
				error:function(){
					$.messager.alert('系统提示',"更新签章位置失败！");
				}
			});
		}
	},

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
		if(this.isExists(sealName)){
			$.messager.alert('系统提示',"已盖章,请核实！");
			return;
		}


		var signData="fake_sign_data"
		if(this.use_fake_seal){
			$("body").append($("<div/>").attr("id",sealName).addClass("jc-seal").css({display:"none",position:"absolute",top:y,left:x,width:150,height:150,zIndex:999}).append($("<img/>").css("width","100%").attr("src","data:image/png;base64,"+imgData)));
		}else{
			//绑定要签名附带的表单域数据(需要review)
			document.all.DWebSignSeal.SetSignData("+LIST:"+nameArray.join(";"));
			
			//网络版的唯一页面ID ，SessionID
			document.all.DWebSignSeal.RemoteID = "0100017";
			
			//固定印章的位置
			document.all.DWebSignSeal.SetPosition(positionX,positionY,relativeId);
			
			//调用盖章的接口
			var sealid=document.all.DWebSignSeal.AddSeal("",sealName);
			
			signData=document.all.DWebSignSeal.GetStoreData();
			
			var imgData = $.ajax({url: ctx+"/signatureData/loadSealImage",type:"post",data:{signvalue:signData},async: false}).responseText;
			
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

			if(signData!=undefined&&signData!=""){
				$.ajax({
					url:ctx+"/signatureData/addSignatureData",
					data:{signatureData:signData,sealName:sealName,objectId:businessKey},
					type:"post",
					dataType:"json",
					success:function(data){
						if(data.success){
							$("body").append($("<div/>").attr("jc",sealName).addClass("jc-seal").css({display:"none",position:"absolute",top:y,left:x,width:150,height:150,zIndex:999}).append($("<img/>").css("width","100%").attr("src","data:image/png;base64,"+imgData)));
						}
					},
					error:function(){
						
					}
				});
			}
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
        JITDSignOcx.Initialize(InitParam);
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
		$("body").append($("<div/>").attr("id",sealName).addClass("jc-seal").css({display:"none",position:"absolute",top:y,left:x,width:150,height:150,zIndex:999}).append($("<img/>").css("width","100%").attr("src","data:image/png;base64,"+imgData)));
		//TODO
		//JITDSignOcx.SetCertChooseType(1);
		//JITDSignOcx.SetCertEx("MY", "SC", "", "", "", "", "");
		/*if(JITDSignOcx.GetErrorCode()!=0){
			alert("错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return ;
		}*/
		//alert("{"+annoForm.join(",")+"}");
		var signData=JITDSignOcx.AttachSignStr("","{"+annoForm.join(",")+"}");
        JITDSignOcx.Finalize();
		return signData;
	},
	removeSeal:function(sealName){
		$("#"+sealName).remove();
	},
	/*****
	 * 验证印章
	 * @param signData
	 */
	verifySeal:function(signData,pos){
		document.all.DWebSignSeal.SetStoreData(signData);
		var strObjectName ;
		//获取第一个印章
		strObjectName = DWebSignSeal.FindSeal("",0);
		var x = pos;
		var y = 200;
		while(strObjectName  != ""){
			x = x+1;
			if(x >= 3){
				x = 1;
				y = y + 200;
			}
			document.all.DWebSignSeal.MoveSealPosition(strObjectName, x*150-75, y, "noticeContent")
			//遍历，获取下一个印章
			strObjectName = DWebSignSeal.FindSeal(strObjectName,0);
		}
		//显示印章
		document.all.DWebSignSeal.ShowWebSeals();

		//获取第一个印章
		strObjectName = DWebSignSeal.FindSeal("",0);
		while(strObjectName  != ""){
			if(document.all.DWebSignSeal.VerifySeal(strObjectName)!=0){
				$.messager.alert('系统提示',"验证印章【"+strObjectName+"】失败!");
				return;
			}
			if(document.all.DWebSignSeal.VerifyDoc(strObjectName)!=0){
				$.messager.alert('系统提示',"验证文档【"+strObjectName+"】失败!");
				return;
			}
			//遍历，获取下一个印章	
			strObjectName = DWebSignSeal.FindSeal(strObjectName,0);				 
		}

	},
	sealExists:function(sealName){
		//if(this.sealCount()>0){
		if(this.isExists(sealName)){
			return true;
		}else{
			return false;
		}
	}, 
	isExists:function(sealName){
		if(this.use_fake_seal){
			return true;
		}
		var strObjectName ;
		//获取第一个印章
		try{
			strObjectName = document.all.DWebSignSeal.FindSeal("",0);
		}catch(e){
				$.messager.alert('系统提示',"签章控件加载失败，请使用IE8以上浏览器，并确保ActiveX控件具有执行权限");
			}
		while(strObjectName  != ""){
			//通过循环进行便利所有印章，加入当前文本域已经加盖印章的话进行提示
			if(sealName == strObjectName){
				return true;
			}
			strObjectName = DWebSignSeal.FindSeal(strObjectName,0);
		}
		return false;
	},
	/*****
	 * 印章数量
	 * @returns
	 */
	sealCount:function(){
		var count = 0;
		var strObjectName;
		//获取第一个印章
		try{
			strObjectName = document.all.DWebSignSeal.FindSeal("",0);
		}catch(e){
			$.messager.alert('系统提示',"签章控件加载失败，请使用IE8以上浏览器，并确保ActiveX控件具有执行权限");
		}
		while(strObjectName  != ""){
			count++;
			//遍历，获取下一个印章
			strObjectName = DWebSignSeal.FindSeal(strObjectName,0);
		}
		return count;
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
                        sealUtil.verifySeal(data[i].signatureData,i);
                        //break;
                    }catch(e){

                    }
                }
            }
        });
    },
	/*****
	 * 加载所有印章
	 * @param objectId
	 */
	loadAllSealWithBKey:function(objectId,signObjStr,domID){
		$.ajax({
			url:ctx+"/signatureData/loadSignatureData",
			data:{objectId:objectId},
			type:"post",
			dataType:"json",
			success:function(data){
				for(var i=0,l=data.length;i<l;i++){
					try{
						sealUtil.showAndVerifySeal(data[i],signObjStr,domID);
					}catch(e){
						//console.log(e);
                        $.messager.alert('系统提示',"显示与验证签章失败，请使用IE8以上浏览器，并确保ActiveX控件具有执行权限");
					}
				}
			}
		});
	},
	
	loadTenderSignData:function(str){
		if(this.use_fake_seal){
            return "MIIElQYKKoEcz1UGAQQCAqCCBIUwggSBAgEBMQwwCgYIKoEcz1UBgxEwDAYKKoEcz1UGAQQCAaCCA08wggNLMIIC76ADAgECAgh6z9CZhvAeujAMBggqgRzPVQGDdQUAMIGOMQswCQYDVQQGEwJDTjEPMA0GA1UECAwGU2hhblhpMRAwDgYDVQQHDAdUYWlZdWFuMS0wKwYDVQQKDCRTaGFuWGkgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkxLTArBgNVBAMMJFNoYW5YaSBEaWdpdGFsIENlcnRpZmljYXRlIEF1dGhvcml0eTAeFw0xNzAzMTAwMjM5MzNaFw0xODAzMTAwMjM5MzNaMIGEMQswCQYDVQQGEwJDTjEPMA0GA1UECAwG5bGx6KW";
        }else{
            return this.JitSignDataStr(str);
        }
    },

    /***
    *@param str 待签名字符串
    **@autho xieyang
    **@date 2017-07-13
    *@return 签名后的结果
     **/
    //字符串签名用
    JitSignDataStr:function(str) {
    	if(this.use_fake_seal){
    		return "use_fake_seal";
    	}
        //调用JITDSignOcx
		try{
			JITDSignOcx.Initialize(InitParam);
		}catch(e){
			$.messager.alert("系统提示","请确认已经安装好USB KEY驱动，并使用IE8以上浏览器");
			return "";
		}
        JITDSignOcx.SetCertChooseType(1);
        JITDSignOcx.SetCert("SC", "", "", "", "", "");
        if (JITDSignOcx.GetErrorCode() != 0) {
            $.messager.alert("系统提示","错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
            JITDSignOcx.Finalize();
            return "";
        }
        //带原文的数字签名
        var signStr = JITDSignOcx.AttachSignStr("", str);
        if (JITDSignOcx.GetErrorCode() != 0) {
            $.messager.alert("系统提示","错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
            JITDSignOcx.Finalize();
            return "";
        }
        JITDSignOcx.Finalize();
        return signStr;
    },

	/***
	 *@param str 待签名字符串数组
	 **@autho xieyang
	 **@date 2017-07-13
	 *@return 签名后的结果
	 **/
	//字符串签名用
	JitSignDataStrArray:function(strArray) {
		
	if(!this.use_fake_seal){
		//调用JITDSignOcx
		try{
			JITDSignOcx.Initialize(InitParam);
		}catch(e){
			$.messager.alert("系统提示","请确认已经安装好USB KEY驱动，并使用IE8以上浏览器");
			return "";
		}
		JITDSignOcx.SetCertChooseType(1);
		JITDSignOcx.SetCert("SC", "", "", "", "", "");
		if (JITDSignOcx.GetErrorCode() != 0) {
			$.messager.alert("系统提示","错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			JITDSignOcx.Finalize();
			return "";
		}
		for(x in strArray){
			//带原文的数字签名
			var i = 0;
			var signStr="";
			while(i<5&&signStr==""){
				signStr = JITDSignOcx.AttachSignStr("", strArray[x]);
				i++;
				if(i == 5){
					return "";
				}
			}
			strArray[x] = signStr;
		}

		if (JITDSignOcx.GetErrorCode() != 0) {
			$.messager.alert("系统提示","错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			JITDSignOcx.Finalize();
			return "";
		}
		JITDSignOcx.Finalize();
		
	}else{
		for(x in strArray){
			strArray[x] = "fake_sign_data";
		}
	}
		return strArray;
	}
};


	