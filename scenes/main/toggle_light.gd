@tool
extends PointLight2D

@export var on_energy := 1.0
@export var off_energy := 0.5
@export var time_to_toggle := 0.5
var _current_time: float

func _ready():
	_current_time = time_to_toggle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if _current_time <= 0:
		
		if energy == on_energy:
			energy = off_energy
		else:
			energy = on_energy
		_current_time = time_to_toggle 
	else:
		_current_time -= delta
