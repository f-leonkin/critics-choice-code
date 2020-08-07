extends Control


func _ready():
	$Label.text = tr("disclaimer")


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Game.tscn")
