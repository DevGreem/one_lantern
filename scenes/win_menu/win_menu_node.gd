extends CenterContainer

class_name WinMenuNode

@onready var label: Label = $Container/Label

func win(level: LevelData):
	
	self.show()
	label.text = label.text.format([level.name])
