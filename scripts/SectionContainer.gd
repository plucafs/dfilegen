extends VBoxContainer

export (String) var text_label
export (String) var placeholder_line_edit
export (bool) var is_button_visible
export (Resource) var button_icon

onready var label = $Label
onready var line_edit = $ButtonContainer/LineEdit
onready var button = $ButtonContainer/Button

func _ready():
#	button.text = "Path"
	button.icon = button_icon
	if is_button_visible:
		button.visible = true
	else:
		button.visible = false
		
	label.text = text_label
	line_edit.placeholder_text = placeholder_line_edit
	
