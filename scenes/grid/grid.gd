class_name Grid
extends Node2D

var grid = []
@export var relic_start_position:Vector2i = Vector2i(0,0)
@export var aliens_amount: int
var player_starting_position: Vector2i = Vector2i(round(Globals.grid_size.x/2)-1, Globals.grid_size.y-1)
func _ready():
	initialize_grid()
	place_entities()
func initialize_grid():
	for y in range(Globals.grid_size.y):
		var row = []
		for x in range(Globals.grid_size.x):
			var tile  
			if Vector2i(x, y) == player_starting_position:
				tile = Globals.start_tile_scene.instantiate() as Area2D
				tile.position = Vector2(x * Globals.tile_size.x  + (x * Globals.grid_gap.x), (y * Globals.tile_size.y) + (y *  Globals.grid_gap.y))
				tile.get_node('GridPositionTracker').set_grid_position(Vector2i(x, y))
				add_child(tile)
				tile.connect("tile_left_clicked",  _on_tile_left_clicked )
			else:
				tile = create_tile(x, y)
			row.append(tile)
		grid.append(row)
func place_entities( ):
	# Place relic
	var relic_tile = GridUtils.get_tile_from_coors(relic_start_position)
	var relic = Globals.relic_scene.instantiate() as Relic
	relic_tile.get_node("ObjectContainerManager").add_child_node(relic)

	# Place player
	var player_tile = GridUtils.get_tile_from_coors(player_starting_position)
	var player = Globals.player_scene.instantiate() as Player
	player_tile.get_node("ObjectContainerManager").add_child_node(player)

	# Place aliens
	var placed_aliens = 0
	var max_attempts = 50  # Adjust the maximum attempts as needed

	while placed_aliens < aliens_amount  :
		var random_position = Vector2i(randi() % Globals.grid_size.x, randi() % Globals.grid_size.y)
		var random_tile = GridUtils.get_tile_from_coors(random_position)
		# Check if the tile is empty (no player, relic, or other alien)
		if abs( random_position.x -player_starting_position.x) <=  2 and abs( random_position.y -player_starting_position.y) <=  2:
			continue
			
		if not random_tile.objectContainerManager.retrieve_container_content().size() > 0:
			var alien = Globals.alien_scene.instantiate() as Alien
			random_tile.get_node("ObjectContainerManager").add_child_node(alien)
			placed_aliens += 1

		# Break the loop if too many attempts are made to avoid infinite loop
		if placed_aliens >= aliens_amount or max_attempts <= 0:
			break

		max_attempts -= 1

func create_tile(x, y):
	var tile = Globals.tile_scene.instantiate() as Area2D
	tile.position = Vector2(x * Globals.tile_size.x  + (x * Globals.grid_gap.x), (y * Globals.tile_size.y) + (y *  Globals.grid_gap.y))
	tile.get_node('GridPositionTracker').set_grid_position(Vector2i(x, y))
 
	add_child(tile)
	tile.connect("tile_left_clicked",  _on_tile_left_clicked )

	return tile

func _on_tile_left_clicked(tile_position):
	if  Globals.selected_tile_coors == tile_position :
		Globals.selected_tile_coors = Vector2i(-1,-1)
	else:
		Globals.selected_tile_coors = tile_position

 
func move_entity_to_validated_position(from_container_coors, to_container_coors: Vector2i, entity: Entity)-> void:
	# this function processes already validated moves
#	print(entity,entity.positionTracker)
	if to_container_coors == from_container_coors:
		printerr("you want to move to the same position as before")
		return
 
	var tile = GridUtils.get_tile_from_coors(to_container_coors)
	entity.get_parent().remove_child_node(entity)
	tile.get_node("ObjectContainerManager").add_child_node(entity)
	# Check if the new parent is valid and different from the current parent
 
 
#			entity.owner.remove_child_node(entity)
		
		# Remove from current parent

 
