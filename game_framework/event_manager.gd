extends Node

var listeners = {}

class ListenerInfo:
	var callback
	var obj: Node
	var func_name:String
	var obj_id: int


func add_event_listener(event: String, callback_func: String, listener_obj: Node):
	assert(listener_obj && is_instance_valid(listener_obj) && listener_obj.has_method(callback_func))
	
	if not listeners.has(event):
		listeners[event] = []
	
	var new_info = ListenerInfo.new()
	new_info.callback = funcref(listener_obj, callback_func)
	new_info.func_name = callback_func
	new_info.obj_id = listener_obj.get_instance_id()
	
	listeners[event].append(new_info)

func remove_event_listener(event: String, callback_func: String, listener_obj):
	var listener_id: int
	if listener_obj is int:
		listener_id = listener_obj
	else:
		if !listener_obj || !is_instance_valid(listener_obj) || !(listener_obj is Node):
			return;
		listener_id = listener_obj.get_instance_id();
	
	if listeners.has(event):
		var listener_list : Array = listeners[event];
		for i in range(listener_list.size()):
			if listener_list[i].obj_id == listener_id && listener_list[i].func_name == callback_func:
				listener_list.remove(i);
				break;

func dispitch_event(event: String, args = {}):
	if listeners.has(event):
		for info in listeners[event]:
			var listener_info : ListenerInfo = info;
			if listener_info.obj.is_inside_tree():
				if args is Dictionary && args.empty():
					listener_info.callback.call_func()
				else:
					listener_info.callback.call_func(args)
	




