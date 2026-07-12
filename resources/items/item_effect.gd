extends ShareableResource

class_name ItemEffect

@export var to_property: StringName
@export var operator: String
@export var effect: Variant
@export var action: Script
@export var wait_time := -1.0

func evaluate(obj: Object) -> void:
	
	if action:
		action.execute(obj)
		return
	
	var ids := to_property.split(".")
	var prop = obj
	
	for i in range(ids.size()-1):
		prop = prop.get(ids[i])
	
	if operator == "=":
		prop.set(ids[-1], effect)
		return
	
	var expression := Expression.new()
	expression.parse(str(prop.get(ids[-1]))+operator+str(effect))
	
	prop.set(ids[-1], expression.execute())
