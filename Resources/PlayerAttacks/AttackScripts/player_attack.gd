@abstract 
class_name PlayerAction extends Resource

@export var target_damage : Array[float] = [
	0, 1, 0,
	0, 0, 0,
	0, 0, 0
]

@export var name : String
@export var damage : int
@export var cooldown : int # Num of ticks it takes to reuse
@export var cooldown_recover : int # Num we need to tick our recovery
@export var description : String
@export var resolve_text : String
@export var target_icon : Texture2D
@abstract func effect(target : Enemy, countdown : float)
@abstract func get_description(countdown : float) -> String
