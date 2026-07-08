extends LimitRange

class_name LimitedValue

signal on_change_current_value

@export var current_value: float:
	set(value):
		
		current_value = value
		on_change_current_value.emit()

func _init(min_val := min_value, max_val := max_value, default_value := current_value):
	
	current_value = default_value
	
	if not on_change_min_value.is_connected(_update_current):
		on_change_min_value.connect(_update_current)
	
	if not on_change_max_value.is_connected(_update_current):
		on_change_max_value.connect(_update_current)
	
	super._init(min_val, max_val)

func _update_current():
	current_value = clampf(current_value, min_value, max_value)
