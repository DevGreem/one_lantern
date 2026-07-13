@tool
extends Sprite2D

class_name ItemNode

@export var node: Node
@export var property := &""
@export var info: ItemData:
	set(value):
		
		info = value
		_update_info()

@onready var area: ItemArea = $Area
@onready var timer: Timer = $Timer

var blinking := false

func _ready() -> void:
	_update_info()
	
	if Engine.is_editor_hint():
		return
	
	if not area.pressed.is_connected(_on_pressed):
		area.pressed.connect(_on_pressed)
	
	timer.wait_time = info.despawn_time
	timer.start()

func _process(_delta):
	
	if Engine.is_editor_hint():
		return
	
	if !blinking and timer.time_left <= timer.wait_time * 0.3:
		_blink()
		blinking = true

func _blink() -> void:
	
	while timer.time_left > 0:
		
		var tween := create_tween()
		tween.tween_property(self, "modulate:a", 0.4, 0.2)
		await tween.finished
		
		tween = create_tween()
		tween.tween_property(self, "modulate:a", 1, 0.2)
		await tween.finished

func _update_info() -> void:
	
	if not info:
		return
	
	self.texture = info.texture

func _on_pressed() -> void:
	
	if property.length() == 0:
		info.buffs.apply_buffs(node)
	else:
		var ids := property.split(".")
		var obj: Object = node
		
		for id in ids:
			obj = obj.get(id)
		
		info.buffs.apply_buffs(obj)
	
	self.queue_free()


func _on_timer_timeout() -> void:
	self.queue_free()
