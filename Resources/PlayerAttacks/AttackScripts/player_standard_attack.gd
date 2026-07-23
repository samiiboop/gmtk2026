class_name StandardAttack extends PlayerAttack

func effect(enemy : Enemy, countdown : float):
	enemy.deal_damage(10)
