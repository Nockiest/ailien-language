class_name DeathComponent
extends Node2D
 
func kill_owner():
	print_debug("killing owner ", owner)
	if owner is Player:
		Globals.game_lost = true
		$DeathSound.play()
		$Timer.start()
 

func _on_timer_timeout() -> void:
	print("timeout")
	owner.queue_free()
	if owner is Player:
		var root_node = get_tree().get_root()
		root_node.get_node("Map").end_game(false)
