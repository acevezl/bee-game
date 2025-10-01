extends CharacterBody2D
class_name Player
@export var bullet_scene: PackedScene

var speed: float = 400;
var base_rotation = -180;

var coins: int = 0;
var lifes: int = 3;
var can_shoot: bool = true
var last_shot: int = Time.get_ticks_msec();
var cooldown: int = 250
var hit_count: int = 0

var animated_sprite: AnimatedSprite2D;

func _ready():
	animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var now = Time.get_ticks_msec();

	velocity = Vector2.ZERO
	can_shoot = ((now - last_shot) > cooldown)

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
	
	if Input.is_action_pressed("ui_select") and can_shoot:
		can_shoot = false
		shoot()
		
		
func shoot():
	last_shot = Time.get_ticks_msec()
	var bullet = bullet_scene.instantiate()
	bullet.shooter = self
	bullet.position = self.position + Vector2(64, 0)
	bullet.direction = Vector2(1, 0)
	add_sibling(bullet)

func hit(damage: int):
	lifes -= damage
	if lifes==0:
		$AnimatedSprite2D.play("die")
	else:
		$AnimatedSprite2D.play("hit")
		


func _on_animation_finished() -> void:
	if animated_sprite.animation=="hit":
		if hit_count<1:
			hit_count+=1
			$AnimatedSprite2D.play("hit")
		else:
			hit_count=0
			$AnimatedSprite2D.play("default_state")
	elif animated_sprite.animation:
		queue_free()
	
