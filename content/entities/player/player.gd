extends Sprite2D

class_name Player

signal on_die

func _physics_process(_delta: float) -> void:
	
	var pos := get_global_mouse_position()
	
	self.look_at(pos)
	self.rotation += deg_to_rad(90)

func die() -> void:
	on_die.emit()
	self.queue_free()

func _on_body_entered(_body: Node2D) -> void:
	die()
