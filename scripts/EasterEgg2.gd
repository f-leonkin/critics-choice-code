extends Button
class_name EasterEgg2


func _ready():
	$Control.visible = false


func _on_EasterEgg2_pressed():
	get_tree().paused = true
	$Control/Square/ControlAnimation/Text.text = tr("easter_2")
	$Control.visible = true
	raise()


func hide():
	get_tree().paused = false
	$Control.visible = false


func destroy():
	queue_free()
