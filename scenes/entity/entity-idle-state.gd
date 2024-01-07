class_name EntityIdleState
extends State


 
func update(_delta):
 
	if Input.is_action_just_pressed("left_mouse_click") and owner.is_hovered:
		state_machine.transition_to("Selected")
	elif Input.is_action_just_pressed("right_mouse_click") :
#		healthComponent.take_hit(1)
		call_deferred_thread_group("move_aliens")
		$"../../AudioFiles/NextTurn".play()
		Globals.elapsed_turns += 1
 
func move_aliens():
	var aliens = get_tree().get_nodes_in_group("alien")
	for alien in aliens:
		alien.move_alien( ) 
		state_machine.transition_to("Idle")
