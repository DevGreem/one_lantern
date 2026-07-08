extends Node2D

class_name LevelNode

@onready var camera: Camera2D = $Camera2D
@onready var entities_container: EntitiesContainer = $Entities
@onready var player: Player = $Entities/Player
@onready var lose: CenterContainer = $Menus/Lose
@onready var win: CenterContainer = $Menus/Win
@onready var timer: Timer = $Timer

@export var info: LevelData

func _ready():
	entities_container.info = info.entities_data
	entities_container.update()
	timer.timeout.connect(_on_survive)
	timer.wait_time = info.time_to_survive
	timer.start()

func _process(_delta) -> void:
	
	if not player:
		lose.show()
		get_tree().paused = true

func _on_survive() -> void:
	get_tree().paused = true
	win.show()
