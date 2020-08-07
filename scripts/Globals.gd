extends Node

const MIN_VOLUME = -30
const MUSIC_VOLUME_OFFSET = -20
const SOUND_VOLUME_OFFSET = -9

var text_lang_list = ["en", "ru"]
var text_lang = 0
var voice_lang_list = ["ru", "none"]
var voice_lang = 0
var music_vol = 100.0
var voice_vol = 100.0
var sound_vol = 100.0
var fullscreen = OS.window_fullscreen

var choices = []
var writing = ""

var voices = {}
var sounds = {}


func _ready():
	TranslationServer.set_locale(text_lang_list[text_lang])
	for b in ["music", "voice", "sound"]:
		change_volume(b)
	
	preload_voices()
	preload_sounds()


func preload_voices():
	for c in ["girl", "guy", "jason", "matt", "naomi", \
			"narrator", "old", "rebel"]:
		voices[c] = {}
		var amount
		match c:
			"girl":
				amount = 7
			"guy":
				amount = 22
			"jason":
				amount = 26
			"matt":
				amount = 16
			"naomi":
				amount = 7
			"narrator":
				amount = 32
			"old":
				amount = 5
			"rebel":
				amount = 4
		
		for lang in voice_lang_list:
			if lang != "none":
				voices[c][lang] = {}
				for i in amount:
					voices[c][lang][i] = load("res://nc-assets/voice/" \
							+ lang + "/" + c + "/" + str(i+1) + ".ogg")


func preload_sounds():
	var list = File.new()
	list.open("res://sounds-list.txt", File.READ)
	while !list.eof_reached():
		var path = list.get_line()
		if path != "":
			var filename = path.split("/")[-1].split(".")[0]
			sounds[filename] = load("res://" + path)


func text_lang_label():
	match text_lang_list[text_lang]:
		"en":
			return "English"
		"ru":
			return "Русский"


func voice_lang_label():
	match voice_lang_list[voice_lang]:
		"none":
			return tr("no_voice")
		"ru":
			return "Русский"


func change_volume(bus):
	match bus:
		"music":
			if music_vol == 0:
				AudioServer.set_bus_mute(
					AudioServer.get_bus_index("Music"),
					true
				)
			else:
				AudioServer.set_bus_mute(
					AudioServer.get_bus_index("Music"),
					false
				)
				AudioServer.set_bus_volume_db(
					AudioServer.get_bus_index("Music"),
					MIN_VOLUME + float(music_vol / 100) * -MIN_VOLUME \
							+ MUSIC_VOLUME_OFFSET
				)
		"voice":
			if voice_vol == 0:
				AudioServer.set_bus_mute(
					AudioServer.get_bus_index("Voice"),
					true
				)
			else:
				AudioServer.set_bus_mute(
					AudioServer.get_bus_index("Voice"),
					false
				)
				AudioServer.set_bus_volume_db(
					AudioServer.get_bus_index("Voice"),
					MIN_VOLUME + float(voice_vol / 100) * -MIN_VOLUME
				)
		"sound":
			if sound_vol == 0:
				AudioServer.set_bus_mute(
					AudioServer.get_bus_index("Sound"),
					true
				)
			else:
				AudioServer.set_bus_mute(
					AudioServer.get_bus_index("Sound"),
					false
				)
				AudioServer.set_bus_volume_db(
					AudioServer.get_bus_index("Sound"),
					MIN_VOLUME + float(sound_vol / 100) * -MIN_VOLUME \
							+ SOUND_VOLUME_OFFSET
				)
