extends TabBar

@onready var v_box_container: VBoxContainer = $HBoxContainer/ScrollContainer/VBoxContainer
@onready var desc_label : RichTextLabel = $HBoxContainer/DescLabel
@onready var target_texture: TextureRect = $HBoxContainer/TextureRect
@onready var scroll_container: ScrollContainer = $HBoxContainer/ScrollContainer

const MENU_SELECT_ELEMENT = preload("uid://dt1u3vg0ojcdo")


var selections : Array[MenuSelectElement] = []

var active = false
var index = 0

signal action_selected(action : PlayerAction)

var countdown_getter : Callable

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
	menu_select_scene.recharge_bar.visible = false
	
	if attack.cooldown > 0:
		menu_select_scene.cooldown = attack.cooldown
		menu_select_scene.charge = attack.cooldown
		menu_select_scene.recovery_num = attack.cooldown_recover
		
		menu_select_scene.recharge_bar.max_value = menu_select_scene.cooldown
		menu_select_scene.recharge_bar.value = menu_select_scene.charge
		menu_select_scene.recharge_bar.visible = true

func _check_cooldowns():
	for selection in selections:
		selection.regain_charge(countdown_getter.call())

func _update_desc(action : PlayerAction):
	desc_label.text = action.get_description(countdown_getter.call())
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
	scroll_container.ensure_control_visible(selections[index] as Control)

func nav_up():
	selections[index].element_focus_exited.emit()
	index = (index - 1 + selections.size()) % selections.size()
	
	selections[index].element_focus_entered.emit()
	scroll_container.ensure_control_visible(selections[index] as Control)

func _input(event: InputEvent) -> void:
	if not active: return
	if Input.is_action_just_pressed("down"):
		nav_down()
	if Input.is_action_just_pressed("up"):
		nav_up()
