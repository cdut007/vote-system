<%@page pageEncoding="utf-8" %>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<div class="bannerB ctr">
    <div class="bannerLogo">
        <div class="left">
            <img class="left" src="${util:property('backEnd')}/attachment/download/${organ.logo.path}" width="70" height="70" onerror="this.src='/resources/portal/yc-images/logo_no.jpg'"/>
            <span class="t1">
                <p>${organ}</p>
                <p>${organ.portal}</p>
            </span>
        </div>
        <div class="sbg left"></div>
    </div>
</div>