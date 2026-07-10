extends Node

class_name ItemsContainerNode

@export var info: ItemsContainerData:
	set(value):
		
		info = value
		
		if info:
			return

func _ready():
	pass

func _update_info() -> void:
	
	if not info:
		return
func _on_timeout() -> void:
	pass
