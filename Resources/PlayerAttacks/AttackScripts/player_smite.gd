class_name PlayerSmite extends PlayerAction


func effect(target : Enemy, countdown : float):
	target.deal_damage((damage - countdown) * 3)

func get_description(countdown : float) -> String:
	var result = (damage - countdown) * 3
	var new_string = description.replace("X", "[color=yellow]" + str(countdown) + "[/color]")
	var recovery = "Gains charge when countdown is at or below [color=green]" + str(cooldown) + "[/color]"
	return new_string + " = [color=aqua]" + str(result) + "[/color] \n" + recovery
