extends ShareableResource

class_name EntityData

@export var id: String
@export var name: String
@export var health: LimitedValue
@export var speed: float
@export var texture: SpriteFrames

@export_file("*.tscn") var scene: String

@export var drops: Array
