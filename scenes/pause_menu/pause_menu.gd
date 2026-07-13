extends CenterContainer

func _input(event: InputEvent):
	
	if event.is_action_pressed("pause"):
		if self.visible:
			_on_resume_button_pressed()
		else:
			get_tree().paused = true
			show()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	hide()
