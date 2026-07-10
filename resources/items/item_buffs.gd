extends ShareableResource

class_name ItemBuffs

@export var affect_to: Script
@export var effects: Array[ItemEffect] = []

func apply_buffs(obj: Object) -> void:
	
	if obj.get_script() != affect_to:
		printerr("Object not is ", affect_to, "!")
		return
	
	for effect in effects:
		effect.evaluate(obj)
