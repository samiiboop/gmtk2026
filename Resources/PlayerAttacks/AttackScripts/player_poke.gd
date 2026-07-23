class_name PlayerPoke extends PlayerAttack



func effect(enemy : Enemy, countdown : float):
	enemy.deal_damage(5)
