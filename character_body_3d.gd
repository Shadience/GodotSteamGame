extends CharacterBody3D

@export var speed = 6.0
@export var jump_vel = 4.5
@onready var main_cam: Camera3D = $Camera3D

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_vel
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var dir := input_dir.rotated(-main_cam.rotation.y)
	var direction = Vector3(dir.x, 0, dir.y)
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
