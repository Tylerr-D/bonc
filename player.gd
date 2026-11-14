extends CharacterBody2D

var speed = 240
var health = 3

func _physics_process(delta):
	# bleh 
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	move_and_slide()

# website used for this - https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html

	$ShieldPivot.look_at(get_global_mouse_position())
	$ShieldPivot.rotate(PI)

func take_damage():
	health -= 1
	print("Health: ", health)
	if health <= 0:
		get_tree().call_deferred("reload_current_scene")
