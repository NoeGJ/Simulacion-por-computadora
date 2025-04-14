extends CanvasLayer


signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$collection.hide()
	$IconColection.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$collection.hide()
	$StartButton.show()
	$IconColection.hide()
	$bg.show()
	

func update_score(score):
	$ScoreLabel.text = str(score)

func update_collection(value, max):
	$collection.text = str(value) + "/" + str(max)

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$collection.show()
	$bg.hide()
	$IconColection.show()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()
