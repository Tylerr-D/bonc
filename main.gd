extends Node2D

static var saved_level = 1
var level = saved_level - 1
var counts = [2, 3, 5]
var speeds = [80, 110, 150]
var hearts = [2, 3, 2]
var enemy_scene = preload("res://enemy.tscn")

func _process(delta):
	if level < 3 and get_tree().get_nodes_in_group("enemies").is_empty():
		start_level()

func start_level():
	level += 1
	saved_level = level
	$Player.health = 3
	$Player.recoil = Vector2.ZERO
	$Player.flash_time = 0
	$Player/Sprite2D.modulate = Color.WHITE
	for i in range(1, 4):
		get_node("HUD/Heart" + str(i)).show()
	for ball in get_tree().get_nodes_in_group("balls"):
		ball.set_physics_process(false)
		ball.queue_free()
	$HUD/Wave.text = "Level " + str(level)
	var screen = get_viewport_rect().size
	var x = 60
	if $Player.get_global_transform_with_canvas().origin.x < screen.x / 2:
		x = screen.x - 60
	for i in range(counts[level - 1]):
		var enemy = enemy_scene.instantiate()
		var pos = Vector2(x, randf_range(90, screen.y - 60))
		enemy.speed = speeds[level - 1]
		enemy.health = hearts[level - 1]
		add_child(enemy)
		enemy.get_node("Hearts/Heart3").visible = enemy.health == 3
		enemy.global_position = get_canvas_transform().affine_inverse() * pos

func play_sound(sound):
	var audio = AudioStreamPlayer.new()
	audio.stream = sound
	audio.volume_db = -22
	add_child(audio)
	audio.finished.connect(audio.queue_free)
	audio.play()
