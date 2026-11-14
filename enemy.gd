extends CharacterBody2D

# so i aint writing ALL the scripts myself. 
# these are popular things you could find if ya do a search
var speed = 150
var direction = Vector2.ZERO
var time = 0.0

func _physics_process(delta):
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
	if pos.y < 35:
		direction.y = abs(direction.y)
	if pos.y > screen.y - 35:
		direction.y = -abs(direction.y)
