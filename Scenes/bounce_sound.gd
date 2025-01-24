extends AudioStreamPlayer


#This list isn't used to select the sound but does show the order of the clips.
var note_list = ["Blank", "A5", "A6", "B5", "C6", "C7", "D5", "D6", "E5", 
				 "E6", "F5", "F6", "F#5", "G5", "G6", "G#5"]

var music_clock :int = 0

#selecting audio clips doesnpt work unless you play the interactive player first
func _ready():
	play() 

func play_bounce_sound():
	var note_index : int
	note_index = note_selector(music_clock)
	get_stream_playback().switch_to_clip(note_index)

func note_selector(seconds):
	var chord_number : int
	var chord
	chord_number = ((seconds - 2) / 2) % 48
	chord = chord_list[chord_number]
	return chord.pick_random()

func _on_b_411_life_start():
	$MusicTimer.start()
	music_clock = 0

func _on_music_timer_timeout():
	music_clock += 1


var chord_list = [
	[13, 4, 9],
	[1, 7, 11],
	[13, 3, 7],
	[8, 13, 4],
	[13, 3, 7],
	[13, 1, 4],
	[13, 3, 4],
	[6, 13, 3],
	[10, 1, 4],
	[1, 4, 9],
	[4, 9, 14],
	[9, 14, 5],
	[13, 4, 9],
	[3, 7, 11],
	[4, 9, 14],
	[13, 4, 9],
	[13, 4, 9],
	[1, 7, 11],
	[13, 3, 7],
	[8, 13, 4],
	[13, 3, 7],
	[13, 1, 4],
	[13, 3, 4],
	[6, 13, 3],
	[10, 1, 4],
	[1, 4, 9],
	[4, 9, 14],
	[9, 14, 5],
	[13, 4, 9],
	[3, 7, 11],
	[4, 9, 14],
	[13, 4, 9],
	[1, 4, 9],
	[12, 1, 4],
	[15, 3, 7],
	[1, 4, 9],
	[4, 9, 14],
	[3, 7, 14],
	[8, 15, 3],
	[13, 4, 9],
	[13, 3, 7],
	[4, 9, 2],
	[4, 9, 14],
	[1, 4, 9],
	[13, 3, 7],
	[13, 3, 7],
	[13, 4, 9],
	[8, 13, 4]
]
