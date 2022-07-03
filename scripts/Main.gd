extends Control

onready var AppNameLineEdit = $CenterContainer/VBoxContainer/DesktopVariables/AppNameLineEdit
onready var AppPathLineEdit = $CenterContainer/VBoxContainer/DesktopVariables/AppPathContainer/AppPathLineEdit
onready var AppIcoLineEdit = $CenterContainer/VBoxContainer/DesktopVariables/AppIcoContainer/AppIcoLineEdit
onready var AppTypeLineEdit = $CenterContainer/VBoxContainer/DesktopVariables/AppTypeLineEdit
onready var AppName = $CenterContainer/VBoxContainer/DesktopVariables/AppName
onready var file_save = $CenterContainer/VBoxContainer/FileSaved
onready var timer_file_save = $TimerFileSave

func _ready():
	file_save.hide()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func save_file():
	var file = File.new()
	file.open(AppNameLineEdit.text + ".desktop", File.WRITE)
	file.store_string("[Desktop Entry]" + 
	"\nName=" + AppNameLineEdit.text +
	"\nExec=" + AppPathLineEdit.text +
	"\nIcon=" + AppIcoLineEdit.text +
	"\nEncoding=UTF-8" +
	"\nVersion=1.0" +
	"\nType=" + AppTypeLineEdit.text +
	"\nTerminal=false")
	file.close()
	file_correctly_saved()
	
func file_correctly_saved():
	file_save.text = AppNameLineEdit.text + ".desktop is a success!"
	timer_file_save.start()
	file_save.show()

func _on_GenDeskFileButton_pressed():
	$GenerateFileDialog.rect_position = OS.window_size / 2
	$GenerateFileDialog.show()
	
func _on_TimerFileSave_timeout():
	file_save.hide()

func _on_AppPathButton_pressed():
	$AppPathFileDialog.rect_position = OS.window_size / 2
	$AppPathFileDialog.show()

func _on_AppPathFileDialog_file_selected(path):
	AppPathLineEdit.text = path
	
func _on_AppIcoButton_pressed():
	$AppPathFileDialog.rect_position = OS.window_size / 2
	$AppPathFileDialog.show()

func _on_AppIcoFileDialog_file_selected(path):
	AppIcoLineEdit.text = path 

func _on_GenerateFileDialog_confirmed():
	save_file()
