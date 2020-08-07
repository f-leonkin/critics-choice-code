extends GameText

const OFFSET = Vector2(40, 40)


func change_size():
	var size = $ControlAnimation/Text.get_minimum_size() + OFFSET * 2
	$ControlAnimation/Text.rect_size = size
	
	rect_position = Vector2(float(line[2]), float(line[3]))
	
	$ControlAnimation/BG.rect_size = size
	$ControlAnimation/FG.rect_size = size - Vector2(20, 20)
