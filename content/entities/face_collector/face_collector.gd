@tool
extends Entity

var _first_lightned := true

func _ready():
	
	super._ready()
	
	if Engine.is_editor_hint():
		return
	
	if not on_lightned.is_connected(_on_lightned):
		on_lightned.connect(_on_lightned)
	
	if not animation.animation_finished.is_connected(_on_finish_animation):
		animation.animation_finished.connect(_on_finish_animation)
	
	sprite.play("move")

func _on_lightned() -> void:
	
	if _first_lightned:
		_first_lightned = false
		animation.play("quit_face")

func _on_finish_animation(anim: StringName) -> void:
	
	if anim == &"quit_face":
		animation.process_mode = Node.PROCESS_MODE_DISABLED
		self.info.speed = 150
