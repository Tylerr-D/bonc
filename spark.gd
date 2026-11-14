extends Node2D

var life = 0.05

func _draw():
	draw_line(Vector2(-8, 0), Vector2(8, 0), Color.YELLOW, 2)
	draw_line(Vector2(0, -8), Vector2(0, 8), Color.YELLOW, 2)
	draw_line(Vector2(-5, -5), Vector2(5, 5), Color.YELLOW, 2)
	draw_line(Vector2(-5, 5), Vector2(5, -5), Color.YELLOW, 2)

func _process(delta):
	life -= delta
	if life <= 0:
		queue_free()
