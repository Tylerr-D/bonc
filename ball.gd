extends Node2D

var direction = Vector2.ZERO
var speed = 220
var life = 5.0
var bounce_time = 0.0
var reflected = false

func _draw():
	draw_arc(Vector2.ZERO, 5, 0, TAU, 24, Color(1, 0.95, 0.8), 2, true)

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
				var spark = preload("res://spark.gd").new()
				get_parent().add_child(spark)
				spark.global_position = closest
				var normal = (end - start).orthogonal().normalized()
				get_parent().get_node("Player").recoil = direction * 180
				direction = direction.bounce(normal)
				reflected = true
				global_position += direction * 7
				bounce_time = 0.15
				break
	if reflected:
		for enemy in get_tree().get_nodes_in_group("enemies"):
			var body = enemy.get_node("CollisionShape2D")
			if body.shape.get_rect().grow(5).has_point(body.to_local(global_position)):
				enemy.take_damage()
				queue_free()
				return
	life -= delta
	if life <= 0:
		queue_free()
		
	if not reflected:
		var player = get_parent().get_node("Player")
		if global_position.distance_to(player.global_position) < 21:
			player.take_damage()
			queue_free()
			return
