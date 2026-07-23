class_name Enemy extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar


# base class for enemy
@export var hp : float = 10
@export var attacks : Array[EnemyAttack]
var grid_index : int

func _ready() -> void:
	progress_bar.max_value = hp

func deal_damage(damage : float):
	print("YOUCH")
	hp -= damage
	if hp <= 0:
		kill()
		return
	progress_bar.value = hp

func kill():
	queue_free()
