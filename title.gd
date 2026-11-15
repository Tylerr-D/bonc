extends Control

func _ready():
	$Music.stream.loop = true
	$Title.position.y = -100
	var tween = create_tween()
	tween.tween_property($Title, "position:y", get_viewport_rect().size.y * 0.4 - 50, 0.65).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func start():
	load("res://main.gd").saved_level = 1
	get_tree().change_scene_to_file("res://main.tscn")
