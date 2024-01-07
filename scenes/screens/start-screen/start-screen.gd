class_name StartScreen
extends Control

func _ready() -> void:
	$AudioStreamPlayer.play()
	Globals.load_data()
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/map/map.tscn") 
	$AudioStreamPlayer.stop()
 

func _on_show_description_pressed() -> void:
	Utils.show_and_hide( $description , $"base-screen" )


func _on_return_pressed() -> void:
	Utils.show_and_hide($"base-screen" ,$description )


func _on_end_game_pressed() -> void:
	get_tree().quit()
