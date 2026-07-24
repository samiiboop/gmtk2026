class_name StandardAttack extends PlayerAction

func effect(enemy : Enemy, countdown : float):
	enemy.deal_damage(damage)

func get_description(countdown : float) -> String:
	var result = damage
	var new_string = description.replace("X", "[color=yellow]" + str(countdown) + "[/color]")
	return new_string + " = [color=aqua]" + str(result) + "[/color]"
