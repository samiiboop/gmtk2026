extends Node2D

#DEBUG preload the icon to be our sprite for grid stuff for now
const ICON = preload("uid://cogdba0jll7mc")

var tile_size = 128
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_grid_create():
	pass

func create_visuals(grid : Array):
	for y in grid.size():
		for x in grid[y].size():
			debug_spawn(Vector2(x, y) * tile_size, x, y)

func debug_spawn(pos : Vector2, _tiles_x : int, _tiles_y : int):
	var sprite = Sprite2D.new()
	sprite.texture = ICON
	add_child(sprite)
	sprite.global_position = pos + get_viewport_rect().size /2 - Vector2(tile_size,tile_size * 2)
