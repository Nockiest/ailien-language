extends Camera2D

@export var speed = 200
@export var zoom_speed = 0.3
@export var min_zoom = 0.5  # Minimum zoom level
@export var max_zoom = 2    # Maximum zoom level

func _process(_delta):
	var movement = Vector2()

	# Camera movement logic (WASD)
	if Input.is_action_pressed("ui_left"):  # A
		movement.x -= 1
	if Input.is_action_pressed("ui_right"):  # D
		movement.x += 1
	if Input.is_action_pressed("ui_up"):  # W
		movement.y -= 1
	if Input.is_action_pressed("ui_down"):  # S
		movement.y += 1

	movement = movement.normalized() * speed
	position += movement * _delta

	# Camera zoom logic (Q and E)
	if Input.is_action_pressed("zoom_in"):  # Q
		zoom.x = max(zoom.x - zoom_speed * _delta, min_zoom)
		zoom.y = max(zoom.y - zoom_speed * _delta, min_zoom)
	if Input.is_action_pressed("zoom_out"):  # E
		zoom.x = min(zoom.x + zoom_speed * _delta, max_zoom)
		zoom.y = min(zoom.y + zoom_speed * _delta, max_zoom)
