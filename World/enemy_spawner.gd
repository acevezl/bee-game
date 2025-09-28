extends Timer

@export var enemy_scene: PackedScene;
@export var spawn_offset: float = 64;
@export var enemy_speed: float = 100;

func _on_enemy_spawner_timeout() -> void:
	var enemy = enemy_scene.instantiate();
	add_sibling(enemy);
	var half_cam_height = get_viewport().get_camera_2d().get_viewport_rect().size.y / 2.0;
	enemy.position.x = get_viewport().size.x + spawn_offset;
	enemy.position.y = randf_range(-half_cam_height + 30, half_cam_height - 30);
	
	enemy.speed = enemy_speed;
