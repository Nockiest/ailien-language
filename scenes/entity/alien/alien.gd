class_name Alien
extends Entity
@onready var move_tile =  choose_move_tile()

func choose_move_tile():
	var validation_data =  movementComponent.validation_input_data
#	print(validation_data)
	var self_position = Utils.find_ancestor_by_factor(3, self).position_tracker.get_grid_position()
	var random_tile = $"random-move-chooser".generate_random_valid_coordinate(self_position, validation_data)
	print(random_tile)
	return random_tile
	
func move_alien():
	var self_position = Utils.find_ancestor_by_factor(3, self).position_tracker.get_grid_position()
	movementComponent.process_movement(self_position ,move_tile)
	move_tile =  choose_move_tile()
