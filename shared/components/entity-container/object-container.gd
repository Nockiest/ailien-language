class_name ObjectContainer 
extends Node2D 

signal objects_changed(objects)

@export var max_objects: int = 1
# Function to add a child node
func recieve_child_node(child_node:Node):
 
	if    not is_full() :#is_within_limit and is_valid_type
		add_child(child_node)
		emit_signal("objects_changed", get_children())
	else:
		Utils.print_spaced(["Cannot add child node: Type mismatch or maximum number of objects reached", get_children()], true)

func is_full() -> bool:
	return get_child_count() >= max_objects
# Function to remove a child node
func remove_child_node(child_node):
	if child_node in get_children():
		remove_child(child_node)
		emit_signal("objects_changed", get_children())
	else:
		print_debug("Child node not found")
