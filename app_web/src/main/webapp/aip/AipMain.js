/**
 *
 * 远程打开pdf或者aip文档
 * **/
function OpenFile(url) {
    var AipObj = document.getElementById("HWPostil1");
    var IsOpen = AipObj.LoadFile(url);
    if (IsOpen != 1) {
        ShowMessage("打开文档失败！");
    }
}
function OpenFileEx(url,filetype) {
    var AipObj = document.getElementById("HWPostil1");
    var IsOpen = AipObj.LoadFileEx(url,filetype,0,0);
    if (IsOpen != 1) {
        ShowMessage("打开文档失败！");
    }
}
/**
 *
 * 手动盖章
 * **/
function AddSeal(doaction) {
    var AipObj = document.getElementById("HWPostil1");
    var islogin = AipObj.Login("",1,65535,"","");
    if (islogin != 0) {
        return "-200";
    } else {
        if(doaction==0){
            AipObj.CurrAction = 2568;//盖章
        }else if(doaction==1){
            AipObj.CurrAction = 264;//手写
        }
    }
}
/**
 *
 doaction					操作类型：0 普通印章，1 右骑缝章，2对开骑缝
 searchtype					定位盖章位置类型：只对普通印章doaction=0时有效，0 绝对坐标，1 文字定位
 searchstring				定位信息：只对普通印章doaction=0时有效
 searchtype为0时，searchstring为x:y:page格式，即200:500:0   x为横向坐标1-50000，y为纵向坐标1-50000，page为盖章页码从0开始
 searchtype为1时，searchstring为要查找的文字字符串
 * **/
function AutoSeal(doaction,searchtype,searchstring) {
    var AipObj = document.getElementById("HWPostil1");
    var islogin=AipObj.Login("",1,65535,"","");
    if (islogin != 0) {
        return "-200";
    } else {
        if(doaction==0){
            var num=AipObj.PageCount;
            var str=searchstring.split(":");
            var page="";
            if(searchtype==0){
                var isseal=AipObj.AddQifengSeal(0,0+","+str[0]+",0,"+str[1]+",50,"+str[2],"","AUTO_ADD_SEAL_FROM_PATH");
                if(isseal!=1){
                    return "-100";
                }else{
                    return "1";
                }
            }else if(searchtype==1){
                var isseal=AipObj.AddQifengSeal(0,"AUTO_ADD:0,"+num+",50000,0,1,"+searchstring+")|(0,","","AUTO_ADD_SEAL_FROM_PATH");
                if(isseal!=1){
                    return "-100";
                }else{
                    return "1";
                }
            }
        }else if(doaction==1){
            var num=AipObj.PageCount;
            var page="";
            for(i=1;i<num;i++){
                page+=i+",";
            }
            if(num>1){
                var bl=100/(num);
                var isseal=AipObj.AddQifengSeal(0,0+",25000,1,3,"+bl+","+page,"","AUTO_ADD_SEAL_FROM_PATH");
                if(isseal!=1){
                    return "-100";
                }else{
                    return "1";
                }
            }else{
                return "-100";
            }
        }else if(doaction==2){
            var num=AipObj.PageCount;
            for(i=0;i<num-1;i++){
                var isseal=AipObj.AddQifengSeal(0,i+",25000,2,3,50,1","","AUTO_ADD_SEAL_FROM_PATH");
                if(isseal!=1){
                    return "-100";
                }else{
                    return "1";
                }
            }
        }
    }
}
function SaveToS(savetype,filepath,filecode) {
    var AipObj = document.getElementById("HWPostil1");
    if(savetype==0){
        var issave = AipObj.SaveTo(filepath, filecode, 0);
        if (issave == 0) {
            ShowMessage("保存失败！");
        }
    }else if(savetype==1){
        AipObj.HttpInit(); //初始化HTTP引擎。
        AipObj.HttpAddPostString("FileCode", filecode); //设置上传变量FileCode文档惟一标示。
        AipObj.HttpAddPostCurrFile("FileBlod"); //设置上传当前文件,文件标识为FileBlod。
        var ispost = AipObj.HttpPost(filepath); //上传数据。
        if (ispost != 0) {
            ShowMessage("文档上传失败！错误代码：" + ispost);
        }
    }else{
        ShowMessage("SaveTo方法参数错误！")
    }
}
/**
 *
 * matchCase 0区分大小写，1不区分
 * findNext 0从头查找，1查找下一个
 *
 * **/
function SearchText(text,matchCase,findNext){
    var AipObj = document.getElementById("HWPostil1");
    AipObj.SearchText(text,matchCase,findNext);
}

function ShowMessage(msg) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.ShowMessage(msg,"系统提示",0);
}
function ShowMessageOkCancel(msg) {
    var AipObj = document.getElementById("HWPostil1");
    return AipObj.ShowMessage(msg,"系统提示",1);//ok 1,cancel 2
}

function GetCurrUserID() {
    var AipObj = document.getElementById("HWPostil1");
    return AipObj.GetCurrUserID();
}

function SaveDoc(mapPostString,url) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.HttpInit();   // 初始化Http引擎
    // 添加相应的Post元素
    mapPostString.forEach(function (item, key, mapObj) {
        AipObj.HttpAddPostString(key, item.toString());
    });
    // 添加上传文件
    AipObj.HttpAddPostCurrFile("file");
    // 提交上传文件
    return AipObj.HttpPost(url);
}

function SaveDocArray(paramsArray,url) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.HttpInit();   // 初始化Http引擎
    // 添加相应的Post元素
    for (var key in paramsArray) {
        AipObj.HttpAddPostString(key, paramsArray[key]);
        console.log("key " + key + " has value " + paramsArray[key]);
    }
    // 添加上传文件
    AipObj.HttpAddPostCurrFile("file");
    // 提交上传文件
    return AipObj.HttpPost(url);
}
function SaveDocArrayAsPdf(fileName,paramsArray,url) {
    var AipObj = document.getElementById("HWPostil1");
    var temp = AipObj.GetTempFileName("pdf");//获取缓冲文件地址
    AipObj.SaveTo(temp, "pdf", 0);//保存pdf到缓冲目录

    AipObj.HttpInit();   // 初始化Http引擎
    // 添加相应的Post元素
    for (var key in paramsArray) {
        AipObj.HttpAddPostString(key, paramsArray[key]);
        //console.log("key " + key + " has value " + paramsArray[key]);
    }
    AipObj.HttpAddPostString("filename", fileName);
    AipObj.HttpAddPostFile("file", temp);//设置上传当前文件,文件标识为FileBlodPDF。缓冲的pdf文件

    // 提交上传文件
    return AipObj.HttpPost(url);
}
/**获取文档印章数量*/
function getSealCount() {
    var AipObj = document.getElementById("HWPostil1");
    var count = AipObj.GetNoteNum(251);
    return count;
}

/*function GetNextUserID(userID) {
    var AipObj = document.getElementById("HWPostil1");
    return AipObj.GetNextUserID(userID,0);
}*/

function ShowFullScreen(slog) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.ShowFullScreen = slog;
}
function FilePrint(plog) {
    var AipObj = document.getElementById("HWPostil1");
    var isprint = AipObj.PrintDoc(1, plog);
    if (isprint == 0) {
        ShowMessage("打印失败！");
    }
}
function FileMerge(filepath,page) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.Login("HWSEALDEMO**",4,65535,"DEMO","");
    if(filepath==""){
        var isMerge = AipObj.InsertEmptyPage(page,0,0,0);
    }else{
        var isMerge = AipObj.MergeFile(page,filepath);
    }
    if (isMerge == 0) {
        ShowMessage("合并文档失败！");
    }
}
function SetAction(SetLog) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.CurrAction=SetLog;
}
function SetPageMode(SetLog) {
    var AipObj = document.getElementById("HWPostil1");
    if(SetLog==1){
        AipObj.SetPageMode(1,100);
    }else if(SetLog==2){
        AipObj.SetPageMode(2,100);
    }else if(SetLog==3){
        AipObj.SetPageMode(4,100);
    }else if(SetLog==4){
        AipObj.SetPageMode(8,2);
    }else if(SetLog==5){
        AipObj.SetPageMode(16,1);
    }
}
function ShowToolBar(SetLog) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.ShowToolBar=SetLog;
}
function ShowDefMenu(SetLog) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.ShowDefMenu=SetLog;
}
function ShowScrollBarButton(SetLog) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.ShowScrollBarButton=SetLog;
}
function SetFullScreen(SetLog) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.ShowFullScreen =SetLog;
}
function SearchText(stxt,matchcase,findnext) {
    var AipObj = document.getElementById("HWPostil1");
    AipObj.SearchText(stxt,matchcase,findnext);
}
function SealUnclear(setlog) {
    var AipObj = document.getElementById("HWPostil1");
    if(setlog==0){
        AipObj.ForceSignType|=0x400;
    }else if(setlog==1){
        AipObj.ForceSignType^=0x400;
    }
}

