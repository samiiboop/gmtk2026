extends Node2D

# The grid managers job is to change and edit and keep track of a grid with
# enemies placed on it, it should have functions related to helping us get
# an enemy at tiles we are hitting

@export var grid = []

# Signals
signal grid_created

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_grid(3,3)

func create_grid(width : int, height : int):
	for y in height:
		var col = []
		col.resize(width)
		grid.append(col)
	
	# DEBUG
	$GridVisualizer.create_visuals(grid)
