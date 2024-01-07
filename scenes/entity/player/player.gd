class_name Player
extends Entity
 


 
 


func _on_movement_component_moved(from, to) -> void:
	Globals.elapsed_turns += 1
