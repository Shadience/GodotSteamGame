extends Camera3D

var mouse_delta = Vector2.ZERO
@export var mouse_sensitivity = 0.005

func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

func _process(_delta):
	if mouse_delta != Vector2.ZERO:
		rotation.y -=  mouse_delta.x * mouse_sensitivity
		rotation.x -= mouse_delta.y * mouse_sensitivity
		rotation.x = clamp(rotation.x, -deg_to_rad(90), deg_to_rad(90))
		mouse_delta = Vector2.ZERO
