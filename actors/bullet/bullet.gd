extends Area2D
class_name AbstractBullet

@export var damage: int = 1

var shooter: Node # who is the shooter of this bullet, so we increase its score

var direction: Vector2 # in which direction should bullet move
var speed: float = 1024

func _physics_process(delta: float) -> void:
	move_behavior(delta)

func _on_area_entered(area: Area2D):
	if area is AbstractEnemy and area != shooter:
		on_hit()
		
func on_hit():
	queue_free()
	
func move_behavior(delta: float):
	position += direction * speed * delta
