extends Area2D

#func _init(a: Vector2, b: Vector2):
	##set the X and Y of the line and collision shape
	#$Line2D.add_point(a)
	#$Line2D.add_point(b)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var die_roll = randi_range(0, 2)
	if die_roll == 2:
		body.get_node("AnimatedSprite2D").animation = 'stuck'
		body.get_node('BuzzSound').stop()
		body.get_node('CaughtSound').play()
		body.linear_velocity = Vector2(0, 0)
		body.add_to_group('caught_flies')
