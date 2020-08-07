extends Control

const LIMIT = 120

var current_text = ""
var cursor_line = 0
var cursor_column = 0

onready var counter = $Counter


func _ready():
	$TextEdit.text = ""
	counter.text = "0/" + str(LIMIT)
	$Header.text = tr("writing") + "..."
	$Button.text = tr("writing_send")


# warning-ignore:unused_argument
func _input(event):
	if Input.is_key_pressed(KEY_ENTER):
		get_tree().set_input_as_handled()


func _on_TextEdit_text_changed():
	var new_text = $TextEdit.text
	if new_text.length() > LIMIT:
		$TextEdit.text = current_text
		$TextEdit.cursor_set_line(cursor_line)
		$TextEdit.cursor_set_column(cursor_column)
	
	current_text = $TextEdit.text
	cursor_line = $TextEdit.cursor_get_line()
	cursor_column = $TextEdit.cursor_get_column()
	
	counter.text = str(current_text.length()) + "/" + str(LIMIT)


func _on_Button_pressed():
	if $TextEdit.text == "":
		g.writing = tr("writing_empty")
	else:
		g.writing = $TextEdit.text
	get_parent().ready = true
	get_parent().go_next()
	queue_free()
