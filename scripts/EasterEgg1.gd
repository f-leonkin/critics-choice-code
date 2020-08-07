extends Button
class_name EasterEgg1

var shown = false


func _ready():
	$Square/ControlAnimation/Text.bbcode_text = tr("easter_" + name[-1])


func _on_EasterEgg1_pressed():
	if !shown:
		shown = true
		$Square/AnimationPlayer.play("fade_in")


func destroy():
#	if shown:
#		$Square/AnimationPlayer.play_backwards("fade_in")
#		yield($Square/AnimationPlayer, "animation_finished")
	queue_free()


func _on_Text_meta_clicked(meta):
	if meta == "itch":
		# warning-ignore:return_value_discarded
		OS.shell_open("https://itch.io/jam/i-cant-write-but-want-to-tell-a-story")
	elif meta == "btk":
		# warning-ignore:return_value_discarded
		OS.shell_open("https://leonkin.itch.io/burn-the-kingdom")
