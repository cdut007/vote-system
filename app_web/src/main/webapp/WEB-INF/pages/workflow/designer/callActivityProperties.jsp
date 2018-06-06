<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	//var tid = "";
	var listenerId = "";
	var inputParamsEditCount = 0;
	var outputParamsEditCount = 0;
	jq(function() {
		_input_params_list = jq('#input-params-list').datagrid({
			//title:"Listener",
			//url:'${pageContext.request.contextPath}/wf/procdef/procdef!search.action',//¼ÓÔØ±í¸ñÊý¾ÝµÄURL
			singleSelect : true,
			width : 500,
			height : 200,
			iconCls : 'icon-edit',
			//fit:true,
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
				text : 'New',
				iconCls : 'icon-add',
				handler : function() {
					if (inputParamsEditCount > 0) {
						jq.messager.alert("error", "ÓÐ¿É±à¼­µÄµ¥Ôª¸ñ£¬²»ÄÜÌí¼Ó!", 'error');
						return;
					}
					jq('#input-params-list').datagrid('appendRow', {
						id : '',
						_source : '',
						sourceExpression : '',
						_target : '',
						action : ''
					});
					var index = jq('#input-params-list').datagrid('getRows').length - 1;
					jq('#input-params-list').datagrid('beginEdit', index);
				}
			} ],

			onDblClickRow : function(rowIndex, rowData) {
				editInputParam(rowIndex);
			},

			onBeforeEdit : function(index, row) {
				row.editing = true;
				jq(this).datagrid('refreshRow', index);
				inputParamsEditCount++;
			},
			onAfterEdit : function(index, row) {
				row.editing = false;
				jq(this).datagrid('refreshRow', index);
				inputParamsEditCount--;
			},
			onCancelEdit : function(index, row) {
				row.editing = false;
				jq(this).datagrid('refreshRow', index);
				inputParamsEditCount--;
			}
		});
		_output_params_list = jq('#output-params-list').datagrid({
			//title:"Listener",
			//url:'${pageContext.request.contextPath}/wf/procdef/procdef!search.action',//¼ÓÔØ±í¸ñÊý¾ÝµÄURL
			singleSelect : true,
			width : 500,
			height : 200,
			iconCls : 'icon-edit',
			//fit:true,
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
				text : 'New',
				iconCls : 'icon-add',
				handler : function() {
					if (outputParamsEditCount > 0) {
						jq.messager.alert("error", "ÓÐ¿É±à¼­µÄµ¥Ôª¸ñ£¬²»ÄÜÌí¼Ó!", 'error');
						return;
					}
					jq('#output-params-list').datagrid('appendRow', {
						id : '',
						_source : '',
						sourceExpression : '',
						_target : '',
						action : ''
					});
					var index = jq('#output-params-list').datagrid('getRows').length - 1;
					jq('#output-params-list').datagrid('beginEdit', index);
				}
			} ],

			onDblClickRow : function(rowIndex, rowData) {
				editOutputParam(rowIndex);
			},

			onBeforeEdit : function(index, row) {
				row.editing = true;
				jq(this).datagrid('refreshRow', index);
				outputParamsEditCount++;
			},
			onAfterEdit : function(index, row) {
				row.editing = false;
				jq(this).datagrid('refreshRow', index);
				outputParamsEditCount--;
			},
			onCancelEdit : function(index, row) {
				row.editing = false;
				jq(this).datagrid('refreshRow', index);
				outputParamsEditCount--;
			}
		});
		_listener_win = jq('#listener-win').window({
			//href:'${pageContext.request.contextPath}/wf/procdef/procdef!forTaskListenerConfig.action',   
			closed : true,
			//cache:false,
			draggable : false,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			modal : true,
			shadow : true
		});
		jq('#task-listeners-list').datagrid({
			title : "Execution Listeners",
			//url:'${pageContext.request.contextPath}/wf/procdef/procdef!search.action',//¼ÓÔØ±í¸ñÊý¾ÝµÄURL
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
				text : 'New',
				iconCls : 'icon-add',
				handler : function() {
					_listener_win.window('open');
					//_listener_frame.src="";
					_listener_win.window('refresh', '${pageContext.request.request.contextPath}/workflow/designer/executionListenerConfig?t=' + new Date().getTime());
					//alert(_listener_frame.document.body.innerHTML);
				}
			} ]
		});

		populateTaskProperites();
	});
	function cancelInputParam(id) {
		_input_params_list.datagrid('cancelEdit', id);
	}
	function editInputParam(id) {
		_input_params_list.datagrid('beginEdit', id);
	}
	function saveInputParam(id) {
		_input_params_list.datagrid('endEdit', id);
	}
	function deleteInputParam(id) {
		_input_params_list.datagrid('deleteRow', id);
		refreshAllInputParams();
	}
	function refreshAllInputParams() {
		var rs = _input_params_list.datagrid('getRows');
		for (var i = 0; i < rs.length; i++) {
			var ri = _input_params_list.datagrid('getRowIndex', rs[i]);
			_input_params_list.datagrid('refreshRow', ri);
		}
	}
	function inputParamsActionFormatter(value, rowData, rowIndex) {
		var id = rowIndex;
		var s = '<img onclick="saveInputParam(' + id + ')" src="/resources/designer//ok.png" title="Save" style="cursor:hand;"/>';
		var c = '<img onclick="cancelInputParam(' + id + ')" src="/resources/designer/image/cancel.png" title="Cancel" style="cursor:hand;"/>';
		var e = '<img onclick="editInputParam(' + id + ')" src="/resources/designer/image/modify.png" title="Update" style="cursor:hand;"/>';
		var d = '<img onclick="deleteInputParam(' + id + ')" src="/resources/designer/image/delete.gif" title="Delete" style="cursor:hand;"/>';
		if (rowData.editing)
			return s;
		else
			return e + '&nbsp;' + d;
	}
	function getInputParamsGridChangeRows() {
		if (inputParamsEditCount > 0) {
			jq.messager.alert("error", "ÇëÏÈ±£´æ¿É±à¼­±í¸ñ£¡", 'error');
			return null;
		}
		var insertRows = _input_params_list.datagrid('getChanges', 'inserted');
		var updateRows = _input_params_list.datagrid('getChanges', 'updated');
		var deleteRows = _input_params_list.datagrid('getChanges', 'deleted');
		var changesRows = {
			inserted : [],
			updated : [],
			deleted : []
		};
		if (insertRows.length > 0) {
			for (var i = 0; i < insertRows.length; i++) {
				changesRows.inserted.push(insertRows[i]);
			}
		}

		if (updateRows.length > 0) {
			for (var k = 0; k < updateRows.length; k++) {
				changesRows.updated.push(updateRows[k]);
			}
		}

		if (deleteRows.length > 0) {
			for (var j = 0; j < deleteRows.length; j++) {
				changesRows.deleted.push(deleteRows[j]);
			}
		}
		return changesRows;
	}
	function saveInputParams() {
		var changesRows = getInputParamsGridChangeRows();
		if (changesRows == null)
			return false;
		var insertRows = changesRows['inserted'];
		var updateRows = changesRows['updated'];
		var deleteRows = changesRows['deleted'];
		if (insertRows.length > 0) {
			for (var i = 0; i < insertRows.length; i++) {
				var param = new draw2d.CallActivity.Parameter.InputParameter();
				param.source = insertRows[i]._source;
				param.sourceExpression = insertRows[i].sourceExpression;
				param.target = insertRows[i]._target;
				task.inputParams.add(param);
			}
		}

		if (updateRows.length > 0) {
			for (var k = 0; k < updateRows.length; k++) {
				var param = task.getInputParam(updateRows[k].id);
				param.source = updateRows[k]._source;
				param.sourceExpression = updateRows[k].sourceExpression;
				param.target = updateRows[k]._target;
			}
		}

		if (deleteRows.length > 0) {
			for (var j = 0; j < deleteRows.length; j++) {
				task.deleteInputParam(deleteRows[j].id);
			}
		}
		return true;
	}
	function cancelOutputParam(id) {
		_output_params_list.datagrid('cancelEdit', id);
	}
	function editOutputParam(id) {
		_output_params_list.datagrid('beginEdit', id);
	}
	function saveOutputParam(id) {
		_output_params_list.datagrid('endEdit', id);
	}
	function deleteOutputParam(id) {
		_output_params_list.datagrid('deleteRow', id);
		refreshAllOutputParams();
	}
	function refreshAllOutputParams() {
		var rs = _output_params_list.datagrid('getRows');
		for (var i = 0; i < rs.length; i++) {
			var ri = _output_params_list.datagrid('getRowIndex', rs[i]);
			_output_params_list.datagrid('refreshRow', ri);
		}
	}
	function outputParamsActionFormatter(value, rowData, rowIndex) {
		var id = rowIndex;
		var s = '<img onclick="saveOutputParam(' + id + ')" src="/resources/designer/image/ok.png" title="Save" style="cursor:hand;"/>';
		var c = '<img onclick="cancelOutputParam(' + id + ')" src="/resources/designer/image/cancel.png" title="Cancel" style="cursor:hand;"/>';
		var e = '<img onclick="editOutputParam(' + id + ')" src="/resources/designer/image/modify.png" title="Update" style="cursor:hand;"/>';
		var d = '<img onclick="deleteOutputParam(' + id + ')" src="/resources/designer/image/delete.gif" title="Delete" style="cursor:hand;"/>';
		if (rowData.editing)
			return s;
		else
			return e + '&nbsp;' + d;
	}
	function getOutputParamsGridChangeRows() {
		if (outputParamsEditCount > 0) {
			jq.messager.alert("error", "ÇëÏÈ±£´æ¿É±à¼­±í¸ñ£¡", 'error');
			return null;
		}
		var insertRows = _output_params_list.datagrid('getChanges', 'inserted');
		var updateRows = _output_params_list.datagrid('getChanges', 'updated');
		var deleteRows = _output_params_list.datagrid('getChanges', 'deleted');
		var changesRows = {
			inserted : [],
			updated : [],
			deleted : []
		};
		if (insertRows.length > 0) {
			for (var i = 0; i < insertRows.length; i++) {
				changesRows.inserted.push(insertRows[i]);
			}
		}

		if (updateRows.length > 0) {
			for (var k = 0; k < updateRows.length; k++) {
				changesRows.updated.push(updateRows[k]);
			}
		}

		if (deleteRows.length > 0) {
			for (var j = 0; j < deleteRows.length; j++) {
				changesRows.deleted.push(deleteRows[j]);
			}
		}
		return changesRows;
	}
	function saveOutputParams() {
		var changesRows = getOutputParamsGridChangeRows();
		if (changesRows == null)
			return false;
		var insertRows = changesRows['inserted'];
		var updateRows = changesRows['updated'];
		var deleteRows = changesRows['deleted'];
		if (insertRows.length > 0) {
			for (var i = 0; i < insertRows.length; i++) {
				var param = new draw2d.CallActivity.Parameter.OutputParameter();
				param.source = insertRows[i]._source;
				param.sourceExpression = insertRows[i].sourceExpression;
				param.target = insertRows[i]._target;
				task.outputParams.add(param);
			}
		}

		if (updateRows.length > 0) {
			for (var k = 0; k < updateRows.length; k++) {
				var param = task.getOutputParam(updateRows[k].id);
				param.source = updateRows[k]._source;
				param.sourceExpression = updateRows[k].sourceExpression;
				param.target = updateRows[k]._target;
			}
		}

		if (deleteRows.length > 0) {
			for (var j = 0; j < deleteRows.length; j++) {
				task.deleteOutputParam(deleteRows[j].id);
			}
		}
		return true;
	}
	function listenerActionBt(value, rowData, rowIndex) {
		var id = rowData.id;
		var e = '<img onclick="editListener(\'' + id + '\')" src="/resources/designer/image/edit.gif" title="ÐÞ¸Ä" style="cursor:hand;"/>';
		var d = '<img onclick="deleteListener(\'' + id + '\')" src="/resources/designer/image/delete.gif" title="É¾³ý" style="cursor:hand;"/>';
		return e + '&nbsp;' + d;
	}
	function editListener(id) {
		_listener_win.window('open');
		_listener_win.window('refresh', '${pageContext.request.request.contextPath}/workflow/designer/executionListenerConfig?t=' + new Date().getTime());
	}
	function deleteListener(id) {
		task.deleteListener(id);
		loadTaskListeners();
	}
	function saveTaskProperties() {
		saveTaskGeneral();
		if (typeof saveTaskMultiInstance == 'function')
			saveTaskMultiInstance();
		var r = saveTaskMainConfig();
		if (r)
			jq.messager.alert('Info', 'Save Successfully!', 'info');
	}
	function saveTaskMainConfig() {
		task.callElement = jq('#callElement').val();
		var r = saveInputParams();
		var p = saveOutputParams();
		return r && p;
	}
	function populateTaskProperites() {
		loadTaskMainConfig();
		loadTaskListeners();
	}
	function loadTaskMainConfig() {
		jq('#callElement').val(task.callElement);
		loadInputParams();
		loadOutputParams();
	}
	function loadInputParams() {
		var params = task.inputParams;
		var params_grid_rows = [];
		for (var i = 0; i < params.getSize(); i++) {
			var param = params.get(i);
			var nparam = {
				id : param.id,
				_source : param.source,
				sourceExpression : param.sourceExpression,
				_target : param.target,
				action : ''
			};
			params_grid_rows[i] = nparam;
		}
		;
		var params_grid_data = {
			total : params.getSize(),
			rows : params_grid_rows
		};
		_input_params_list.datagrid('loadData', params_grid_data);
	}
	function loadOutputParams() {
		var params = task.outputParams;
		var params_grid_rows = [];
		for (var i = 0; i < params.getSize(); i++) {
			var param = params.get(i);
			var nparam = {
				id : param.id,
				_source : param.source,
				sourceExpression : param.sourceExpression,
				_target : param.target,
				action : ''
			};
			params_grid_rows[i] = nparam;
		}
		;
		var params_grid_data = {
			total : params.getSize(),
			rows : params_grid_rows
		};
		_output_params_list.datagrid('loadData', params_grid_data);
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
		;
		//alert(listener_grid_rows);
		var listener_grid_data = {
			total : listeners.getSize(),
			rows : listener_grid_rows
		};
		jq('#task-listeners-list').datagrid('loadData', listener_grid_data);
	}
//-->
</script>
<div id="task-properties-layout" class="easyui-layout" fit="true">
	<div id="task-properties-toolbar-panel" region="north" border="false" style="height:30px;background:#E1F0F2;">
		<a href="##" id="sb2" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="saveTaskProperties()">保存</a>
	</div>
	<div id="task-properties-panel" region="center" border="true">
		<div id="task-properties-accordion" class="easyui-accordion" fit="true" border="false">
			<div id="general" title="基本配置" selected="true" class="properties-menu">
				<jsp:include page="taskGeneral.jsp" />
			</div>
			<div id="mainConfig" title="主配置" class="properties-menu">
				<table id="main-properties">
					<tr>
						<td align="right" style="width:80px">Call Element:</td>
						<td>
							<input type="text" id="callElement" name="callElement" />
						</td>
					</tr>
					<tr>
						<td align="right">Input Parameters:</td>
						<td>
							<div id="input-params-panel">
								<table id="input-params-list">
									<thead>
										<tr>
											<th field="id" hidden="true"></th>
											<th field="_source" width="100" align="middle" sortable="false" editor="{
										type:'validatebox',
										options:{
										required:true,
										validType:'length[1,100]'
									}}">Source</th>
											<th field="sourceExpression" width="100" align="middle" sortable="false" editor="{
										type:'validatebox',
										options:{
										validType:'length[1,100]'
									}}">Source Expression</th>
											<th field="_target" width="100" align="middle" sortable="false" editor="{
										type:'validatebox',
										options:{
										required:true,
										validType:'length[1,100]'
									}}">Target</th>
											<th field="action" width="80" align="middle" formatter="inputParamsActionFormatter">Action</th>
										</tr>
									</thead>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">Output Parameters:</td>
						<td>
							<div id="output-params-panel">
								<table id="output-params-list">
									<thead>
										<tr>
											<th field="id" hidden="true"></th>
											<th field="_source" width="100" align="middle" sortable="false" editor="{
										type:'validatebox',
										options:{
										required:true,
										validType:'length[1,100]'
									}}">Source</th>
											<th field="sourceExpression" width="100" align="middle" sortable="false" editor="{
										type:'validatebox',
										options:{
										validType:'length[1,100]'
									}}">Source Expression</th>
											<th field="_target" width="100" align="middle" sortable="false" editor="{
										type:'validatebox',
										options:{
										required:true,
										validType:'length[1,100]'
									}}">Target</th>
											<th field="action" width="80" align="middle" formatter="outputParamsActionFormatter">Action</th>
										</tr>
									</thead>
								</table>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div id="listeners" title="Listeners" style="overflow: hidden;">
				<table id="task-listeners-list">
					<thead>
						<tr>
							<th field="listenerImplimentation" width="200" align="middle" sortable="false">Listener Implimentation</th>
							<th field="type" width="70" align="middle" sortable="false">Type</th>
							<th field="event" width="70" align="middle" sortable="false">Event</th>
							<th field="fields" width="100" align="middle">Fields</th>
							<th field="action" width="100" align="middle" formatter="listenerActionBt">Action</th>
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