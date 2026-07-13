@tool
extends CharacterBody2D

class_name Entity

@warning_ignore("unused_signal")
signal on_lightned

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var on_screen: OnScreenCollisionShape = $OnScreen
@onready var animation: AnimationPlayer = $Animation
@onready var items_node: Node = $"../../Items"
@onready var audio: AudioStreamPlayer2D = $Audio

@export var level: LevelNode
@export var info: EntityData:
	set(value):
		info = value
		print("SET: ", info)
		
		if info:
			
			if not Engine.is_editor_hint():
				info = info.duplicate(true)
			
			_update_info()
			
@export var target: Player:
	set(value):
		
		target = value
		
		if target:
			_update_look()
@export var can_move := true
@export var item: ItemData = null

var into_screen := false
var is_paused := false
var spawn_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print(get_viewport().size)
	if info:
		_update_info()
	
	if Engine.is_editor_hint():
		return
	
	if not target:
		target = get_node("../Player")
	
	if not on_screen.screen_entered.is_connected(_on_enter_screen):
		on_screen.screen_entered.connect(_on_enter_screen)
	
	if not on_screen.screen_exited.is_connected(_on_exit_screen):
		on_screen.screen_exited.connect(_on_exit_screen)
	
	into_screen = on_screen.is_on_screen()
	spawn_pos = global_position
	print(audio.stream)

func _process(_delta: float):
	
	if not info:
		return
	
	if Engine.is_editor_hint():
		return
	
	sprite.modulate.a = info.health.current_value/info.health.max_value
	
	if info.health.current_value <= 0:
		die()

func die() -> void:
	
	if item:
		var node: ItemNode = load(item.scene).instantiate()
		node.global_position = self.global_position
		node.node = level.player
		items_node.add_child(node)
	
	self.queue_free()

func _physics_process(delta: float) -> void:
	
	if Engine.is_editor_hint() or not target or not info:
		return
	
	_take_step(delta)

func _update_info() -> void:
	
	if not is_node_ready():
		await ready
	
	if info.texture:
		sprite.sprite_frames = info.texture
	
	if not Engine.is_editor_hint():
		return
	
	audio.stream = info.spawn_audio

func _update_look() -> void:
	
	if is_paused:
		return
	
	self.look_at(target.global_position) 
	self.rotation += deg_to_rad(90)

@warning_ignore("unused_parameter")
func _take_step(delta: float):
	
	if is_paused:
		return
	
	if can_move:
		var speed := self.global_position.direction_to(target.global_position)
		
		self.velocity = speed*info.speed
	else:
		self.velocity = Vector2.ZERO
	
	move_and_slide()

func _on_enter_screen() -> void:
	into_screen = true
	print("Entity enter into the screen")

func _on_exit_screen() -> void:
	into_screen = false
	print("Entity exited of the screen")

func pause() -> void:
	is_paused = true
	animation.pause()

func resume() -> void:
	is_paused = false
	animation.resume()
