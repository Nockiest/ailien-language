class_name Grid
extends Node2D

var grid = []
@export var relic_start_position:Vector2i = Vector2i(0,0)
@export var enemies_starting_positons: Array[Vector2i]
var player_starting_position: Vector2i = Vector2i(round(Globals.grid_size.x/2)-1, Globals.grid_size.y-1)
func _ready():
	initialize_grid()
 
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
			
			# Check if the current position is a relic starting position
			if Vector2i(x, y) == relic_start_position:
				var relic = Globals.relic_scene.instantiate() as Relic
				tile.get_node("ObjectContainerManager").add_child_node(relic)
			elif Vector2i(x, y) == player_starting_position:
				var player = Globals.player_scene.instantiate() as Player
				tile.get_node("ObjectContainerManager").add_child_node(player)
			for enemy_position in enemies_starting_positons:
				if Vector2i(x, y) == enemy_position:
					var enemy = Globals.alien_scene.instantiate() as Alien
					tile.get_node("ObjectContainerManager").add_child_node(enemy)

		grid.append(row)


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
	# Get the current parent
	print("moving ", from_container_coors, to_container_coors)
	var tile = GridUtils.get_tile_from_coors(to_container_coors)
	entity.get_parent().remove_child_node(entity)
	tile.get_node("ObjectContainerManager").add_child_node(entity)
	# Check if the new parent is valid and different from the current parent
 
 
#			entity.owner.remove_child_node(entity)
		
		# Remove from current parent

 
