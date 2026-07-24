extends Node

@onready var enemy_manager: Node2D = $"../EnemyManager"

var countdown : float = 10

signal update_countdown(total : float)
signal player_turn
signal player_action(action : PlayerAction)
signal enemy_action
signal enemy_turn
signal enemies_spawn_request

func _ready() -> void:
	# Signals we can connect within script.
	player_turn.connect(_on_player_turn)
	enemy_turn.connect(_enemy_action)
	
	spawn_next_wave() # Spawn the first wave, this will change
	player_turn.emit() # Start the first turn

func _on_player_turn():
	# When we start our turn check if we have enemies
	if enemy_manager.get_child_count() == 0:
		spawn_next_wave()

# we get this from the menu with our action
func _on_player_action(action : PlayerAction):
	var enemy_list = enemy_manager.get_children()
	for i in action.target_damage.size():
		if action.target_damage[i] <= 0: continue
		for enemy in enemy_list:
			if enemy.grid_index == i:
				action.effect(enemy, countdown)
				break # Found valid target
	# Resolve the action with text
	if enemy_manager.get_child_count() > 0:
		player_action.emit(action) # Signal out the action to be resolved



func _enemy_action():
	var enemy_list = enemy_manager.get_children()
	enemy_action.emit()
	print("enemies turn")
	
	for enemy in enemy_list:
		if not is_instance_valid(enemy): 
			continue 
		
		var action = enemy.attacks.pick_random()
		var damage = action.effect()
		countdown -= snapped(damage, 0.1) 
		$"../UI/CountDown/Label".text = str(countdown)
		var tween = create_tween()
		tween.tween_property(enemy, "global_position:y", enemy.global_position.y + 10, 0.15)
		tween.tween_property(enemy, "global_position:y", enemy.global_position.y - 10, 0.15)
		await tween.finished

	countdown -= 1
	countdown = snapped(countdown, 0.1)
	$"../UI/CountDown/Label".text = str(countdown)
	player_turn.emit()


func spawn_next_wave():
	countdown = 10
	$"../UI/CountDown/Label".text = str(countdown)
	print("spawn_next_wave set label to: ", $"../UI/CountDown/Label".text)
	enemies_spawn_request.emit()

func get_countdown() -> float:
	return countdown
