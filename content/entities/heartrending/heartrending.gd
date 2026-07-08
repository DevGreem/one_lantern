@tool
extends Entity

func _ready() -> void:
	
	super._ready()
	
	if Engine.is_editor_hint():
		return
	
	animation.play("move")

func _take_step(delta: float):
	
	if can_move:
		super._take_step(delta)
	else:
		self.velocity = Vector2.ZERO
