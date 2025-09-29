extends RigidBody2D

var speed: float = 10

func _physics_process(delta):
	$AnimatedSprite2D.play("default")
	apply_central_impulse(Vector2(-mass * speed, 0))
	
	if position.x < -32:
		queue_free()
