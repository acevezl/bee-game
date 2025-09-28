extends CharacterBody2D

var speed: float = 400;
var base_rotation = -180;

var coins: int = 0;
var lifes: int = 3;

var animated_sprite: AnimatedSprite2D;

func _ready():
	animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed
		animated_sprite.rotation = lerp_angle(animated_sprite.rotation, deg_to_rad(base_rotation-30), 0.1)
	if Input.is_action_pressed("ui_down"):
		velocity.y = speed
		animated_sprite.rotation = lerp_angle(animated_sprite.rotation, deg_to_rad(base_rotation+30), 0.1)
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	if velocity.length() > 0:
		move_and_slide()
	if animated_sprite.rotation != -180:
		animated_sprite.rotation = lerp_angle(animated_sprite.rotation, deg_to_rad(base_rotation), 0.1)
	pass	
