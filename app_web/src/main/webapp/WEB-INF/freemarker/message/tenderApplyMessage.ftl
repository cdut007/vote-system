<#if task.getVariable('pass')>
您对 ${task.getVariable('projectInstanceName')} 提交的报名申请审核通过，招标文件已经添加到您的购物车。<a href='/pay/pagingUnPayItemRecord'>去支付</a>
<#else>
您对 ${task.getVariable('projectInstanceName')} 提交的报名申请审核未通过，原因如下：<br/>
${task.getVariable('nopassReason')}
</#if>