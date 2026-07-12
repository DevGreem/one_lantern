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

func _ready() -> void:
	_update_info()
	
	if Engine.is_editor_hint():
		return
	
	if not area.pressed.is_connected(_on_pressed):
		area.pressed.connect(_on_pressed)
	
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
