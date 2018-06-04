/*****************盖章******************************
说明：
    WebSign_AddSeal 添加印章接口
    1.设置盖章人
    2.设置章所盖的位置 (可以设置相对于表单域的偏移位置,有效防止印章在不同分辨率下错位)
***********************************************/	
function AddSeal(sealName){
		try{
			
			var strObjectName ;
			//获取第一个印章
			strObjectName = document.all.DWebSignSeal.FindSeal("",0);
			while(strObjectName  != ""){
					//通过循环进行便利所有印章，加入当前文本域已经加盖印章的话进行提示
					if(sealName == strObjectName){
					alert("当前页面已经加盖过印章：【"+sealName+"】请核实");
					return false;
				}
				alert(strObjectName);
				//查询strObjectName的下一个印章
				strObjectName = document.all.DWebSignSeal.FindSeal(strObjectName,0);
			}

			
			//设置当前印章绑定的表单域
			Enc_onclick(sealName);

			//设置盖章人，可以是OA的用户名
			document.all.DWebSignSeal.SetCurrUser("盖章人");
			//网络版服务器路径
			//var addresss= "http://192.168.0.84:8089/inc/seal_interface/";
				//document.all.DWebSignSeal.HttpAddress = "http://192.168.0.197:8089/inc/seal_interface/";
				//document.all.DWebSignSeal.HttpAddress = "http://www.dianju.cn:9236/Seal/general/interface/";
			//网络版的唯一页面ID ，SessionID
				document.all.DWebSignSeal.RemoteID = "0100018";
			//这样就可以很好的固定印章的位置
			document.all.DWebSignSeal.SetPosition(100,10,sealName+ "sealpostion");
			//调用盖章的接口
			var sealid=document.all.DWebSignSeal.AddSeal("",sealName);
		}catch(e) {
			alert("WebSign_AddSeal-error" +e);
		}
	}	
/*******************全屏幕手写****************************
说明：
    WebSign_HandWrite添加印章接口
    1.设置签名人
***********************************************/	
function HandWrite(sealName){
	try{ 
		//设置当前印章绑定的表单域
		Enc_onclick(sealName);
		//设置签名人，可以是OA的用户名
		document.all.DWebSignSeal.SetCurrUser("全屏手写人");
		//调用签名的接口
		document.all.DWebSignSeal.SetPosition(100,10,sealName+ "sealpostion");
		//调用手写的接口
		if("" == document.all.DWebSignSeal.HandWrite(0,255,sealName)){
			 alert("全屏幕签名失败");
			 return false;
		} 
	}catch(e) {
		alert("WebSign_HandWrite-error" +e);
	}
}

/*******************弹出窗口手写****************************
说明：
    HandWritePop_onclick 弹出窗口手写
    1.设置签名人 (可以不调用)
    2.设置签名所盖的位置 (可以设置相对于表单域的偏移位置,有效防止签名在不同分辨率下错位)
***********************************************/	
function HandWritePop_onclick(sealName){
	try{ 
			//设置当前印章绑定的表单域
			Enc_onclick(sealName);
			//设置签名人，可以是OA的用户名
			document.all.DWebSignSeal.SetCurrUser("弹出手写人");
			//设置当前印章的位置,相对于sealPostion1 (<div id="handWritePostion1"> </div>) 的位置相左偏移0px,向上偏移0px
			//这样就可以很好的固定印章的位置
			document.all.DWebSignSeal.SetPosition(0,0,sealName);
			//调用签名的接口
			if("" == document.all.DWebSignSeal.HandWritePop(0,255,50, 400,300,sealName)){
				 alert("全屏幕签名失败");
				 return false;
			}
		}catch(e) {
		  alert("HandWritePop_onclick-error" +e);
		}
}	
		
/*****************表单提交******************************
说明：
    submit 提交表单
    调用WebSign的GetStoreData()接口获取印章的所有数据(印章数据+证书数据+签名数据...)
    把这个值赋值于Hiddle变量,保存到数据库中.
***********************************************/		
 
function submit_onclick(){
try{
	var v = document.all.DWebSignSeal.GetStoreData();
	if(v.length < 200){
		alert("必须先盖章才可以提交");
		return false;
	}
	document.all.form1.sealdata.value = v;
	}catch(e) {
		alert("submit_onclick-error" +e);
		return false;
	}
}
 
 
/***********************************************
说明：
    Enc_onclick 主要设置绑定的表单域。
    WebSign的SetSignData接口支持两种绑定数据方式：
    1.字符串数据
    2.表单域
    一旦数据发生改变，WebSign会自动校验，并提示修改。
***********************************************/	

function Enc_onclick(tex_name) {		
	try{
		//清空原绑定内容	
		document.all.DWebSignSeal.SetSignData("-");		
		// str为待绑定的字符串数据
		//var str = "";
		 //设置绑定的表单域
		 //来文单位
		 document.all.DWebSignSeal.SetSignData("+LIST:laiwendanwei;");
		 //来文日期
		 document.all.DWebSignSeal.SetSignData("+LIST:laiwenDate;");
		 //事由
		 document.all.DWebSignSeal.SetSignData("+LIST:shiyou;");
		 //时间要求
		 document.all.DWebSignSeal.SetSignData("+LIST:time;");
		  //意见
		 document.all.DWebSignSeal.SetSignData("+LIST:"+tex_name+";");
		 
		/*根据表单域内容自己组织绑定内容,当前例子仅仅做与表单域绑定
		如果绑定字符串数据,需要做如下调用
			document.all.DWebSignSeal.SetSignData("+DATA:"+str);		
		*/
	}catch(e) {
		alert("Enc_onclick-error" +e);
	}
	}
	
/***********************************************
说明：
    SetUI 设置用户界面风格
***********************************************/	
function SetUI() {
	try{
		 document.all.DWebSignSeal.TipBKLeftColor = 29087;
		 document.all.DWebSignSeal.TipBKRightColor = 65443;
		 document.all.DWebSignSeal.TipLineColor = 65535;
		 document.all.DWebSignSeal.TipTitleColor = 32323;
		 document.all.DWebSignSeal.TipTextColor = 323;
	}catch(e) {
		alert("SetUI-error" +e);
	}
 }
 
 /***********************************************
说明：
    hiddenseal 显示\隐藏印章
***********************************************/	

function hiddenseal(value){
	try{ 
		var strObjectName ;
		strObjectName = document.all.DWebSignSeal.FindSeal("",0);
		while(strObjectName  != ""){
			document.all.DWebSignSeal.ShowSeal(strObjectName,value); //0为隐藏印章，1为显示印章
			strObjectName = document.all.DWebSignSeal.FindSeal(strObjectName,0);
		} 
	}catch(e) {
		alert("hiddenseal - error" +e);
	}
}

 /***********************************************
说明：
    checkData 检测印章绑定的数据是否
***********************************************/	

function checkData() {
	try{ 
		var strObjectName ;
		strObjectName = document.all.DWebSignSeal.FindSeal("",0);
		while(strObjectName  != ""){
			document.all.DWebSignSeal.VerifyDoc(strObjectName);
			strObjectName = document.all.DWebSignSeal.FindSeal(strObjectName,0);
		} 
	}catch(e) {
		alert("checkData - error" +e);
	}
}
 /***********************************************
说明：
    GetValue_onclick 获取当前页面的全部印章数据
***********************************************/	

function GetValue_onclick(){
	var v = document.all.DWebSignSeal.GetStoreData();
	if(v.length ==""){
	alert("必须先盖章才可以提交");
	return false;
	}
	document.all.SealData.value = v;
}

 /***********************************************
说明：
    SetValue_onclick 设置印章数据到当前页面再次显示
***********************************************/	

function SetValue_onclick(){
	document.all.DWebSignSeal.SetStoreData(document.all.SealData.value); 
	document.all.DWebSignSeal.ShowWebSeals();
}