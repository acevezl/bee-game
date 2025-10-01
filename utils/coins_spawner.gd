extends Timer

@export var coin_scene: PackedScene;
@export var spawn_offset: float = 64;
@export var coin_speed: float = 100;

func _on_coin_spawner_timeout() -> void:
	var coin = coin_scene.instantiate();
	add_sibling(coin);
	var half_cam_height = get_viewport().get_camera_2d().get_viewport_rect().size.y / 2.0;
	coin.position.x = get_viewport().size.x + spawn_offset;
	coin.position.y = randf_range(-half_cam_height + 30, half_cam_height - 30);
	
	coin.speed = coin_speed;
