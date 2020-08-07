extends Control

onready var music_node = get_parent().get_node("MusicPlayer")


func _ready():
	if g.choices.size() < 4:
		g.choices = ["test1", "test2", "test3", "test4"]
	$Sprite/Intro.text = tr("buttons13_" + str(g.choices[-4]))
	$Sprite/Plot.text = tr("buttons14_" + str(g.choices[-3]))
	$Sprite/Gameplay.text = tr("buttons15_" + str(g.choices[-2]))
	$Sprite/Artstyle.text = tr("buttons16_" + str(g.choices[-1]))
	$Sprite/Writing.text = tr("writing") + " " + g.writing


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	$Timer.start()


func _on_Timer_timeout():
	music_node.volume_db -= 2
	if music_node.volume_db <= -40:
		$Timer.stop()
		music_node.stop()
		music_node.volume_db = 0
		
		get_parent().ready = true
		get_parent().go_next()
		queue_free()
