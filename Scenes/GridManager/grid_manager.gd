extends Node2D

# The grid managers job is to change and edit and keep track of a grid with
# enemies placed on it, it should have functions related to helping us get
# an enemy at tiles we are hitting

var grid = []

@onready var grid_visualizer: Node2D = $GridVisualizer


# Signals
signal grid_created(child_grid : Array) # We are actually just going to return the list of children under the visualizer


func create_grid(width : int, height : int):
	for y in height:
		var col = []
		col.resize(width)
		grid.append(col)
	
	# DEBUG
	grid_visualizer.create_visuals(grid)
	print("EMIT")
	grid_created.emit(grid_visualizer.get_children())
