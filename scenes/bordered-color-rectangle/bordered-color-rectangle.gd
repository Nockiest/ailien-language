class_name BorderedRectangle
extends Control

@export var border_width: int = 2
@export var rectangle_size: Vector2i = Globals.tile_size
var border_visible: bool = true  # Track the visibility of the border

func _ready() -> void:
	resize(rectangle_size)

func resize(new_size:Vector2i) -> void:
	# Set the size of the outer rectangle
	$Border.size = Utils.convert_to_normal_vector(new_size)

	# Calculate and set the size and position of the inner rectangle
	var fill_size = Utils.convert_to_normal_vector(new_size)  - Vector2(border_width * 2, border_width * 2)
	$Fill.size = fill_size
	$Fill.position = Vector2(border_width, border_width)


func toggle_border_visibility() -> void:
	border_visible = !border_visible  # Toggle the visibility state
	$Border.visible = border_visible  # Apply the visibility state to the outer rectangle

	# Optionally, adjust the size and position of the inner rectangle
	if border_visible:
		$Fill.rect_min_size = rectangle_size - Vector2i(border_width * 2, border_width * 2)
		$Fill.rect_position = Vector2(border_width, border_width)
	else:
		$Fill.rect_min_size = rectangle_size
		$Fill.rect_position = Vector2.ZERO
