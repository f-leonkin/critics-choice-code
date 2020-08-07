extends Control
class_name TFOTText

var text = ""


func show_text(line):
	visible = true
	text = line
	update_text()
	get_parent().ready = true


func update_text():
	$Text.text = tr(text)
	$Actor.text = tr("tfot_" + text.split("_")[0])


func hide():
	visible = false
