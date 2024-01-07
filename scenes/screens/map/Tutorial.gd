extends Control

@onready var x_in_retracted: float = get_viewport().size.x -250   # Adjust the margin as needed
@onready var x_normal: float = $".".position.x  # Assuming this is the node you want to control

 
func _on_button_pressed():
	if $".".position.x == x_in_retracted:
		$".".position.x = x_normal
		$Button.text = "Hide"
		$ColorRect.visible = true
	else:
		$".".position.x = x_in_retracted
		$Button.text = "Show"
		$ColorRect.visible = false
