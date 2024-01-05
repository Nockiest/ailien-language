class_name CollisionHandler
extends Node2D

enum collision_reactions   {
	IGNORE,
	SELF_DESTRUCT,
	GET_PICKED_UP,
	BLOCK_ENTERING_COMPONENT,
	DESTROY_ENTERING_COMPONENT
}
signal pickedUp(object)

@export var collision_reaction:collision_reactions = collision_reactions.SELF_DESTRUCT
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func handle_collision(object):
	if object == owner:
		print(owner, object, "they are the same")
 
	elif collision_reaction == collision_reactions.SELF_DESTRUCT:
		print("self destructing")
		owner.queue_free()
	elif collision_reaction == collision_reactions.GET_PICKED_UP:
		emit_signal("pickedUp", owner)

		# Apply the collision reaction to the owner when picked up

		# Remove the owner from its current parent
		owner.get_parent().remove_child(owner)

		# Add the owner as a child to the object that picked it up
		object.add_child(owner)
		
		return collision_reactions.GET_PICKED_UP
	elif  collision_reaction == collision_reactions.BLOCK_ENTERING_COMPONENT:
		print("ABORTING ENEMY MOVEMENT")
 
	elif   collision_reaction == collision_reactions.DESTROY_ENTERING_COMPONENT:
		object.queue_free()
	return collision_reaction
