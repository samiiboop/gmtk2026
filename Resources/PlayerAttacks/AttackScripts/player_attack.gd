@abstract 
class_name PlayerAttack extends Resource

@export var target_damage : Array[float] = [
	0, 1, 0,
	0, 0, 0,
	0, 0, 0
]
@export var name : String
@export var cooldown : int
@export var cooldown_recover_count : int
@export var description : String
@export var resolve_text : String
@abstract func effect(target : Enemy, countdown : float)
