extends Node

@onready var grid_manager: Node2D = $GridManager
@onready var enemy_manager: Node2D = $EnemyManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signal_setup()
	grid_manager.create_grid(3,3)

func signal_setup():
	grid_manager.grid_created.connect(enemy_manager._spawn_enemies)
