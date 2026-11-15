extends Control

var tiles = preload("res://Dungeon_Tileset.png")
var barrel = preload("res://props/barrel.png")
var chest = preload("res://props/chest_closed.png")
var chains = preload("res://props/wall_chains.png")
var bones = preload("res://props/bone_pile.png")
var skull = preload("res://props/skull.png")
var torch = preload("res://props/torch_wall_anim.png")

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

	draw_prop(barrel, Vector2(40, 90))
	draw_prop(barrel, Vector2(72, 110))
	draw_prop(barrel, Vector2(size.x - 76, size.y - 110))
	draw_prop(chest, Vector2(size.x - 90, 90))
	draw_prop(bones, Vector2(42, size.y - 120))
	draw_prop(bones, Vector2(size.x - 110, size.y * 0.55))
	draw_prop(skull, Vector2(size.x * 0.3, size.y - 68))
	draw_prop(skull, Vector2(size.x * 0.7, 48))
	draw_prop(chains, Vector2(size.x * 0.35, 16))
	draw_prop(chains, Vector2(size.x * 0.65, 16))
	for x in [size.x * 0.2, size.x * 0.8]:
		draw_texture_rect_region(torch, Rect2(x, 24, 32, 32), Rect2(0, 0, 16, 16))

func draw_prop(texture, pos):
	draw_texture_rect(texture, Rect2(pos, texture.get_size() * 2), false)
