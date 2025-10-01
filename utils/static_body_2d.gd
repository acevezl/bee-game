extends StaticBody2D

@onready var wall_top: CollisionShape2D = $wall_top
@onready var wall_bottom: CollisionShape2D = $wall_bottom
@onready var wall_left: CollisionShape2D = $wall_left
@onready var wall_right: CollisionShape2D = $wall_right

func _process(delta: float) -> void:
	var cam = get_viewport().get_camera_2d()
	if cam == null:
		return
	
	var cam_w = cam.get_viewport_rect().size.x * cam.zoom.x
	var cam_h = cam.get_viewport_rect().size.y * cam.zoom.y
	var cam_pos = cam.position

	var thickness = 32.0

	wall_top.shape = RectangleShape2D.new()
	wall_top.shape.size = Vector2(cam_w, thickness)
	wall_top.position = cam_pos + Vector2(0, -cam_h/2 - thickness/2)

	wall_bottom.shape = RectangleShape2D.new()
	wall_bottom.shape.size = Vector2(cam_w, thickness)
	wall_bottom.position = cam_pos + Vector2(0, cam_h/2 + thickness/2)

	wall_left.shape = RectangleShape2D.new()
	wall_left.shape.size = Vector2(thickness, cam_h)
	wall_left.position = cam_pos + Vector2(-cam_w/2 - thickness/2, 0)

	wall_right.shape = RectangleShape2D.new()
	wall_right.shape.size = Vector2(thickness, cam_h)
	wall_right.position = cam_pos + Vector2(cam_w/2 + thickness/2, 0)
