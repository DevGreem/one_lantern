extends ShareableResource

class_name EntityData

@export var id: String
@export var name: String:
	set(value):
		
		name = value
		
		if not Engine.is_editor_hint():
			return
		
		id = name.to_lower().replace(" ", "_")
@export var health: LimitedValue
@export var speed: float
@export var texture: SpriteFrames
@export var spawn_audio: AudioStream

@export_file("*.tscn") var scene: String

@export var spawneable_in: Array[StringName] = []
