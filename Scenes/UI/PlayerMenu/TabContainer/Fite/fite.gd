extends TabBar

@onready var v_box_container: VBoxContainer = $HBoxContainer/ScrollContainer/VBoxContainer
@onready var desc_label: Label = $HBoxContainer/DescLabel
@onready var target_texture: TextureRect = $HBoxContainer/TextureRect

const MENU_SELECT_ELEMENT = preload("uid://dt1u3vg0ojcdo")


var selections : Array[MenuSelectElement] = []

var active = false
var index = 0

signal action_selected(action : PlayerAction)

func _ready() -> void:
	# Connect signals
	draw.connect(_on_menu_active)
	hidden.connect(_on_menu_inactive)

func setup():
	for element in v_box_container.get_children():
		if element is MenuSelectElement:
			selections.append(element)
			element.element_focus_exited.emit()
	

func _set_available_attacks(available_attacks : Array[PlayerAction]):
	print("FITE RECEIVING")
	for attack in available_attacks:
		print("SETTING ATTACKS")
		create_menu_select_element(attack)
	setup()

func create_menu_select_element(attack : PlayerAction):
	var menu_select_scene = MENU_SELECT_ELEMENT.instantiate()
	v_box_container.add_child(menu_select_scene)
	menu_select_scene.selected.connect(_on_action_selected.bind(attack))
	menu_select_scene.element_focus_entered.connect(_update_desc.bind(attack))
	menu_select_scene.label.text = attack.name
	
func _update_desc(action : PlayerAction):
	desc_label.text = action.description
	target_texture.texture = action.target_icon

func _on_action_selected(attack : PlayerAction):
	action_selected.emit(attack)

func _on_menu_active():
	active = true
	selections[index].element_focus_entered.emit()


func _on_menu_inactive():
	if selections.is_empty(): return
	active = false
	selections[index].element_focus_exited.emit()

func nav_down():
	selections[index].element_focus_exited.emit()
	index = (index + 1) % selections.size()
	selections[index].element_focus_entered.emit()

func nav_up():
	selections[index].element_focus_exited.emit()
	index = (index - 1 + selections.size()) % selections.size()
	selections[index].element_focus_entered.emit()

func _input(event: InputEvent) -> void:
	if not active: return
	if Input.is_action_just_pressed("down"):
		nav_down()
	if Input.is_action_just_pressed("up"):
		nav_up()
