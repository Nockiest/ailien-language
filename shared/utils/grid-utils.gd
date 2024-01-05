extends Node
func calculate_tiles_in_path(position: Vector2i, direction: DirectionList.Direction, squares: int, goal_position: Vector2i) -> Array[Vector2i]:
	var tile_coordinates: Array[Vector2i] = []

	var current_position: Vector2i = position

	# Update the tile coordinates based on the direction until reaching the goal position
	while current_position != goal_position:
		# Add the current position to the array
		tile_coordinates.append(current_position)

		# Update the current position based on the direction
		match direction:
			DirectionList.Direction.LEFT:
				current_position.x -= 1
			DirectionList.Direction.RIGHT:
				current_position.x += 1
			DirectionList.Direction.UP:
				current_position.y -= 1
			DirectionList.Direction.DOWN:
				current_position.y += 1
			DirectionList.Direction.UP_LEFT:
				current_position.x -= 1
				current_position.y -= 1
			DirectionList.Direction.UP_RIGHT:
				current_position.x += 1
				current_position.y -= 1
			DirectionList.Direction.DOWN_LEFT:
				current_position.x -= 1
				current_position.y += 1
			DirectionList.Direction.DOWN_RIGHT:
				current_position.x += 1
				current_position.y += 1

		# Break the loop if the maximum number of squares is reached
		if tile_coordinates.size() >= squares:
			break

	return tile_coordinates
	
func get_movement_direction(from, to) -> DirectionList.Direction:
	var direction: DirectionList.Direction
	var movement_vector = to - from
	if movement_vector.x < 0:
		direction = DirectionList.Direction.LEFT
#		print("x1")
	elif movement_vector.x > 0:
		direction = DirectionList.Direction.RIGHT
#		print("x2")

	if movement_vector.y < 0:
		direction = DirectionList.Direction.UP
#		print("x3")
	elif movement_vector.y > 0:
		direction = DirectionList.Direction.DOWN
#		print("x4")

	# Check for diagonal movements
	if movement_vector.x != 0 and movement_vector.y != 0:
		if movement_vector.x < 0 and movement_vector.y < 0:
			direction = DirectionList.Direction.UP_LEFT
#			print("x5")
		elif movement_vector.x > 0 and movement_vector.y < 0:
			direction = DirectionList.Direction.UP_RIGHT
#			print("x6")
		elif movement_vector.x < 0 and movement_vector.y > 0:
			direction = DirectionList.Direction.DOWN_LEFT
#			print("x7")
		elif movement_vector.x > 0 and movement_vector.y > 0:
			direction = DirectionList.Direction.DOWN_RIGHT
#			print("x8")
	return direction

# Function to find the tile node using coordinates
func get_tile_from_coors(coordinates: Vector2i) -> Node:
	var tile_nodes = get_tree().get_nodes_in_group("tiles")

	# Loop through tile nodes to find the one with the matching coordinates
	for tile_node in tile_nodes:
		if tile_node.position_tracker.get_grid_position() == coordinates:
			return tile_node

	return null
 
