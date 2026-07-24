class_name MenuSelectElement extends Control

@onready var select: TextureRect = $VBoxContainer/HBoxContainer/Select
@onready var label: Label = $VBoxContainer/HBoxContainer/Label
@onready var recharge_bar: ProgressBar = $VBoxContainer/HBoxContainer2/RechargeBar

var active : bool = false

signal element_focus_entered
signal element_focus_exited

signal selected

var cooldown : int
var charge : int = -1
var recovery_num : int
# Called when the node enters the scene tree for the first time.

func disable_recharge_bar():
	recharge_bar.visible = false

func _ready() -> void:
	element_focus_entered.connect(_on_focus_entered)
	element_focus_exited.connect(_on_focus_exited)


func enable_selection():
	select.offset_transform_scale = Vector2(1.0,1.0)
	active = true

func disable_selection():
	select.offset_transform_scale = Vector2(0,0)
	active = false

func _on_focus_entered():
	enable_selection()

func _on_focus_exited():
	disable_selection()

func regain_charge(countdown : float):
	print("RECHARGING")
	if cooldown <= countdown:
		charge += 1
		update_bar()

func update_bar():
	recharge_bar.value = charge

func _input(event: InputEvent) -> void:
	if not active: return
	
	if Input.is_action_just_pressed("accept"):
		if charge <= cooldown and charge != -1: # Cant select if it isnt off cooldown
			return
		selected.emit()
		if charge != -1 : charge = 0 # this is becoming spaghetti but oh well
		update_bar()
