class_name PlayerSpell extends PlayerAction


func effect(target : Enemy, countdown : float):
	target.deal_damage(countdown)

func get_description(countdown : float) -> String:
	var result = countdown
	var new_string = description.replace("X", "[color=yellow]" + str(countdown) + "[/color]")
	return new_string + " = [color=aqua]" + str(result) + "[/color]"
