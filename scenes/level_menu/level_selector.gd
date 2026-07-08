extends HBoxContainer

const LEVELS = preload("res://databases/levels.tres")
@onready var forests: ItemList = $Forests
var loaded_levels: Array[LevelData] = []
@onready var forest_name: Label = $ForestInfo/Container/MarginName/Name
@onready var description: RichTextLabel = $ForestInfo/Container/Description
@onready var difficulty: Label = $ForestInfo/Container/MarginPlay/VBoxContainer/Difficulty
@onready var play_button: Button = $ForestInfo/Container/MarginPlay/VBoxContainer/Play

func _ready() -> void:
	
	if not forests.item_selected.is_connected(_on_level_selected):
		forests.item_selected.connect(_on_level_selected)
	
	if not play_button.pressed.is_connected(_on_pressed_play):
		play_button.pressed.connect(_on_pressed_play)
	
	list_levels(LEVELS.get_all_string_ids())

func list_levels(ids: Array[StringName]) -> void:
	for id in ids:
		list_level(LEVELS.load_entry(id))
	
	loaded_levels.sort_custom(func(a, b): return a.difficulty < b.difficulty)
	
	for level in loaded_levels:
		forests.add_item(level.name)
	
	forests.select(0, true)
	_on_level_selected(0)

func list_level(level: LevelData) -> void:
	loaded_levels.append(level)

func _on_level_selected(index: int) -> void:
	var level := loaded_levels[index]
	forest_name.text = level.name
	description.text = level.description
	
	var diff_name: String = LevelData.Difficulty.find_key(level.difficulty)
	difficulty.text = "Difficulty: {0}".format([diff_name])

func _on_pressed_play() -> void:
	pass
