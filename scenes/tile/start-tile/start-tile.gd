class_name StartTile
extends Tile
 


func _on_object_container_manager_objects_changed(objects) -> void:
	# Check if any of the objects is a Player
	var player_found = false
	var relic_found = false
	for obj in objects:
		if obj is Player:
			player_found = true
			for child in obj.get_children():
				if child is Relic:
					relic_found = true
					break

	# If both Player and Relic are present, trigger the game won condition
	if player_found and relic_found:
		get_tree().get_root().get_node("Map").end_game(true)

 
