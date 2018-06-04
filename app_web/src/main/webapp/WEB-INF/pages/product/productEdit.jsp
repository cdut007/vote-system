<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" jgrowl="true" plupload="true" ztree="true" uedit="true"/>
<script type="text/javascript">
$(function(){
	var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : "pickfile",
		//container : document.getElementById('container'),
		url : ctx + '/attachment/uploadAttachment',
		flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
		silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
		multi_selection : false,
		multipart_params : {
			fjgslx : "30",
			unique : true
		},
		filters : {
			mime_types : [ //只允许上传图片和zip文件
			{
				title : "Image files",
				extensions : "jpg,gif,png,bmp"
			}, ],
			prevent_duplicates : true,
			max_file_size : '200mb'
		},
		init : {
			PostInit : function() {
			},
			FilesAdded : function(up, files) {
				up.start();
			},
			UploadProgress : function(up, file) {

			},
			FileUploaded : function(up, file, result) {
				var data = $.parseJSON(result.response);
				$("#logo").html($("<img/>").css({
					"width" : "229px",
					"height" : "229px"
				}).attr("src", "${pageContext.request.contextPath}/attachment/download/" + data.data.path));
				$("#picId").val(data.data.fjid00);
				up.removeFile(file);
			},
			UploadComplete : function(uploader, files) {

			},
			Error : function(up, err) {

			}
		}
	}).init();
	UE.getEditor('specification', {
		toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|', 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols' ] ],
		elementPathEnabled : false,
		autoHeightEnabled : false
	});

});

function submitForm(){
	var picId = $("#picId").val();
	
	if(picId==""){
		$.messager.alert("信息", "请先上传产品图片", 'info');
	}else{
		
		if($("#product_form").form('validate')){
			$("#product_form").submit();
		}
	}
}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			产品管理
			<code>&gt;</code>
			${empty product.id?"添加":"编辑"}产品
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<form:form method="post" id="product_form" action="${pageContext.request.contextPath}/product/createOrUpdateProduct" modelAttribute="product">
				<form:hidden path="id"/>
				<form:hidden path="picId" id="picId"  />
				<table style="width:100%;">
					<tbody>
						<tr>
							<td style="width:80px;">产品名称</td>
							<td>
								<form:input path="productName" cssClass="inputxt easyui-validatebox" data-options="required:true" />
							</td>
							<td colspan="2" rowspan="8">
								<div>
									<div id="logo" style="width:229px;height:229px;border:1px solid #ddd">
										<c:if test="${not empty product.picId}">
											<img src="${pageContext.request.contextPath}/attachment/download/${product.attachment.path}" style="width:229px;height:229px;" />
										</c:if>
									</div>
									<a id="pickfile" class="easyui-linkbutton" style="width:231px;">选择产品图片</a>
								</div>
							</td>
						</tr>
						<tr>
							<td>产品分类</td>
							<td>
								<sys:treeselect title="请选择产品类别" includeRoot="false" name="productType" value="${product.productType}" id="productType" cssClass="inputxt easyui-validatebox" dataOptions="required:true" typeCode="PRODUCT_TYPE"/>
							</td>
						</tr>
						<tr>
							<td>库存</td>
							<td>
								<sys:number name="stock" value="${product.stock}"></sys:number>
							</td>
						</tr>
						<tr>
							<td>价格</td>
							<td>
								<sys:number name="price" value="${product.price}" precision="2"/>元<form:select path="productUnit" cssStyle="width:60px"><form:options items="${util:dictionaryTree('PRODUCT_UNIT',false)}" itemLabel="itemName" itemValue="itemCode"/></form:select>
							</td>
						</tr>
						<tr>
							<td>生产地</td>
							<td>
								<form:input path="yieldly" cssClass="inputxt" />
							</td>
						</tr>
						<tr>
							<td>品牌</td>
							<td>
								<form:input path="brand" cssClass="inputxt" />
							</td>
						</tr>
						<tr>
							<td>型号</td>
							<td>
								<form:input path="model" cssClass="inputxt" />
							</td>
						</tr>
						<tr>
							<td>制造商</td>
							<td>
								<form:input path="manufacturer" cssClass="inputxt" />
							</td>
						</tr>
						<tr>
							<td>规格参数</td>
							<td colspan="3">
								<form:textarea path="specification" style="width:100%;height:300px;" />
							</td>
						</tr>
					</tbody>
				</table>
				<div class="blank10"></div>
				<button type="button" class="button red"   onclick="submitForm()">保存</button>
				<a class="button red" href="${pageContext.request.contextPath}/product/pagingProduct">返回</a>
			</form:form>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
