<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta content="text/html; charset=UTF-8" http-equiv="content-type" />
<title>流程设计器</title>
<!-- framework CSS -->
<!-- JQuery EasyUi CSS-->
<link href="/resources/easyui/themes/icon.css" type="text/css" rel="stylesheet" />
<link href="/resources/easyui/themes/default/easyui.css" type="text/css" rel="stylesheet" />
<link href="/resources/easyui/themes/button.css" type="text/css" rel="stylesheet" />
<!-- JQuery validate CSS-->
<link href="/resources/designer/validate/jquery.validate.extend.css" type="text/css" rel="stylesheet" />
<!-- JQuery AutoComplete -->
<link rel="stylesheet" type="text/css" href="/resources/designer/jquery-autocomplete/jquery.autocomplete.css" />
<!-- JQuery-->
<script type="text/javascript" src="/resources/jquery/jquery-1.9.1.min.js"></script>
<!-- JQuery EasyUi JS-->
<script src="/resources/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<script src="/resources/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<!-- JQuery validate JS-->
<script src="/resources/designer/validate/jquery.validate.js" type="text/javascript"></script>
<script src="/resources/designer/validate/jquery.metadata.js" type="text/javascript"></script>
<script src="/resources/designer/validate/jquery.validate.method.js" type="text/javascript"></script>
<script src="/resources/designer/validate/jquery.validate.extend.js" type="text/javascript"></script>
<!-- JQuery form Plugin -->
<script src="/resources/jquery/jquery.form.js" type="text/javascript"></script>
<!-- JSON JS-->
<script src="/resources/designer/json2.js" type="text/javascript"></script>
<!-- JQuery AutoComplete -->
<script type='text/javascript' src='/resources/designer/jquery-autocomplete/lib/jquery.bgiframe.min.js'></script>
<script type='text/javascript' src='/resources/designer/jquery-autocomplete/lib/jquery.ajaxQueue.js'></script>
<script type='text/javascript' src='/resources/designer/jquery-autocomplete/jquery.autocomplete.min.js'></script>
<!-- framework JS -->
<script src="/resources/designer/skin.js" type="text/javascript"></script>
<link href="/resources/designer/object/designer.css" type="text/css" rel="stylesheet" />
<!-- common, all times required, imports -->
<script src='/resources/designer/draw2d/wz_jsgraphics.js'></script>
<script src='/resources/designer/draw2d/mootools.js'></script>
<script src='/resources/designer/draw2d/moocanvas.js'></script>
<script src='/resources/designer/draw2d/draw2d.js'></script>
<!-- example specific imports -->
<script src="/resources/designer/MyCanvas.js"></script>
<script src="/resources/designer/ResizeImage.js"></script>
<script src="/resources/designer/object/event/Start.js"></script>
<script src="/resources/designer/object/event/End.js"></script>
<script src="/resources/designer/object/connection/MyInputPort.js"></script>
<script src="/resources/designer/object/connection/MyOutputPort.js"></script>
<script src="/resources/designer/object/connection/DecoratedConnection.js"></script>
<script src="/resources/designer/object/task/Task.js"></script>
<script src="/resources/designer/object/task/UserTask.js"></script>
<script src="/resources/designer/object/task/ManualTask.js"></script>
<script src="/resources/designer/object/task/ServiceTask.js"></script>
<script src="/resources/designer/object/task/ScriptTask.js"></script>
<script src="/resources/designer/object/task/MailTask.js"></script>
<script src="/resources/designer/object/task/ReceiveTask.js"></script>
<script src="/resources/designer/object/task/BusinessRuleTask.js"></script>
<script src="/resources/designer/object/task/CallActivity.js"></script>
<script src="/resources/designer/object/gateway/ExclusiveGateway.js"></script>
<script src="/resources/designer/object/gateway/ParallelGateway.js"></script>
<script src="/resources/designer/object/designer.js"></script>
<style type="text/css">
.properties-menu {
	padding: 5px;
}
</style>
<!-- 界面初始化 -->
<script type="text/javascript">
	var processDefinitionId = "";
	var processDefinitionName = "";
	var processDefinitionVariables = "";
	var _process_def_provided_listeners = "";
	var is_open_properties_panel = false;
	var task;
	var line;
	jq(function() {
		try {
			_task_obj = jq('#task');
			_designer = jq('#designer');
			_properties_panel_obj = _designer.layout('panel', 'east');
			_properties_panel_obj.panel({
				loadingMessage : "正在加载...",
				onExpand : function() {
					is_open_properties_panel = true;
				},
				onCollapse : function() {
					is_open_properties_panel = false;
				}
			});
			_process_panel_obj = _designer.layout('panel', 'center');
			_task_context_menu = jq('#task-context-menu').menu({});
			_designer.layout('collapse', 'east');

			jq('.easyui-linkbutton').draggable({
				proxy : function(source) {
					var n = jq('<div class="draggable-model-proxy"></div>');
					n.html(jq(source).html()).appendTo('body');
					return n;
				},
				deltaX : 0,
				deltaY : 0,
				revert : true,
				cursor : 'auto',
				onStartDrag : function() {
					jq(this).draggable('options').cursor = 'not-allowed';
				},
				onStopDrag : function() {
					jq(this).draggable('options').cursor = 'auto';
				}
			});
			jq('#paintarea').droppable({
				accept : '.easyui-linkbutton',
				onDragEnter : function(e, source) {
					jq(source).draggable('options').cursor = 'auto';
				},
				onDragLeave : function(e, source) {
					jq(source).draggable('options').cursor = 'not-allowed';
				},
				onDrop : function(e, source) {
					//jq(this).append(source)
					//jq(this).removeClass('over');
					var wfModel = jq(source).attr('wfModel');
					var shape = jq(source).attr('iconImg');
					if (wfModel) {
						var x = jq(source).draggable('proxy').offset().left;
						var y = jq(source).draggable('proxy').offset().top;
						var xOffset = workflow.getAbsoluteX();
						var yOffset = workflow.getAbsoluteY();
						var scrollLeft = workflow.getScrollLeft();
						var scrollTop = workflow.getScrollTop();
						//alert(xOffset+"|"+yOffset+"|"+scrollLeft+"|"+scrollTop);
						//alert(shape);
						addModel(wfModel, x - xOffset + scrollLeft, y - yOffset + scrollTop, shape);
					}
				}
			});
			//界面初始化
			jq('#process-definition-tab').tabs({
				fit : true,
				onSelect : function(title) {
					if (title == 'XML') {
						jq('#descriptorarea').val(workflow.toXML());
					}
				}
			});

			//jq('#paintarea').bind('contextmenu',function(e){
			//alert(e.target.tagName);
			//});
		} catch (e) {
			alert(e.message);
		}
		/* jq(window).unload(function() {
			window.opener._list_grid_obj.datagrid('reload');
		}); */
	});
	function addModel(name, x, y, icon) {
		var model = null;
		if (icon != null && icon != undefined) {
			model = eval("new draw2d." + name + "(openTaskProperties,'" + icon + "')");
		} else {
			model = eval("new draw2d." + name + "(openTaskProperties)");
		}
		//userTask.setContent("DM Approve");
		model.generateId();
		//var id= task.getId();
		//task.id=id;
		//task.setId(id);
		//task.taskId=id;
		//task.taskName=id;
		//var parent = workflow.getBestCompartmentFigure(x,y);
		//workflow.getCommandStack().execute(new draw2d.CommandAdd(workflow,task,x,y,parent));
		workflow.addModel(model, x, y);

	}

	function openTaskProperties(t) {
		if (!is_open_properties_panel)
			_designer.layout('expand', 'east');
		task = t;
		if (task.type == "draw2d.Start")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/startEventProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.End")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/endEventProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.ExclusiveGateway")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/exclusiveGatewayProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.ParallelGateway")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/parallelGatewayProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.UserTask")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/userTaskProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.ManualTask")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/manualTaskProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.ServiceTask")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/serviceTaskProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.ScriptTask")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/scriptTaskProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.ReceiveTask")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/receiveTaskProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.MailTask")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/mailTaskProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.BusinessRuleTask")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/businessRuleTaskProperties?t=' + new Date().getTime());
		else if (task.type == "draw2d.CallActivity")
			_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/callActivityProperties?t=' + new Date().getTime());
	}
	function openProcessProperties(id) {
		//alert(id);
		if (!is_open_properties_panel)
			_designer.layout('expand', 'east');
		_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/processProperties?t=' + new Date().getTime());
	}
	function openFlowProperties(l) {
		//alert(id);
		if (!is_open_properties_panel)
			_designer.layout('expand', 'east');
		line = l;
		_properties_panel_obj.panel('refresh', '${pageContext.request.contextPath}/workflow/designer/flowProperties?t=' + new Date().getTime());
	}
	function openEventProperties() {

	}
	function deleteModel(id) {
		var task = workflow.getFigure(id);
		workflow.removeFigure(task);
	}
	function redo() {
		workflow.getCommandStack().redo();
	}
	function undo() {
		workflow.getCommandStack().undo();
	}
	function saveProcessDef() {
		var xml = workflow.toXML();
		//alert(workflow.process.getVariablesJSONObject());
		//alert(workflow.process.getVariablesJSONObject());
		//return;
		jq.ajax({
			url : "${pageContext.request.contextPath}/workflow/deploy",
			type : "post",
			data : {
				processDescriptor : xml,
				processName : workflow.process.name,
				processVariables : workflow.process.getVariablesJSONObject()
			},
			dataType : 'json',
			error : function() {
				//$.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.save.failure'></s:text>","error");
				return "";
			},
			success : function(data) {
				if (data.success) {
					jq.messager.alert('系统提示', '保存成功!', 'info');
				} else {
					jq.messager.alert('系统提示', data.msg, 'error');
				}
			}
		});

	}
	function exportProcessDef(obj) {
		//obj.href="${pageContext.request.contextPath}/wf/procdef/procdef!exportProcessDef.action?procdefId="+processDefinitionId+"&processName="+processDefinitionName;
	}

	var workflow;
	function openProcessDef() {
		jq.ajax({
			url : "../../wf/procdef/procdef!getProcessDefXML.action?procdefId=" + processDefinitionId,
			type : 'POST',
			/*data:{
						moduleId:"${moduleId}",
						_request_json_fields:json4params
			},*/
			dataType : 'xml',
			error : function() {
				$.messager.alert("<s:text name='label.common.error'></s:text>", "System Error", "error");
				return "";
			},
			success : parseProcessDescriptor
		});
	}

	function createCanvas(disabled) {
		try {
			//initCanvas();
			workflow = new draw2d.MyCanvas("paintarea");
			workflow.scrollArea = document.getElementById("designer-area");
			if (disabled)
				workflow.setDisabled();
			if (typeof processDefinitionId != "undefined" && processDefinitionId != null && processDefinitionId != "null" && processDefinitionId != "" && processDefinitionId != "NULL") {
				openProcessDef();
			} else {
				var id = "process" + Sequence.create();
				//var id = workflow.getId();
				workflow.process.category = 'qingfeng_process_def';
				workflow.process.id = id;
				workflow.process.name = id;
				// Add the start,end,connector to the canvas
				// init ;
				//var startObj = new draw2d.Start("../../js/designer/icons/type.startevent.none.png");
				//startObj.setId("start");
				//workflow.addFigure(startObj, 200, 50);
				//var endObj = new draw2d.End("../../js/designer/icons/type.endevent.none.png");
				//endObj.setId("end");
				//workflow.addFigure(endObj, 200, 400);
			}
		} catch (e) {
			alert(e.message);
		}
	}
	//xml 转换流程图 
	function parseProcessDescriptor(data) {
		var isChrome = (window.navigator.userAgent.indexOf("Chrome") !== -1);
		var descriptor = jq(data);
		var definitions = descriptor.find('definitions');
		var process = descriptor.find('process');
		var startEvent = descriptor.find('startEvent');
		var endEvent = descriptor.find('endEvent');
		var userTasks = descriptor.find('userTask');
		var ServiceTasks = descriptor.find('serviceTask');
		var exclusiveGateway = descriptor.find('exclusiveGateway');
		var parallelGateway = descriptor.find('parallelGateway');
		var lines = descriptor.find('sequenceFlow');
		var shapes = isChrome ? descriptor.find("BPMNShape") : descriptor.find('bpmndi\\:BPMNShape');
		var edges = isChrome ? descriptor.find("BPMNEdge") : descriptor.find('bpmndi\\:BPMNEdge');
		workflow.process.category = definitions.attr('targetNamespace');
		workflow.process.id = process.attr('id');
		workflow.process.name = process.attr('name');
		var documentation = trim(descriptor.find('process > documentation').text());
		if (documentation != null && documentation != "")
			workflow.process.documentation = documentation;
		var extentsion = descriptor.find('process > extensionElements');
		if (extentsion != null) {
			var listeners = isChrome ? extentsion.find('executionListener') : extentsion.find('activiti\\:executionListener');
			var taskListeners = isChrome ? extentsion.find('taskListener') : extentsion.find('activiti\\:taskListener');
			workflow.process.setListeners(parseListeners(listeners, "draw2d.Process.Listener", "draw2d.Process.Listener.Field"));
		}
		jq.each(processDefinitionVariables, function(i, n) {
			var variable = new draw2d.Process.variable();
			variable.name = n.name;
			variable.type = n.type;
			variable.scope = n.scope;
			variable.defaultValue = n.defaultValue;
			variable.remark = n.remark;
			workflow.process.addVariable(variable);
		});
		startEvent.each(function(i) {
			var start = new draw2d.Start(openTaskProperties, "/resources/designer/object/icons/type.startevent.none.png");
			start.id = jq(this).attr('id');
			start.eventId = jq(this).attr('id');
			start.eventName = jq(this).attr('name');
			start.initiator = jq(this).attr('activiti:initiator');
			var formProperties = isChrome ? jq(this).find('extensionElements').find("formProperty") : jq(this).find('extensionElements').find("activiti\\:formProperty");
			start.setFormProperties(parseFormProperties(formProperties, "draw2d.UserTask.FormProperty"));
			var documentation = trim(jq(this).find('documentation').text());
			if (documentation != null && documentation != "")
				start.documentation = documentation;
			shapes.each(function(i) {
				var id = jq(this).attr('bpmnElement');
				if (id == start.id) {
					var x = parseInt(isChrome ? jq(this).find('Bounds').attr('x') : jq(this).find('omgdc\\:Bounds').attr('x'));
					var y = parseInt(isChrome ? jq(this).find('Bounds').attr('y') : jq(this).find('omgdc\\:Bounds').attr('y'));
					workflow.addFigure(start, x, y);
					return false;
				}
			});
		});
		endEvent.each(function(i) {
			var end = new draw2d.End(openTaskProperties, "/resources/designer/object/icons/type.endevent.none.png");
			end.id = jq(this).attr('id');
			end.eventId = jq(this).attr('id');
			end.eventName = jq(this).attr('name');
			var documentation = trim(jq(this).find('documentation').text());
			if (documentation != null && documentation != "") {
				task.documentation = documentation;
			}
			shapes.each(function(i) {
				var id = jq(this).attr('bpmnElement');
				if (id == end.id) {
					var x = parseInt(isChrome ? jq(this).find('Bounds').attr('x') : jq(this).find('omgdc\\:Bounds').attr('x'));
					var y = parseInt(isChrome ? jq(this).find('Bounds').attr('y') : jq(this).find('omgdc\\:Bounds').attr('y'));
					workflow.addFigure(end, x, y);
					return false;
				}
			});
		});
		userTasks.each(function(i) {
			var task = new draw2d.UserTask(openTaskProperties);
			var tid = jq(this).attr('id');
			task.id = tid;
			var tname = jq(this).attr('name');
			var assignee = jq(this).attr('activiti:assignee');
			var candidataUsers = jq(this).attr('activiti:candidateUsers');
			var candidataGroups = jq(this).attr('activiti:candidateGroups');
			var formKey = jq(this).attr('activiti:formKey');
			if (assignee != null && assignee != "") {
				task.isUseExpression = true;
				task.performerType = "assignee";
				task.expression = assignee;
			} else if (candidataUsers != null && candidataUsers != "") {
				task.isUseExpression = true;
				task.performerType = "candidateUsers";
				task.expression = candidataUsers;
			} else if (candidataGroups != null && candidataGroups != "") {
				task.isUseExpression = true;
				task.performerType = "candidateGroups";
				task.expression = candidataGroups;
			}
			if (formKey != null && formKey != "") {
				task.formKey = formKey;
			}
			var documentation = trim(jq(this).find('documentation').text());
			if (documentation != null && documentation != "") {
				task.documentation = documentation;
			}
			task.taskId = tid;
			task.taskName = tname;
			if (tid != tname) {
				task.setContent(tname);
			}
			var formProperties = isChrome ? jq(this).find('extensionElements').find("formProperty") : jq(this).find('extensionElements').find("activiti\\:formProperty");
			task.setFormProperties(parseFormProperties(formProperties, "draw2d.UserTask.FormProperty"));
			var listeners = isChrome ? jq(this).find('extensionElements').find('taskListener') : jq(this).find('extensionElements').find('activiti\\:taskListener');
			task.setListeners(parseListeners(listeners, "draw2d.Task.Listener", "draw2d.Task.Listener.Field"));
			var performersExpression = jq(this).find('potentialOwner').find('resourceAssignmentExpression').find('formalExpression').text();
			if (performersExpression.indexOf('user(') != -1) {
				task.performerType = "candidateUsers";
			} else if (performersExpression.indexOf('group(') != -1) {
				task.performerType = "candidateGroups";
			}
			var performers = performersExpression.split(',');
			jq.each(performers, function(i, n) {
				var start = 0;
				var end = n.lastIndexOf(')');
				if (n.indexOf('user(') != -1) {
					start = 'user('.length;
					var performer = n.substring(start, end);
					task.addCandidateUser({
						id : performer
					});
				} else if (n.indexOf('group(') != -1) {
					start = 'group('.length;
					var performer = n.substring(start, end);
					task.addCandidateGroup({
						id : performer
					});
				}
			});
			shapes.each(function(i) {
				var id = jq(this).attr('bpmnElement');
				if (id == task.id) {
					var x = parseInt(isChrome ? jq(this).find('Bounds').attr('x') : jq(this).find('omgdc\\:Bounds').attr('x'));
					var y = parseInt(isChrome ? jq(this).find('Bounds').attr('y') : jq(this).find('omgdc\\:Bounds').attr('y'));
					workflow.addModel(task, x, y);
					return false;
				}
			});
		});
		ServiceTasks.each(function(i) {
			var task = undefined;
			var tid = jq(this).attr('id');
			if (jq(this).attr('activiti:type') == "mail") {
				task = new draw2d.MailTask(openTaskProperties);
				task.id = tid;
				var tname = jq(this).attr('name');
				task.taskId = tid;
				task.taskName = tname;
				if (tid != tname)
					task.setContent(tname);
				jq(this).children("extensionElements").children().each(function() {
					if (jq(this).attr("name") == "charset" || jq(this).attr("name") == "text" || jq(this).attr("name") == "html") {
						task["_" + jq(this).attr("name")] = jq(this).children().text();
					} else {
						task[jq(this).attr("name")] = jq(this).children().text();
					}
				});
			} else {
				task = new draw2d.ServiceTask(openTaskProperties);
				task.id = tid;
				var tname = jq(this).attr('name');
				task.taskId = tid;
				task.taskName = tname;
				if (tid != tname)
					task.setContent(tname);
				task._javaClass = jq(this).attr('activiti:class');
				if (task._javaClass) {
					task._type = "javaClass";
				}
				task._expression = jq(this).attr('activiti:expression');
				if (task._expression) {
					task._type = "expression";
				}
				task.delegateExpression = jq(this).attr("activiti:delegateExpression");
				if (task.delegateExpression) {
					task._type = "delegateExpression";
				}
				task.resultVariable = jq(this).attr("activiti:resultVariableName");
			}
			shapes.each(function(i) {
				var id = jq(this).attr('bpmnElement');
				if (id == task.id) {
					var x = parseInt(isChrome ? jq(this).find('Bounds').attr('x') : jq(this).find('omgdc\\:Bounds').attr('x'));
					var y = parseInt(isChrome ? jq(this).find('Bounds').attr('y') : jq(this).find('omgdc\\:Bounds').attr('y'));
					workflow.addModel(task, x, y);
					return false;
				}
			});
		});
		exclusiveGateway.each(function(i) {
			var gateway = new draw2d.ExclusiveGateway(openTaskProperties, "/resources/designer/object/icons/type.gateway.exclusive.png");
			var gtwid = jq(this).attr('id');
			var gtwname = jq(this).attr('name');
			gateway.id = gtwid;
			gateway.gatewayId = gtwid;
			gateway.gatewayName = gtwname;
			shapes.each(function(i) {
				var id = jq(this).attr('bpmnElement');
				if (id == gateway.id) {
					var x = parseInt(isChrome ? jq(this).find('Bounds').attr('x') : jq(this).find('omgdc\\:Bounds').attr('x'));
					var y = parseInt(isChrome ? jq(this).find('Bounds').attr('y') : jq(this).find('omgdc\\:Bounds').attr('y'));
					workflow.addModel(gateway, x, y);
					return false;
				}
			});
		});
		parallelGateway.each(function(i) {
			var gateway = new draw2d.ExclusiveGateway(openTaskProperties, "/resources/designer/object/icons/type.gateway.parallel.png");
			var gtwid = jq(this).attr('id');
			var gtwname = jq(this).attr('name');
			gateway.id = gtwid;
			gateway.gatewayId = gtwid;
			gateway.gatewayName = gtwname;
			shapes.each(function(i) {
				var id = jq(this).attr('bpmnElement');
				if (id == gateway.id) {
					var x = parseInt(isChrome ? jq(this).find('Bounds').attr('x') : jq(this).find('omgdc\\:Bounds').attr('x'));
					var y = parseInt(isChrome ? jq(this).find('Bounds').attr('y') : jq(this).find('omgdc\\:Bounds').attr('y'));
					workflow.addModel(gateway, x, y);
					return false;
				}
			});
		});
		lines.each(function(i) {
			var lid = jq(this).attr('id');
			var name = jq(this).attr('name');
			var condition = trim(jq(this).find('conditionExpression').text());
			var sourceRef = jq(this).attr('sourceRef');
			var targetRef = jq(this).attr('targetRef');
			var source = workflow.getFigure(sourceRef);
			var target = workflow.getFigure(targetRef);
			edges.each(function(i) {
				var eid = jq(this).attr('bpmnElement');
				if (eid == lid) {
					var startPort = null;
					var endPort = null;
					var points = isChrome ? jq(this).find('waypoint') : jq(this).find('omgdi\\:waypoint');
					var startX = jq(points[0]).attr('x');
					var startY = jq(points[0]).attr('y');
					var endX = jq(points[1]).attr('x');
					var endY = jq(points[1]).attr('y');
					var sports = source.getPorts();
					for (var i = 0; i < sports.getSize(); i++) {
						var s = sports.get(i);
						var x = s.getAbsoluteX();
						var y = s.getAbsoluteY();
						if (x == startX && y == startY) {
							startPort = s;
							break;
						}
					}
					var tports = target.getPorts();
					for (var i = 0; i < tports.getSize(); i++) {
						var t = tports.get(i);
						var x = t.getAbsoluteX();
						var y = t.getAbsoluteY();
						if (x == endX && y == endY) {
							endPort = t;
							break;
						}
					}
					if (startPort != null && endPort != null) {
						var cmd = new draw2d.CommandConnect(workflow, startPort, endPort);
						var connection = new draw2d.DecoratedConnection();
						connection.id = lid;
						connection.lineId = lid;
						connection.lineName = name;
						if (lid != name)
							connection.setLabel(name);
						if (condition != null && condition != "") {
							connection.condition = condition;
						}
						cmd.setConnection(connection);
						workflow.getCommandStack().execute(cmd);
					}
					return false;
				}
			});
		});
		if (typeof setHightlight != "undefined") {
			setHightlight();
		}
	}
	function parseFormProperties(formProperties, formPropertyType) {
		var isChrome = (window.navigator.userAgent.indexOf("Chrome") !== -1);
		var parsedFormProperties = new draw2d.ArrayList();
		formProperties.each(function(i) {
			var formProperty = eval("new " + formPropertyType + "()");
			formProperty.id = jq(this).attr("id");
			formProperty.name = jq(this).attr("name");
			formProperty.type = jq(this).attr("type");
			formProperty.expression = jq(this).attr("expression");
			formProperty.variable = jq(this).attr("variable");
			formProperty.defaultValue = jq(this).attr("default");
			formProperty.datePattern = jq(this).attr("datePattern");
			formProperty.readable = jq(this).attr("readable");
			formProperty.writable = jq(this).attr("writable");
			formProperty.required = jq(this).attr("required");
			formProperty.values = new draw2d.ArrayList();
			(isChrome ? jq(this).find("value") : jq(this).find("activiti\\:value")).each(function(i) {
				var formValue = new draw2d.UserTask.FormProperty.FormValue();
				formValue.id = jq(this).attr("id");
				formValue.name = jq(this).attr("name");
				formProperty.values.add(formValue);
			});
			parsedFormProperties.add(formProperty);
		});
		return parsedFormProperties;
	}
	function parseListeners(listeners, listenerType, fieldType) {
		var isChrome = (window.navigator.userAgent.indexOf("Chrome") !== -1);
		var parsedListeners = new draw2d.ArrayList();
		listeners.each(function(i) {
			var listener = eval("new " + listenerType + "()");
			listener.event = jq(this).attr('event');
			var expression = jq(this).attr('expression');
			var clazz = jq(this).attr('class');
			if (expression != null && expression != "") {
				listener.serviceType = 'expression';
				listener.serviceExpression = expression;
			} else if (clazz != null && clazz != "") {
				listener.serviceType = 'javaClass';
				listener.serviceExpression = clazz;
			}
			var fields = isChrome ? jq(this).find('field') : jq(this).find('activiti\\:field');
			fields.each(function(i) {
				var field = eval("new " + fieldType + "()");
				field.name = jq(this).attr('name');
				//alert(field.name);
				var string = (isChrome ? jq(this).find('string') : jq(this).find('activiti\\:string')).text();
				var expression = (isChrome ? jq(this).find('expression') : jq(this).find('activiti\\:expression')).text();
				//alert("String="+string.text()+"|"+"expression="+expression.text());
				if (string != null && string != "") {
					field.type = 'string';
					field.value = string;
				} else if (expression != null && expression != "") {
					field.type = 'expression';
					field.value = expression;
				}
				listener.setField(field);
			});
			parsedListeners.add(listener);
		});
		return parsedListeners;
	}
</script>
<c:if test="${not empty processDefinitionId}">
	<script type="text/javascript">
		jq(function() {
			jq.ajax({
				url : "/workflow/open?processDefinitionId=${processDefinitionId}&_="+new Date().getTime(),
				dataType : "xml",
				success : function(data) {
					parseProcessDescriptor(data);
				},
				error : function(e, s1, s2) {
					alert(s1);
				}
			});
		});
	</script>
</c:if>
</head>
<body id="designer" class="easyui-layout">
	<div id="toolbar-panel" region="north" border="false" style="height:48px;padding:5px;background-color:#fafafa;">
		<div style="padding:5px;border:1px solid #ddd;">
			<a href="javascript:void(0)" id="sb1" class="easyui-splitbutton" menu="#edit-menu" iconCls="icon-edit">编辑</a>
			<!--			<a href="javascript:void(0)" id="sb2" class="easyui-splitbutton" menu="#mm2" iconCls="icon-ok" onclick="javascript:alert(workflow.toXML())">Ok</a>-->
			<!--			<a href="javascript:void(0)" id="mb2" class="easyui-menubutton" menu="#xml/diagram" onclick="viewXMLOrDiagram()">XML/Diagram</a>-->
			<a href="javascript:void(0)" id="mb3" class="easyui-menubutton" menu="#mm3" iconCls="icon-house">帮助</a>
		</div>
		<div id="edit-menu" style="width:150px;">
			<div iconCls="icon-undo" onclick="undo()">撤销</div>
			<div iconCls="icon-redo" onclick="redo()">重做</div>
			<div class="menu-sep"></div>
			<!--		<div onclick="openProcessDef()">Open</div>-->
			<div iconCls="icon-save" onclick="saveProcessDef()">保存</div>
			<div onclick="exportProcessDef(this)">导出</div>
			<!--		<div class="menu-sep"></div>-->
			<!--		<div>-->
			<!--			<span>Toolbar</span>-->
			<!--			<div style="width:150px;">-->
			<!--				<div>Address</div>-->
			<!--				<div>Link</div>-->
			<!--				<div>Navigation Toolbar</div>-->
			<!--				<div>Bookmark Toolbar</div>-->
			<!--				<div class="menu-sep"></div>-->
			<!--				<div>New Toolbar...</div>-->
			<!--			</div>-->
			<!--		</div>-->
			<!--		<div iconCls="icon-remove">Delete</div>-->
			<!--		<div>Select All</div>-->
		</div>
		<div id="mm3" style="width:150px;">
			<div>帮助</div>
			<div class="menu-sep"></div>
			<div>关于</div>
		</div>
	</div>
	<div region="west" split="true" iconCls="palette-icon" title="控制板" style="width:180px;">
		<div class="easyui-accordion" fit="true" border="false">
			<!--<div id="connection" title="Connection" iconCls="palette-menu-icon" class="palette-menu">
				<a href="##" class="easyui-linkbutton" plain="true" iconCls="sequence-flow-icon">SequenceFlow</a>
			<br/>
			</div>-->
			<div id="event" title="事件" iconCls="palette-menu-icon" class="palette-menu">
				<a href="##" class="easyui-linkbutton" plain="true" iconCls="start-event-icon" iconImg="/resources/designer/object/icons/type.startevent.none.png" wfModel="Start">Start</a> <br /> <a href="##" class="easyui-linkbutton" plain="true" iconCls="end-event-icon" iconImg="/resources/designer/object/icons/type.endevent.none.png" wfModel="End">End</a> <br />
			</div>
			<div id="task" title="任务" iconCls="palette-menu-icon" selected="true" class="palette-menu">
				<a href="##" class="easyui-linkbutton" plain="true" iconCls="user-task-icon" wfModel="UserTask">User Task</a> <br /> <a href="##" class="easyui-linkbutton" plain="true" iconCls="manual-task-icon" wfModel="ManualTask">Manual Task</a> <br /> <a href="##" class="easyui-linkbutton" plain="true" iconCls="service-task-icon" wfModel="ServiceTask">Service Task</a> <br /> <a href="##" class="easyui-linkbutton" plain="true" iconCls="script-task-icon" wfModel="ScriptTask">Script Task</a> <br /> <a href="##" class="easyui-linkbutton" plain="true" iconCls="mail-task-icon" wfModel="MailTask">Mail Task</a> <br /> <a href="##" class="easyui-linkbutton" plain="true" iconCls="receive-task-icon" wfModel="ReceiveTask">Receive Task</a> <br /> <a href="##" class="easyui-linkbutton" plain="true"
					iconCls="business-rule-task-icon" wfModel="BusinessRuleTask">Business Rule Task</a> <br /> <a href="##" class="easyui-linkbutton" plain="true" iconCls="callactivity-icon" wfModel="CallActivity">CallActivity</a> <br />
			</div>
			<div id="container" title="容器" iconCls="palette-menu-icon" class="palette-menu">
				<a href="##" class="easyui-linkbutton" plain="true" iconCls="subprocess-icon">SubProcess</a> <br />
			</div>
			<div id="gateway" title="分支" iconCls="palette-menu-icon" class="palette-menu">
				<a href="##" class="easyui-linkbutton" plain="true" iconCls="parallel-gateway-icon" wfModel="ParallelGateway" iconImg="/resources/designer/object/icons/type.gateway.parallel.png">ParallelGateway</a> <br /> <a href="##" class="easyui-linkbutton" plain="true" iconCls="exclusive-gateway-icon" wfModel="ExclusiveGateway" iconImg="/resources/designer/object/icons/type.gateway.exclusive.png">ExclusiveGateway</a> <br />
			</div>
			<div id="boundary-event" title="边界事件" iconCls="palette-menu-icon" class="palette-menu">
				<a href="##" class="easyui-linkbutton" plain="true" iconCls="timer-boundary-event-icon">TimerBoundaryEvent</a> <br /> <a href="##" class="easyui-linkbutton" plain="true" iconCls="error-boundary-event-icon">ErrorBoundaryEvent</a> <br />
			</div>
		</div>
	</div>
	<div id="process-panel" region="center" split="true" iconCls="process-icon" title="流程">
		<div id="process-definition-tab">
			<div id="designer-area" title="图表" style="POSITION: absolute;width:100%;height:100%;padding: 0;border: none;overflow:auto;">
				<div id="paintarea" style="POSITION: absolute;WIDTH: 3000px; HEIGHT: 3000px"></div>
			</div>
			<div id="xml-area" title="XML" style="width:100%;height:100%;overflow:hidden;overflow-x:hidden;overflow-y:hidden;">
				<textarea id="descriptorarea" rows="38" style="width: 100%;height:100%;padding: 0;border: none;" readonly="readonly"></textarea>
			</div>
		</div>
	</div>
	<div id="properties-panel" region="east" split="true" iconCls="properties-icon" title="属性" style="width:400px;"></div>
	<!-- toolbar -->
	<!-- task context menu -->
	<div id="task-context-menu" class="easyui-menu" style="width:120px;">
		<div id="properties-task-context-menu" iconCls="properties-icon">属性</div>
		<div id="delete-task-context-menu" iconCls="icon-remove">删除</div>
	</div>
	<!-- form configuration window -->
	<div id="form-win" title="表单配置" style="width:750px;height:500px;"></div>
	<!-- listener configuration window -->
	<div id="listener-win" title="监听配置" style="width:750px;height:500px;"></div>
	<!-- candidate configuration window -->
	<div id="task-candidate-win" style="width:750px;height:500px;"></div>
	<script type="text/javascript">
		createCanvas(false);
	</script>
</body>
</html>
