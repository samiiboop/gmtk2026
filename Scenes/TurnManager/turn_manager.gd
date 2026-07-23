extends Node

# Change this reference later
@onready var enemy_manager: Node2D = $"../EnemyManager"

# Resolve all the effects an attacks of players and enemies

var countdown : float = 10

signal update_countdown(total : float)
# Keeps track of the count down and who's turn it is
#signal player_turn

signal player_resolve

signal enemy_turn

#signal enemy_resolve
func _ready() -> void:
	enemy_turn.connect(_enemy_action)


#signal update_countdown(countdown : float)
func _on_player_action(action : PlayerAttack):
	var enemy_list = enemy_manager.get_children()
	for i in action.target_damage.size():
		if action.target_damage[i] <= 0: continue
		for enemy in enemy_list:
			if enemy.grid_index == i:
				action.effect(enemy, countdown)
				break
	# We want to resolve before enemy turn
	enemy_turn.emit()

func _on_player_resolve_finished():
	pass

func _enemy_action():
	var enemy_list = enemy_manager.get_children()
	for enemy in enemy_list:
		if enemy.grid_index >= 6:
			countdown -= 1
		$"../UI/CountDown/Label".text = str(countdown) # Change to signal later

func start():
	pass
