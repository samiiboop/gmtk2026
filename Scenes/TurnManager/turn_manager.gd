extends Node

# Change this reference later
@onready var enemy_manager: Node2D = $"../EnemyManager"

# Resolve all the effects an attacks of players and enemies

var countdown : float = 10

signal update_countdown(total : float)
# Keeps track of the count down and who's turn it is
#signal player_turn

signal player_action(action : PlayerAction)

signal enemy_turn
signal enemies_spawn_request

#signal enemy_resolve
func _ready() -> void:
	enemy_turn.connect(_enemy_action)
	spawn_next_wave()


func player_before():
	var enemy_list = enemy_manager.get_children()
	if enemy_list.is_empty():
		spawn_next_wave()

func _process(delta: float) -> void:
	# DEBUG
	var enemy_list = enemy_manager.get_children()
	if enemy_list.is_empty():
		spawn_next_wave()

func _on_player_action(action : PlayerAction):
	var enemy_list = enemy_manager.get_children()
	# Go to the action resolving menu
	player_action.emit(action)
	for i in action.target_damage.size():
		if action.target_damage[i] <= 0: continue
		for enemy in enemy_list:
			if enemy.grid_index == i:
				action.effect(enemy, countdown)
				break
		
	# We want to resolve before enemy turn
	await get_tree().create_timer(0.4).timeout
	enemy_turn.emit()



func _enemy_action():
	var enemy_list = enemy_manager.get_children()
	# Next round condition
	for enemy in enemy_list:
		# Debuggy enemy behavior i think it gets the point across
		if enemy.grid_index >= 3 and enemy.grid_index <= 5:
			countdown -= 0.5
		if enemy.grid_index >= 6:
			countdown -= 1
		$"../UI/CountDown/Label".text = str(countdown) # Change to signal later
	
	countdown -= 1


func spawn_next_wave():
	enemies_spawn_request.emit()
	countdown = 10
	update_countdown.emit(countdown)

func start():
	pass
