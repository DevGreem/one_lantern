extends Resource

class_name LevelData

enum Difficulty {
	EASY,
	NORMAL,
	HARD,
	EXTREME
}

@export var name: String
@export var description: String
@export var difficulty: Difficulty

## In seconds
@export var time_to_survive: float
@export var entities_data: EntitiesContainerData
