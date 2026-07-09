extends PropertyNode

func make_action(value: Variant) -> void:
	
	assert("text" in self, "Your node don't had the property \"text\"!")
	
	self.text = str(int(value))
