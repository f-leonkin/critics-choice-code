extends GameText

const OFFSET = Vector2(120, 180)


func change_size():
	var size = $ControlAnimation/Text.get_minimum_size() + OFFSET
	
	match line[1]:
		"naomi_6":
			size = Vector2(150, 150)
		"jason_4":
			size = Vector2(287, 208.5)
	
	$ControlAnimation/Text.rect_size = size
	$ControlAnimation/Sprites.rect_scale = \
			Vector2(size.x / 1000, size.y / 1000)
	
	rect_position = Vector2(
		float(line[2]) + size.x / 2,
		float(line[3]) + size.y / 2
	)
	$ControlAnimation/Text.rect_position = \
			$ControlAnimation/Text.rect_size / -2 + Vector2(0, 4)
	
	$ControlAnimation/Sprites/BG_Cursor.rotation_degrees = float(line[-1])
	$ControlAnimation/Sprites/FG_Cursor.rotation_degrees = float(line[-1])
