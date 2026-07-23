extends Node

# Purely visual, we just wait for the text to scroll and do whatever effects here
# when they are done we go to the next turn
@onready var label: Label = $Label

signal player_action_resolved
signal enemy_action_resolved

func _resolve_player_action(action : PlayerAction):
	label.visible_ratio = 0
	label.text = action.resolve_text
	var tween = get_tree().create_tween()
	tween.tween_property(label, "visible_ratio", 1, 0.4)
	
	await tween.finished
	await get_tree().create_timer(1).timeout
	
	player_action_resolved.emit()

func _resolve_enemy_action():
	label.visible_ratio = 0
	label.text = "It's the enemies turn!"
	var tween = get_tree().create_tween()
	tween.tween_property(label, "visible_ratio", 1, 0.4)
	
	await tween.finished
	await get_tree().create_timer(0.5).timeout
	
	enemy_action_resolved.emit()
