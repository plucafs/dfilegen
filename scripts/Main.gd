extends Control

# TODO escape spaces

onready var executable_path_button = $MarginContainer/Container/DesktopVariables/ExecutablePath.get_node("ButtonContainer/Button").connect("_on_Button_pressed", self, "_on_AppPathButton_pressed")
onready var icon_path_button = $MarginContainer/Container/DesktopVariables/IconPath.get_node("ButtonContainer/Button").connect("_on_Button_pressed", self, "_on_AppIcoButton_pressed")
onready var save_location_button = $MarginContainer/Container/DesktopVariables/SaveLocation.get_node("ButtonContainer/Button").connect("_on_Button_pressed", self, "_on_SaveLocationButton_pressed")

onready var app_name = $"%Name".get_node("ButtonContainer/LineEdit")
onready var executable_path = $"%ExecutablePath".get_node("ButtonContainer/LineEdit")
onready var app_icon_path = $"%IconPath".get_node("ButtonContainer/LineEdit")
onready var app_type = $"%Type".get_node("ButtonContainer/LineEdit")
onready var save_location = $"%SaveLocation".get_node("ButtonContainer/LineEdit")
onready var generate_file_button = $"%GenerateFileButton"
onready var file_saved_label = $"%FileSavedLabel"

onready var app_path_file_dialog = $FileDialog/AppPathFileDialog
onready var app_ico_file_dialog = $FileDialog/AppIcoFileDialog
onready var generate_file_dialog = $FileDialog/GenerateFileDialog
onready var bg_dialog: ColorRect = $FileDialog/BgDialog

onready var timer_file_save = $TimerFileSave

var username: String = OS.get_data_dir().split("/")[2]
var save_location_dir: String = "/home/%s/.local/share/applications/" % username
var desktop_dir: String

func _ready():
	OS.window_resizable = false
	OS.window_size = Vector2(500, 500)
	app_name.grab_focus()
	save_location.text = save_location_dir
	file_saved_label.hide()
	bg_dialog.hide()
	desktop_dir = get_desktop_directory()

func get_desktop_directory():
	var output: Array
	OS.execute("xdg-user-dir", ["DESKTOP"], true, output)
	return output[0]

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func save_file(path):
	var file = File.new()
	printt("path", path)
	file.open(path + "/" + app_name.text + ".desktop", File.WRITE)
	file.store_string("[Desktop Entry]" + 
	"\nName=" + app_name.text +
	"\nExec=" + executable_path.text.replace(" ", "\\ ") +
	"\nIcon=" + app_icon_path.text.replace(" ", "\\ ") +
	"\nType=" + "Application" +
	"\nEncoding=UTF-8" +
	"\nVersion=1.0" +
	"\nTerminal=false")
	file.close()
	create_link_to_desktop(app_name.text)
	file_saved()
	
func file_saved():
	file_saved_label.text = app_name.text + ".desktop is saved"
	timer_file_save.start()
	file_saved_label.show()

func _on_TimerFileSave_timeout():
	file_saved_label.hide()

func _on_AppPathFileDialog_file_selected(path):
	executable_path.text = path
	
func _on_AppIcoFileDialog_file_selected(path):
	app_icon_path.text = path 

func _on_GenerateFileDialog_dir_selected(dir: String) -> void:
	save_location.text = dir


# on button pressed
func _on_AppPathButton_pressed():
	bg_dialog.show()
	app_path_file_dialog.popup_centered()
	
func _on_AppIcoButton_pressed():
	bg_dialog.show()
	app_ico_file_dialog.popup_centered()

func _on_SaveLocationButton_pressed():
	bg_dialog.show()
	app_path_file_dialog.popup_centered()

func _on_GenerateFileButton_pressed() -> void:
	save_file(save_location.text)
#

func create_link_to_desktop(name_of_app):
	var dot_desktop_file_path = save_location_dir + "/" + name_of_app + ".desktop"
	OS.execute("ln", [dot_desktop_file_path, desktop_dir])
	pass

# on dialog hide
func _on_AppPathFileDialog_hide() -> void:
	bg_dialog.hide()

func _on_AppIcoFileDialog_hide() -> void:
	bg_dialog.hide()

func _on_GenerateFileDialog_hide() -> void:
	bg_dialog.hide()
#
