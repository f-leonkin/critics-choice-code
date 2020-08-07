extends Control

var next_bg = "1"


func start(bg):
	visible = true
	next_bg = bg
	$AnimationPlayer.play("flash_1")
	$AudioStreamPlayer.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "flash_1":
		get_node("../BG").texture = load(get_parent().IMG_PATH \
				+ next_bg + ".png")
		$AnimationPlayer.play("flash_2")
	elif anim_name == "flash_2":
		visible = false
		get_parent().ready = true
		get_parent().go_next()
