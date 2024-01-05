class_name HealthComponent
extends Node2D

@export var max_hp: int = 1
@export var start_hp: int = 1
@export var max_shields: int = 1
@export var start_shields: int = 1
@export var regeneration_speed: int = 1
 
signal health_ran_out()
signal shields_ran_out()

var current_hp: int = start_hp:
	set(new_hp):
		if new_hp <= 0:
			emit_signal("health_ran_out")
		current_hp = clampi(new_hp,0 , max_hp) 
		print("current health is", current_hp)
var current_shields: int = start_shields:
	set(new_shields):
		if new_shields <= 0:
			emit_signal("shields_ran_out")
		current_shields =clampi(new_shields ,0 , max_shields )
		print("current shields are", current_shields)

# Called every frame. '_delta' is the elapsed time since the previous frame.
func take_hit(dmg: int) -> void:
	if current_shields > 0:
		# If there are shields, subtract damage from shields
		current_shields -= dmg
	else:
		# If no shields, subtract damage from health
		current_hp -= dmg
		# Check if health ran out
 
func take_direct_health_damage(dmg:int) -> void:
	current_hp -= dmg
 
func regenerate(ammount:int=regeneration_speed)-> void:
	current_hp =  ammount 

# Add functions to retrieve current health and shields if needed
func get_current_health() -> int:
	return current_hp
	
func get_current_shields() -> int:
	return current_shields
