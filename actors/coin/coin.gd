extends Area2D

var speed = 256

func _process(delta: float) -> void:
	$AnimatedSprite2D.play("default")
	position.x -= speed * delta
	var half_cam_width = get_viewport().get_camera_2d().get_viewport_rect().size.x / 2;
	if position.x < -half_cam_width - 100: # Assumes cam at 0,0 + extra range to free coin
		queue_free();
		
func _on_body_entered(body: Node2D):
	if "coins" in body:
		body.coins +=1
		queue_free()
