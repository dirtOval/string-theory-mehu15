extends Area2D
var spider_state: String
var spider_target: Node2D
@export var spider_speed: int

signal ate_food

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spider_state = 'wait'
	$AnimatedSprite2D.play('wait')
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spider_state == 'wait':
		wait_for_flies()
	elif spider_state == 'select':
		spider_target = find_closest_food()
		spider_state = 'walking'
		#$AnimatedSprite2D.animation = 'walk'
		$AnimatedSprite2D.play('walk')
	elif spider_state == 'walking':
		go_to_food(delta)
	else:
		pass
	

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


func _on_body_entered(body: Node2D) -> void:
	spider_target = null
	spider_state = 'eat'
	$AnimatedSprite2D.play('eat', 1.0)
	print('yom')
	await get_tree().create_timer(1.0).timeout
	$ChompSound.play()
	#send a signal to timer to restart
	body.queue_free()
	ate_food.emit()
	spider_state = 'wait'
	$AnimatedSprite2D.play('wait')


func _on_food_timer_timeout() -> void:
	spider_state = 'dead'
	$AnimatedSprite2D.play('dead')
