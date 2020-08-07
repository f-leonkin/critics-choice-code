extends Control


func _ready():
	visible = false
	update_text()


func update_text():
	$Menu/VBoxContainer/Continue.text = tr("continue")
	$Menu/VBoxContainer/Settings.text = tr("settings")
	$Menu/VBoxContainer/Exit.text = tr("go_to_main")
	
	get_parent().update_text()


func _on_Continue_pressed():
	get_tree().paused = false
	visible = false


func _on_Settings_pressed():
	$Menu.visible = false
	$SettingsMenu.visible = true


func settings_closed():
	$Menu.visible = true
	$SettingsMenu.visible = false


func _on_Exit_pressed():
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://MainMenu.tscn")
