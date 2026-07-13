extends Button

class_name UnpauseButton

func _on_pressed() -> void:
	get_tree().paused = false
