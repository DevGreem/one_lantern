extends ShareableResource

class_name ItemsContainer

@export var items: Array[WeightData] = []

var _weight_cache := WeightCache.new()
func total_weight() -> int:
	
	if items.size() == _weight_cache.size:
		return _weight_cache.value
	
	var sum := 0
	for item in items:
		sum += item.weight
	
	_weight_cache.size = items.size()
	_weight_cache.value = sum
	
	return sum

func get_random_item() -> ItemData:
	
	var weight := randi_range(1, total_weight())
	
	for item in items:
		
		weight -= item.weight
		
		if weight <= 0:
			return item.item
	
	var default := ItemData.new()
	default.name = "NonGenerated"
	
	return default
