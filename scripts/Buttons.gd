extends Control
class_name GameButtons

var key = ""
var active = false


func update_text():
	var h = "1"
	for i in ["1", "2", "3", "4"]:
		if i == "3":
			h = "2"
		var label = get_node("VBoxContainer/HBoxContainer" + h \
				+ "/Button" + i + "/Label")
		label.text = tr(key + "_" + i)


func _on_Button_pressed(value):
	if active:
		g.choices.append(value)
		$AnimationPlayer.play_backwards("show")


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	active = !active
	if !active:
		get_parent().ready = true
		get_parent().go_next()
		queue_free()
