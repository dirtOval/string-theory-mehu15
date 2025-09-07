extends Node2D

var fly_scene = preload('res://fly.tscn')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FlySpawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
