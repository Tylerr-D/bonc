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
