extends ProgressBar

@export var player: Player:
	set(res):
		
		player = res
		
		if player and player.flashlight:
			
			if player.flashlight.info:
				max_value = player.flashlight.info.max_duration

func _process(_delta: float) -> void:
	
	if not player:
		return
	
	if not player.flashlight:
		return
	
	if not player.flashlight.info:
		return
		
	self.max_value = player.flashlight.info.max_duration
	self.value = player.flashlight.duration
