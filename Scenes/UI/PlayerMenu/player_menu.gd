extends Control

@onready var main: TabBar = $MarginContainer/BackGround/TabContainer/Main
@onready var tab_container: TabContainer = $MarginContainer/BackGround/TabContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open_main_tab()
	signal_setup()

func signal_setup():
	# Kinda a sloppy way of doing it but looks better in editor :\
	main.fite.selected.connect(open_fite_tab)
	main.magi.selected.connect(open_magi_tab)

func open_fite_tab():
	tab_container.current_tab = 1

func open_magi_tab():
	tab_container.current_tab = 2

func _open_player_resolve_tab(_player_action : PlayerAction):
	tab_container.current_tab = 3

func _open_enemy_resolve_tab():
	tab_container.current_tab = 4

func open_main_tab():
	tab_container.current_tab = 0

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("cancel") and tab_container.current_tab < 3:
		open_main_tab()
