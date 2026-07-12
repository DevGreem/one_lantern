extends ShareableResource

class_name ItemData

@export var id: String
@export var name: String:
	set(value):
		
		name = value
		
		if not Engine.is_editor_hint():
			return
		
		id = name.to_lower().replace(" ", "_")
@export var texture: Texture2D
@export var buffs: ItemBuffs
@export var can_spawn := true

@export_file("*.tscn") var scene: String
