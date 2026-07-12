extends Area2D

class_name FlashlightArea

var entities: Dictionary[String, Entity] = {}
var dmg_perc := 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	
	if not body_exited.is_connected(_on_body_exited):
		body_exited.connect(_on_body_exited)

func _on_body_entered(node: Node2D) -> void:
	
	if node is Entity:
		entities[node.name] = node
		print("Entered enemy to flashlight!")

func _on_body_exited(node: Node2D) -> void:
	
	if node is Entity:
		entities.erase(node.name)
		print("Exited enemy to flashlight")

func _physics_process(delta: float) -> void:
	
	if not monitoring:
		return
	
	for id in entities:
		var entity := entities[id]
		
		if entity.into_screen:
			entity.info.health.current_value -= delta*dmg_perc
			entity.on_lightned.emit()
