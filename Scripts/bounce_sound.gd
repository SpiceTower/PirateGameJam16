extends AudioStreamPlayer


#This list isn't used to select the sound but does show the order of the clips.
var note_list = ["Blank", "A5", "A#5", "B5", "C6", "C7", "D5", "D6", "D#5",
				 "D#6", "E5", "E6", "F5", "F6", "F#5", "G5", "G6", "G#5", "G#6"]

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
	[15, 4, 9],
	[17, 4, 13],
	[15, 3, 7],
	[8, 15, 4],
	[15, 3, 7],
	[8, 17, 4],
	[15, 2, 16],
	[6, 15, 2],
	[12, 17, 4],
	[17, 4, 9],
	[4, 9, 16],
	[9, 16, 5],
	[15, 4, 9],
	[3, 7, 13],
	[4, 9, 16],
	[15, 4, 9],
	[15, 4, 9],
	[17, 4, 13],
	[15, 3, 7],
	[8, 15, 4],
	[15, 3, 7],
	[8, 17, 4],
	[15, 2, 16],
	[6, 15, 2],
	[12, 17, 4],
	[17, 4, 9],
	[4, 9, 16],
	[9, 16, 5],
	[15, 4, 9],
	[3, 7, 13],
	[4, 9, 16],
	[15, 4, 9],
	[1, 4, 11],
	[14, 1, 4],
	[17, 3, 7],
	[1, 4, 11],
	[4, 11, 16],
	[3, 7, 16],
	[10, 17, 3],
	[17, 3, 7],
	[15, 4, 9],
	[4, 9, 18],
	[4, 9, 16],
	[1, 4, 9],
	[15, 3, 7],
	[15, 3, 7],
	[15, 4, 9],
	[8, 15, 4]
]
