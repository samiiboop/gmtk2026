extends Node2D

#DEBUG preload the icon to be our sprite for grid stuff for now

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
	var mult = 1.0
	if _tiles_y == 3:
		mult *= 2.0
	elif _tiles_y == 3 - 1:
		mult *= 1.5
	if mult != 1.0:
		var center_x = (3 - 1) * tile_size / 2.0
		pos.x = center_x + (pos.x - center_x) * mult
	var marker = Marker2D.new()
	add_child(marker)
	marker.global_position = pos + get_viewport_rect().size /2 - Vector2(tile_size,tile_size * 2)
