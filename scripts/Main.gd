extends Control

onready var executable_path_button = $MarginContainer/Container/DesktopVariables/ExecutablePath.get_node("ButtonContainer/Button").connect("_on_Button_pressed", self, "_on_AppPathButton_pressed")
onready var icon_path_button = $MarginContainer/Container/DesktopVariables/IconPath.get_node("ButtonContainer/Button").connect("_on_Button_pressed", self, "_on_AppIcoButton_pressed")
onready var save_location_button = $MarginContainer/Container/DesktopVariables/SaveLocation.get_node("ButtonContainer/Button").connect("_on_Button_pressed", self, "_on_SaveLocationButton_pressed")

onready var app_name = $MarginContainer/Container/DesktopVariables/Name.get_node("ButtonContainer/LineEdit")
onready var executable_path = $MarginContainer/Container/DesktopVariables/ExecutablePath.get_node("ButtonContainer/LineEdit")
onready var app_icon_path = $MarginContainer/Container/DesktopVariables/IconPath.get_node("ButtonContainer/LineEdit")
onready var app_type = $MarginContainer/Container/DesktopVariables/Type.get_node("ButtonContainer/LineEdit")
onready var save_location = $MarginContainer/Container/DesktopVariables/SaveLocation.get_node("ButtonContainer/LineEdit")
onready var generate_file_button = $MarginContainer/Container/DesktopVariables/GenerateFileButton
onready var file_saved_label = $MarginContainer/Container/FileSavedLabel

onready var app_path_file_dialog = $FileDialog/AppPathFileDialog
onready var app_ico_file_dialog = $FileDialog/AppIcoFileDialog
onready var generate_file_dialog = $FileDialog/GenerateFileDialog

onready var timer_file_save = $TimerFileSave

func _ready():
	app_name.grab_focus()
	save_location.text = "/home/username/.local/share/applications/"
	file_saved_label.hide()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func save_file(path):
	var file = File.new()
	printt("path", path)
	file.open(path + "/" + app_name.text + ".desktop", File.WRITE)
	file.store_string("[Desktop Entry]" + 
	"\nName=" + app_name.text +
	"\nExec=" + executable_path.text +
	"\nIcon=" + app_icon_path.text +
	"\nType=" + "Application" +
	"\nEncoding=UTF-8" +
	"\nVersion=1.0" +
	"\nTerminal=false")
	file.close()
	file_correctly_saved()
	
func file_correctly_saved():
	file_saved_label.text = app_name.text + ".desktop is saved"
	timer_file_save.start()
	file_saved_label.show()

func _on_TimerFileSave_timeout():
	file_saved_label.hide()

### Select and apply executable path
func _on_AppPathButton_pressed():
	app_path_file_dialog.rect_position = Vector2(0, OS.window_size.y/8)
	app_path_file_dialog.rect_size = Vector2(400,400)
	app_path_file_dialog.show()

func _on_AppPathFileDialog_file_selected(path):
	executable_path.text = path
###

### Select and apply icon path
func _on_AppIcoButton_pressed():
	app_ico_file_dialog.rect_position = Vector2(0, OS.window_size.y/8)
	app_ico_file_dialog.rect_size = Vector2(400,400)
	app_ico_file_dialog.show()

func _on_AppIcoFileDialog_file_selected(path):
	app_icon_path.text = path 
###

### Select and apply location path
func _on_SaveLocationButton_pressed():
	app_path_file_dialog.rect_position = Vector2(0, OS.window_size.y/8)
	app_path_file_dialog.rect_size = Vector2(400,400)
	app_path_file_dialog.show()

func _on_GenerateFileDialog_dir_selected(dir: String) -> void:
	save_location.text = dir
###

func _on_GenerateFileButton_pressed() -> void:
	save_file(save_location.text)
