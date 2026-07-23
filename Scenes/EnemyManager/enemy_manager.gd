extends Node2D

var wave_index : int = 0
@export var waves : Array[EnemyWave]

func _spawn_enemies(grid : Array):
	var wave = waves[wave_index].enemies
	wave_index += 1
	print("Attempting spawn")
	for i in min(wave.size(), grid.size()):
		print(i, grid)
		print("SPAWNING")
		if !wave[i]: continue
		
		var to_spawn = wave[i].instantiate()
		to_spawn.grid_index = i

		add_child(to_spawn)
		if i >= 3 and i <= 5:
			to_spawn.scale *= 1.5
		if i >= 6:
			to_spawn.scale *= 2
		
		to_spawn.global_position = grid[i].global_position
