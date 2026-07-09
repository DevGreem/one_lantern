extends ShareableResource

class_name FlashlightData

## In seconds
@export var max_duration: float

## In seconds, if -1 use the max_duration by default
@export var default_duration := -1.0

func get_default_duration() -> float:
	return max_duration if default_duration < 0 else default_duration
