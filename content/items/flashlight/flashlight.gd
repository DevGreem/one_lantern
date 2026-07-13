extends Sprite2D

class_name FlashlightNode

@onready var light: PointLight2D = $Light
@onready var flash_area: FlashlightArea = $Light/Area2D
@onready var sound: AudioStreamPlayer = $Sound

@export var info: FlashlightData:
	set(value):
		
		info = value
		_update_info()

@export var duration := 0.0:
	set(value):
		duration = clamp(value, 0, info.max_duration)
@export var consumption := 1.0
@export var dmg_perc: float:
	get:
		return flash_area.dmg_perc
	set(value):
		flash_area.dmg_perc = value

var is_on := true

func _ready():
	_update_info()
	turn_off()

func _update_info() -> void:
	
	if not info:
		return
	
	duration = info.get_default_duration()

func turn_on() -> void:
	
	if is_on:
		return
	
	light.show()
	sound.play()
	flash_area.monitoring = true
	is_on = true

func turn_off() -> void:
	
	if not is_on:
		return
	
	light.hide()
	sound.play()
	flash_area.monitoring = false
	is_on = false

func _process(delta: float) -> void:
	
	if is_on:
		duration -= delta*consumption
	
	if duration <= 0:
		turn_off()
		return
	
	if light:
		
		if Input.is_action_pressed("light"):
			turn_on()
		else:
			turn_off()
