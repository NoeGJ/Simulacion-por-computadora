extends Node

@export var mob_scene: PackedScene
@export var npc_scene: PackedScene

var score
var collection

var screen_size # Size of the game window.

# contador de coleccionables
var npc_counter = 0
# define el maximo de coleccionables
var max_npc = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size

func spawn_npc():
	var npc = npc_scene.instantiate()
	npc.collected.connect(_on_npc_collected)
	
	var position = Vector2(
		randf_range(0, screen_size.x),
		randf_range(0, screen_size.y)
	)
	npc.position = position
	add_child(npc)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$NPCTimer.stop()
	

func new_game():
	score = 0
	collection = 0
	npc_counter = 0
	$HUD.update_score(score)
	$HUD.update_collection(collection, max_npc)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	get_tree().call_group("npc", "queue_free")
	$NPCTimer.start()


func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_npc_collected() -> void:
	npc_counter += 1
	$HUD.update_collection(npc_counter, max_npc)
	if ( npc_counter >= max_npc ):
		print("Limite alcanzado")


func _on_npc_timer_timeout() -> void:
	if npc_counter < max_npc:
		spawn_npc()
