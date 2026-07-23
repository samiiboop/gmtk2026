class_name StandardAttack extends PlayerAction

func effect(enemy : Enemy, countdown : float):
	enemy.deal_damage(10)
