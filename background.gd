extends Control

var room = 1
var door_open = false
var tiles = preload("res://Dungeon_Tileset.png")
var barrel = preload("res://props/barrel.png")
var chest = preload("res://props/chest_closed.png")
var chains = preload("res://props/wall_chains.png")
var bones = preload("res://props/bone_pile.png")
var skull = preload("res://props/skull.png")
var torch = preload("res://props/torch_wall_anim.png")
var candle = preload("res://props/candle_anim.png")
var closed_door = preload("res://props/door_closed.png")
var open_door = preload("res://props/door_open.png")

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

	if room == 1:
		draw_prop(barrel, Vector2(40, 90))
		draw_prop(barrel, Vector2(72, 110))
		draw_prop(barrel, Vector2(48, size.y - 100))
		draw_prop(barrel, Vector2(size.x - 76, size.y - 110))
		draw_prop(chest, Vector2(size.x - 90, 90))
		draw_prop(chest, Vector2(size.x - 130, 90))
	if room == 2:
		for x in [48, size.x - 112]:
			draw_prop(bones, Vector2(x, 90))
			draw_prop(bones, Vector2(x, size.y - 120))
		for x in [size.x * 0.3, size.x * 0.5, size.x * 0.7]:
			draw_prop(chains, Vector2(x, 16))
			draw_prop(skull, Vector2(x, size.y - 68))
	if room == 3:
		var center = size / 2
		draw_rect(Rect2(center - Vector2(80, 80), Vector2(160, 160)), Color(0.45, 0.12, 0.1), false, 3)
		draw_rect(Rect2(center - Vector2(56, 56), Vector2(112, 112)), Color(0.45, 0.12, 0.1), false, 3)
		for x in [size.x * 0.25, size.x * 0.5, size.x * 0.75]:
			draw_candle(Vector2(x, 64))
			draw_candle(Vector2(x, size.y - 80))
		for y in [size.y * 0.3, size.y * 0.6]:
			draw_candle(Vector2(48, y))
			draw_candle(Vector2(size.x - 80, y))
		draw_prop(bones, Vector2(48, 100))
		draw_prop(bones, Vector2(size.x - 112, size.y - 128))
		draw_prop(skull, Vector2(size.x / 2, 100))
	for x in [size.x * 0.2, size.x * 0.8]:
		draw_texture_rect_region(torch, Rect2(x, 24, 32, 32), Rect2(0, 0, 16, 16))

	if room < 3:
		var door = open_door if door_open else closed_door
		draw_texture_rect(door, Rect2(size.x / 2 - 24, 0, 48, 96), false)

func draw_prop(texture, pos):
	draw_texture_rect(texture, Rect2(pos, texture.get_size() * 2), false)

func draw_candle(pos):
	draw_texture_rect_region(candle, Rect2(pos, Vector2(32, 32)), Rect2(0, 0, 16, 16))
