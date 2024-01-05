class_name ObjectContainerManager extends Node2D

 
# Function to receive a node and send it to the appropriate container
func add_child_node(node: Node) -> void:
	$ObjectContainer.recieve_child_node(node)

# Function to retrieve an object from the appropriate container
func retrieve_object(container_type: String, object_name: String) -> Node:
	# Retrieve the object from the container based on the name
	return $ObjectContainer  .retrieve_child_node_by_name(object_name)
	
func is_container_full(container_type: String) -> bool: 
	# Check if the container is empty
	return $ObjectContainer  .is_full()
	
func retrieve_container_content():
	return $ObjectContainer.get_children()
#func select_container_from_string(word:String) -> ObjectContainer:
#	match word:
#		"Entity":
#			return entity_container
#		"Structure":
#			printerr("Currently not supporting structures")
#			return structure_container
#		"Projectile":
#			return projectile_container
#		_:
#			printerr("Unknown container type")
#			return entity_container
