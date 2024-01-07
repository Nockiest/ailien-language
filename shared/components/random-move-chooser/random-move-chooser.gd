class_name random_move_chooser
extends Node2D
 
 

func generate_random_valid_coordinate(center: Vector2i, validation_input_data) -> Vector2i:
	var valid_max_movement_range = 2
#	var valid_movement_patterns = []
	var valid_directions = validation_input_data["valid_directions"]
	var random_coordinate: Vector2i
	var max_tries = 500
	var tries = 0
	while tries < max_tries:
		# Generate a random direction and distance within the specified range
		var random_direction: DirectionList.Direction = valid_directions[randi() % valid_directions.size()]
		var distance = valid_max_movement_range

		# Calculate the random coordinate based on the random direction and distance
		var tile_coordinates: Array[Vector2i] = GridUtils.calculate_tiles_in_path(center, random_direction, distance)

		# Choose a random coordinate from the array
		random_coordinate = tile_coordinates[1]

		# Check if the generated coordinate is valid using the provided validation function
		if $MovementValidator.validate_move(center, random_coordinate, validation_input_data) and random_coordinate:
			# Display the new word after choosing a direction
			var selected_tile = GridUtils.get_tile_from_coors(random_coordinate)
#			print(selected_tile, random_coordinate)
			if selected_tile:
				var aliens = get_tree().get_nodes_in_group("alien")
				var  selected_by_other_ailien = false
				for alien in aliens:
					if alien.move_tile == random_coordinate:
						selected_by_other_ailien = true
						break 
				var entities_on_tile =  selected_tile.objectContainerManager. retrieve_container_content()
#				print("x", entities_on_tile, selected_tile, random_coordinate, tile_coordinates)
				if entities_on_tile:
					if selected_tile.objectContainerManager. retrieve_container_content()[0] is Alien or selected_tile.objectContainerManager. retrieve_container_content()[0] is Relic:
						continue
				if not selected_by_other_ailien:
					
					display_new_word(random_direction)
					return random_coordinate

		tries += 1
	return Vector2i(0, 0)

	
func display_new_word(random_direction):
	# Get the alien name and color for the chosen direction
	var alien_name = AilienNames.DirectionAlienNames[random_direction]
	var alien_color = AilienNames.direction_colors[random_direction]

	# Set the text and color in the UI elements
	$MovementAnouncer/ColorRect/MovementName.text = alien_name
	$MovementAnouncer/ColorRect.modulate = alien_color
