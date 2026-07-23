extends TabBar

@onready var v_box_container: VBoxContainer = $HBoxContainer/VBoxContainer

@onready var fite: MenuSelectElement = $HBoxContainer/VBoxContainer/Fite
@onready var magi: MenuSelectElement = $HBoxContainer/VBoxContainer/Magi

var selections : Array[MenuSelectElement] = []

var active = false
var index = 0

func _ready() -> void:
	# Connect signals
	draw.connect(_on_menu_active)
	hidden.connect(_on_menu_inactive)
	for element in v_box_container.get_children():
		if element is MenuSelectElement:
			selections.append(element)
			element.element_focus_exited.emit()
	
	selections[0].element_focus_entered.emit()

func _on_menu_active():
	active = true
	selections[index].element_focus_entered.emit()


func _on_menu_inactive():
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
