extends Reference

class_name SubscriptionList

class EventListener:
	var event: String
	var callback_func: String

var subscriptions: Array = []
var event_manager
var listener_obj_id: int 
var listener_obj: Node

func _init(manager: Node, listener: Object):
	event_manager = manager
	listener_obj_id = listener.get_instance_id()
	listener_obj = instance_from_id(listener_obj_id)
	
func _notification(what):
	if what == NOTIFICATION_PREDELETE and is_instance_valid(event_manager):
		for entry in subscriptions:
			event_manager.remove_event_listener(entry.event, entry.callback_func, listener_obj_id)
		subscriptions.clear()


func add_event_listener(event: String, callback_func: String):
	if event_manager and listener_obj and is_instance_valid(event_manager) and is_instance_valid(listener_obj):
		var has_entry = false
		for entry in subscriptions:
			if entry.event == event and entry.callback_func == callback_func:
				has_entry = true
				break
		
		if not has_entry:
			event_manager.add_event_listener(event, callback_func, listener_obj)
			var new_entry = EventListener.new()
			new_entry.event = event
			new_entry.callback_func = callback_func
			subscriptions.append((new_entry))


func remove_event_listener(event: String, callback_func: String):
	if event_manager and listener_obj and is_instance_valid(event_manager):
		event_manager.remove_event_listener(event, callback_func, listener_obj)
		for i in range(subscriptions.size()):
			var entry = subscriptions[i]
			if entry.event == event and entry.callback_func == callback_func:
				subscriptions.remove(i)
				break
		
		
		
		
