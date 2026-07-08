extends Sprite2D

class_name FlashlightNode

@onready var light: PointLight2D = $Light
@onready var flash_area: Area2D = $Light/Area2D
@onready var sound: AudioStreamPlayer = $Sound

func turn_on() -> void:
	
	if light.visible:
		return
	
	light.show()
	sound.play()
	flash_area.monitoring = true

func turn_off() -> void:
	
	if not light.visible:
		return
	
	light.hide()
	sound.play()
	flash_area.monitoring = false

func _process(_delta: float) -> void:
	
	if light:
		if Input.is_action_pressed("light"):
			turn_on()
		else:
			turn_off()
		
