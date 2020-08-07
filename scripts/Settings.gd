extends Control


func _ready():
	$VBoxContainer/MusicVolume/Value.text = str(g.music_vol)
	$VBoxContainer/VoiceVolume/Value.text = str(g.voice_vol)
	$VBoxContainer/SoundVolume/Value.text = str(g.sound_vol)
	update_text()
	update_buttons()


func update_text():
	$VBoxContainer/TextLanguage/Label.text = tr("text_lang_select")
	$VBoxContainer/VoiceLanguage/Label.text = tr("voice_lang_select")
	$VBoxContainer/MusicVolume/Label.text = tr("music_vol")
	$VBoxContainer/VoiceVolume/Label.text = tr("voice_vol")
	$VBoxContainer/SoundVolume/Label.text = tr("sound_vol")
	$VBoxContainer/Fullscreen/Label.text = tr("fullscreen")
	if g.fullscreen:
		$VBoxContainer/Fullscreen/Value.text = tr("on")
	else:
		$VBoxContainer/Fullscreen/Value.text = tr("off")
	if g.voice_lang_list[g.voice_lang] == "none":
		$VBoxContainer/VoiceLanguage/Value.text = tr("no_voice")
	$VBoxContainer/Back.text = tr("back")
	$VBoxContainer/TextLanguage/Value.text = g.text_lang_label()
	$VBoxContainer/VoiceLanguage/Value.text = g.voice_lang_label()
	get_parent().update_text()


func update_buttons():
	for n in ["Music", "Voice", "Sound"]:
		var path = "VBoxContainer/" + n + "Volume/"
		var value = get_node(path + "Value").text
		if value == "100":
			get_node(path + "ControlRight/ButtonRight").visible = false
		elif value == "0":
			get_node(path + "ControlLeft/ButtonLeft").visible = false
		else:
			get_node(path + "ControlRight/ButtonRight").visible = true
			get_node(path + "ControlLeft/ButtonLeft").visible = true


func _on_BackButton_pressed():
	get_parent().settings_closed()


func _on_TextLang_changed(value):
	g.text_lang += value
	if g.text_lang == g.text_lang_list.size():
		g.text_lang = 0
	if g.text_lang == -1:
		g.text_lang = g.text_lang_list.size() - 1
	
	TranslationServer.set_locale(g.text_lang_list[g.text_lang])
	$VBoxContainer/TextLanguage/Value.text = g.text_lang_label()
	update_text()


func _on_VoiceLang_changed(value):
	g.voice_lang += value
	if g.voice_lang == g.voice_lang_list.size():
		g.voice_lang = 0
	if g.voice_lang == -1:
		g.voice_lang = g.voice_lang_list.size() - 1
	
	$VBoxContainer/VoiceLanguage/Value.text = g.voice_lang_label()


func _on_MusicVol_changed(value):
	g.music_vol += value * 10
	if g.music_vol > 100:
		g.music_vol = 0
	if g.music_vol < 0:
		g.music_vol = 100
	
	$VBoxContainer/MusicVolume/Value.text = str(g.music_vol)
	update_buttons()
	g.change_volume("music")


func _on_VoiceVol_changed(value):
	g.voice_vol += value * 10
	if g.voice_vol > 100:
		g.voice_vol = 0
	if g.voice_vol < 0:
		g.voice_vol = 100
	
	$VBoxContainer/VoiceVolume/Value.text = str(g.voice_vol)
	update_buttons()
	g.change_volume("voice")


func _on_SoundVol_changed(value):
	g.sound_vol += value * 10
	if g.sound_vol > 100:
		g.sound_vol = 0
	if g.sound_vol < 0:
		g.sound_vol = 100
	
	$VBoxContainer/SoundVolume/Value.text = str(g.sound_vol)
	update_buttons()
	g.change_volume("sound")


func _on_Fullscreen_changed():
	OS.window_fullscreen = !OS.window_fullscreen
	g.fullscreen = OS.window_fullscreen
	
	if g.fullscreen:
		$VBoxContainer/Fullscreen/Value.text = tr("on")
	else:
		$VBoxContainer/Fullscreen/Value.text = tr("off")
