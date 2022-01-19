extends AudioPlayer

func _ready() -> void:
	._ready()
	if TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.MUSIC_NB] != null:
		var childNbLoaded:int = TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.MUSIC_NB]
		self.get_child(childNbLoaded).play(TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.PLAYBACK_POSITION])
		self.childNumberPlaying = childNbLoaded
	else:
		self.playMusic()

func _on_Musics_tree_exiting() -> void:
	TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.MUSIC_NB] = self.childNumberPlaying
	TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.PLAYBACK_POSITION] = get_child(self.childNumberPlaying).get_playback_position()
	pass # Replace with function body.
