extends Node2D

var web_strand = preload('res://web_strand.tscn')
@export var strands: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_web(strands)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func random_web(strands: int):
	var screen_width = get_viewport().size.x
	var screen_height = get_viewport().size.y
	for i in range(strands):
		var a = Vector2(randf_range(0, screen_width), randf_range(0, screen_height))
		var b = Vector2(randf_range(0, screen_width), randf_range(0, screen_height))
		add_strand(a, b)

func add_strand(a: Vector2, b: Vector2):
	var new_strand = web_strand.instantiate()
	#draw the webs
	new_strand.get_node('Line2D').add_point(a)
	new_strand.get_node('Line2D').add_point(b)
	#collision segments!
	new_strand.get_node('CollisionShape2D').shape.a = a
	new_strand.get_node('CollisionShape2D').shape.b = b
	
	add_child(new_strand)
