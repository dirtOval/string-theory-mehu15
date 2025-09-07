extends ColorRect
signal start_game(seed: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_text_submitted(new_text: String) -> void:
	#print(hash(new_text))
	#print(len(str(hash(new_text))))
	start_game.emit(new_text)
	hide()
