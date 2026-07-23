class_name PlayerSpell extends PlayerAction


func effect(target : Enemy, countdown : float):
	target.deal_damage(countdown)
