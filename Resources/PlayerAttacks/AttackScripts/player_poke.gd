class_name PlayerPoke extends PlayerAction



func effect(enemy : Enemy, countdown : float):
	enemy.deal_damage(5)
