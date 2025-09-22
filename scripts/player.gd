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

# Bee direction: 1 - Forward, -1 Backwards
var bee_direction = 1; 

func _ready():
	reset()
	
func reset():
	moving = false
	idling = true

# Method to ge the input played (left, right, top, down)
# Pulled it out of the _physics_process, in case I need it in other places (tho unlikely ATM)
func get_input():
	# Returns an x,y direction
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Normalize with speed constant
	velocity = input_direction * SPEED
	
func _physics_process(delta):
	get_input()
	move_and_slide()
	
	# Calculate tilt based on vertical movement
	# If bee flies up, then tilt up, if bee flies down, then tilt down
	#var target_tilt_rad := 0.0
	var v = clamp(velocity.y / SPEED, -1.0, 1.0)
	# Flip horizontally when moving left/right (i.e., look forwards vs backwards)
	if velocity.x == -SPEED:
		bee_sprite.flip_h = true
		bee_direction = -1
	if velocity.x == SPEED:
		bee_sprite.flip_h = false
		bee_direction = 1
	
	var target_tilt_rad = deg_to_rad(MAX_TILT_DEGREES) * v * bee_direction

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
