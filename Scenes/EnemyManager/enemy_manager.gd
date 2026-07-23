extends Node2D

@export var spawn_example : Array[PackedScene]


func _spawn_enemies(grid : Array):
	print("Attempting spawn")
	for i in min(spawn_example.size(), grid.size()):
		print("SPAWNING")
		if !spawn_example[i]: continue
		
		var to_spawn = spawn_example[i].instantiate()
		to_spawn.grid_index = i

		add_child(to_spawn)
		if i >= 3 and i <= 5:
			to_spawn.scale *= 1.5
		if i >= 6:
			to_spawn.scale *= 2
		
		to_spawn.global_position = grid[i].global_position
