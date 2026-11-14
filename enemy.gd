extends CharacterBody2D

# so i aint writing ALL the scripts myself. 
# these are popular things you could find if ya do a search
var speed = 150
var health = 3
var flash_time = 0.0
var direction = Vector2.ZERO
var time = 0.0
var shoot_time = 2.0
var ball_scene = preload("res://ball.tscn")

func _physics_process(delta):
	if flash_time > 0:
		flash_time -= delta
		if flash_time <= 0:
			$Sprite2D.modulate = Color.WHITE
	shoot_time -= delta
	if shoot_time <= 0:
		var ball = ball_scene.instantiate()
		get_parent().add_child(ball)
		ball.global_position = global_position + Vector2(16, -8)
		ball.direction = (get_parent().get_node("Player").global_position - ball.global_position).normalized()
		shoot_time = 2.0

	time -= delta

	if time <= 0:
		direction = Vector2.from_angle(randf() * TAU)
		time = randf_range(0.5, 2.0)

	velocity = direction * speed
	move_and_slide()
	
	var screen = get_viewport_rect().size
	var pos = get_global_transform_with_canvas().origin

	if pos.x < 20:
		direction.x = abs(direction.x)
	if pos.x > screen.x - 20:
		direction.x = -abs(direction.x)
	if pos.y < 60:
		direction.y = abs(direction.y)
	if pos.y > screen.y - 35:
		direction.y = -abs(direction.y)
	pos = pos.clamp(Vector2(28, 60), screen - Vector2(28, 35))
	global_position = get_canvas_transform().affine_inverse() * pos
		
func take_damage():
	if health <= 0:
		return
	health -= 1
	flash_time = 0.12
	$Sprite2D.modulate = Color(1, 0.25, 0.25)
	get_node("Hearts/Heart" + str(health + 1)).hide()
	print("Health: ", health)

	if health <= 0:
		queue_free()
	
