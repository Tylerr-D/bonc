extends Node2D

var wave = 0
var enemy_scene = preload("res://enemy.tscn")

func _process(delta):
	if get_tree().get_nodes_in_group("enemies").is_empty():
		start_wave()

func start_wave():
	wave += 1
	$HUD/Wave.text = "Wave " + str(wave)
	var screen = get_viewport_rect().size
	var x = 60
	if $Player.get_global_transform_with_canvas().origin.x < screen.x / 2:
		x = screen.x - 60
	for i in range(wave + 2):
		var enemy = enemy_scene.instantiate()
		var pos = Vector2(x, randf_range(90, screen.y - 60))
		add_child(enemy)
		enemy.global_position = get_canvas_transform().affine_inverse() * pos
