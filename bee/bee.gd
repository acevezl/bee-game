extends RigidBody2D

var speed: float = 450
var animated_sprite: AnimatedSprite2D

func _ready():
	position.x = get_viewport_rect().size.x / 11
	position.y = get_viewport_rect().size.y / 2
	animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var velocity = Vector2.ZERO

	# Movement input
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
		animated_sprite.rotation = lerp_angle(animated_sprite.rotation, deg_to_rad(-30), 0.1)
	elif Input.is_action_pressed("ui_down"):
		velocity.y += speed
		animated_sprite.rotation = lerp_angle(animated_sprite.rotation, deg_to_rad(30), 0.1)
	else:
		# Smoothly reset rotation if no input
		animated_sprite.rotation = lerp_angle(animated_sprite.rotation, deg_to_rad(0), 0.1)

	# Apply velocity directly (no inertia)
	linear_velocity = velocity

	# Play default animation
	animated_sprite.play("default")

	# Keep player inside the screen
	var screen_rect = get_viewport_rect()
	position.x = clamp(position.x, 0, screen_rect.size.x)
	position.y = clamp(position.y, 0, screen_rect.size.y)
