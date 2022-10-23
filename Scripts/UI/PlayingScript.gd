extends Control

var score = 0
var combo = 0
var max_combo = 0

var perfect = 0
var great = 0
var good = 0
var ok = 0
var missed = 0

var bpm = 115 #Change to fit to your music

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 0
var spawn_4_beat = 0

var lane = 0
var rand = 0
var note = load("res://Scenes/Note.tscn")
var instance
var multiplier


func _ready():
	randomize()
	$Conductor.play_with_beat_offset(9)


func _on_Conductor_measure(position):
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)

func _on_Conductor_beat(position):
	song_position_in_beats = position
	if song_position_in_beats<161:
		match song_position_in_beats:
			28,44,60,76,92,108,124,140: 
				spawn_1_beat = 1
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 1
			32, 36, 48, 64, 68, 80, 96, 100, 112,128,132,144: 
				spawn_1_beat = 0
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 1
			40,72,104,136: 
				spawn_1_beat = 1
				spawn_2_beat = 0
				spawn_3_beat = 1
				spawn_4_beat = 0
			52,84,116: 
				spawn_1_beat = 1
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 0
			56,88,120,160:
				spawn_1_beat = 0
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 0
			148:
				spawn_1_beat = 1
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 1
			152:
				spawn_1_beat = 0
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 1
			156:
				spawn_1_beat = 1
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 0
	elif song_position_in_beats > 219 and song_position_in_beats<480:
		match song_position_in_beats:
			220,224,228,248,284,288,292,312,336,344,352,356,360,380,416,420,424,444,468,472:					
				spawn_1_beat = 1
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 0	
			236,300,368,432:
				spawn_1_beat = 1
				spawn_2_beat = 1
				spawn_3_beat = 1
				spawn_4_beat = 0
			256,388:
				spawn_1_beat = 1
				spawn_2_beat = 0
				spawn_3_beat = 1
				spawn_4_beat = 0
			240,244,260,264,268,304,308,332,372,376,392,396,400,436,440,464:
				spawn_1_beat = 0
				spawn_2_beat = 1
				spawn_3_beat = 0
				spawn_4_beat = 0
			316,448:
				spawn_1_beat = 1
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 1
			328,460:
				spawn_1_beat = 0
				spawn_2_beat = 0
				spawn_3_beat = 1
				spawn_4_beat = 0
			232,252,272,296,320,324,340,348,364,384,404,428,448,452,456,476:
				spawn_1_beat = 0
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 0
	elif song_position_in_beats > 479 and song_position_in_beats<560:
		match song_position_in_beats:
			480:
				spawn_1_beat = 1
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 0
			484,504:
				spawn_1_beat = 1
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 1
			488:
				spawn_1_beat = 0
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 1
			496,500:
				spawn_1_beat = 0
				spawn_2_beat = 1
				spawn_3_beat = 0
				spawn_4_beat = 0
			492,508:
				spawn_1_beat = 0
				spawn_2_beat = 0
				spawn_3_beat = 0
				spawn_4_beat = 0
	elif song_position_in_beats>560: 	#end of song
			#write scores
			#Global.set_score(score)
			#Global.combo = max_combo
			#Global.great = great
			#Global.good = good
			#Global.okay = okay
			#Global.missed = missed
			if get_tree().change_scene("res://Scenes/UI/EndingUI.tscn") != OK:
				print ("Error changing scene to End")

func _spawn_notes(to_spawn):
	if to_spawn > 0:
		lane = randi() % 5
		instance = note.instance()
		instance.initialize(lane)
		add_child(instance)
	if to_spawn > 1:
		while rand == lane:
			rand = randi() % 5
		lane = rand
		instance = note.instance()
		instance.initialize(lane)
		add_child(instance)
		


func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	
	if by == 4:
		perfect +=1
	elif by == 3:
		great += 1
	elif by == 2:
		good += 1
	elif by == 1:
		ok += 1
	else:
		missed += 1
	
	multiplier = min(5,round(0.25*combo))
	score += by * max(multiplier, 1)
	$Score.text = str(score)
	
	if combo < 5:
		$Combo.text = ""
	elif combo < 30:
		$Combo.text = str(combo) + " combo! x" + str(multiplier)
		if combo > max_combo:
			max_combo = combo
	elif combo < 60:
		$Combo.text = str(combo) + " you're on fire! x" + str(multiplier)
	else :
		$Combo.text = str(combo) + " you're unstoppable! x"+ str(multiplier)


func reset_combo():
	combo = 0
	$Combo.text = ""
