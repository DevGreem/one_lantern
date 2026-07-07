extends Sprite2D

@onready var flashlight: PointLight2D = $Flashlight

func _physics_process(_delta: float) -> void:
	
	var pos := get_local_mouse_position()
	
	self.look_at(pos)
	
	if flashlight:
		if Input.is_action_pressed("light"):
			flashlight.show()
		else:
			flashlight.hide()
