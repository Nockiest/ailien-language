class_name MomvementComponent
extends Node

@export var valid_directions: Array[DirectionList.Direction] # ['left', 'right', 'down', 'up', 'up-left', 'up-right', 'down-left', 'down-right']
@export var valid_movement_patterns: Array[Vector2i]  # Define the array with valid vectors
@export var valid_max_movement_range: float = 1  # Define the maximum movement range
signal moved(from, to)
func process_movement(from, to):
 
	
	var validation_input_data = {
		"valid_directions": valid_directions,
		"valid_movement_patterns": valid_movement_patterns,
		"valid_max_movement_range": valid_max_movement_range
	}
	if $MovementValidator.validate_move(from, to, validation_input_data):
		var objects_in_from_tile = GridUtils.get_tile_from_coors(from).objectContainerManager.retrieve_container_content()
		var objects_in_to_tile = GridUtils.get_tile_from_coors(to).objectContainerManager.retrieve_container_content()
		var object_from_tile
		var object_to_tile
		if objects_in_from_tile.size() > 0:
			object_from_tile = objects_in_from_tile[0]
		# Continue with further processing for object_from_tile
		if objects_in_to_tile.size() > 0:
			object_to_tile = objects_in_to_tile[0]
		var res
		if objects_in_to_tile :
			res =resolve_collisions([object_to_tile, object_from_tile])
			print(res,"res")
		if res:
			emit_signal("moved", from,to)
			Utils.find_ancestor_by_factor(4,owner).move_entity_to_validated_position(from, to, owner)
	else:
		print("movement failed")
		
		
func resolve_collisions(entities: Array):
	print("resolving collisions")
	for i in range(entities.size() - 1):
		var current_entity = entities[i]
		var next_entity = entities[i + 1]
		if current_entity.collisionHandler:
			# Call the handle_collision function with the next entity
			var res =current_entity.collisionHandler.handle_collision(next_entity)
			if res == CollisionHandler.collision_reactions.BLOCK_ENTERING_COMPONENT:
				return false
		else:
			print("unit doesn't have a way to resolve conflict")

	return true
#func move_entity_to_new_cell_container(new_entity_container_coors: Vector2i):
#	# this function processes already validated moves
#	if new_entity_container_coors == owner.MovementComponent:
#		printerr("you want to move to the same position as before")
#		return
#	# Get the current parent
#	var current_parent = owner.get_parent()
#	var tiles = get_tree().get_nodes_in_group("tiles")
#	# Check if the new parent is valid and different from the current parent
#	for tile in tiles:
#		if tile.position_tracker.get_grid_position() == new_entity_container_coors:
#			print("found the correct tile ",tile.position_tracker.get_grid_position() , tile.position_tracker.get_grid_position() == new_entity_container_coors)
#			owner.get_parent().remove_child_node(self)
#			tile.get_node("EntityContainer").recieve_child_node(owner)
#
#		# Remove from current parent
#	current_position_tracker.set_grid_position(new_entity_container_coors)
		
 
