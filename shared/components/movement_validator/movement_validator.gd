class_name MovementtValidator
extends Node

# Function to validate the move
func validate_move(from: Vector2i, to: Vector2i, validation_input_data: Dictionary, objectType:String="Entity") -> bool:
	# Extract data from the validation_input_data dictionary
	var valid_max_movement_range = validation_input_data["valid_max_movement_range"]
	var valid_movement_patterns = validation_input_data["valid_movement_patterns"]
	var valid_directions = validation_input_data["valid_directions"]
	var grid_size = Globals.grid_size
		# Continue with further processing for object_to_tile

	var movement_vector = to - from
	var movement_distance = movement_vector.length()
 
	# Check if movement is within the valid range
	if movement_distance > valid_max_movement_range:
		print("returning false")
		return false

	# Check if the move lies within the grid
	if to.x < 0 or to.y < 0 or to.x >= grid_size.x or to.y >= grid_size.y:
		print("returning false")
		return false
		
	# Check if the movement matches any valid movement pattern
	for pattern in valid_movement_patterns:
		if movement_vector == pattern:
			print("returning true", 1)
			return true

	# Translate the movement vector to a direction string
	var direction = GridUtils.get_movement_direction(to , from)
	# Check if the direction is valid
	print("returning true", 1)
	return direction in valid_directions

func is_tile_empty(destination: Vector2i ) -> bool:
	# Find the tile node using the destination coordinates
	var tile_node = GridUtils.get_tile_from_coors(destination)
	
	# If the tile node is found, ask ObjectContainerManager if it's empty
	if tile_node:
		print( tile_node.get_node("ObjectContainerManager").retrieve_container_content())
		return tile_node.get_node("ObjectContainerManager").retrieve_container_content().size() == 0

	
	return false
 

# Function to get the movement direction string
# Function to get the movement direction string
 
