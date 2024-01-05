class_name Relic
extends Area2D

@export var collision_handler:CollisionHandler
# Called when the node enters the scene tree for the first time.
var desired_size: Vector2 = Globals.tile_size
func _ready() -> void:
	var scale_factor: Vector2 = Vector2.ZERO
	if $Sprite2D.texture and $Sprite2D.texture.get_size() != Vector2.ZERO:
		var texture_size: Vector2 = $Sprite2D.texture.get_size()
		scale_factor = desired_size / texture_size
		scale = scale_factor
	else:
		print_debug("Sprite texture is not set or has zero size")

 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
