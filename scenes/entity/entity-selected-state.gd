class_name EntitySelectedState
extends State


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}):
	owner.scale = owner.scale*1.1
	Globals.selected_entity = owner
	
func exit():
 
	Globals.selected_entity = null
	owner.scale = owner.scale*0.9 
	
 
func update(_delta):
	if not (owner.get_parent() is ObjectContainer):
		state_machine.transition_to("Idle")
		return 
	
	if (Input.is_action_just_pressed("left_mouse_click") ):
		var positionTracker = Utils.find_ancestor_by_factor(3, owner).get_node("GridPositionTracker")
		owner.movementComponent.process_movement(positionTracker.gridPosition, Globals.hovered_tile_coors)
		state_machine.transition_to("Idle")
	elif   Globals.selected_entity != owner:
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("right_mouse_click") :
#		healthComponent.take_hit(1)
		owner.weaponComponent.attack()
	

 
 

func _on_movement_component_moved(_from, _to) -> void:
	call_deferred_thread_group("move_aliens")
func move_aliens():
	var aliens = get_tree().get_nodes_in_group("alien")
	for alien in aliens:
		alien.move_alien( ) 
		state_machine.transition_to("Idle")
