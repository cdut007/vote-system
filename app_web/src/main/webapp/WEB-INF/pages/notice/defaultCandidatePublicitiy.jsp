<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<h2 style="text-align:center">
    ${candidatePublicity.publicityTitle}
</h2>
<h4 style="text-align:center">
    (招标编号：${projectInstance.organProjectCode})
    <br>
</h4>
<p><br /></p>

<p>
   公示开始时间：<fmt:formatDate value="${candidatePublicity.gskssj}" pattern="yyyy年MM月dd日"/>
</p>
<p>
   公示结束时间：<fmt:formatDate value="${candidatePublicity.gsjssj}" pattern="yyyy年MM月dd日"/>
</p>

<p>
    本${projectInstance}（招标项目编号：${projectInstance.organProjectCode}），经评标委员会评审，确定${itemList}的中标候选人，现公示如下：

    <%--${organA}受${organT}的委托，对${projectInstance}（${projectItemList}）组织了${util:dictionary('ZBFS00',projectInstance.zbfs00)}，现已完成了评标工作，评标结果公示如下：--%>
</p>

<h4>一、评标情况</h4>
${itemList}:
<p style="text-indent:0em;">
    <span>1、中标候选人基本情况</span>
</p>
    <c:forEach items="${list}" var="item">
        <c:forEach items="${item.mapList}" var="map" varStatus="status">
            <p>
                第${status.count==1?"一":status.count==2?"二":"三"}中标候选人：${map.organBName}；投标报价：${map.tbbjje}；质量：${map.quality}；工期/交货期：${map.gq}
            </p>
        </c:forEach>
    </c:forEach>

<p style="text-indent:0em;">
    <span>2、中标候选人按照招标文件要求承诺的项目负责人情况</span>
</p>
    <c:forEach items="${list}" var="item">
        <c:forEach items="${item.mapList}" var="map" varStatus="status">
            <p>
                第${status.count==1?"一":status.count==2?"二":"三"}中标候选人：${map.organBName}；项目负责人：${map.xmfzr0}；相关证书名称及编号：${map.bidPrincipalCertificateAndNo}
            </p>
        </c:forEach>
    </c:forEach>
<p style="text-indent:0em;">
    <span>3、中标候选人响应招标文件要求的资格能力条件</span>
</p>
    <c:forEach items="${list}" var="item">
        <c:forEach items="${item.mapList}" var="map" varStatus="status">
            <p>
                第${status.count==1?"一":status.count==2?"二":"三"}中标候选人：${map.organBName}；响应情况：${map.respones}
            </p>
        </c:forEach>
    </c:forEach>


<h4>二、提出异议的渠道和方式</h4>
    <p style="text-indent:0em;">
        <span>${candidatePublicity.objectionsWay}</span>
    </p>
<h4>三、其他公示内容</h4>
    <p style="text-indent:0em;">
        <span>${candidatePublicity.otherContent}</span>
    </p>



<h4>
    四、监督部门：
</h4>
<p>
    本招标项目的监督部门为：${projectInstance.jdbmmc}
</p>


<h4>
    五、联系方式：
</h4>
<p>
    招标人：${organT.ztmc00}
    <br />
</p>

<p>
    地址：${organT.address}
    <br />
</p>

<p>
    联系人：${projectInstance.project.contacts}
    <br />
</p>

<p>
    联系方式：${projectInstance.project.phones}
    <br />
</p>

<p>
    招标代理机构：${organA.ztmc00}
    <br />
</p>

<p>
    地址：${organA.address}
    <br />
</p>

<p>
    联系人：${projectInstance.contacts}
    <br />
</p>

<p>
    联系方式：${projectInstance.phones}
    <br />
    <br />
</p>

<p>
    平台网站：www.jcebid.com
    <br />
    <br />
    <br />
</p>

<p>
    招标人或其招标代理机构主要负责人（项目负责人）：           （签名）
    <br />
    <br />
</p>
<p>
    招标人或其招标代理机构：                 （盖章）
    <br />
    <br />
</p>











<%--
<p>
     ${organA}受${organT}的委托，对${projectInstance}（${projectItemList}）组织了${util:dictionary('ZBFS00',projectInstance.zbfs00)}，现已完成了评标工作，评标结果公示如下：
</p>
<p>
    <br/>
</p>
<p>
               招标编号：${projectInstance.zbxmbh}
</p>


<c:forEach items="${list}" var="item">
	<p>
		${item.projectItem}
	</p>
	<p>
	          候选人为：
	</p>
	<c:forEach items="${item.organBList}" var="organB" varStatus="status">
	<p>
	    第${status.count==1?"一":status.count==2?"二":"三"}中标候选人：${organB}
	</p>
	</c:forEach>
</c:forEach>



<p>
    <br/>
</p>

<p>
    如对上述结果有异议的，请与${organA}联系，并提供相关书面材料。
</p>
<c:if test="${not empty candidatePublicity.contacts}">
<p>
    <br/>
</p>
<p>
    联系人：${candidatePublicity.contacts}
</p>
</c:if>
<c:if test="${not empty candidatePublicity.phone}">
<p>
    联系电话：${candidatePublicity.phone}
</p>
</c:if>
<c:if test="${not empty candidatePublicity.email}">
<p>
    电子邮箱：${candidatePublicity.email}
</p>
</c:if>
<p>
    <br/>
</p>
<p>
    公示截止时间：<fmt:formatDate value="${candidatePublicity.gsjssj}" pattern="yyyy年MM月dd日"/>
</p>
<p>
    <br/>
</p>
<p >
    ${organA}
</p>
<p ">
    <fmt:formatDate value="${candidatePublicity.gskssj}" pattern="yyyy年MM月dd日"/>
</p>--%>
