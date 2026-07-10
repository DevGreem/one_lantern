extends ShareableResource

class_name ItemEffect

@export var to_property: StringName
@export var operator: String
@export var effect: Variant

func evaluate(obj: Object) -> void:
	
	var ids := to_property.split(".")
	var prop = obj
	
	for i in range(ids.size()-1):
		prop = prop.get(ids[i])
	
	var expression := Expression.new()
	expression.parse(str(prop.get(ids[-1]))+operator+str(effect))
	
	prop.set(ids[-1], expression.execute())
