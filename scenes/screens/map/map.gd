class_name Map
extends Node2D
 
# Called every frame. '_delta' is the elapsed time since the previous frame.


func end_game():
	print("ending the game")
	get_tree().change_scene_to_file("res://scenes/screens/end-screen/end-screen.tscn") 

