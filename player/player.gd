extends KinematicBody
# scalar kinematics
var speed = 7 # m/s, Base = 7, Assault = 10, Heavy = 5
var acceleration = 20 # m/s^2
var gravity = 9.8 #m/s^2
var jump = 5 # m/s
var has_double_jumped = false
# controls
var mouse_sensitivity = 0.05
# vector kinematics
var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var head = $head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion: # mouse look
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _process(delta):
	direction = Vector3()
	if not is_on_floor():
		fall.y -= gravity * delta
	else:
		has_double_jumped = false
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			fall.y = jump
		else:
			double_jump()
		
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # free mouse cursor
	# movement direction
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z # basis relative to where player is facing
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	fall = move_and_slide(fall, Vector3.UP)

func double_jump():
	pass # assault only

func accelerate_source():
	pass
