extends Area2D
var spider_state: String
var spider_target: Node2D
@export var spider_speed: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spider_state = 'wait'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spider_state == 'wait':
		wait_for_flies()
	elif spider_state == 'select':
		spider_target = find_closest_food()
		spider_state = 'eating'
	elif spider_state == 'eating':
		go_to_food(delta)

func wait_for_flies() -> void:
	if get_tree().get_nodes_in_group("caught_flies").size() > 0:
		spider_state = 'select'

func find_closest_food() -> Node2D:
	var closest: Node2D = null
	var closest_distance: float = INF
	for fly in get_tree().get_nodes_in_group('caught_flies'):
		var distance = global_position.distance_squared_to(fly.global_position)
		if distance < closest_distance:
			closest = fly
			closest_distance = distance
	return closest
	
func go_to_food(delta: float) -> void:
	global_position = global_position.move_toward(spider_target.global_position, delta * spider_speed)
