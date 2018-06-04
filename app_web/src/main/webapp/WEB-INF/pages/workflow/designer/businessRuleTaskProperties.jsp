<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	//var tid = "";
	var listenerId = "";
	jq(function() {
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
	function listenerActionBt(value, rowData, rowIndex) {
		var id = rowData.id;
		var e = '<img onclick="editListener(\'' + id + '\')" src="/resources/designer/image/edit.gif" title="ÐÞ¸Ä" style="cursor:hand;"/>';
		var d = '<img onclick="deleteListener(\'' + id + '\')" src="/resources/designer/image/delete.gif" title="É¾³ý" style="cursor:hand;"/>';
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
	function saveTaskProperties() {
		saveTaskGeneral();
		saveTaskMainConfig();
		if (typeof saveTaskMultiInstance == 'function')
			saveTaskMultiInstance();
		jq.messager.alert('Info', 'Save Successfully!', 'info');
	}
	function saveTaskMainConfig() {
		task.ruleName = jq('#ruleName').val();
		task.inputVariable = jq('#inputVariable').val();
		task.resultVariable = jq('#resultVariable').val();
		if (jq('#excludeYes').is(':checked'))
			task.excluded = true;
		if (jq('#excludeNo').is(':checked'))
			task.excluded = false;
	}
	function populateTaskProperites() {
		loadTaskMainConfig();
		loadTaskListeners();
	}
	function loadTaskMainConfig() {
		jq('#ruleName').val(task.ruleName);
		jq('#inputVariable').val(task.inputVariable);
		jq('#resultVariable').val(task.resultVariable);
		if (task.excluded)
			jq('#excludeYes').prop(':checked', true);
		else
			jq('#excludeNo').prop(':checked', true);
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
	<div id="task-properties-toolbar-panel" region="north" border="false" style="height:30px;padding:2px;">
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
						<td align="right" style="width:80px">Rule Name:</td>
						<td>
							<input type="text" id="ruleName" name="ruleName" />
						</td>
					</tr>
					<tr>
						<td align="right">Input Variable:</td>
						<td>
							<input type="text" id="inputVariable" name="inputVariable" />
						</td>
					</tr>
					<tr>
						<td align="right">Excluded:</td>
						<td>
							<input type="radio" id="excludeYes" name="excluded" value="true" />Yes <input type="radio" id="excludeNo" name="excluded" value="false" checked />No
						</td>
					</tr>
					<tr>
						<td align="right">Result Variable:</td>
						<td>
							<input type="text" id="resultVariable" name="resultVariable" />
						</td>
					</tr>
				</table>
			</div>
			<div id="listeners" title="监听配置" class="properties-menu">
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