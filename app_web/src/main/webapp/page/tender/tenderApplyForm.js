$(function() {
	var uploader_ = null;
	var fjztid = -1;
	var percent="<div class=\"progressbar easyui-fluid\" style=\"width: 127px; height: 20px;\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div><div class=\"progressbar-value\" style=\"width: 100%; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div></div></div>";
	/*******************************************************************************
	 * vSealName:印章名称 vSealPostion:印章绑定的位置 vSealSignData:印章绑定的数据
	 ******************************************************************************/

	//var sealName="sqbsign";
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
	function doDetachSign(strRaw) {

		var InitParam = "<?xml version=\"1.0\" encoding=\"utf-8\"?><authinfo><liblist><lib type=\"CSP\" version=\"1.0\" dllname=\"\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"Sml0M2tHTVAxMVYyMTEuZGxs\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"SERfR01DQUlTLmRsbA==\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"U2h1dHRsZUNzcDExXzMwMDBHTS5kbGw=\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"U0tGQVBJLmRsbA==\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"U3hjYUNzcDExXzMwMDBHTS5kbGw=\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib></liblist></authinfo>";
	       
		JITDSignOcx.Initialize(InitParam);
		if (JITDSignOcx.GetErrorCode() != 0) {
			alert("初始化失败，错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			JITDSignOcx.Finalize();
			return;
		}

		JITDSignOcx.SetCertChooseType(1);
		if (JITDSignOcx.GetErrorCode() != 0) {
			alert("错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			JITDSignOcx.Finalize();
			return;
		}

		// JITDSignOcx.SetCert("SC", DSign_Subject.value, "", "",
		// CERTISSUSER_DN.value, "");
		JITDSignOcx.SetCert("SC", "", "", "", "", "");
		if (JITDSignOcx.GetErrorCode() != 0) {
			alert("设置证书过滤失败，错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			JITDSignOcx.Finalize();
			return;
		}
		// 签名
		var signData = JITDSignOcx.DetachSignStr("", strRaw);
		//console.info(signData);
		// 验签，rs=0 成功 1失败
		//var rs = JITDSignOcx.VerifyDetachedSignStr(signData, strRaw);
		//console.info(rs);

		// JITDSignOcx.SetFileNameUseUTF8(1);
		// if(JITDSignOcx.GetErrorCode()!=0)
		// {

		// alert("错误码："+JITDSignOcx.GetErrorCode()+"
		// 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
		// JITDSignOcx.Finalize();
		// return ;
		// }

		JITDSignOcx.Finalize();
		return signData;

	}
	
	function isNewFile(id){
		var isNewFile=$("div."+id).length==1;
		return isNewFile;
	}
	function isFullPercent(id){
		var isFullPercent=isNewFile(id)&&$("div."+id).progressbar("getValue")==100;
		return isFullPercent;
	}
	function isUploaded(id){
		var isUploaded=isFullPercent(id)&&$(":input."+id).length==1;
		return isUploaded;
	}
	//删除附件
	function removeAttachment(fileId,btnId){
		var row= $("#attachmentUpload1").datagrid("getSelected");
		var rowIndex = $("#attachmentUpload1").datagrid("getRowIndex",row);
		$.messager.confirm('系统提示','确定要删除该附件吗？',function(r){
			if(r){
				var timer=window.setInterval(function(){
					if(isUploaded(fileId)||!isNewFile(fileId)){//完成存储
						$.ajax({
							url : ctx+"/attachment/deleteAttachment",
							data:{"id":(isUploaded(fileId)?$(":input."+fileId).val():fileId)},
							type:"post",
							dataType:"json",
							success : function(data) {
								if(data.success){
									if(isUploaded(fileId)){
										uploader.removeFile(fileId);
										$(":input."+fileId).remove();
									}
									$("#attachmentUpload1").datagrid("clearSelections");
//									$("#attachmentUpload").datagrid("deleteRow",rowIndex);
									$("#attachmentUpload1").datagrid("updateRow",{
										index:rowIndex,
										row:{
											uploadTime:"-",
											length:"0",
											status:"-",
											fjlx00:"-",
											opt:'<a id="'+btnId+'" class="button small red">添加附件</a>',
											flag:"false"
										}
									});
									initUpload(btnId,row.fjmc,rowIndex);
								}
							}
						});
					}else if(isFullPercent(fileId)){//完成上传
						return;
					}else if(isNewFile(fileId)){//正在上传
						uploader.removeFile(fileId);
						$("#attachmentUpload1").datagrid("deleteRow",rowIndex);
					}
					window.clearInterval(timer);
				},500);
			}
		});
	}
	//提交数据检查
	function saveTenderApplyCheck(isComplete){
		if ($("input[name='item_ids']:checked").length == 0) {
			$.messager.alert("系统提示", "请先选择要投标的标段！", "warning");
			return;
		}
		if(isComplete){
			var rows = $("#attachmentUpload1").datagrid("getRows");
			var flag = true;
			$.each(rows,function(index,row){
				if(row.flag!=="true"||!row.flag){
					flag = false;
					return;
				}
			});
			if(!flag){
				$.messager.alert("系统提示", "还没有上传完必需附件！", "warning");
				return;
			}
			// if($("#attachmentUpload1").datagrid("getRows").length==0){
			// 	$.messager.alert("系统提示", "还没有上传附件！", "warning");
			// 	return;
			// }
			/*if(!sealUtil.sealExists(sealName)){
				$.messager.alert("系统提示", "提交申请表之前请先加盖电子印章！", "warning");
				return;
			}*/
			$.messager.confirm("系统提示", "确定提交申请表信息吗？", function(r) {
				if (r) {
					saveTenderApply(isComplete);
				}
			});
			return;
		}
		saveTenderApply(isComplete);
	}
	//提交数据
	function saveTenderApply(isComplete,callback){
		var loadSignDataSuccess=true;
		
		var data = $("#tenderApplicationForm").serialize() + "&" + 
		$("input[name='item_ids']:enabled:checked").map(function(i) {
			return "tenderItemList[" + i + "].projectItemId=" + this.value;
		}).get().join("&");
		

		if(isComplete){
			var data2sign ="";
            var projectItemId = "";
            var signStr2 = "";
            $("input[name='item_ids']:enabled:checked").map(function(i) {
				var bdbh = $("#" +this.value).val();
				projectItemId = this.value;
				
                //var signStr1 = "PROJECT_CODE:" + xmbh00+"&TENDER_PROJECT_CODE:" + zbxmbh + "&BIDDER_NAME:" + bidderName + "&BIDDER_ORG_CODE:" + bidderId;
				//data2sign = signStr1;
				
				signStr2 = "PROJECT_CODE=" + xmbh00+"&TENDER_PROJECT_CODE=" + zbxmbh + "&BID_SECTION_CODE=" + bdbh + "&BIDDER_NAME=" + bidderName + "&BIDDER_ORG_CODE=" + bidderCode;
				//console.info(signStr2);
			});
            
            /****************************************************
             * 取消页面签章，改成文件形式归档
             ****************************************************/
            //var signData = sealUtil.addSealWithBKey(noticeId+':'+ownerId,sealName,'data='+data2sign,'sealPos',250,-400);
            var signData = "";
            
            /***************************************************************************
             * FIXME 多标段同时报名，这里会出问题，只传递了一个标段的数字签名
             ***************************************************************************/
			var signData_raw = doDetachSign(signStr2);//document.all.CertInfo.SXCA_SignData(signStr2);//对接公告平台需要的数字签名
			//console.info(signData_raw);
			if(signData_raw==null || signData_raw==''){
				$.messager.alert('系统提示','请输入正确的PIN码！', 'error');
				return ;
			}
			//var signData_raw = document.all.CertInfo.SXCA_SignData(signStr2);//对接公告平台需要的数字签名
			
			//signData_raw = signData_raw.replace(/+/g,'*');			
			var signData_raw = signData_raw.split('+').join('*');
			data = data + "&" + projectItemId +"=" + signData + "&signData_raw=" + signData_raw;
			
		}
		
		data = data + "&isComplete="+isComplete;

		if(loadSignDataSuccess){
			$.ajax({
				url : ctx + "/tenderApply/tenderApply",
				type:"post",
				async:false,
				dataType : "json",
				data : data,
				beforeSend : function() {
					$.messager.progress({
						title : "系统提示",
						msg : "数据提交中"
					});
				},
				success : function(data) {
					if (data.success) {
						$(":input[name='id']").val(data.data);
                        // if (callback && typeof callback === "function") {
                        //     callback(data.data);
                        // }
					}

					$.jGrowl(data.msg);

					if(data.success && isComplete){
						//window.location.href=ctx+"/home";
						window.location.href=ctx+"/tenderApply/tenderApply_sign?tenderId="+data.data;
					}

				},
				complete : function() {
					$.messager.progress("close");
				}
			});
		}else{
			$.jGrowl("数字签名失败");
		}
	}
	//SetValue_onclick();
	$(document).on("click",".del",function(){
		removeAttachment($(this).attr("id"),$(this).attr("data-id"));
	});
	//标段全选
	$("input[name='all']").prop("checked", $("input[name='item_ids']:enabled").filter(function(){return !$(this).prop("checked");}).length==0);
	$("input[name='item_ids']:enabled").change(function(){
		$("input[name='all']").prop("checked", $("input[name='item_ids']:enabled").filter(function(){return !$(this).prop("checked");}).length==0);
		$("#projectItemName").html($("input[name='item_ids']:enabled:checked").map(function(){
			return $(this).parent().parent().children(".itemName").text();
		}).get().join(","));
		//sealUtil.removeSeal(sealName);
		$("#content").val($("#tender_application").html());
	});
	//标段单选
	$("input[name='all']").change(function(){
		$("input[name='item_ids']:enabled").prop("checked",$(this).prop("checked"));
		$("#projectItemName").html($("input[name='item_ids']:enabled:checked").map(function(){
			return $(this).parent().parent().children(".itemName").text();
		}).get().join(","));
		//sealUtil.removeSeal(sealName);
		$("#content").val($("#tender_application").html());
	});
	if($("#id").val()==""){
		$("input[name='item_ids']:enabled").prop("checked",$("input[name='item_ids']:enabled").length==1).change();
	}
	/**
	 * 保存
	 */
//	$("#attachmentUpload").datagrid({
//		title:"附件列表",
//		rownumbers:true,
//		striped:true,
//		collapsible:true,
//		url:ctx+"/attachment/listAttachment",
//		idField:"fjid00",
//		queryParams:{"fjsszt":$("#id").val()==""?"-1":$("#id").val()},
//		height:200,
//		columns:[[
//		  {title:"附件名称",field:"fjmc00",width:300},
//		  {title:"上传时间",field:"uploadTime",width:120},
//		  {title:"附件大小",field:"length",width:80,align:"right",formatter:function(value){
//			  return castSize(value);
//		  }},
//		  {title:"进度",field:"status",width:150,align:"center",formatter:function(value){
//			  return value?value:percent;
//		  }},
//		  {title:"附件类型",field:"fjgslx",width:120},
//		  {title:"操作",field:"opt",width:120,align:'center',formatter:function(value,rowData,rowIndex){
//			  return (rowData["path"]?"<a id=\""+rowData["fjid00"]+"\" class=\"del\">删除</a>&nbsp;<a target=\"_blank\" href=\""+ctx+"/attachment/download/"+rowData["path"]+"\">下载</a>":"");
//		  }}
//		]]
//	});
	
	$("#attachment").datagrid({
		title:"附件列表",
		rownumbers:true,
		striped:true,
		url:ctx+"/attachment/listAttachment",
		idField:"fjid00",
		queryParams:{"fjsszt":$("#id").val()==""?"-1":$("#id").val()},
		height:200,
		columns:[[
		  {title:"附件名称",field:"fjmc00",width:300},
		  {title:"上传时间",field:"uploadTime",width:150},
		  {title:"附件大小",field:"length",width:150,align:"right",formatter:function(value){
			  return castSize(value);
		  }},
		  {title:"附件类型",field:"fjgslx",width:150},
		  {title:"操作",field:"opt",width:150,align:'center',formatter:function(value,rowData,index){
			  return "<a target=\"_blank\" href=\""+ctx+"/attachment/download/"+rowData["path"]+"\">下载</a>";
		  }}
		]]
	});
	$("#saveBtn").click(function() {
		if ($("input[name='item_ids']:enabled:checked").length == 0) {
			$.messager.alert("系统提示", "请先选择要投标的标段！", "warning");
			return;
		}
		saveTenderApply(false);
	});
	$("#sign").click(function() {
		if ($("input[name='item_ids']:enabled:checked").length == 0) {
			$.messager.alert("系统提示", "请先选择要投标的标段！", "warning");
			return;
		}
		//TODO
		//var signData=sealUtil.addSeal(sealName,["content"],"ht_end",580, -350);
		if(signData!=undefined&&signData!=""){
			$("#sealSignData").val(signData);
			$("#sealName").val(sealName);
			saveTenderApplyCheck(false);
		}
	});
	/**
	 * 提交
	 */
	$("#subBtn").click(function() {
		saveTenderApplyCheck(true);
	});
	$("#reason-dialog").dialog({
		open : false,
		title : '撤销原因',
		closed:true,
		modal:true,
		width:600,
		height:400,
		buttons:[
			{text:"提交",handler:function(){
				if($("#nopassReason").val()=="" || $("#nopassReason").val()==null){
					$.messager.alert("系统提示", "请填写撤销原因！");
					return;
				}
				$.messager.confirm("系统提示", "确认提交吗？", function(r) {
					if (r) {
						
						$('#reason-dialog').children("form").ajaxSubmit({
							beforeSend:function(){
								return $('#reason-dialog').children("form").form("validate");
							},
							dataType:"json",
							success:function(data){
								$.jGrowl(data.msg);
							}
						});
						
					}
				});
			}},
			{text:"关闭",handler:function(){
				$('#reason-dialog').dialog('close');
			}}
		]
	});
	

	/**
	 * 撤销
	 */
	$("#cancelBtn").click(function() {
		$(document).scrollTop(0);
		$("#reason-dialog").dialog("open");
	});
	$("#selectAptitude").click(function(){
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 800,
			height : 600,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "选择企业资质",
			href : ctx + "/tenderApply/selectAptitude?t=" + new Date().getTime(),
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			buttons : [ {
				text : "确认",
				color : "red",
				handler : function() {
					var checkedArray = $("#" + id + " #aptitude-datagrid").datagrid("getChecked");
					if(checkedArray.length==0){
						$.jGrowl("请选择资质！");
						return;
					}
					if($("#id").val()==""){
						saveTenderApply(false);
					}
					$.ajax({
						url : ctx + "/tenderApply/addAptitude?t=" + new Date().getTime(),
						type : "post",
						data : "fjsszt=" + $("#id").val()  +"&" +$(checkedArray).map(function() {
							return "aptitudeId="+this.id;
						}).get().join("&"),
						cache:false,
						dataType : "json",
						success : function(data) {
							$("#" + id).dialog("close");
							if (data.success) {
								$("#userList").datagrid("reload");
							}
							$.jGrowl(data.msg);
						},
						error : function(e, s1, s2) {
							$.jGrowl("操作失败！");
						}
					});
				}
			}, {
				text : "取消",
				color : "red",
				handler : function() {
					$("#" + id).dialog("close");
				}
			} ]
		});
	});

	/*var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : 'addAttachment',
		//container : document.getElementById('container'),
		url : ctx + '/attachment/uploadAttachment',
		flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
		silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
		multi_selection : false,
		multipart_params : {
			fjsszt : $("#id").val()==""?"-1":$("#id").val(),
			fjgslx:"39"
		},
		//file_data_name:"Filedata",
		//drop_element : 'drop_area',
		filters : {
			mime_types : [ //只允许上传图片和zip文件
				{ title : "Image files", extensions : "jpg,gif,png,bmp" }, 
				{ title : "Pdf files", extensions : "pdf" },
				{ title : "Word files", extensions : "doc,docx" }
			],
			prevent_duplicates : true,//不允许选取重复文件
			max_file_size : '5000mb'//最大只能上传400kb的文件
		},
		init : {
			PostInit : function() {
			},
			FilesAdded : function(up, files) {
				if ($("input[name='item_ids']:enabled:checked").length == 0) {
					$.messager.alert("系统提示", "请先选择要投标的标段！", "warning");
					return;
				}
//				$("#main").layout("expand", "east");
//				plupload.each(files, function(file) {
//					$('#filelist').append("<div id='" + file.id + "' class='easyui-progressbar' data-options=\"value:0,text:'" + file.name + "'\" style='width:100%;'></div>");
//					$("#" + file.id).progressbar({});
//				});
				if($("#id").val()==""){
					saveTenderApply(false);
					$("#attachmentUpload").datagrid("options").queryParams["fjsszt"]=$("#id").val();
				}
				for(var i=0;i<files.length;i++){
					var file=files[i];
					$("#attachmentUpload").datagrid("appendRow",{
						 id:file.id,
						 fjid00:file.id,
						 fjmc00:file.name,
						 status:"<div class='" + file.id + "' style='width:100%;'></div>",
						 uploadTime:new Date().format("yyyy-MM-dd HH:mm:ss"),
						 length:file.size,
						 fjgslx:""
					});
					$("div." + file.id).progressbar({});
				}
				up.start();
			},
			UploadProgress : function(up, file) {
				$("div." + file.id).progressbar("setValue", file.percent);
			},
			FileUploaded : function(up, file, result) {
				var data=$.parseJSON(result.response);
				data.data.id=file.id;
				data.data.status=percent;
				$($("#attachmentUpload").datagrid("getRows")).each(function(index){
					if(this.id==data.data.id){
						$("#attachmentUpload").datagrid("updateRow",{index:index,row:data.data});
					}
				});
				$("#tenderApplicationForm").append($("<input/>").attr("type","hidden").addClass(file.id).val(data.data.fjid00));
				up.removeFile(file);
				//$("div."+file.id).find(".progressbar-text").html("完成");
				//$("div."+file.id).find(".progressbar-value,.progressbar-text").css({backgroundColor:'#0095cd'});
			},
			UploadComplete : function(uploader, files) {
			},
			Error : function(up, err) {
			},
			FilesRemoved:function(up,files){
				
			}
		}
	});
	uploader.init();*/
	
	/**
	 * 报名附件上传需求新增20180504zm
	 * 初始化时刷新新附件数据表格数据
	 */
	$.ajax({
		url:ctx+"/attachment/listAttachment",
		type:"post",
		data:{"fjsszt":$("#id").val()==""?"-1":$("#id").val()},
		dataType:"json",
        beforeSend : function() {
            saveInit();
        },
		success:function(result){
			for(var i=0;i<attachmentRequirements.length;i++){
				for(var j=0;j<result.length;j++){
					if(result[j]["fjdzqm"]==attachmentRequirements[i]["content"]){
						$("#attachmentUpload1").datagrid("updateRow",{
							index:i,
							row:{
								id:result[j]["fjid00"],
								fjmc:result[j]["fjdzqm"],
								fjid00:result[j]["fjid00"],
								status:percent,
								uploadTime:result[j]["uploadTime"],
								length:result[j]["length"],
								fjlx00:result[j]["fjlx00"],
								opt: result[j]["path"]?"<a id=\""+result[j]["fjid00"]+"\" data-id=\""+attachmentRequirements[i]["id"]+"\" class=\"del button small red\">删除</a>&nbsp;<a target=\"_blank\" class=\"button small orange\" href=\""+ctx+"/attachment/download/"+result[j]["path"]+"\">预览</a>":"",
								flag:"true"
							}
						});
					}
				}
			}
			
		}
	});

	function saveInit() {
        var data = $("#tenderApplicationForm").serialize() + "&" +
            $("input[name='item_ids']:enabled:checked").map(function(i) {
                return "tenderItemList[" + i + "].projectItemId=" + this.value;
            }).get().join("&");

        data = data + "&isComplete=false";
        $.ajax({
            url:ctx + "/tenderApply/tenderApply",
            type:"post",
            data:data,
            async:false,
            dataType:"json",
            success:function(result){
                if (result.success) {
                    $(":input[name='id']").val(result.data);
                    fjztid = result.data;
                    console.log(fjztid);
                }
            }
        });
    }
	/**
	 * 获取报名资料必需附件名，初始化上传按钮
	 */
	$.each(attachmentRequirements,function(index,data){
		initUpload(data.id,data.content,index);
	})
	
	/**
	 * 实例化一个plupload上传对象
	 * @param self 按钮ID
	 * @param content 标识内容
	 * @param index  按钮所在表格行
	 * @returns
	 */
	function initUpload(self,content,index){
	    uploader_ = new plupload.Uploader({
	        browse_button : self, //触发文件选择对话框的按钮，为那个元素id
			url : ctx + '/attachment/uploadAttachment',
			flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
			silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
			multi_selection : false,//选择多个文件
			multipart_params : {
				fjsszt : $("#id").val()==""?fjztid:$("#id").val(),
				fjgslx:"39",
                fjmc00:content,
				fjdzqm:content
			},
	        filters : {
				mime_types : [ //允许上传文件类型
					{ title : "Image files", extensions : "jpg,gif,png,bmp" }, 
					{ title : "Pdf files", extensions : "pdf" },
					{ title : "Word files", extensions : "doc,docx" }
				],
				prevent_duplicates : true,//不允许选取重复文件
				max_file_size : '5000mb'//最大上传文件大小
			}
	    });
	  //在实例对象上调用init()方法进行初始化
	    uploader_.init();
	  //绑定各种事件，并在事件监听函数中做你想做的事
	    uploader_.bind('FilesAdded',function(uploader,files){
	    	if ($("input[name='item_ids']:enabled:checked").length == 0) {
				$.messager.alert("系统提示", "请先选择要投标的标段！", "warning");
				for(var i=0;i<files.length;i++){
					uploader.removeFile(files[i]);					
				}
				return;
			}
	    	if($("#id").val()==""){
                // saveTenderApply(false,function (result) {
                //     var multipart_params=uploader.getOption("multipart_params");
                //     multipart_params["fjsszt"]=result;
					// console.log(multipart_params);
                // });
                $.messager.alert("系统提示", "请先保存草稿！", "warning");
                return;
			}
			for(var i=0;i<files.length;i++){
				var file=files[i];
				$("#attachmentUpload1").datagrid("updateRow",{
					index:index,
					row:{
						id:file.id,
						fjid00:file.id,
						status:"<div class='" + file.id + "' style='width:100%;'></div>",
						uploadTime:new Date().format("yyyy-MM-dd HH:mm:ss"),
						length:file.size,
						fjgslx:"",
						flag:"true"
					}
				});
				$("div." + file.id).progressbar({});
			}
	    	uploader.start();
	    });
	    uploader_.bind('FileUploaded',function(uploader,file,result){
	    	var data=$.parseJSON(result.response);
			data.data.id=file.id;
			data.data.status=percent;
			$($("#attachmentUpload1").datagrid("getRows")).each(function(index){
				if(this.id==data.data.id){
					$("#attachmentUpload1").datagrid("updateRow",{
							index:index,
							row:{
								id:data["data"]["id"],
								fjid00:data["data"]["fjid00"],
								status:data["data"]["status"],
								uploadTime:data["data"]["uploadTime"],
								length:data["data"]["length"],
								fjlx00:data["data"]["fjlx00"],
								opt: data["data"]["path"]?"<a id=\""+data["data"]["fjid00"]+"\" data-id=\""+self+"\" class=\"del button small red\">删除</a>&nbsp;<a target=\"_blank\" class=\"button small orange\" href=\""+ctx+"/attachment/download/"+data["data"]["path"]+"\">预览</a>":""
							}
						});
					}
			});
			$("#tenderApplicationForm").append($("<input/>").attr("type","hidden").addClass(file.id).val(data.data.fjid00));
			uploader.removeFile(file);
	    });
	}
	
	//
	//印章验证
	/*if($("#id").val()!=""){
		sealUtil.loadAllSealWithBusinessKey($("#id").val());
	}*/
});