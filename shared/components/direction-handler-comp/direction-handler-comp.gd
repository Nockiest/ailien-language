class_name DirectionHandler
extends Node
const Directions = preload("res://types/direction-list.gd")

@export var starting_direction: DirectionList.Direction = DirectionList.Direction.UP
var current_direction = starting_direction
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotate_parent(starting_direction)

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# You might want to update the rotation dynamically during gameplay
	# rotate_parent()
	pass

func rotate_parent(direction: DirectionList.Direction) -> void:
	match direction:
		DirectionList.Direction.LEFT:
#			print(1)
			owner.rotation_degrees = 270
		DirectionList.Direction.RIGHT:
#			print(2)
			owner.rotation_degrees = 90
		DirectionList.Direction.DOWN:
#			print(3)
			owner.rotation_degrees = 180
		DirectionList.Direction.UP:
#			print(4, direction, DirectionList.Direction.UP)
			owner.rotation_degrees = 0
		DirectionList.Direction.UP_LEFT:
#			print(5)
			owner.rotation_degrees =315  
		DirectionList.Direction.UP_RIGHT:
#			print(6)
			owner.rotation_degrees =  45
		DirectionList.Direction.DOWN_LEFT:
#			print(7)
			owner.rotation_degrees =  225
		DirectionList.Direction.DOWN_RIGHT:
#			print(8)
			owner.rotation_degrees =  135
	current_direction = direction




func _on_movement_component_moved(from, to) -> void:
	var direction = GridUtils.get_movement_direction(from, to)
	rotate_parent(direction)
