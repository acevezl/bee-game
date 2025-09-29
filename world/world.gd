extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_offset: float = 64


func _process(delta):
	$ParallaxBackground.scroll_offset = Vector2(0, 0)
	$ParallaxBackground/ParallaxLayer.motion_offset += Vector2(-0.15, 0)
	$ParallaxBackground/ParallaxLayer2.motion_offset += Vector2(-0.3, 0)
	

func _on_enemy_spawn_timer_timeout():
	if enemy_scene == null:
		print("⚠️ No enemy scene assigned in Inspector")
		return

	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.z_index = 1 

	# Start just outside the right edge
	enemy.position.x = get_viewport_rect().size.x + spawn_offset
	# Random Y within screen
	enemy.position.y = randf_range(28, get_viewport_rect().size.y - 28)
