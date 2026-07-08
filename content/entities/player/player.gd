extends Sprite2D

class_name Player



func _physics_process(_delta: float) -> void:
	
	var pos := get_global_mouse_position()
	
	self.look_at(pos)
	self.rotation += deg_to_rad(90)
