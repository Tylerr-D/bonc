extends CharacterBody2D

var speed = 240

func _physics_process(delta):
	# bleh 
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	move_and_slide()
