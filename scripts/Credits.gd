extends Control
class_name Credits

const TXT_PATH = "res://nc-assets/credits"


func _ready():
	update_text()


func update_text():
	var file = File.new()
	var path = TXT_PATH + "-" + g.text_lang_list[g.text_lang] + ".txt"
	if !file.file_exists(path):
		path = TXT_PATH + ".txt"
	file.open(path, File.READ)
	var text = file.get_as_text()
	$Text.bbcode_text = text


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	if get_parent().name == "MainMenu":
		queue_free()
	else:
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://MainMenu.tscn")
