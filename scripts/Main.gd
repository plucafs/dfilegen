extends Control

onready var AppNameLineEdit = $CenterContainer/VBoxContainer/DesktopVariables/AppNameLineEdit
onready var AppPathLineEdit = $CenterContainer/VBoxContainer/DesktopVariables/AppPathLineEdit
onready var AppIcoLineEdit = $CenterContainer/VBoxContainer/DesktopVariables/AppIcoLineEdit
onready var AppTypeLineEdit = $CenterContainer/VBoxContainer/DesktopVariables/AppTypeLineEdit
onready var AppName = $CenterContainer/VBoxContainer/DesktopVariables/AppName

onready var file_dialog = $CenterContainer/FileDialog

var directory = ""

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
func save_file():
	var file = File.new()
#	file.open("user://" + AppNameLineEdit.text + ".desktop", File.WRITE)
	file.open(str(directory) + AppNameLineEdit.text + ".desktop", File.WRITE)
	file.store_string("[Desktop Entry] \nName="+AppNameLineEdit.text+"\nExec="+AppPathLineEdit.text+"\nIcon="+AppIcoLineEdit.text+"\nEncoding=UTF-8\nVersion=1.0\nType="+AppTypeLineEdit.text+"\nTerminal=false")
	file.close()
	print("File saved!")
#	file_path_dialog()
	
func _on_GenDeskFileButton_pressed():
	file_dialog.show()

func _on_FileDialog_dir_selected(dir):
	dir = directory
	save_file()

	
