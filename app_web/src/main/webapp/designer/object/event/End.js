draw2d.End = function(configPropCallback, _url) {
	draw2d.ResizeImage.call(this, _url);
	this.rightInputPort = null;
	this.leftInputPort = null;
	this.topInputPort = null;
	this.bottomInputPort = null;
	this.eventId = 'end';
	this.eventName = 'End';
	this.setDimension(30, 30);
	this.documentation = null;
	this.listeners = new draw2d.ArrayList();
	this.openPropertiesCallBack = configPropCallback;
};
draw2d.End.prototype = new draw2d.Node();
draw2d.End.prototype.type = "draw2d.End";
draw2d.End.prototype.generateId = function() {
	this.id = "endevent" + Sequence.create();
	this.eventId = this.id;
};
draw2d.End.prototype.createHTMLElement = function() {
	var item = draw2d.ResizeImage.prototype.createHTMLElement.call(this);
	return item;
};
draw2d.End.prototype.setDimension = function(w, h) {
	draw2d.ResizeImage.prototype.setDimension.call(this, w, h);
};
draw2d.End.prototype.setWorkflow = function(_505d) {
	draw2d.ResizeImage.prototype.setWorkflow.call(this, _505d);
	if (_505d !== null && this.rightInputPort === null) {
		this.rightInputPort = new draw2d.MyInputPort();
		this.rightInputPort.setName("RightInputPort");
		this.rightInputPort.setWorkflow(_505d);
		this.rightInputPort.setBackgroundColor(new draw2d.Color(115, 115, 245));
		this.addPort(this.rightInputPort, this.width, this.height / 2);
	}
	if (_505d !== null && this.leftInputPort === null) {
		this.leftInputPort = new draw2d.MyInputPort();
		this.leftInputPort.setName("leftInputPort");
		this.leftInputPort.setWorkflow(_505d);
		this.leftInputPort.setBackgroundColor(new draw2d.Color(115, 115, 245));
		this.addPort(this.leftInputPort, 0, this.height / 2);
	}
	if (_505d !== null && this.topInputPort === null) {
		this.topInputPort = new draw2d.MyInputPort();
		this.topInputPort.setName("RightInputPort");
		this.topInputPort.setWorkflow(_505d);
		this.topInputPort.setBackgroundColor(new draw2d.Color(115, 115, 245));
		this.addPort(this.topInputPort, this.width / 2, 0);
	}
	if (_505d !== null && this.bottomInputPort === null) {
		this.bottomInputPort = new draw2d.MyInputPort();
		this.bottomInputPort.setName("RightInputPort");
		this.bottomInputPort.setWorkflow(_505d);
		this.bottomInputPort.setBackgroundColor(new draw2d.Color(115, 115, 245));
		this.addPort(this.bottomInputPort, this.width / 2, this.height);
	}
};
draw2d.End.prototype.getContextMenu = function() {
	if (this.workflow.disabled)
		return null;
	var menu = new draw2d.ContextMenu(100, 50);
	var data = {
		event : this
	};
	menu.appendMenuItem(new draw2d.ContextMenuItem("Properties", "properties-icon", data, function(x, y) {
		var data = this.getData();
		var event = data.event;
		var tid = event.getId();
		if (typeof openTaskProperties != "undefined") {
			openTaskProperties(tid);
		}
	}));

	return menu;
};
draw2d.End.prototype.toXML = function() {
	var xml = '<endEvent id="' + this.eventId + '" name="' + this.eventName + '">\n';
	xml += this.getDocumentationXML();
	xml += this.getExtensionElementsXML();
	xml += '</endEvent>\n';
	return xml;
};
draw2d.End.prototype.toBpmnDI = function() {
	var w = this.getWidth();
	var h = this.getHeight();
	var x = this.getAbsoluteX();
	var y = this.getAbsoluteY();
	var xml = '<bpmndi:BPMNShape bpmnElement="' + this.eventId + '" id="BPMNShape_' + this.eventId + '">\n';
	xml = xml + '<omgdc:Bounds height="' + h + '" width="' + w + '" x="' + x + '" y="' + y + '"/>\n';
	xml = xml + '</bpmndi:BPMNShape>\n';
	return xml;
};
draw2d.End.prototype.onDoubleClick = function() {
	if (typeof this.openPropertiesCallBack == "function") {
		this.openPropertiesCallBack(this);
	}
};

draw2d.End.prototype.getListener = function(id) {
	for (var i = 0; i < this.listeners.getSize(); i++) {
		var listener = this.listeners.get(i);
		if (listener.getId() === id) {
			return listener;
		}
	}
};

draw2d.End.prototype.deleteListener = function(id) {
	var listener = this.getListener(id);
	this.listeners.remove(listener);
};
draw2d.End.prototype.addListener = function(listener) {
	this.listeners.add(listener);
};
draw2d.End.prototype.setListeners = function(listeners) {
	this.listeners = listeners;
};
draw2d.End.prototype.getListenersXML = function() {
	var xml = '';
	for (var i = 0; i < this.listeners.getSize(); i++) {
		var listener = this.listeners.get(i);
		xml = xml + listener.toXML();
	}
	return xml;
};
draw2d.End.prototype.getExtensionElementsXML = function() {
	if (this.listeners.getSize() == 0)
		return '';
	var xml = '<extensionElements>\n';
	xml = xml + this.getListenersXML();
	xml = xml + '</extensionElements>\n';
	return xml;
};
draw2d.End.prototype.getDocumentationXML = function() {
	if (this.documentation == null || this.documentation == '')
		return '';
	var xml = '<documentation>';
	xml = xml + this.documentation;
	xml = xml + '</documentation>';
	return xml;
};