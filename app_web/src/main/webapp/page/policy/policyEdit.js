$(function() {
	var editor=UE.getEditor('policyContent', {
		toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|', 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols' ] ],
		elementPathEnabled : false,
		autoHeightEnabled : false
	});
	var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : "pickfile",
		//container : document.getElementById('container'),
		url : ctx + '/common/word2Html',
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
				title : "Office files",
				extensions : "doc,docx"
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
				var index=file.name.lastIndexOf("."); 
				$(":input[name='policyTitle']").val(file.name.substr(0,index));
				editor.setContent(result.response);
				up.removeFile(file);
			},
			UploadComplete : function(uploader, files) {

			},
			Error : function(up, err) {

			}
		}
	}).init();
});