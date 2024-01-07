extends Control
 
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/start-screen/start-screen.tscn") 

func _ready():
	if Globals.game_lost:
#		$ColorRect.modulate = Color("red")
		$ColorRect/VBoxContainer2/Label.text = "THE ALIENS GOT YOU! ENJOY LIFE IN PRISON"
		$ColorRect/VBoxContainer2/VBoxContainer/TakenTurns.text = "Turns " + str(Globals.elapsed_turns)
		$ColorRect/VBoxContainer2/VBoxContainer/BestTurns.text = ""
		Utils.show_and_hide($losescreen,$victoryscreen)
	else:
		if (Globals.record_turns >= Globals.elapsed_turns or Globals.record_turns == 0):
			Globals.record_turns = Globals.elapsed_turns
			$ColorRect/VBoxContainer2/VBoxContainer/RecordAnnouncer.text = "Guess what! " + str( Globals.elapsed_turns) + " turns is the least ammount of turn you have ever needed to complete the game"
#		$ColorRect.modulate = Color("blue")
		$ColorRect/VBoxContainer2/Label.text = "WELL DONE YOU ARE THE RICHEST MAN IN THE UNIVERSE"
		$ColorRect/VBoxContainer2/VBoxContainer/TakenTurns.text = "Turns Needed: "+ str( Globals.elapsed_turns)
		$ColorRect/VBoxContainer2/VBoxContainer/BestTurns.text = "Record Turns: "+ str( Globals.record_turns)
		Utils.show_and_hide($victoryscreen,$losescreen     )
	Globals.elapsed_turns = 0
	Globals.save_data()
