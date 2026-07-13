extends ActionScript

static func execute(obj: Object) -> void:
	obj = obj as FlashlightNode
	
	if obj:
		obj.dmg_perc = 1.25
	
		print("Gived 1.2 of dmg percent, now turning on the timer")
		print("obj.dmg_perc = ", obj.dmg_perc)
		await obj.get_tree().create_timer(15).timeout
		print("Timer timeout! now the damage is 1.0")
	
	if obj:
		obj.dmg_perc = 1
