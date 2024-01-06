class_name EntityIdleState
extends State


 
func update(_delta):
 
	if Input.is_action_just_pressed("left_mouse_click") and owner.is_hovered:
		state_machine.transition_to("Selected")
