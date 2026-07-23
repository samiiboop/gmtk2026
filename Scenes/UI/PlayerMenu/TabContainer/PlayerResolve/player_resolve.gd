extends Node

# Purely visual, we just wait for the text to scroll and do whatever effects here
# when they are done we go to the next turn
@onready var label: Label = $Label

signal player_action_resolved

func resolve_player_action(action : PlayerAction):
	label.visible_ratio = 0
	action.resolve_text
	var tween = get_tree().create_tween()
	
