extends Node

const tile_scene:= preload("res://scenes/tile/tile.tscn")
const start_tile_scene := preload("res://scenes/tile/start-tile/start-tile.tscn")
const entity_scene := preload("res://scenes/entity/entity.tscn")
const player_scene := preload("res://scenes/entity/player/player.tscn")
const relic_scene := preload("res://scenes/structures/relic.tscn")
const alien_scene := preload("res://scenes/entity/alien/alien.tscn")

var tile_size:= Vector2i(100,100)
var grid_size:= Vector2i(10,10)
var grid_gap:= Vector2i(10,10)

var ailien_forbidden_tiles_to_move: Array[Vector2i]

var hovered_tile_coors:Vector2i= Vector2(-1,-1)
var selected_tile_coors:Vector2i= Vector2(-1,-1)
var selected_entity: Entity:
	set(value):
		if value == selected_entity:
			selected_entity = null
		else:
			selected_entity = value

var elapsed_turns := 0:
	set(value):
		elapsed_turns = value
		var map = get_tree().get_first_node_in_group("map")
		if map:
			map.get_node("CanvasLayer/Stats/VBoxContainer/ElapsedTurns").text = "Elapsed Turns: " + str(elapsed_turns) + " Turns"
var record_turns: int = -1
var game_lost := false

const SAVE_GAME_PATH = "user://savegame.tres"
 
func save_data():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	file.store_var(record_turns)
	file.close()

func load_data():
	if FileAccess.file_exists(SAVE_GAME_PATH):
		var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
		record_turns = file.get_var(record_turns)
		file.close()
