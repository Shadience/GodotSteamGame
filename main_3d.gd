extends Node3D

var captured = true;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent):
	if event.is_pressed():
		if Input.is_key_pressed(KEY_ESCAPE):
			if captured:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				captured = !captured
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				captured = !captured
