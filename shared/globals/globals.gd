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
		map.get_node("Stats/VBoxContainer/ElapsedTurns").text = "Elapsed Turns: " + str(elapsed_turns)
