extends Area2D

var shooter: Node # who is the shooter of this bullet, so we increase its score

var direction: Vector2 # in which direction should bullet move
var speed: float = 1024

func _ready() -> void:
	add_to_group("bullets")

func _process(delta):
	position += direction * speed * delta

func _on_area_entered(area: Area2D):
	if area.is_in_group("enemies") and area != shooter:
		if "kills" in shooter: # If variable kills exists in shooter's script
			shooter.kills += 1
		self.queue_free()
