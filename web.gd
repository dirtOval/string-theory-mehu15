extends Node2D

var web_strand = preload('res://web_strand.tscn')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_strand = web_strand.instantiate()
	new_strand.get_node('Line2D').add_point(Vector2(300.0, 300.0))
	new_strand.get_node('Line2D').add_point(Vector2(400.0, 300.0))
	add_child(new_strand)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
