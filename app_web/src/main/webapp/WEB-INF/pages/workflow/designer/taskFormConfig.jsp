<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	var formValuesEditCount = 0;
	jq(function() {
		_form_property_type = jq('#propertyType').combobox({
			editable : false
		});
		_form_property_readable = jq('#readable').combobox({
			editable : false
		});
		_form_property_writable = jq('#writable').combobox({
			editable : false
		});
		_form_property_required = jq('#required').combobox({
			editable : false
		});
		_task_form_values_dg = jq('#task-form-values-list').datagrid({
			singleSelect : true,
			width : 600,
			height : 300,
			iconCls : 'icon-edit',
			rownumbers : true,
			striped : true,
			toolbar : [ {
				text : "添加",
				iconCls : 'icon-add',
				handler : function() {
					if (formValuesEditCount > 0) {
						//jq.messager.alert("error","ÓÐ¿É±à¼­µÄµ¥Ôª¸ñ£¬²»ÄÜÌí¼Ó",'error');
						return;
					}
					jq('#task-form-values-list').datagrid('appendRow', {
						id : '',
						name : '',
						action : ''
					});
					var index = jq('#task-form-values-list').datagrid('getRows').length - 1;
					jq('#task-form-values-list').datagrid('beginEdit', index);
				}
			} ],
			onDblClickRow : function(rowIndex, rowData) {
				editFormValue(rowIndex);
			},

			onBeforeEdit : function(index, row) {
				row.editing = true;
				jq(this).datagrid('refreshRow', index);
				formValuesEditCount++;
			},
			onAfterEdit : function(index, row) {
				row.editing = false;
				jq(this).datagrid('refreshRow', index);
				formValuesEditCount--;
			},
			onCancelEdit : function(index, row) {
				row.editing = false;
				jq(this).datagrid('refreshRow', index);
				formValuesEditCount--;
			}
		});

		jq('#formSaveBt').linkbutton({
			iconCls : "icon-save"
		});
		jq('#formCancelBt').linkbutton({
			iconCls : "icon-cancel"
		});
		populateFormProperties();
	});

	function formValuesActionFormatter(value, rowData, rowIndex) {
		var id = rowIndex;
		var s = '<img onclick="saveFormValue(' + id + ')" src="/resources/designer/image/ok.png" title="Save" style="cursor:hand;"/>';
		var c = '<img onclick="cancelFormValue(' + id + ')" src="/resources/designer/image/cancel.png" title="Cancel" style="cursor:hand;"/>';
		var e = '<img onclick="editFormValue(' + id + ')" src="/resources/designer/image/modify.png" title="Update" style="cursor:hand;"/>';
		var d = '<img onclick="deleteFormValue(' + id + ')" src="/resources/designer/image/delete.gif" title="Delete" style="cursor:hand;"/>';
		if (rowData.editing) {
			return s;
		} else {
			return e + '&nbsp;' + d;
		}
	}
	function cancelFormValue(id) {
		_task_form_values_dg.datagrid('cancelEdit', id);
	}
	function editFormValue(id) {
		_task_form_values_dg.datagrid('beginEdit', id);
	}
	function saveFormValue(id) {
		//alert(id);
		_task_form_values_dg.datagrid('endEdit', id);
		//alert(editcount);
	}
	function deleteFormValue(id) {
		_task_form_values_dg.datagrid('deleteRow', id);
		refreshAllFormValues();
	}
	function refreshAllFormValues() {
		var rs = _task_form_values_dg.datagrid('getRows');
		for (var i = 0; i < rs.length; i++) {
			var ri = _task_form_values_dg.datagrid('getRowIndex', rs[i]);
			_task_form_values_dg.datagrid('refreshRow', ri);
		}
	}
	function createNewProperty() {
		var property = new draw2d.UserTask.FormProperty();
		return property;
	}
	function getExsitingProperty(propId) {
		var property = task.getFormProperties(propId);
		return property;
	}
	function getFormValuesGridChangeRows() {
		if (formValuesEditCount > 0) {
			jq.messager.alert("error", "", 'error');
			return null;
		}
		var insertRows = _task_form_values_dg.datagrid('getChanges', 'inserted');
		var updateRows = _task_form_values_dg.datagrid('getChanges', 'updated');
		var deleteRows = _task_form_values_dg.datagrid('getChanges', 'deleted');
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
	function saveTaskFormConfig() {
		if (formPropertyId != "" && formPropertyId != null && formPropertyId != "null" && formPropertyId != "NULL") {
			var prop = getExsitingProperty(formPropertyId);
			var r = updateExistingProperty(prop);
			if (!r)
				return;
		} else {
			var prop = createNewProperty();
			var r = insertNewProperty(prop);
			if (!r)
				return;
		}
		_form_win.window('close');
	}
	function insertNewProperty(prop) {
		prop.id = jq('#propertyId').val();
		prop.name = jq('#propertyName').val();
		prop.type = _form_property_type.combobox('getValue');
		prop.expression = jq('#expressionValue').val();
		prop.variable = jq('#variable').val();
		prop.defaultValue = jq('#default').val();
		prop.datePattern = jq('#datePattern').val();
		prop.readable = _form_property_readable.combobox('getValue');
		prop.writable = _form_property_writable.combobox('getValue');
		prop.required = _form_property_required.combobox('getValue');
		var changesRows = getFormValuesGridChangeRows();
		if (changesRows == null)
			return false;
		var insertRows = changesRows['inserted'];
		if (insertRows.length > 0) {
			for (var i = 0; i < insertRows.length; i++) {
				var fvs = new draw2d.UserTask.FormProperty.FormValue();
				fvs.id = insertRows[i].id;
				fvs.name = insertRows[i].name;
				prop.values.add(fvs);
			}
		}
		task.formProperties.add(prop);
		loadTaskFormProperties();
		return true;
	}
	function updateExistingProperty(prop) {
		prop.id = jq('#propertyId').val();
		prop.name = jq('#propertyName').val();
		prop.type = _form_property_type.combobox('getValue');
		prop.expression = jq('#expressionValue').val();
		prop.variable = jq('#variable').val();
		prop.defaultValue = jq('#default').val();
		prop.datePattern = jq('#datePattern').val();
		prop.readable = _form_property_readable.combobox('getValue');
		prop.writable = _form_property_writable.combobox('getValue');
		prop.required = _form_property_required.combobox('getValue');
		var changesRows = getFormValuesGridChangeRows();
		if (changesRows == null)
			return false;
		var insertRows = changesRows['inserted'];
		var updateRows = changesRows['updated'];
		var deleteRows = changesRows['deleted'];
		if (insertRows.length > 0) {
			for (var i = 0; i < insertRows.length; i++) {
				var fvs = new draw2d.UserTask.FormProperty.FormValue();
				fvs.id = insertRows[i].id;
				fvs.name = insertRows[i].name;
				prop.values.add(fvs);
			}
		}

		if (updateRows.length > 0) {
			for (var k = 0; k < updateRows.length; k++) {
				var fvs = prop.getFormValue(updateRows[k].id);
				fvs.id = updateRows[k].id;
				fvs.name = updateRows[k].name;
			}
		}

		if (deleteRows.length > 0) {
			for (var j = 0; j < deleteRows.length; j++) {
				prop.deleteFormValue(deleteRows[j].id);
			}
		}
		loadTaskFormProperties();
		return true;
	}

	function populateFormProperties() {
		if (formPropertyId != "" && formPropertyId != null && formPropertyId != "null" && formPropertyId != "NULL") {
			var prop = task.getFormProperties(formPropertyId);
			jq('#propertyId').val(prop.id);
			jq('#propertyName').val(prop.name);
			_form_property_type.combobox('setValue', prop.type);
			jq('#expressionValue').val(prop.expression);
			jq('#variable').val(prop.variable);
			jq('#default').val(prop.defaultValue);
			jq('#datePattern').val(prop.datePattern);
			_form_property_readable.combobox('setValue', prop.readable);
			_form_property_writable.combobox('setValue', prop.writable);
			_form_property_required.combobox('setValue', prop.required);
			var fvs = prop.values;
			var _form_values_grid_data = [];
			for (var i = 0; i < fvs.getSize(); i++) {
				var v = {
					id : fvs.get(i).id,
					name : fvs.get(i).name,
					action : ''
				};
				_form_values_grid_data[i] = v;
			}
			_task_form_values_dg.datagrid('loadData', _form_values_grid_data);
		}
	}
	function closeTaskFormPropertyWin() {
		_form_win.window('close');
	}
//-->
</script>
<table>
	<tr>
		<td align="right">唯一标识:</td>
		<td>
			<input type="text" id="propertyId" name="propertyId" size="80" value="" required="required" />
		</td>
	</tr>
	<tr>
		<td align="right">名称:</td>
		<td>
			<input type="text" id="propertyName" name="propertyName" size="80" value="" />
		</td>
	</tr>
	<tr>
		<td align="right">数据类型:</td>
		<td>
			<select id="propertyType" name="propertyType">
				<option value=""></option>
				<option value="string">文本</option>
				<option value="text">大文本</option>
				<option value="long">整数</option>
				<option value="double">小数</option>
				<option value="enum">选择</option>
				<option value="date">日期</option>
				<option value="boolean">真假</option>
				<option value="binary">文件</option>
				<option value="user">用户</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right">表达式:</td>
		<td>
			<input type="text" id="expressionValue" name="expressionValue" size="80" />
		</td>
	</tr>
	<tr>
		<td align="right">Variable:</td>
		<td>
			<input type="text" id="variable" name="variable" size="80" value="" />
		</td>
	</tr>
	<tr>
		<td align="right">默认值:</td>
		<td>
			<input type="text" id="default" name="default" size="80" value="" />
		</td>
	</tr>
	<tr>
		<td align="right">日期格式:</td>
		<td>
			<input type="text" id="datePattern" name="datePattern" size="80" value="" />
		</td>
	</tr>
	<tr>
		<td align="right">阅读权限:</td>
		<td>
			<select id="readable" name="readable">
				<option value=""></option>
				<option value="true">有</option>
				<option value="false">无</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right">编辑权限:</td>
		<td>
			<select id="writable" name="writable">
				<option value=""></option>
				<option value="true">有</option>
				<option value="false">无</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right">是否必填:</td>
		<td>
			<select id="required" name="required">
				<option value=""></option>
				<option value="true">是</option>
				<option value="false">否</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right">可选项:</td>
		<td>
			<table id="task-form-values-list">
				<thead>
					<tr>
						<th field="id" width="200" align="middle" sortable="false" editor="{
						type:'validatebox',
						options:{
						required:true,
						validType:'length[1,100]'
					}}">唯一标识</th>
						<th field="name" width="200" align="middle" sortable="false" editor="{
						type:'validatebox',
						options:{
						required:true,
						validType:'length[1,100]'
					}}">名称</th>
						<th field="action" width="80" align="middle" formatter="formValuesActionFormatter">操作</th>
					</tr>
				</thead>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<a href="##" id="formSaveBt" onclick="saveTaskFormConfig()">保存</a> <a href="##" id="formCancelBt" onclick="closeTaskFormPropertyWin()">取消</a>
		</td>
	</tr>
</table>