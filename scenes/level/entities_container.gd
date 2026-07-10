extends Node

class_name EntitiesContainer

@onready var camera: Camera2D = $"../Camera2D"

@export var level: LevelNode
@export var info: EntitiesContainerData:
	set(value):
		
		info = value
		update()

@export var item_info: ItemsContainerData

var _time_to_spawn: float

var IDS: Array[StringName] = []
const ENTITIES: Registry = preload("res://databases/entities.tres")

func _ready():
	update()
	
	#TODO: Fix empty val array (for some reason)
	print(ENTITIES.get_all_string_ids())
	IDS = ENTITIES.filter(&"spawneable_in", 
		func(val: Array[StringName]):
			print(val)
			print(typeof(val))
			return level.info.id in val
	)
	print(IDS)

func update() -> void:
	
	if not info:
		return
	
	_time_to_spawn = info.time_between_enemy_spawns

func _physics_process(delta: float) -> void:
	
	_time_to_spawn -= delta
	
	if _time_to_spawn <= 0:
		_time_to_spawn = _randf_spawn()
		print("Spawning enemies...")
		generate_rand_enemies()
		print("Enemies spawned!")

func _randf_spawn() -> float:
	return randf_range(info.time_between_enemy_spawns - info.range_time_between_spawns.min_value, info.time_between_enemy_spawns + info.range_time_between_spawns.max_value)

func generate_rand_enemies() -> void:
	
	var cant := randi_range(max(1, info.cantity_between_spawns.min_value), int(info.cantity_between_spawns.max_value))
	
	for i in range(cant):
		generate_enemy()

func generate_enemy() -> void:
	
	var data: EntityData = ENTITIES.load_entry(IDS.pick_random())
	var entity: Entity = load(data.scene).instantiate()
	
	entity.level = get_node("/root/Level")
	entity.position = get_rand_spawn(data)
	entity.add_to_group("enemy")
	
	if randf() <= item_info.probability_to_spawn:
		entity.item = item_info.container.get_random_item()
	
	add_child(entity)

func get_rand_spawn(entity: EntityData) -> Vector2:
	
	var rect = camera.get_viewport_rect()
	var size = rect.size*camera.zoom
	rect.position = camera.global_position - rect.size * camera.zoom / 2.0
	rect.size *= camera.zoom
	
	var side := randi_range(0, 3)
	var margin := randf_range(0, info.range_between_spawns)
	var entity_text := entity.texture.get_frame_texture("default", 0)
	
	if side == SIDE_LEFT:
		return Vector2(
			rect.position.x - margin - entity_text.get_size().x/2,
			randf_range(rect.position.y, rect.end.y)
		)
	
	if side == SIDE_TOP:
		return Vector2(
			randf_range(rect.position.x, rect.end.x),
			rect.position.y - margin - entity_text.get_size().y/2
		)
	
	if side == SIDE_RIGHT:
		return Vector2(
			rect.end.x + margin + entity_text.get_size().x/2,
			randf_range(rect.position.y, rect.end.y)
		)
	
	if side == SIDE_BOTTOM:
		return Vector2(
			randf_range(rect.position.x, rect.end.x),
			rect.end.y + margin + entity_text.get_size().y/2
		)
	
	return Vector2.ZERO
