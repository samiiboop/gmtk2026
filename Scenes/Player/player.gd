extends Node


@export var available_attacks : Array[PlayerAction] = []
@export var available_magi : Array[PlayerAction] = []
signal send_available_attacks(available_attack : Array)
signal send_available_magi(available_magi : Array)


func unlock_attack(resource : PlayerAction):
	pass

func update_ui():
	print("PLAYER EMITTING")
	send_available_attacks.emit(available_attacks)
	send_available_magi.emit(available_magi)
