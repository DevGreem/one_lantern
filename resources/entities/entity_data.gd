extends Resource

class_name EntityData

@export var id: String
@export var name: String
@export var health := LimitedValue.new(0, 100, 100)
@export var speed: float
@export var texture: SpriteFrames

@export_file("*.tscn") var scene: String
