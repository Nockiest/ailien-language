extends Node

const tile_scene: PackedScene = preload("res://scenes/tile/tile.tscn")
const start_tile_scene: PackedScene = preload("res://scenes/tile/start-tile/start-tile.tscn")

const entity_scene: PackedScene = preload("res://scenes/entity/entity.tscn")
const player_scene: PackedScene = preload("res://scenes/entity/player/player.tscn")
const relic_scene: PackedScene = preload("res://scenes/structures/relic.tscn")
const alien_scene: PackedScene = preload("res://scenes/entity/alien/alien.tscn")

var tile_size: Vector2i = Vector2(100,100)
var grid_size: Vector2i = Vector2(3,3)
var grid_gap: Vector2i = Vector2(10,10)



var hovered_tile_coors:Vector2i= Vector2(-1,-1)
var selected_tile_coors:Vector2i= Vector2(-1,-1)
var selected_entity: Entity:
	set(value):
		if value == selected_entity:
			selected_entity = null
		else:
			selected_entity = value
