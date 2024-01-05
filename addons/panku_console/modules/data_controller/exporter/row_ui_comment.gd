extends HBoxContainer

@export var container:Control
@export var label:Label

var state := "s1"
var t := 0.0
var d := 0.0

func _process(_delta:float) -> void:
	d = label.size.x - container.size.x
	t -= _delta
	call(state, _delta)

func s1(_delta:float):
	if d > 0:
		t = 1.0
		state = "s2"

func s2(_delta:float):
	if d <= 0:
		state = "s1"
		return
	if t <= 0:
		state = "s3"
		label.position.x = 0

func s3(_delta:float):
	if d <= 0:
		state = "s1"
		label.position.x = 0
		return
	if label.position.x + d < 0.1:
		t = 1.0
		state = "s4"
		return
	label.position.x -= _delta * 30.0
	label.position.x = max(-d, label.position.x)

func s4(_delta:float):
	if d <= 0 or t <= 0:
		state = "s1"
		label.position.x = 0
