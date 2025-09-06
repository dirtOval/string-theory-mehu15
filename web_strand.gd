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
