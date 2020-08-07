extends Control

onready var credits = load("res://Credits.tscn")


func _ready():
	update_text()
	$SettingsMenu.visible = false


func update_text():
	$Label.text = tr("title")
	for c in $Buttons.get_children():
		c.text = tr(c.name.to_lower())


func _on_Start_pressed():
	for c in $Buttons.get_children():
		c.disabled = true
	$AnimationPlayer.play("fade")


func _on_Settings_pressed():
	$SettingsMenu.visible = true
	$Buttons.visible = false


func settings_closed():
	$SettingsMenu.visible = false
	$Buttons.visible = true


func _on_Credits_pressed():
	var ci = credits.instance()
	add_child(ci)


func _on_Quit_pressed():
	get_tree().quit()


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Disclaimer.tscn")
