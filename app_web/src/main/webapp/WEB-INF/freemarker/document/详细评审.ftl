<table style="border: currentColor; border-image: none; border-collapse: collapse; mso-table-layout-alt: fixed; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt;" border="1" cellspacing="0" cellpadding="0">
	<tbody>
		<tr style="height: 37.6pt;">
			<td style="padding: 0cm 5.4pt; border: 1pt solid windowtext; border-image: none;height: 37.6pt; background-color: transparent; mso-border-alt: solid windowtext .5pt;" colspan="2">
				<b style="mso-bidi-font-weight: normal;">条款号</b>
			</td>
			<td style="border-width: 1pt 1pt 1pt 0px; border-style: solid solid solid none; border-color: windowtext windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none; height: 37.6pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;">
				<b style="mso-bidi-font-weight: normal;">条款内容</b>
			</td>
			<td style="border-width: 1pt 1pt 1pt 0px; border-style: solid solid solid none; border-color: windowtext windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none; height: 37.6pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;">
				<b style="mso-bidi-font-weight: normal;">编列内容</b>
			</td>
		</tr>
        <tr style="mso-yfti-irow: 1;">
            <td style="border-width: 0px 1pt 1pt; border-style: none solid solid; border-color: rgb(0, 0, 0) windowtext windowtext; padding: 0cm 5.4pt; border-image: none;  background-color: transparent; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt;" colspan="2">2.2.1</td>
            <td style="border-width: 0px 1pt 1pt 0px; border-style: none solid solid none; border-color: rgb(0, 0, 0) windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt;  background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;">分值构成 (总分100分)</td>
            <td style="border-width: 0px 1pt 1pt 0px; border-style: none solid solid none; border-color: rgb(0, 0, 0) windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt;  background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;"><#list scoreGroupList as scoreGroup>${scoreGroup.groupName!''}:${scoreGroup.groupFullScore!''}&nbsp;&nbsp;</#list></td>
        </tr>
        <tr style="mso-yfti-irow: 2;">
            <td style="border-width: 0px 1pt 1pt; border-style: none solid solid; border-color: rgb(0, 0, 0) windowtext windowtext; padding: 0cm 5.4pt; border-image: none;  background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" colspan="2">2.2.2</td>
            <td style="border-width: 0px 1pt 1pt 0px; border-style: none solid solid none; border-color: rgb(0, 0, 0) windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt;  background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;">评标基准价计算方法</td>
            <td style="border-width: 0px 1pt 1pt 0px; border-style: none solid solid none; border-color: rgb(0, 0, 0) windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt;  background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;">
                <#if evaluationMethodInstance??&&evaluationMethodInstance.benchmarkInstance??>
	                ${evaluationMethodInstance.benchmarkInstance.benchmarkDescription}
                </#if>
            </td>
        </tr>
        <tr style="height: 33.45pt; mso-yfti-irow: 3;">
            <td style="border-width: 0px 1pt 1pt; border-style: none solid solid; border-color: rgb(0, 0, 0) windowtext windowtext; padding: 0cm 5.4pt; border-image: none;  height: 33.45pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" colspan="2">2.2.3</td>
            <td style="border-width: 0px 1pt 0px 0px; border-style: none solid none none; border-color: rgb(0, 0, 0) windowtext rgb(0, 0, 0) rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none;  height: 33.45pt; background-color: transparent; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt;">投标报价的偏差率 计算公式</td>
            <td style="border-width: 0px 1pt 0px 0px; border-style: none solid none none; border-color: rgb(0, 0, 0) windowtext rgb(0, 0, 0) rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none;  height: 33.45pt; background-color: transparent; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt;">偏差率=100% ×(投标人报价-评标基准价)/评标基准价</td>
        </tr>
        <#if scoreGroupList??>
	        <#list scoreGroupList as scoreGroup>
	            <#list scoreGroup.scoreItemList as scoreItem>
	                <tr style="height: 24.85pt; page-break-inside: avoid;">
	                    <#if scoreItem_index==0>
	                        <td rowspan="${scoreGroup.scoreItemList?size}">2.2.4 （${scoreGroup_index+1}）</td>
	                        <td style="border-width: 0px 1pt 1px 1px; border-style: none solid solid; border-color: rgb(0, 0, 0) windowtext rgb(0, 0, 0) rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none;  height: 23pt; background-color: transparent; mso-border-top-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt;" rowspan="${scoreGroup.scoreItemList?size}">${scoreGroup.groupName!''}（总分${scoreGroup.groupFullScore!''}分）</td>
	                    </#if>
	                    <#if scoreGroup.flag=='price'>
	                        <td valign="top" style="border-width: 1pt 1pt 1pt 0px; border-style: solid solid solid none; border-color: windowtext windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none;  height: 23pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;">偏差率</td>
	                        <td style="border-width: 1pt 1pt 1pt 0px; border-style: solid solid solid none; border-color: windowtext windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none;  height: 23pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;">当投标报价等于评标基准价时得${scoreGroup.groupFullScore!''}分；${evaluationMethodInstance.text()}</td>
	                    <#else>
	                        <td valign="top" style="border-width: 1pt 1pt 1pt 0px; border-style: solid solid solid none; border-color: windowtext windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none;  height: 23pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;">${scoreItem.itemDescription!''}</td>
	                        <td style="border-width: 1pt 1pt 1pt 0px; border-style: solid solid solid none; border-color: windowtext windowtext windowtext rgb(0, 0, 0); padding: 0cm 5.4pt; border-image: none;  height: 23pt; background-color: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;">${scoreItem.itemFullScore!''}分</td>
	                    </#if>
	                </tr>
	            </#list>
	        </#list>
        </#if>
    </tbody>
</table>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    