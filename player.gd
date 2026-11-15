extends CharacterBody2D

var speed = 240
var health = 3
var flash_time = 0.0
var recoil = Vector2.ZERO

func _physics_process(delta):
	if flash_time > 0:
		flash_time -= delta
		if flash_time <= 0:
			$Sprite2D.modulate = Color.WHITE
	# bleh 
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed + recoil
	move_and_slide()
	recoil = recoil.move_toward(Vector2.ZERO, 600 * delta)
	var screen = get_viewport_rect().size
	var pos = get_global_transform_with_canvas().origin
	if pos.x <= 55:
		recoil.x = 400
	if pos.x >= screen.x - 55:
		recoil.x = -400
	if pos.y <= 55:
		recoil.y = 400
	if pos.y >= screen.y - 55:
		recoil.y = -400
	pos = pos.clamp(Vector2(55, 55), screen - Vector2(55, 55))
	global_position = get_canvas_transform().affine_inverse() * pos

# website used for this - https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html

	$ShieldPivot.look_at(get_global_mouse_position())
	$ShieldPivot.rotate(PI)

func take_damage():
	if health <= 0:
		return
	get_parent().play_sound(preload("res://sounds/impactPunch_medium_000.ogg"))
	health -= 1
	flash_time = 0.12
	$Sprite2D.modulate = Color(1, 0.25, 0.25)
	get_parent().get_node("HUD/Heart" + str(health + 1)).hide()
	print("Health: ", health)
	if health <= 0:
		get_tree().call_deferred("reload_current_scene")
