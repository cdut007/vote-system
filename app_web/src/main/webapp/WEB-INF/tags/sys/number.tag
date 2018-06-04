<%@tag language="java" pageEncoding="UTF-8" dynamic-attributes="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@attribute name="id" type="java.lang.String" required="false" description="唯一标识"%>
<%@attribute name="name" type="java.lang.String" required="false" description="表单提交标识名称"%>
<%@attribute name="value" type="java.lang.String" required="false" description="输入框默认值"%>
<%@attribute name="precision" type="java.lang.Integer" required="false" description="小数精度"%>
<%@attribute name="max" type="java.lang.Double" required="false" description="最大值"%>
<%@attribute name="min" type="java.lang.Double" required="false" description="最小值"%>
<%@attribute name="required" type="java.lang.Boolean" required="false" description="是否必填"%>
<%@attribute name="readonly" type="java.lang.Boolean" required="false" description="是否可编辑"%>
<%@attribute name="style" type="java.lang.String" required="false" description="样式"%>
<%@attribute name="disabled" type="java.lang.Boolean" required="false" description="是否禁用"%>
<%@attribute name="onChange" type="java.lang.String" required="false" description="事件"%>
<input id="${id}" name="${name}" value="${value}" class="easyui-numberbox" style="${style}" data-options="required:${empty required?false:true},precision:${empty precision?0:precision},min:${empty min?0:min},max:${empty max?'undefined':max},onChange:${empty onChange?'undefined':onChange}" ${readonly?"readonly='readonly'":""} ${disabled?"disabled='disabled'":""}/>