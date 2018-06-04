<%@page pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="stylesheet" href="/resources/weboffice/style.css" type="text/css">


    <SCRIPT LANGUAGE=javascript FOR=WebOffice1 EVENT=NotifyCtrlReady>
        <!--
        WebOffice1_NotifyCtrlReady()
        //-->
    </SCRIPT>
    <SCRIPT LANGUAGE=javascript FOR=WebOffice1 EVENT=NotifyToolBarClick(lCmd)>
        <!--
        WebOffice1_NotifyToolBarClick(lCmd)
        //-->
    </SCRIPT>

    <SCRIPT LANGUAGE=javascript >
        //function DES1_NotifyCtrlReady() {
        //   document.all.DES1.EnableOfficeCtrl(1);
        //}
        function WebOffice1_NotifyCtrlReady(){

            //文档加载
            document.all.WebOffice1.OptionFlag |= 0x0020;
            document.all.WebOffice1.OptionFlag |= 0x0080;
            document.all.WebOffice1.LoadOriginalFile("${docUrl}","doc");
            document.all.WebOffice1.HideMenuItem(0x01 + 0x02);
            document.all.WebOffice1.SetCustomToolBtn(0,"远程保存");
            document.all.WebOffice1.SetCurrUserName("${CURRENT_USER_SESSION_INFO.id}"+":"+"${CURRENT_USER_SESSION_INFO.userName}");
            document.all.WebOffice1.SetTrackRevisions(1);

        }
        function WebOffice1_NotifyToolBarClick(lCmd) {
            if(32776==lCmd) {
                // document.all.WebOffice1.lEventRet = 0;
                //保存文档之前，如果需要接受修订，需要调用
                document.all.WebOffice1.SetTrackRevisions(4);
                //通过Http接口上传
                document.all.WebOffice1.HttpInit();
                document.all.WebOffice1.HttpAddPostString("id", "${template.id}");
                document.all.WebOffice1.HttpAddPostCurrFile("file", "");
                returnValue = document.all.WebOffice1.HttpPost("${docSaveUrl}");
                console.log(returnValue);
                if('{"data":null,"msg":"upload success","success":true}' == returnValue){
                    alert("文件上传保存成功");
                } else  {
                    alert("文件上传保存失败")
                }

            }
        }
    </SCRIPT>

</head>
<BODY style="BACKGROUND: #ccc" >
<div style="align-content: center">
    <!--des 加载 开始
    <SCRIPT src="/resources/weboffice/LoadDESSeal.js"></SCRIPT> -->
    <!--des 加载 结束 -->
    <!--  webofice 加载 开始-->
    <SCRIPT src="/resources/weboffice/LoadWebOffice.js"></SCRIPT>
    <!--  webofice 加载 结束-->
</div>
</BODY>
</HTML>
