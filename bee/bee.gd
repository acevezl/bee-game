extends CharacterBody2D

var speed: float = 450
var animated_sprite: AnimatedSprite2D

# Max tilt angles in degrees
var max_tilt_x: float = 15   # tilt for vertical movement
var max_tilt_y: float = 10   # tilt for horizontal movement

func _ready():
	position.x = get_viewport_rect().size.x / 11
	position.y = get_viewport_rect().size.y / 2
	animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var input_velocity = Vector2.ZERO

	# Movement input
	if Input.is_action_pressed("ui_up"):
		input_velocity.y -= speed
	if Input.is_action_pressed("ui_down"):
		input_velocity.y += speed
	if Input.is_action_pressed("ui_left"):
		input_velocity.x -= speed
	if Input.is_action_pressed("ui_right"):
		input_velocity.x += speed

	# Apply movement
	velocity = input_velocity
	move_and_slide()

	# Compute tilt based on movement
	var tilt = Vector2.ZERO
	if input_velocity != Vector2.ZERO:
		tilt.x = clamp(input_velocity.y / speed, -1, 1) * deg_to_rad(-max_tilt_x)  # vertical tilt
		tilt.y = clamp(input_velocity.x / speed, -1, 1) * deg_to_rad(-max_tilt_y)  # horizontal tilt

		# Combine tilts into a single rotation (subtle effect)
		animated_sprite.rotation = lerp_angle(animated_sprite.rotation, tilt.x + tilt.y, 0.1)
	else:
		# Smoothly reset rotation if no input
		animated_sprite.rotation = lerp_angle(animated_sprite.rotation, 0, 0.1)

	# Play default animation
	animated_sprite.play("default")

	# Keep player inside the screen
	var screen_rect = get_viewport_rect()
	position.x = clamp(position.x, 0, screen_rect.size.x)
	position.y = clamp(position.y, 0, screen_rect.size.y)
