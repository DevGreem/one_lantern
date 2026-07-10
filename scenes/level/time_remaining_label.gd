extends PropertyNode

func make_action(value: Variant) -> void:
	
	assert("text" in self, "Your node don't had the property \"text\"!")
	
	value = int(value)
	var minutes: int = value / 60
	var second: int = value % 60
	
	var string := ""
	if minutes > 0:
		string += str(minutes) + "m "
	
	string += str(second) + "s"
	self.text = string
