draw2d.UserTask=function(configPropCallback){
	draw2d.Task.call(this,configPropCallback);
	this.performerType=null;
	this.dueDate=null;
	this.priority=null;
	this.formKey = null;
	this.expression=null;
	this.isUseExpression=null;
	this.assignee=null;
	this.candidateUsers=new draw2d.ArrayList();
	this.candidateGroups=new draw2d.ArrayList();
	this.formProperties=new draw2d.ArrayList();
	this.taskListeners=new draw2d.ArrayList();
	this.setTitle("User Task");
};
draw2d.UserTask.prototype=new draw2d.Task();
draw2d.UserTask.prototype.type="draw2d.UserTask";
draw2d.UserTask.newInstance=function(userTaskXMLNode){
	var task = new draw2d.UserTask();
	task.id=userTaskXMLNode.attr('id');
	task.taskId=userTaskXMLNode.attr('id');
	task.taskName=userTaskXMLNode.attr('name');
	task.setContent(userTaskXMLNode.attr('name'));
	return task;
};
draw2d.UserTask.prototype.getIconClassName = function(){
	return "user-task-icon";
};
draw2d.UserTask.prototype.getStartElementXML=function(){
	var xml='<userTask ';
	xml=xml+this.getGeneralXML();
	xml=xml+this.getPerformersXML();
	xml=xml+'>\n';
	return xml;
};
draw2d.UserTask.prototype.getEndElementXML=function(){
	var xml = '</userTask>\n';
	return xml;
};
draw2d.UserTask.prototype.getDocumentationXML=function(){
	if(this.documentation==null||this.documentation=='')return '';
	var xml='<documentation>';
	xml=xml+this.documentation;
	xml=xml+'</documentation>';
	return xml;
};
draw2d.UserTask.prototype.getPerformersXML=function(){
	var xml='';
	if(this.isUseExpression&&this.expression!=null&&this.expression!=''){
		if(this.performerType=='assignee'){
			xml=xml+'activiti:assignee="'+this.expression+'" ';
		}else if(this.performerType=='candidateUsers'){
			xml=xml+'activiti:candidateUsers="'+this.expression+'" ';
		}else if(this.performerType=='candidateGroups'){
			xml=xml+'activiti:candidateGroups="'+this.expression+'" ';
		}
	}else{
		if(this.performerType=='assignee'){
			if(this.assignee!=null)
				xml=xml+'activiti:assignee="'+this.assignee.id+'" ';
		}else if(this.performerType=='candidateUsers'&&this.candidateUsers.getSize()>0){
			var line="";
			for(var i=0;i<this.candidateUsers.getSize();i++){
				var user = this.candidateUsers.get(i);
				line+=","+user.id;
			}
			xml=xml+'activiti:candidateUsers="'+line.substring(1)+'" ';
		}else if(this.performerType=='candidateGroups'&&this.candidateGroups.getSize()>0){
			var line="";
			for(var i=0;i<this.candidateGroups.getSize();i++){
				var group = this.candidateGroups.get(i);
				line+=","+group.id;
			}
			xml=xml+'activiti:candidateGroups="'+line.substring(1)+'" ';
		}
	}
	if(this.dueDate!=null&&this.dueDate!=''){
		xml=xml+'activiti:dueDate="'+this.dueDate+'" ';
	}
	if(this.formKey != null && this.formKey != ""){
		xml=xml+'activiti:formKey="'+this.formKey+'" ';
	}
	if(this.priority!=null&&this.priority!=''){
		xml=xml+'activiti:priority="'+this.priority+'" ';
	}
	
	return xml;
};
draw2d.UserTask.prototype.getExtensionElementsXML=function(){
	if(this.listeners.getSize()==0&&this.formProperties.getSize()==0)return '';
	var xml = '<extensionElements>\n';
	xml=xml+this.getFormPropertiesXML();
	xml=xml+this.getListenersXML();
	xml=xml+'</extensionElements>\n';
	return xml;
};
draw2d.UserTask.prototype.getListenersXML=function(){
	var xml = draw2d.Task.prototype.getListenersXML.call(this);
	for(var i=0;i<this.taskListeners.getSize();i++){
		var listener = this.taskListeners.get(i);
		xml=xml+listener.toXML();
	}
	return xml;
};
draw2d.UserTask.prototype.getFormPropertiesXML=function(){
	var xml = '';
	for(var i=0;i<this.formProperties.getSize();i++){
		var formProperty = this.formProperties.get(i);
		xml=xml+formProperty.toXML();
	}
	return xml;
};
draw2d.UserTask.prototype.toXML=function(){
	var xml=this.getStartElementXML();
	xml=xml+this.getDocumentationXML();
	xml=xml+this.getExtensionElementsXML();
	xml=xml+this.getMultiInstanceXML();
	xml=xml+this.getEndElementXML();
	return xml;
};
draw2d.UserTask.prototype.getCandidateUser=function(id){
	for(var i=0;i<this.candidateUsers.getSize();i++){
		var candidate = this.candidateUsers.get(i);
		if(candidate.id===id){
			return candidate;
		}
	}
	return null;
};
draw2d.UserTask.prototype.deleteCandidateUser=function(id){
	var candidate = this.getCandidateUser(id);
	this.candidateUsers.remove(candidate);
};
draw2d.UserTask.prototype.addCandidateUser=function(user){
	if(this.getCandidateUser(user.id)==null)
		this.candidateUsers.add(user);
};
draw2d.UserTask.prototype.getCandidateGroup=function(id){
	for(var i=0;i<this.candidateGroups.getSize();i++){
		var candidate = this.candidateGroups.get(i);
		if(candidate.id===id){
			return candidate;
		}
	}
	return null;
};
draw2d.UserTask.prototype.deleteCandidateGroup=function(id){
	var candidate = this.getCandidateGroup(id);
	this.candidateGroups.remove(candidate);
};
draw2d.UserTask.prototype.addCandidateGroup=function(group){
	if(this.getCandidateGroup(group.id)==null)
		this.candidateGroups.add(group);
};
draw2d.UserTask.prototype.getTaskListener=function(id){
	for(var i=0;i<this.taskListeners.getSize();i++){
		var listener = this.taskListeners.get(i);
		if(listener.getId()=== id){
			return listener;
		}
	}
};
draw2d.UserTask.prototype.deleteTaskListener=function(id){
	var listener = this.getTaskListener(id);
	this.taskListeners.remove(listener);
};
draw2d.UserTask.prototype.addTaskListener=function(listener){
	this.taskListeners.add(listener);
};
draw2d.UserTask.prototype.setTaskListeners=function(listeners){
	this.taskListeners = listeners;
};
draw2d.UserTask.prototype.getFormProperties=function(id){
	for(var i=0;i<this.formProperties.getSize();i++){
		var prop = this.formProperties.get(i);
		if(prop.id== id){
			return prop;
		}
	}
};
draw2d.UserTask.prototype.deleteFormProperties=function(id){
	var prop = this.getFormProperties(id);
	this.formProperties.remove(prop);
};
draw2d.UserTask.prototype.addFormProperties=function(prop){
	this.formProperties.add(prop);
};
draw2d.UserTask.prototype.setFormProperties=function(props){
	this.formProperties = props;
};