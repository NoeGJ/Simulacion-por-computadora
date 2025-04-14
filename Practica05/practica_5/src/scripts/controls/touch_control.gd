extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$right.hide()
	$left.hide()
	$up.hide()
	$down.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func hide_controls():
	$right.hide()
	$left.hide()
	$up.hide()
	$down.hide()

func show_controls():
	$right.show()
	$left.show()
	$up.show()
	$down.show()
