extends Control

const SOUND_DOWN_VOL = -12
const IMG_PATH = "res://nc-assets/images/"
const SCRIPT_PATH = "res://script"

var ready = true
var script_file

var skip_to = 0
var skip = false

var ee1 = false # easter egg
var ee2 = false
var ee3 = false

onready var square = load("res://Square.tscn")
onready var balloon = load("res://Balloon.tscn")
onready var buttons = load("res://Buttons.tscn")
onready var tfot_text = load("res://TFOT.tscn")
onready var tfot_credits = load("res://TFOTCredits.tscn")
onready var easter_egg_1 = load("res://EasterEgg1.tscn")
onready var easter_egg_2 = load("res://EasterEgg2.tscn")
onready var easter_egg_3 = load("res://EasterEgg3.tscn")
onready var writing = load("res://Writing.tscn")
onready var bgm = load("res://BGM.tscn")
onready var mesa = load("res://Mesa.tscn")
onready var credits = load("res://Credits.tscn")


func _ready():
	script_file = File.new()
	var err = script_file.open(SCRIPT_PATH + ".csv", File.READ)
	if err != 0:
		# open .txt if .csv isn't found
		script_file.open(SCRIPT_PATH + ".txt", File.READ)
	
	go_next()


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			go_next()


# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("next"):
		go_next()
	if Input.is_action_just_pressed("pause"):
		$PauseMenu.visible = true
		$PauseMenu.raise()
		get_tree().paused = true


func go_next():
	if ready:
		var line = script_file.get_csv_line()
		if script_file.eof_reached():
			return
		
		if skip and (line[0] == "bg" or line[0] == "transition") \
				 and line[1] == str(skip_to):
			skip = false
		if skip:
			go_next()
			return
		
		ready = false
		if $VoicePlayer.playing:
			$VoicePlayer/AnimationPlayer.play("fade")
			yield($VoicePlayer/AnimationPlayer, "animation_finished")
			$VoicePlayer.stop()
		
		if line[0] != "tfot" and line[0] != "delay" and $TFOT.visible:
			$TFOT.visible = false
		
		match line[0]:
			"clear":
				clear()
			"bg":
				if line[1] == "0":
					$BG.visible = false
					$OldBG.visible = false
				else:
					$BG.visible = true
					$OldBG.visible = true
					$BG.texture = load(IMG_PATH + line[1] + ".png")
				
				easter_egg(line[1])
				
				ready = true
				go_next()
			"transition":
				make_transition(line[1])
			"square":
				var si = square.instance()
				add_child(si)
				si.create(line)
				start_voice(line[1])
			"balloon":
				var bi = balloon.instance()
				add_child(bi)
				bi.create(line)
				start_voice(line[1])
			"buttons":
				var bsi = buttons.instance()
				add_child(bsi)
				bsi.key = "buttons" + line[1]
				bsi.update_text()
			"music":
				play_music(line[1])
				ready = true
				go_next()
			"music_stop":
				$MusicPlayer.stop()
				ready = true
				go_next()
			"sound":
				if line[2] != "":
					start_sound(line[1], line[2])
				ready = true
				go_next()
			"sound_stop":
				stop_sound(line[1])
				ready = true
				go_next()
			"sound_down":
				if line[1] == "1":
					$MusicPlayer.volume_db += SOUND_DOWN_VOL
					for i in [1,2,3,4]:
						get_node("SoundPlayers/SoundPlayer" \
								+ str(i)).volume_db += SOUND_DOWN_VOL
				else:
					$MusicPlayer.volume_db = 0
					for i in [1,2,3,4]:
						get_node("SoundPlayers/SoundPlayer" \
								+ str(i)).volume_db = 0
				ready = true
				go_next()
			"wait":
				ready = true
				return
			"delay":
				if line[1]:
					$DelayTimer.wait_time = float(line[1])
				$DelayTimer.start()
			"tfot":
				$TFOT.show_text(line[1])
				start_voice(line[1])
				if line[2] == "force":
					ready = true
					go_next()
			"flash":
				$Flashback.start(line[1])
			"tfot_credits":
				var tci = tfot_credits.instance()
				add_child(tci)
			"writing":
				var wi = writing.instance()
				add_child(wi)
			"bgm":
				var bgmi = bgm.instance()
				add_child(bgmi)
			"mesa":
				var mi = mesa.instance()
				add_child(mi)
			"credits":
				var ci = credits.instance()
				add_child(ci)
			_:
				ready = true
				go_next()


func make_transition(new_bg):
	$OldBG.texture = $BG.texture
	$BG.modulate = Color("00ffffff")
	$BG.texture = load(IMG_PATH + new_bg + ".png")
	$OldBG/TransitionAnimPlayer.play("transition")


# warning-ignore:unused_argument
func _on_TransitionAnimPlayer_animation_finished(anim_name):
	ready = true
	go_next()


func clear():
	var clean = true
	for c in get_children():
		if c is GameText:
			clean = false
			c.destroy()
	if clean:
		go_next()
	else:
		$ClearTimer.start()


func _on_ClearTimer_timeout():
	ready = true
	go_next()


func play_music(name):
	if $MusicPlayer.playing:
		$MusicPlayer/AnimationPlayer.play("fade")
		yield($MusicPlayer/AnimationPlayer, "animation_finished")
	$MusicPlayer.volume_db = 0
	$MusicPlayer.stream = load("res://free-assets/music/" + name + ".ogg")
	$MusicPlayer.play()


func start_voice(key):
	if g.voice_lang_list[g.voice_lang] == "none":
		return
	$VoicePlayer.volume_db = 0
	var actor = key.split("_")[0]
	var index = key.split("_")[1]
	$VoicePlayer.stream = \
			g.voices[actor][g.voice_lang_list[g.voice_lang]][int(index)-1]
	$VoicePlayer.play()


func start_sound(track, player):
	var sound_player = get_node("SoundPlayers/SoundPlayer" + player)
	sound_player.stream = g.sounds[track]
	sound_player.play()


func stop_sound(player):
	var sound_player = get_node("SoundPlayers/SoundPlayer" + player)
	sound_player.stop()


func _on_DelayTimer_timeout():
	ready = true
	go_next()


func easter_egg(bg):
	if ee1 or ee3:
		for c in get_children():
			if c is EasterEgg1:
				c.destroy()
	if ee2:
		for c in get_children():
			if c is EasterEgg2:
				c.destroy()
	
	match bg:
		"7":
			var eei = easter_egg_1.instance()
			add_child(eei)
			ee1 = true
		"10", "11", "18", "26", "32", "35", "37", "43", "48", "52":
			var eei = easter_egg_2.instance()
			add_child(eei)
			ee2 = true
		"23":
			var eei = easter_egg_3.instance()
			add_child(eei)
			ee3 = true


func update_text():
	for c in get_children():
		if c is GameText or c is GameButtons or c is TFOTText or c is Credits:
			c.update_text()
