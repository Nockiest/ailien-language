class_name Player
extends Entity
 


 
 


func _on_movement_component_moved(_from, _to) -> void:
	Globals.elapsed_turns += 1
	$AudioFiles/FootStep.play()
	$AudioFiles/NextTurn.play()
