<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="元素ID"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="搜索对话框标题"%>
<%@ attribute name="typeCode" type="java.lang.String" required="true" description="字典类型编码"%>
<%@ attribute name="includeRoot" type="java.lang.Boolean" required="true" description="是否包含根节点"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="隐藏域值"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="dataOptions" type="java.lang.String" required="false" description="数据选项"%>
<%@ attribute name="maxLevelNo" type="java.lang.Integer" required="false" description="最大深度"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<span id="textbox-${id}" class="textbox combo" style="width: 200px; height: 20px;">
	<span class="textbox-addon textbox-addon-right" style="right: 0px;">
		<a class="textbox-icon combo-arrow searchbox-button" style="width: 18px; height: 20px;border:1px solid #a5aeb6" href="javascript:void(0)" icon-index="0"></a>
	</span>
	<input id="show-${id}" type="text" value="${util:dictionary(typeCode, value)}" class="easyui-validatebox textbox-text textbox-text-readonly" style="width: 174px; padding-top: 3px; padding-bottom: 3px; margin-right: 18px; margin-left: 0px;" type="text" readonly="readonly" placeholder="" autocomplete="off" data-options="${dataOptions}">
	<input id="hide-${id}" type="hidden" class="textbox-value" name="${name }" value="${value}" />
</span>
<script type="text/javascript">
	$("#show-${id}").focus(function(){
		$(this).parent().addClass("textbox-focused");
	}).blur(function(){
		$(this).parent().removeClass("textbox-focused");
	});
	$("#textbox-${id}").click(function() {
		var id = new Date().getTime();
		var ztreeId = "ztree-" + id;
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			title : '${title}',
			width : 300,
			height : 400,
			closed : false,
			cache : false,
			modal : true,
			//loadingMessage : '正在加载...',
			content:"<div class=\"easyui-layout\" data-options=\"fit:true,border:false\"><div data-options=\"region:'north',border:false,height:30\"><input class=\"searchbox\" style=\"width:100%;\"></input></div><div data-options=\"region:'center'\" class=\"ztree\"><div class=\"panel-loading\" style=\"padding: 10px;margin:100px auto;width:100px;\">&nbsp;&nbsp;&nbsp;&nbsp;正在加载...</div></div></div>",
			//href : ctx + "/dictionary/treeselect.do",
			onOpen : function() {
				$("#" + id + " .ztree").attr("id", ztreeId);
				$("#" + id + " .searchbox").searchbox({
					disabled:true
				});
				$.ajax({
					url :ctx+"/dictionary/dictionaryComboList",
					data:{typeCode:"${typeCode}",includeRoot:"${includeRoot}",fetchItemCode:"${value}",maxLevelNo:"${maxLevelNo}"},
					beforeSend : function() {
						//loading();
					},
					type : "post",
					dataType : "json",
					success : function(zNodes) {
						$("#" + ztreeId).data("zNodes",zNodes);
						var setting = {
							view : {
								showLine : true
							},
							data : {
								simpleData : {
									enable : true
								}
							}
						};
						var zTree=$.fn.zTree.init($("#" + ztreeId), setting, zNodes);
						var value=$("#hide-${id}").val();
						if(value!=""){
							var nodeList=zTree.getNodesByFilter(function(node) {
								return node.itemCode==value;
							});
							var node=nodeList[0];
							zTree.selectNode(node);
						}
						$("#" + id + " .searchbox").searchbox({
							prompt:'输入索搜内容',
							disabled:false,
							searcher:function(value,name){
								value=$.trim(value);
								var allNodeList=$("#" + ztreeId).data("zNodes");
								var setting = {
									view : {
										showLine : true
									},
									data : {
										simpleData : {
											enable : true
										}
									}
								};
								if(value==""){
									$.fn.zTree.init($("#" + ztreeId), setting, allNodeList);
									return;
								}
								var allNodeMap={};
								for(var i=0,l=allNodeList.length;i<l;i++){
									allNodeMap[allNodeList[i]["id"]]=allNodeList[i];
								}
								var nodeMap={};
								$(allNodeList).each(function(){
									if(this.text.search(value)>-1){
										nodeMap[this["id"]]=this;
										var parentNode=allNodeMap[this["pId"]];
										while(parentNode){
											nodeMap[parentNode["id"]]=parentNode;
											parentNode=allNodeMap[parentNode["pId"]];
										}
									}
								});
								var nodeList=[];
								for(var key in nodeMap){
									nodeList.push(nodeMap[key]);
								}
								var zTree=$.fn.zTree.init($("#" + ztreeId), setting, nodeList);
								zTree.expandAll(true);
							}
						});
					},
					complete : function() {
						//disLoad();
					}
				});
			},
			onClose : function() {
				//disLoad();
				$("#" + id).dialog("destroy");
			},
			buttons : [ {
				text : '确定',
				color : "red",
				handler : function() {
					var zTree = $.fn.zTree.getZTreeObj(ztreeId);
					var nodeList = zTree.getSelectedNodes();
					if (nodeList.length == 0) {
						$.messager.alert("系统提示", "请选择${title}！");
						return;
					}
					var node = nodeList[0];
					$("#hide-${id}").val(node.itemCode);
					$("#show-${id}").val(node.text).validatebox("validate");
					$("#" + id).dialog("close");
				}
			}, {
				text : '关闭',
				color : "red",
				handler : function() {
					$("#" + id).dialog("close");
				}
			} ]
		});
	});
</script>