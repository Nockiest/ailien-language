class_name Tile
extends Area2D
#
@export var position_tracker:PositionTracker  
@export var objectContainerManager:Node  
signal tile_left_clicked(coors)
signal tile_right_clicked(coors)
func _on_mouse_entered() -> void:
	Globals.hovered_tile_coors = $GridPositionTracker.get_grid_position()

func _ready() -> void:
	resize(Globals.tile_size-  Globals.grid_gap)
#	add_object_to_tile( Globals.entity_scene   )
#
func _process(_event) -> void:
	var is_hovered =  Globals.hovered_tile_coors == $GridPositionTracker.get_grid_position()
	if Input.is_action_just_pressed("left_mouse_click") and is_hovered:
		emit_signal("tile_left_clicked",$GridPositionTracker.get_grid_position() )
	elif Input.is_action_just_pressed("right_mouse_click") and is_hovered:
		emit_signal("tile_right_clicked",$GridPositionTracker.get_grid_position() )
		
func resize(size:Vector2i):
	$BorderedColorRect.resize(size )  
	var shape = RectangleShape2D.new()
	shape.extents = size / 2.0  # Extents are half the size of the rectangle
	$CollisionShape2D.shape = shape
	var center = Utils.get_collision_shape_center(self)
	$ObjectContainerManager.position = size / Vector2i(2,2) 
	$CollisionShape2D.position = size / Vector2i(2,2) 


func add_object_to_tile(object):
#	Globals.entity_scene.instantiate() as Node2D
#	if randf() <= 0.2:  # 20% chance
	var entity = object.instantiate() as Area2D
	print("adding entity ",entity)
	$ObjectContainerManager.add_child_node(entity)

func _on_entity_container_entities_changed(_new_size) -> void:
	$BorderedColorRect/Fill.color = Color('red')
