class_name RangedWeapon
extends Node2D

@export var ammo_capacity := 10
@export var range:int = 2
@export var projectile_scene_path: NodePath   # i will create a bullet scene
@export var packed_projectile_scene: PackedScene = preload("res://shared/components/projectile/projectile.tscn")
# The current active state. At the start of the game, we get the `initial_state`.
@onready var projectile_scene = get_node(projectile_scene_path)
 
@export var ammo_per_volley:int = 1
# building cost = 2 # how much does it cost to add this weapon to the game
signal ammo_ran_out()

var remaining_ammo:int = ammo_capacity:
	set(new_ammo):
		remaining_ammo = clamp(new_ammo, 0, ammo_capacity)
		if remaining_ammo == 0:
			print("ammo ran out")
			emit_signal("ammo_ran_out")
# Called when the node enters the scene tree for the first time.

func attack() -> void:
	if remaining_ammo< ammo_per_volley:
		printerr("ran out of bullets")
		return
	remaining_ammo -= ammo_per_volley # maybe I could move the logic above to the for loop, that could be interesting
	for i in range(ammo_per_volley):
		spawn_bullet()
		
func spawn_bullet():
#	projectile_scene.instantiate()
	var duplicated_node = packed_projectile_scene.instantiate() #projectile_scene.duplicate()
	duplicated_node.show()
 
	var entity = Utils.find_ancestor_by_factor(2, self)
	var duplicated_bullet_direction = entity.directionHandler
	print(duplicated_node, duplicated_node is Projectile, 	Utils.find_ancestor_by_factor(5, self).get_node("ObjectContainerManager"))
	Utils.find_ancestor_by_factor(5, self).get_node("ObjectContainerManager").add_child_node(duplicated_node)

	# instantiate a bullet
	
func reload(ammount=ammo_capacity):
	print_debug("reloading")
	remaining_ammo += ammount
