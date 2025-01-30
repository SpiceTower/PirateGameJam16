extends AudioStreamPlayer


#This list isn't used to select the sound but does show the order of the clips.
var note_list = ["Blank", "A5", "A#5", "B5", "C6", "C7", "D5", "D6", "D#5",
				 "D#6", "E5", "E6", "F5", "F6", "F#5", "G5", "G6", "G#5", "G#6"]

var music_clock :int = 0

#selecting audio clips doesn't work unless you play the interactive player first
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
	chord = $"../../LevelMusic".chord_list[chord_number]
	return chord.pick_random()

func _on_b_411_life_start():
	$MusicTimer.start()
	music_clock = 0

func _on_music_timer_timeout():
	music_clock += 1
