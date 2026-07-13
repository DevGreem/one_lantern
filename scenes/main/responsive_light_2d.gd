extends PointLight2D

class_name ResponsiveLight2D

@export var node: Control
@export var light_offset: Vector2

# Called when the node enters the scene tree for the first time.
func _process(_delta):
	
	var _scale := node.get_global_transform_with_canvas().get_scale()
	
	if node is TextureRect:
		var texture_size: Vector2 = node.texture.get_size() * _scale
		
		self.global_position = node.global_position + (texture_size*light_offset)
