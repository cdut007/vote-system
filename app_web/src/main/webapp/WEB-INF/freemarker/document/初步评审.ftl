<table style="border: currentColor; border-image: none; border-collapse: collapse; mso-table-layout-alt: fixed; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt;" border="1" cellspacing="0" cellpadding="0">
  <tbody>
    <tr style="height: 37.6pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes;">
      <td width="134" style="padding: 0cm 5.4pt; border: 1pt solid windowtext; border-image: none; width: 100.65pt; height: 37.6pt; background-color: transparent; mso-border-alt: solid windowtext .5pt;" colspan="2">
        <b style="mso-bidi-font-weight: normal;">条款号</b>
      </td>
      <td width="162" style="border-width: 1pt 1pt 1pt 0px; border-style: solid solid solid none; border-color: windowtext windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none; width: 121.35pt; height: 37.6pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;">
        <b style="mso-bidi-font-weight: normal;">评审因素</b>
      </td>
      <td width="302" style="border-width: 1pt 1pt 1pt 0px; border-style: solid solid solid none; border-color: windowtext windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none; width: 226.3pt; height: 37.6pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;">
        <b style="mso-bidi-font-weight: normal;">评审标准</b>
      </td>
    </tr>
    <#assign typeIndex=0>
    <#list qualificationReviewList as qualificationReview>
      <#if !preliminaryReviewType??||preliminaryReviewType != qualificationReview.preliminaryReviewType>
        <#assign typeIndex=typeIndex+1>
        <#assign preliminaryReviewType=qualificationReview.preliminaryReviewType/>
        <#assign rowspan=0>
        <#list qualificationReviewList as qualificationReviewChildren >
          <#if qualificationReviewChildren.preliminaryReviewType==qualificationReview.preliminaryReviewType>
            <#assign rowspan=rowspan+1>
          </#if>
        </#list>
        <#if qualificationReviewList??&&qualificationReviewList?size!=0>
	        <#assign index=0>
	        <#list qualificationReviewList as qualificationReviewChildren2 >
	          <#if qualificationReviewChildren2.preliminaryReviewType==preliminaryReviewType>
	            <tr style="page-break-inside: avoid; mso-yfti-irow: 1;">
	              <#if index==0>
	                <#assign index=index+1>
	                <td width="61" style="border-width: 0px 1pt 1pt; border-style: none solid solid; border-color: rgb(0, 0, 0) windowtext windowtext; padding: 0cm 5.4pt; border-image: none; width: 45.75pt;  background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" rowspan="${rowspan}">2.1.${typeIndex}</td>
	                <td width="73" style="border-width: 0px 1pt 1pt 0px; border-style: none solid solid none; border-color: rgb(0, 0, 0) windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; width: 54.9pt;  background-color: transparent; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt;"  rowspan="${rowspan}">${qualificationReview.preliminaryReviewType}</td>
	              </#if>
	              <td width="162" style="border-width: 0px 1pt 1pt 0px; border-style: none solid solid none; border-color: rgb(0, 0, 0) windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; width: 121.35pt; height: 24.85pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;">${qualificationReviewChildren2.evaluationFactor!""}</td>
	              <td width="302" style="border-width: 0px 1pt 1pt 0px; border-style: none solid solid none; border-color: rgb(0, 0, 0) windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; width: 226.3pt; height: 24.85pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;">${qualificationReviewChildren2.reviewStandard!""}</td>
	            </tr>
	          </#if>
	        </#list>
        </#if>
      </#if>
    </#list>
  </tbody>
</table>