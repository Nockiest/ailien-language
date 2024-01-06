class_name DeathComponent
extends Node2D
 
func kill_owner():
	print_debug("killing owner ", owner)
	owner.queue_free()
	if owner is Player:
		var root_node = get_tree().get_root()
		root_node.get_node("Map").end_game()

 
