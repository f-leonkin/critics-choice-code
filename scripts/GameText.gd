extends Control
class_name GameText

var spawned = false
var line = []


func create(array):
	line = array
	print(line)
	update_text(true)
	$AnimationPlayer.play("fade_in")


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_started(anim_name):
	change_size()


func change_size():
	pass


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	if !spawned:
		get_parent().ready = true
		spawned = true
	else:
		queue_free()


func destroy():
	$AnimationPlayer.play_backwards("fade_in")


func update_text(first_set=false):
	$ControlAnimation/Text.text = tr(line[1])
	if "narrator" in line[1]:
		$ControlAnimation/FG.color = Color("#aad4f5")
	if !first_set:
		change_size()
