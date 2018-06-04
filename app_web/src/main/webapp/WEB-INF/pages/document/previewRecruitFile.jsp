<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
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

    <SCRIPT LANGUAGE=javascript >
        function WebOffice1_NotifyCtrlReady(){
            //文档加载
            document.all.WebOffice1.OptionFlag |= 0x0080;

           // document.all.WebOffice1.ReadOnly; 无效，无文档可查
            document.all.WebOffice1.LoadOriginalFile("${docUrl}","doc");
            document.all.WebOffice1.HideMenuItem(0x01 + 0x02);
           // document.all.WebOffice1.HideMenuAction(1,1048576);
            // document.all.WebOffice1.HideMenuAction(5,0);
            // document.all.WebOffice1.HideMenuArea("","","","");
           // document.all.WebOffice1.SetCurrUserName("${CURRENT_USER_SESSION_INFO.id}"+":"+"${CURRENT_USER_SESSION_INFO.userName}");
           // document.all.WebOffice1.SetTrackRevisions(1);

        }
    </SCRIPT>

</head>
<BODY style="BACKGROUND: #ccc" >
<div style="align-content: center">
    <!--  webofice 加载 开始-->
    <SCRIPT src="/resources/weboffice/LoadWebOffice.js"></SCRIPT>
    <!--  webofice 加载 结束-->
</div>
</BODY>
</HTML>
