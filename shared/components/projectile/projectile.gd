 
extends Node2D
class_name Projectile 
@export var directionHandler:DirectionHandler
@export var collateral_damage: bool = false # wheter it can damage units when flying to the target
@export var damage:int = 1 # hwo much damage it does in a hit
@export var speed_per_turn:int = 10 # how much distance it covers per turn
var target_location:Vector2 # where will it land

#@onready var shot_origin_coors = get_parent().get_parent().get_node("GridPositionTracker").get_grid_position()
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("projectile scene added")
	pass # Replace with function body.


 
func move_to_target():
	var moving_through_tiles = GridUtils.calculate_tiles_in_path(Vector2i(5,5),  $"direction-handler-comp".current_direction, speed_per_turn, target_location)
	print_debug(moving_through_tiles)

# maybe there should be a dmg component and a movement component so i dont repeat myslef

