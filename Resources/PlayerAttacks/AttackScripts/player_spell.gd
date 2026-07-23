class_name PlayerSpell extends PlayerAttack


func effect(target : Enemy, countdown : float):
	target.deal_damage(countdown)
