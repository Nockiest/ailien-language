class_name DeathComponent
extends Node2D
 
func kill_owner():
	print_debug("killing owner ", owner)
	owner.queue_free()

 
