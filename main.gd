extends Node2D

static var saved_level = 1
var level = saved_level - 1
var counts = [2, 3, 5]
var speeds = [80, 110, 150]
var hearts = [2, 3, 2]
var enemy_scene = preload("res://enemy.tscn")
var title_tween
var starting = false

func _ready():
	$Music.stream.loop = true

func _process(delta):
	if not starting and level < 3 and get_tree().get_nodes_in_group("enemies").is_empty():
		start_level()

func start_level():
	starting = true
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
	if title_tween:
		title_tween.kill()
	$HUD/Wave.position.y = -100
	$HUD/Wave.modulate.a = 1
	title_tween = create_tween()
	title_tween.tween_property($HUD/Wave, "position:y", screen.y / 2 - 50, 0.65).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	title_tween.tween_interval(0.7)
	title_tween.tween_property($HUD/Wave, "modulate:a", 0.0, 0.25)
	await get_tree().create_timer(2.0).timeout
	screen = get_viewport_rect().size
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
	starting = false

func play_sound(sound):
	var audio = AudioStreamPlayer.new()
	audio.stream = sound
	audio.volume_db = -22
	add_child(audio)
	audio.finished.connect(audio.queue_free)
	audio.play()

func die():
	set_process(false)
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.set_physics_process(false)
	for ball in get_tree().get_nodes_in_group("balls"):
		ball.set_physics_process(false)
	if title_tween:
		title_tween.kill()
	var title = $HUD/Wave
	var screen = get_viewport_rect().size
	title.text = "DEAD"
	title.position.y = screen.y / 2 - 50
	title.pivot_offset = Vector2(screen.x / 2, 50)
	title.scale = Vector2(0.6, 0.6)
	title.modulate = Color(1, 0.15, 0.15, 0)
	title_tween = create_tween()
	title_tween.tween_property(title, "scale", Vector2.ONE, 0.3)
	title_tween.parallel().tween_property(title, "modulate:a", 1.0, 0.3)
	title_tween.tween_interval(1.2)
	await title_tween.finished
	get_tree().call_deferred("reload_current_scene")
