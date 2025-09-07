extends Node2D

var fly_scene = preload('res://fly.tscn')

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#animate BG
	#$Main/BG/FastNoiseLite.offset += Vector3(
		#randf_range(1.0, 5.0),
		#randf_range(1.0, 5.0),
		#randf_range(1.0, 5.0),
		#)
	$FoodBar.value = $FoodTimer.time_left


func _on_fly_spawn_timer_timeout() -> void:
	var fly = fly_scene.instantiate()
	var fly_spawn_location = $FlyPath/FlySpawnLocation
	fly_spawn_location.progress_ratio = randf()
	fly.position = fly_spawn_location.position
	var direction = fly_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI /4)
	fly.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	fly.linear_velocity = velocity.rotated(direction)
	
	add_child(fly)
	$FlySpawnTimer.start(randf_range(1, 45))


func _on_spider_ate_food() -> void:
	$FoodTimer.start()


func _on_food_timer_timeout() -> void:
	print('spider has died')
	$LifeTimer.stop()
	$FlySpawnTimer.stop()
	$GameOverScreen/FinalScore.text = 'Spider Lived for ' + get_converted_time(score)
	$GameOverScreen.show()
	#use this for game over logic

func get_converted_time(time: int) -> String:
	var minutes: int = floori(time / 60.0)
	var seconds: int = time % 60
	return "%02d:%02d" % [minutes, seconds]


func _on_life_timer_timeout() -> void:
	score += 1
	$ScoreDisplay.text = str(get_converted_time(score))


func _on_string_prompt_start_game(string: String) -> void:
	print('game starting')
	$Web.web_from_seed(hash(string))
	$FlySpawnTimer.start()
	$FoodTimer.start()
	$LifeTimer.start()
	$Spider.show()


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
