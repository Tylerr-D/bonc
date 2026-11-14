extends Control

var tiles = preload("res://Dungeon_Tileset.png")

func _ready():
	resized.connect(queue_redraw)

func _draw():
	for y in range(0, int(size.y), 32):
		for x in range(0, int(size.x), 32):
			draw_texture_rect_region(tiles, Rect2(x, y, 32, 32), Rect2(96, 0, 16, 16))
	for x in range(0, int(size.x), 32):
		draw_texture_rect_region(tiles, Rect2(x, 0, 32, 32), Rect2(16, 0, 16, 16))
		draw_texture_rect_region(tiles, Rect2(x, size.y - 32, 32, 32), Rect2(16, 64, 16, 16))
	for y in range(32, int(size.y) - 32, 32):
		draw_texture_rect_region(tiles, Rect2(0, y, 32, 32), Rect2(8, 16, 8, 16))
		draw_texture_rect_region(tiles, Rect2(size.x - 32, y, 32, 32), Rect2(80, 16, 8, 16))
