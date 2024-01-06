class_name CollisionHandler
extends Node2D

enum collision_reactions {
	IGNORE,
	SELF_DESTRUCT,
	GET_PICKED_UP,
	BLOCK_ENTERING_COMPONENT,
	DESTROY_ENTERING_COMPONENT
}
signal pickedUp(object)

@export var collision_reaction:collision_reactions = collision_reactions.SELF_DESTRUCT


func handle_collision(object):
#	print("handling", object, owner, collision_reaction)
	if object == owner:
		print(owner, object, "they are the same")
 
	elif collision_reaction == collision_reactions.SELF_DESTRUCT:
		print("self destructing", owner)
		owner.deathComponent.kill_owner()
	elif collision_reaction == collision_reactions.GET_PICKED_UP:
		emit_signal("pickedUp", owner)

		# Apply the collision reaction to the owner when picked up

		# Remove the owner from its current parent
		owner.get_parent().remove_child(owner)
		print("RELIC IS BEING PICKED UP")
		# Add the owner as a child to the object that picked it up
		object.add_child(owner)
		
		return collision_reactions.GET_PICKED_UP
	elif  collision_reaction == collision_reactions.BLOCK_ENTERING_COMPONENT:
		print("ABORTING ENEMY MOVEMENT")
 
	elif   collision_reaction == collision_reactions.DESTROY_ENTERING_COMPONENT:
		object.deathComponent.kill_owner()
	return collision_reaction
