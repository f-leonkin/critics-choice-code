extends Control


func _ready():
	update_text()
	
	$TextSelect/Control.rect_position = get_node("TextSelect/" + \
			g.text_lang_list[g.text_lang]).rect_position
	$VoiceSelect/Control.rect_position = get_node("VoiceSelect/" + \
			g.voice_lang_list[g.voice_lang]).rect_position


func _on_TextLang_selected(lang):
	$TextSelect/Control.rect_position = \
			get_node("TextSelect/" + lang).rect_position
	
	TranslationServer.set_locale(lang)
	g.text_lang = g.text_lang_list.find(lang)
	
	update_text()


func update_text():
	$TextSelect/Label.text = tr("text_lang_select")
	$VoiceSelect/Label.text = tr("voice_lang_select")
	$PlayButton.text = tr("play")


func _on_VoiceLang_selected(lang):
	$VoiceSelect/Control.rect_position = get_node("VoiceSelect/" + lang).rect_position
	
	g.voice_lang = g.voice_lang_list.find(lang)


func _on_PlayButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://MainMenu.tscn")


func _on_BackButton_pressed():
	get_parent().update_text()
	queue_free()
