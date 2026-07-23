extends Node

@onready var turn_manager: Node = $TurnManager
@onready var grid_manager: Node2D = $GridManager
@onready var enemy_manager: Node2D = $EnemyManager
@onready var player: Node = $Player

# UI References
@onready var fite: TabBar = $UI/PlayerMenu/MarginContainer/BackGround/TabContainer/Fite
@onready var magi: TabBar = $UI/PlayerMenu/MarginContainer/BackGround/TabContainer/Magi

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signal_setup()
	grid_manager.create_grid(3,3)

func signal_setup():
	grid_manager.grid_created.connect(enemy_manager._spawn_enemies)
	
	# player signals
	player.send_available_attacks.connect(fite._set_available_attacks)
	player.send_available_magi.connect(magi._set_available_attacks)
	player.update_ui()
	
	# turn manager signals
	turn_manager.player_resolve
	
	# UI signals
	fite.action_selected.connect(turn_manager._on_player_action)
	magi.action_selected.connect(turn_manager._on_player_action)
