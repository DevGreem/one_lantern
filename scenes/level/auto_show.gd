@tool
extends CanvasModulate


func _ready() -> void:
	
	if not Engine.is_editor_hint():
		self.show()
