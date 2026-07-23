extends Node2D

@export var spawn_example : Array[PackedScene]


func _spawn_enemies(grid : Array):
	print("Attempting spawn")
	for i in min(spawn_example.size(), grid.size()):
		print("SPAWNING")
		if !spawn_example[i]: continue
		
		var to_spawn = spawn_example[i].instantiate()
		add_child(to_spawn)
		to_spawn.global_position = grid[i].global_position
