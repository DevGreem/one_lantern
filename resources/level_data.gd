@tool
extends Resource

class_name LevelData

enum Difficulty {
	EASY,
	NORMAL,
	HARD,
	EXTREME
}

@export var id: String
@export var name: String:
	set(value):
		
		name = value
		if not Engine.is_editor_hint():
			return
		
		id = name.to_lower()
@export var description: String
@export var difficulty: Difficulty

## In seconds
@export var time_to_survive: float
@export var entities_data: EntitiesContainerData
@export var flashlight_data: FlashlightData
@export var spawneable_items: ItemsContainerData
