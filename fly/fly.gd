extends RigidBody2D

var speed: float = 100
@export var despawn_delay: float = 0.5  # time to wait after hit animation before despawn
var animated_sprite: AnimatedSprite2D
var is_hit: bool = false

func _ready():
	animated_sprite = $AnimatedSprite2D
	animated_sprite.play("default")
	linear_velocity = Vector2(-speed, 0)

func _physics_process(delta):
	animated_sprite.play("default")
	if not is_hit:
		linear_velocity = Vector2(-speed, 0)
	
	# Remove enemy if it goes offscreen
	if position.x < -32:
		queue_free()

# Collision detection
func _on_body_entered(body: Node):
	print("AAAAAAAA")
	if is_hit:
		return  # already hit
	if body.name == "Bee":  # or use group check: body.is_in_group("Player")
		is_hit = true
		linear_velocity = Vector2.ZERO  # stop movement
		animated_sprite.play("die")    # play secondary animation
		# Wait for animation to finish then despawn
		var anim_length = animated_sprite.frames.get_animation_length("hit")
		await get_tree().create_timer(anim_length + despawn_delay).timeout
		queue_free()
