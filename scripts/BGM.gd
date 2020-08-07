extends Control


#func _ready():
#	$AnimationPlayer.playback_speed = 30


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	get_parent().ready = true
	get_parent().go_next()
	queue_free()
