extends Node

@onready var turn_manager: Node = $TurnManager
@onready var grid_manager: Node2D = $GridManager
@onready var enemy_manager: Node2D = $EnemyManager
@onready var player: Node = $Player

# UI References
@onready var player_menu: Control = $UI/PlayerMenu
@onready var fite: TabBar = $UI/PlayerMenu/MarginContainer/BackGround/TabContainer/Fite
@onready var magi: TabBar = $UI/PlayerMenu/MarginContainer/BackGround/TabContainer/Magi
@onready var player_resolve: TabBar = $UI/PlayerMenu/MarginContainer/BackGround/TabContainer/PlayerResolve
@onready var enemy_resolve: TabBar = $UI/PlayerMenu/MarginContainer/BackGround/TabContainer/EnemyResolve

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signal_setup()
	grid_manager.create_grid(3,3)
	# methods
	turn_manager.spawn_next_wave()

func signal_setup():
	
	# player signals
	player.send_available_attacks.connect(fite._set_available_attacks)
	player.send_available_magi.connect(magi._set_available_attacks)
	player.update_ui()
	
	# turn manager signals
	#turn_manager.player_resolve
	turn_manager.enemies_spawn_request.connect(grid_manager._enemy_request)
	turn_manager.player_action.connect(player_menu._open_player_resolve_tab)
	turn_manager.player_action.connect(player_resolve._resolve_player_action)
	turn_manager.player_turn.connect(player_menu.open_main_tab)
	turn_manager.player_turn.connect(magi._check_cooldowns)
	turn_manager.enemy_action.connect(player_menu._open_enemy_resolve_tab)
	turn_manager.enemy_action.connect(enemy_resolve._resolve_enemy_action)
	
	# Grid signals
	grid_manager.pass_grid.connect(enemy_manager._spawn_enemies)
	
	# UI signals 
	fite.action_selected.connect(turn_manager._on_player_action)
	fite.countdown_getter = turn_manager.get_countdown # callable
	
	magi.action_selected.connect(turn_manager._on_player_action)
	magi.countdown_getter = turn_manager.get_countdown # callable
	
	player_resolve.player_action_resolved.connect(turn_manager._enemy_action)
