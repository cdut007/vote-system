<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	//var tid = "";
	//var task = workflow.getFigure(tid);
	var listenerId = "";
	var formPropertyId = "";
	jq(function() {
		jq('#performerType').combobox({
			editable : false,
			onChange : function(newValue, oldValue) {
				switchTaskCandidatesList(newValue);
			}
		});
		jq(":radio[name='useExpression']").change(function() {
			switchIsExpression(this);
			if (this.value == "false") {
				switchTaskCandidatesList(jq('#performerType').combobox("getValue"));
			}
		});
		_form_win = jq('#form-win').window({
			//href:'${pageContext.request.contextPath}/wf/procdef/procdef!forTaskListenerConfig.action',   
			closed : true,
			//cache:false,
			draggable : true,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			modal : true,
			shadow : true
		});
		_listener_win = jq('#listener-win').window({
			//href:'${pageContext.request.contextPath}/wf/procdef/procdef!forTaskListenerConfig.action',   
			closed : true,
			//cache:false,
			draggable : true,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			modal : true,
			shadow : true
		});
		jq('#task-listeners-list').datagrid({
			title : "Task Listeners",
			//url:'${pageContext.request.contextPath}/wf/procdef/procdef!search.action',//å è½½è¡¨æ ¼æ°æ®çURL
			singleSelect : true,
			//width:500,
			height : 300,
			//idField:'id',
			//pagination:true,
			//pageSize:15,
			//pageNumber:1,
			//pageList:[10,15],
			rownumbers : true,
			//sortName:'id',
			//sortOrder:'asc',
			striped : true,
			toolbar : [ {
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					_listener_win.window('open');
					//_listener_frame.src="";
					_listener_win.window('refresh', '${pageContext.request.contextPath}/workflow/designer/taskListenerConfig?t=' + new Date().getTime());
					//alert(_listener_frame.document.body.innerHTML);
				}
			} ]
		});
		jq('#execution-listeners-list').datagrid({
			title : "Execution Listeners",
			//url:'${pageContext.request.contextPath}/wf/procdef/procdef!search.action',//å è½½è¡¨æ ¼æ°æ®çURL
			singleSelect : true,
			//width:500,
			height : 300,
			//idField:'id',
			//pagination:true,
			//pageSize:15,
			//pageNumber:1,
			//pageList:[10,15],
			rownumbers : true,
			//sortName:'id',
			//sortOrder:'asc',
			striped : true,
			toolbar : [ {
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					_listener_win.window('open');
					//_listener_frame.src="";
					_listener_win.window('refresh', '${pageContext.request.contextPath}/workflow/designer/executionListenerConfig?t=' + new Date().getTime());
					//alert(_listener_frame.document.body.innerHTML);
				}
			} ]
		});
		jq('#task-form-properties-list').datagrid({
			//title:"Listener",
			//url:'${pageContext.request.contextPath}/wf/procdef/procdef!search.action',//å è½½è¡¨æ ¼æ°æ®çURL
			singleSelect : true,
			//width:500,
			height : 300,
			fit:true,
			//idField:'id',
			//pagination:true,
			//pageSize:15,
			//pageNumber:1,
			//pageList:[10,15],
			rownumbers : true,
			//sortName:'id',
			//sortOrder:'asc',
			striped : true,
			toolbar : [ {
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					formPropertyId = "";
					_form_win.window('open');
					_form_win.window('refresh', '${pageContext.request.contextPath}/workflow/designer/taskFormConfig?t=' + new Date().getTime());
				}
			} ]
		});
		task_candidate_panel = jq('#task-candidate-panel').panel({
			border : false,
			//minimized:true,
			height : 450
		//width:
		//fit:true
		});
		populateTaskProperites();
		//switchTaskCandidatesList(jq('#performerType').combobox('getValue'));
	});
	function switchIsExpression(obj) {
		if (obj.value == 'true') {
			jq('#expressionTr').show();
			task_candidate_panel.panel("close");
		} else if (obj.value == 'false') {
			jq('#expressionTr').hide();
			var performerType = jq('#performerType').combobox('getValue');
			task_candidate_panel.panel("open");
			if (performerType == 'candidateUsers') {
				task_candidate_panel.panel("refresh", "${pageContext.request.request.contextPath}/workflow/designer/candidateUsersConfig?t=" + new Date().getTime());
			} else if (performerType == 'candidateGroups') {
				task_candidate_panel.panel("refresh", "${pageContext.request.request.contextPath}/workflow/designer/candidateGroupsConfig?t=" + new Date().getTime());
			}
		}
	}
	function switchTaskCandidatesList(performerType) {
		if (jq('#nonExpression').prop('checked')) {
			if (performerType == 'assignee') {
				task_candidate_panel.panel("refresh", "${pageContext.request.contextPath}/workflow/designer/assigneeConfig?t=" + new Date().getTime());
			} else if (performerType == 'candidateUsers') {
				task_candidate_panel.panel("refresh", "${pageContext.request.contextPath}/workflow/designer/candidateUsersConfig?t=" + new Date().getTime());
			} else if (performerType == 'candidateGroups') {
				task_candidate_panel.panel("refresh", "${pageContext.request.contextPath}/workflow/designer/candidateGroupsConfig?t=" + new Date().getTime());
			}
		}
	}
	function executionListenerActionBt(value, rowData, rowIndex) {
		var id = rowData.id;
		var e = '<img onclick="editListener(\'' + id + '\')" src="/resources/designer/image/edit.gif" title="' + "编辑" + '" style="cursor:hand;"/>';
		var d = '<img onclick="deleteListener(\'' + id + '\')" src="/resources/designer/image/delete.gif" title="' + "删除" + '" style="cursor:hand;"/>';
		return e + '&nbsp;' + d;
	}
	function taskListenerActionBt(value, rowData, rowIndex) {
		var id = rowData.id;
		var e = '<img onclick="editTaskListener(\'' + id + '\')" src="/resources/designer/image/edit.gif" title="' + "编辑" + '" style="cursor:hand;"/>';
		var d = '<img onclick="deleteTaskListener(\'' + id + '\')" src="/resources/designer/image/delete.gif" title="' + "删除" + '" style="cursor:hand;"/>';
		return e + '&nbsp;' + d;
	}
	function editListener(id) {
		listenerId = id;
		_listener_win.window('open');
		_listener_win.window('refresh', '${pageContext.request.request.contextPath}/workflow/designer/executionListenerConfig?t=' + new Date().getTime());
	}
	function deleteListener(id) {
		task.deleteListener(id);
		loadTaskListeners();
	}
	function editTaskListener(id) {
		listenerId = id;
		_listener_win.window('open');
		_listener_win.window('refresh', '${pageContext.request.request.contextPath}/workflow/designer/taskListenerConfig?t=' + new Date().getTime());
	}
	function deleteTaskListener(id) {
		task.deleteTaskListener(id);
		loadTaskListeners();
	}
	function formActionBt(value, rowData, rowIndex) {
		var id = rowData.id;
		var e = '<img onclick="editForm(\'' + id + '\')" src="/resources/designer/image/edit.gif" title="' + "编辑" + '" style="cursor:hand;"/>';
		var d = '<img onclick="deleteForm(\'' + id + '\')" src="/resources/designer/image/delete.gif" title="' + "删除" + '" style="cursor:hand;"/>';
		return e + '&nbsp;' + d;
	}
	function editForm(id) {
		formPropertyId = id;
		_form_win.window('open');
		_form_win.window('refresh', '${pageContext.request.contextPath}/workflow/designer/taskFormConfig?t=' + new Date().getTime());
	}
	/***
	 * 删除formProperty
	 **/
	function deleteForm(id) {
		formPropertyId = "";
		task.deleteFormProperties(id);
		loadTaskFormProperties();
	}
	function saveTaskProperties() {
		saveTaskGeneral();
		if (typeof saveTaskMultiInstance == 'function')
			saveTaskMultiInstance();
		task.performerType = jq('#performerType').combobox('getValue');
		task.expression = jq('#expression').val();
		task.isUseExpression = jq('#isExpression').is(':checked');
		task.formKey = jq('#formKey').val();
		task.dueDate = jq('#dueDate').val();
		task.priority = jq('#priority').val();
		task.documentation = jq('#documentation').val();
		jq.messager.alert('系统提示', '保存成功!', 'info');
	}
	function populateTaskProperites() {
		//jq('#id').val(task.taskId);
		//jq('#name').val(task.taskName);
		jq(":radio[name='useExpression'][value='" + (task.isUseExpression ? "true" : "false") + "']").prop("checked", true);
		jq('#performerType').combobox('setValue', task.performerType);
		if (task.isUseExpression) {
			jq('#expressionTr').show();
			jq('#expression').val(task.expression);
		} else {
			jq('#expressionTr').hide();
		}
		jq('#formKey').val(task.formKey);
		jq('#dueDate').val(task.dueDate);
		jq('#priority').val(task.priority);
		jq('#documentation').val(task.documentation);
		loadTaskListeners();
		loadTaskFormProperties();
	}
	function loadTaskListeners() {
		var listeners = task.listeners;
		var listener_grid_rows = [];
		//alert(listeners.getSize());
		for (var i = 0; i < listeners.getSize(); i++) {
			var listener = listeners.get(i);
			var nlistener = {
				id : listener.getId(),
				listenerImplimentation : listener.getServiceImplementation(),
				type : listener.serviceType,
				event : listener.event,
				fields : listener.getFieldsString(),
				action : ''
			};
			listener_grid_rows[i] = nlistener;
		}
		//alert(listener_grid_rows);
		var listener_grid_data = {
			total : listeners.getSize(),
			rows : listener_grid_rows
		};
		jq('#execution-listeners-list').datagrid('loadData', listener_grid_data);

		var taskListeners = task.taskListeners;
		var task_listener_grid_rows = [];
		//alert(listeners.getSize());
		for (var i = 0; i < taskListeners.getSize(); i++) {
			var listener = taskListeners.get(i);
			var nlistener = {
				id : listener.getId(),
				listenerImplimentation : listener.getServiceImplementation(),
				type : listener.serviceType,
				event : listener.event,
				fields : listener.getFieldsString(),
				action : ''
			};
			task_listener_grid_rows[i] = nlistener;
		}
		//alert(listener_grid_rows);
		var task_listener_grid_data = {
			total : taskListeners.getSize(),
			rows : task_listener_grid_rows
		};
		jq('#task-listeners-list').datagrid('loadData', task_listener_grid_data);
	}
	function loadTaskFormProperties() {
		var props = task.formProperties;
		var prop_grid_rows = [];
		//alert(listeners.getSize());
		for (var i = 0; i < props.getSize(); i++) {
			var prop = props.get(i);
			var nprop = {
				id : prop.id,
				name : prop.name,
				type : prop.type,
				expression : prop.expression,
				variable : prop.variable,
				defaultValue : prop.defaultValue,
				datePattern : prop.datePattern,
				readable : prop.readable,
				writable : prop.writable,
				required : prop.required,
				formValues : prop.getValuesString(),
				action : ''
			};
			prop_grid_rows[i] = nprop;
		}
		//alert(listener_grid_rows);
		var prop_grid_data = {
			total : props.getSize(),
			rows : prop_grid_rows
		};
		jq('#task-form-properties-list').datagrid('loadData', prop_grid_data);
	}
//-->
</script>
<div id="task-properties-layout" class="easyui-layout" fit="true">
	<div id="task-properties-toolbar-panel" region="north" border="false" style="height:30px;padding:2px;">
		<a href="##" id="sb2" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="saveTaskProperties()">保存</a>
	</div>
	<div id="task-properties-panel" region="center" border="true">
		<div id="task-properties-accordion" class="easyui-accordion" fit="true" border="false">
			<div id="general" title="基本配置" selected="true" class="properties-menu">
				<jsp:include page="taskGeneral.jsp" />
			</div>
			<div id="main-config" title="主配置" class="properties-menu" style="padding:5px;">
				<table id="main-properties">
					<tr>
						<td align="right" style="width:80px">执行者类型:</td>
						<td>
							<select id="performerType" name="performerType" style="width:120px">
								<option value="assignee">委托人</option>
								<option value="candidateUsers">候选人</option>
								<option value="candidateGroups">候选角色</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">使用表达式:</td>
						<td>
							<input type="radio" id="isExpression" name="useExpression" value="true" />Yes 
							<input type="radio" id="nonExpression" name="useExpression" value="false" checked="checked" />No
						</td>
					</tr>
					<tr id="expressionTr" style="display:none;">
						<td align="right">表达式:</td>
						<td>
							<input type="text" id="expression" name="expression" />
						</td>
					</tr>
					<tr>
						<td align="right">引用表单:</td>
						<td>
							<input type="text" id="formKey" name="formKey" value="" />
						</td>
					</tr>
					<tr>
						<td align="right">执行期限:</td>
						<td>
							<input type="text" id="dueDate" name="dueDate" value="" />
						</td>
					</tr>
					<tr>
						<td align="right">优先级:</td>
						<td>
							<input type="text" id="priority" name="priority" value="" />
						</td>
					</tr>
					<tr>
						<td align="right">说明:</td>
						<td>
							<textarea id="documentation" name="documentation" cols="20" rows="5"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="task-candidate-panel"></div>
						</td>
					</tr>
				</table>
			</div>
			<div id="formProperties" title="表单配置" style="padding:5px;">
				<table id="task-form-properties-list">
					<thead>
						<tr>
							<th field="id" width="100" align="middle" sortable="false">唯一标识</th>
							<th field="name" width="100" align="middle" sortable="false">名称</th>
							<th field="type" width="100" align="middle" sortable="false">数据类型</th>
							<th field="expression" width="100" align="middle" sortable="false">表达式</th>
							<th field="variable" width="100" align="middle" sortable="false">Variable</th>
							<th field="defaultValue" width="100" align="middle" sortable="false">默认值</th>
							<th field="datePattern" width="100" align="middle" sortable="false">日期格式</th>
							<th field="readable" width="100" align="middle" sortable="false">查看权限</th>
							<th field="writable" width="100" align="middle" sortable="false">编辑权限</th>
							<th field="required" width="100" align="middle" sortable="false">是否必填</th>
							<th field="formValues" width="100" align="middle" sortable="false">可选值</th>
							<th field="action" width="100" align="middle" formatter="formActionBt">操作</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="listeners" title="监听配置" style="padding:5px;">
				<table id="task-listeners-list">
					<thead>
						<tr>
							<th field="listenerImplimentation" width="200" align="middle" sortable="false">Listener Implimentation</th>
							<th field="type" width="70" align="middle" sortable="false">Type</th>
							<th field="event" width="70" align="middle" sortable="false">Event</th>
							<th field="fields" width="100" align="middle">Fields</th>
							<th field="action" width="100" align="middle" formatter="taskListenerActionBt">Action</th>
						</tr>
					</thead>
				</table>
				<table id="execution-listeners-list">
					<thead>
						<tr>
							<th field="listenerImplimentation" width="200" align="middle" sortable="false">Listener Implimentation</th>
							<th field="type" width="70" align="middle" sortable="false">Type</th>
							<th field="event" width="70" align="middle" sortable="false">Event</th>
							<th field="fields" width="100" align="middle">Fields</th>
							<th field="action" width="100" align="middle" formatter="executionListenerActionBt">Action</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="multi-instance" title="多实例配置" class="properties-menu">
				<jsp:include page="taskMultiInstance.jsp" />
			</div>
		</div>
	</div>
</div>