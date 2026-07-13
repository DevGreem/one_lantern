extends CenterContainer

var _paused_by_self := false

func _input(event: InputEvent):
	
	if not get_tree().paused or _paused_by_self:
		if event.is_action_pressed("pause"):
			if self.visible:
				_on_resume_button_pressed()
			else:
				get_tree().paused = true
				show()
				_paused_by_self = true

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	hide()
	_paused_by_self = false
