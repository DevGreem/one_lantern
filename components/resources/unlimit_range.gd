extends ShareableResource

class_name UnlimitRange

signal on_change_max_value
signal on_change_min_value

@export var min_value := 0.0:
	set(value):
		min_value = value
		on_change_min_value.emit()

@export var max_value := 1.0:
	set(value):
		max_value = value
		on_change_max_value.emit()


func _init(min_val := min_value, max_val := max_value):
	min_value = min_val
	max_value = max_val

func is_in_range(value: float) -> bool:
	return value >= min_value && value <= max_value
