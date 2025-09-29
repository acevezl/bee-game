extends Area2D
class_name Enemy
@export var speed: float = 100

var is_dead: bool = false

func _ready() -> void:
	add_to_group("enemies")
	$AnimatedSprite2D.play("default");

func _physics_process(delta: float):
	position.x -= speed * delta;
	var half_cam_width = get_viewport().get_camera_2d().get_viewport_rect().size.x / 2;
	var half_cam_height = get_viewport().get_camera_2d().get_viewport_rect().size.y / 2;
	if position.x < -half_cam_width - 100 or position.y > half_cam_height  : # Assumes cam at 0,0 + extra range to free enemy
		queue_free();
	if is_dead:
		$AnimatedSprite2D.play("die")
		rotation -= 3 * delta
		position.y += speed * delta;

func _on_body_entered(body: Node2D):
	if body is Player:
		body.hit()
		die()

func _on_area_entered(area: Area2D):
	if area.is_in_group("bullets"):
		die()

func die():
	is_dead = true
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
