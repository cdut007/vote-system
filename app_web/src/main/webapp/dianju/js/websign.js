/*****************����******************************
˵����
    WebSign_AddSeal ���ӡ�½ӿ�
    1.���ø�����
    2.���������ǵ�λ�� (������������ڱ����ƫ��λ��,��Ч��ֹӡ���ڲ�ͬ�ֱ����´�λ)
***********************************************/	
function AddSeal(sealName){
		try{
			
			var strObjectName ;
			//��ȡ��һ��ӡ��
			strObjectName = document.all.DWebSignSeal.FindSeal("",0);
			while(strObjectName  != ""){
					//ͨ��ѭ�����б�������ӡ�£����뵱ǰ�ı����Ѿ��Ӹ�ӡ�µĻ�������ʾ
					if(sealName == strObjectName){
					alert("��ǰҳ���Ѿ��Ӹǹ�ӡ�£���"+sealName+"�����ʵ");
					return false;
				}
				alert(strObjectName);
				//��ѯstrObjectName����һ��ӡ��
				strObjectName = document.all.DWebSignSeal.FindSeal(strObjectName,0);
			}

			
			//���õ�ǰӡ�°󶨵ı���
			Enc_onclick(sealName);

			//���ø����ˣ�������OA���û���
			document.all.DWebSignSeal.SetCurrUser("������");
			//����������·��
			//var addresss= "http://192.168.0.84:8089/inc/seal_interface/";
				//document.all.DWebSignSeal.HttpAddress = "http://192.168.0.197:8089/inc/seal_interface/";
				//document.all.DWebSignSeal.HttpAddress = "http://www.dianju.cn:9236/Seal/general/interface/";
			//������Ψһҳ��ID ��SessionID
				document.all.DWebSignSeal.RemoteID = "0100018";
			//�����Ϳ��ԺܺõĹ̶�ӡ�µ�λ��
			document.all.DWebSignSeal.SetPosition(100,10,sealName+ "sealpostion");
			//���ø��µĽӿ�
			var sealid=document.all.DWebSignSeal.AddSeal("",sealName);
		}catch(e) {
			alert("WebSign_AddSeal-error" +e);
		}
	}	
/*******************ȫ��Ļ��д****************************
˵����
    WebSign_HandWrite���ӡ�½ӿ�
    1.����ǩ����
***********************************************/	
function HandWrite(sealName){
	try{ 
		//���õ�ǰӡ�°󶨵ı���
		Enc_onclick(sealName);
		//����ǩ���ˣ�������OA���û���
		document.all.DWebSignSeal.SetCurrUser("ȫ����д��");
		//����ǩ���Ľӿ�
		document.all.DWebSignSeal.SetPosition(100,10,sealName+ "sealpostion");
		//������д�Ľӿ�
		if("" == document.all.DWebSignSeal.HandWrite(0,255,sealName)){
			 alert("ȫ��Ļǩ��ʧ��");
			 return false;
		} 
	}catch(e) {
		alert("WebSign_HandWrite-error" +e);
	}
}

/*******************����������д****************************
˵����
    HandWritePop_onclick ����������д
    1.����ǩ���� (���Բ�����)
    2.����ǩ�����ǵ�λ�� (������������ڱ����ƫ��λ��,��Ч��ֹǩ���ڲ�ͬ�ֱ����´�λ)
***********************************************/	
function HandWritePop_onclick(sealName){
	try{ 
			//���õ�ǰӡ�°󶨵ı���
			Enc_onclick(sealName);
			//����ǩ���ˣ�������OA���û���
			document.all.DWebSignSeal.SetCurrUser("������д��");
			//���õ�ǰӡ�µ�λ��,�����sealPostion1 (<div id="handWritePostion1"> </div>) ��λ������ƫ��0px,����ƫ��0px
			//�����Ϳ��ԺܺõĹ̶�ӡ�µ�λ��
			document.all.DWebSignSeal.SetPosition(0,0,sealName);
			//����ǩ���Ľӿ�
			if("" == document.all.DWebSignSeal.HandWritePop(0,255,50, 400,300,sealName)){
				 alert("ȫ��Ļǩ��ʧ��");
				 return false;
			}
		}catch(e) {
		  alert("HandWritePop_onclick-error" +e);
		}
}	
		
/*****************���ύ******************************
˵����
    submit �ύ��
    ����WebSign��GetStoreData()�ӿڻ�ȡӡ�µ���������(ӡ������+֤������+ǩ������...)
    �����ֵ��ֵ��Hiddle����,���浽���ݿ���.
***********************************************/		
 
function submit_onclick(){
try{
	var v = document.all.DWebSignSeal.GetStoreData();
	if(v.length < 200){
		alert("�����ȸ��²ſ����ύ");
		return false;
	}
	document.all.form1.sealdata.value = v;
	}catch(e) {
		alert("submit_onclick-error" +e);
		return false;
	}
}
 
 
/***********************************************
˵����
    Enc_onclick ��Ҫ���ð󶨵ı���
    WebSign��SetSignData�ӿ�֧�����ְ����ݷ�ʽ��
    1.�ַ�������
    2.����
    һ�����ݷ����ı䣬WebSign���Զ�У�飬����ʾ�޸ġ�
***********************************************/	

function Enc_onclick(tex_name) {		
	try{
		//���ԭ������	
		document.all.DWebSignSeal.SetSignData("-");		
		// strΪ���󶨵��ַ�������
		//var str = "";
		 //���ð󶨵ı���
		 //���ĵ�λ
		 document.all.DWebSignSeal.SetSignData("+LIST:laiwendanwei;");
		 //��������
		 document.all.DWebSignSeal.SetSignData("+LIST:laiwenDate;");
		 //����
		 document.all.DWebSignSeal.SetSignData("+LIST:shiyou;");
		 //ʱ��Ҫ��
		 document.all.DWebSignSeal.SetSignData("+LIST:time;");
		  //���
		 document.all.DWebSignSeal.SetSignData("+LIST:"+tex_name+";");
		 
		/*���ݱ��������Լ���֯������,��ǰ���ӽ�����������
		������ַ�������,��Ҫ�����µ���
			document.all.DWebSignSeal.SetSignData("+DATA:"+str);		
		*/
	}catch(e) {
		alert("Enc_onclick-error" +e);
	}
	}
	
/***********************************************
˵����
    SetUI �����û�������
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
˵����
    hiddenseal ��ʾ\����ӡ��
***********************************************/	

function hiddenseal(value){
	try{ 
		var strObjectName ;
		strObjectName = document.all.DWebSignSeal.FindSeal("",0);
		while(strObjectName  != ""){
			document.all.DWebSignSeal.ShowSeal(strObjectName,value); //0Ϊ����ӡ�£�1Ϊ��ʾӡ��
			strObjectName = document.all.DWebSignSeal.FindSeal(strObjectName,0);
		} 
	}catch(e) {
		alert("hiddenseal - error" +e);
	}
}

 /***********************************************
˵����
    checkData ���ӡ�°󶨵������Ƿ�
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
˵����
    GetValue_onclick ��ȡ��ǰҳ���ȫ��ӡ������
***********************************************/	

function GetValue_onclick(){
	var v = document.all.DWebSignSeal.GetStoreData();
	if(v.length ==""){
	alert("�����ȸ��²ſ����ύ");
	return false;
	}
	document.all.SealData.value = v;
}

 /***********************************************
˵����
    SetValue_onclick ����ӡ�����ݵ���ǰҳ���ٴ���ʾ
***********************************************/	

function SetValue_onclick(){
	document.all.DWebSignSeal.SetStoreData(document.all.SealData.value); 
	document.all.DWebSignSeal.ShowWebSeals();
}