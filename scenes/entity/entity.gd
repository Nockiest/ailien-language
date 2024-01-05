class_name Entity
extends GridObject
@export var directionHandler:DirectionHandler
@export var stateMachine: StateMachine
@export var movementComponent: MomvementComponent
@export var healthComponent: HealthComponent
@export var deathComponent: DeathComponent
@export var weaponComponent: RangedWeapon
@export var collisionHandler: CollisionHandler
 
var desired_size: Vector2 = Globals.tile_size
var is_hovered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
 
	var scale_factor: Vector2 = Vector2.ZERO
	if $Sprite2D.texture and $Sprite2D.texture.get_size() != Vector2.ZERO:
		var texture_size: Vector2 = $Sprite2D.texture.get_size()
		scale_factor = desired_size / texture_size
		scale = scale_factor
	else:
		print_debug("Sprite texture is not set or has zero size")

 
	stateMachine.init()
	
#func _process(_delta: float) -> void:
#	if Input.is_action_just_pressed("left_mouse_click") :
##		healthComponent.take_hit(1)
#		weaponComponent.attack()
#
func _on_mouse_entered() -> void:
	is_hovered = true
func _on_mouse_exited() -> void:
	is_hovered = false


func _on_health_component_health_ran_out() -> void:
	print_debug("entity is dead ", self)
	if deathComponent:
		deathComponent.kill_owner()
		
		
		#	# Rescale the collision shape
#	if $CollisionShape2D and $CollisionShape2D.shape:
#		$CollisionShape2D.scale = scale_factor
#	else:
#		print_debug("CollisionShape2D or its shape is not set")

