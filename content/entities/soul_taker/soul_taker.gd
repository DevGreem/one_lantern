@tool
extends Entity

func _ready():
	
	super._ready()
	
	if Engine.is_editor_hint():
		return
	
	sprite.play("move")
