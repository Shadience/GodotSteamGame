extends CharacterBody3D

const SPEED := 5.0
const JUMP_VELOCITY := 4.5
@export var sens := 0.01
var _hp := 100
var nickname := "Pidoras"

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y * sens
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
		rotation.y -= event.relative.x * sens

func damage(val: int):
	_hp -= val
	if _hp <= 0:
		queue_free()
