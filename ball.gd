extends Node2D

var direction = Vector2.ZERO
var speed = 220
var life = 5.0
var bounce_time = 0.0

func _draw():
	draw_arc(Vector2.ZERO, 5, 0, TAU, 24, Color.BLACK, 2, true)

func _physics_process(delta):
	position += direction * speed * delta
	bounce_time -= delta
	if bounce_time <= 0:
		var shield = get_parent().get_node("Player/ShieldPivot/Shield")
		for i in range(shield.points.size() - 1):
			var start = shield.to_global(shield.points[i])
			var end = shield.to_global(shield.points[i + 1])
			var closest = Geometry2D.get_closest_point_to_segment(global_position, start, end)
			if global_position.distance_to(closest) <= 6:
				var normal = (end - start).orthogonal().normalized()
				direction = direction.bounce(normal)
				global_position += direction * 7
				bounce_time = 0.15
				shield.get_node("../../AudioStreamPlayer2D").play()
				break
	life -= delta
	if life <= 0:
		queue_free()
