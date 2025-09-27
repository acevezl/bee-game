extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Maximum tilt of the bee when it moves up (positive tilt) and down (negative tilt)
const MAX_TILT_DEGREES = 15

# Smoothness coefficient, the higher, the smoother
const TILT_SMOOTH = 10

@onready var bee_sprite: AnimatedSprite2D = $AnimatedSprite2D 

# Flags to indicate if the bee is idling or moving b/c the animations are different
# Not sure how to use this yet, but will come up later - methinks
var moving : bool = false;
var idling : bool = true;

# Bee direction: 1 - Forward, -1 Backwards, 0 Idle
var bee_direction = 1; 

func _ready():
	reset()
	
func reset():
	moving = false
	idling = true	
	
func _physics_process(delta):
	
	# Get Input Direction - Returns an x,y direction
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Normalize with speed constant
	velocity = input_direction * SPEED
	
	move_and_slide()
	
	# Determine if the bee is moving forward (1) or backwards (-1), or idling (0)
	bee_direction = Input.get_axis("ui_left", "ui_right")

	# Flip horizontally when moving left/right (i.e., look forwards vs backwards)
	if bee_direction == 1:
		bee_sprite.flip_h = false
	if bee_direction == -1:
		bee_sprite.flip_h = true # flipped
	
	
	# Animate Idle vs "Run" (i.e., Fly)
	if abs(velocity.x) > 0:
		# Bee is moving left or right, animate flight
		bee_sprite.play("fly")
	else:
		# Bee is idle, do not animate
		bee_sprite.play("idle")
	
	# Tilt the bee up and down
	# If bee flies up, then tilt up, if bee flies down, then tilt down
	var target_tilt_rad : float = 0.0
	var v = clamp(velocity.y / SPEED, -1.0, 1.0)
	target_tilt_rad = deg_to_rad(MAX_TILT_DEGREES) * v * bee_direction
	bee_sprite.rotation = lerp_angle(
		bee_sprite.rotation,
		target_tilt_rad,
		clamp(TILT_SMOOTH * delta, 0.0, 1.0)
	)
	# Snap to whole pixels for crisp pixel art
	position = position.round()
	
	
	
	
	
	# Default Godot code below, to be deleted
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
