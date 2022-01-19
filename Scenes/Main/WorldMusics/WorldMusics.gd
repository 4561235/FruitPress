extends Node



func _ready() -> void:
	for music in $Pressing.get_children():
		music.connect("finished", self, "_on_Pressing_Music_finished")
	for music in $Shop.get_children():
		music.connect("finished", self, "_on_Shop_Music_finished")
	pass # Replace with function body.


func playMusic(musicEnum:int) -> void:
	self._stopAll()
	#Need a little time to stop all musics
	yield(get_tree().create_timer(0.15),"timeout")
	self.dontRepeat = false
	
	match musicEnum:
		Enums.MUSICS.PRESSING:
				self._on_Pressing_Music_finished()
		Enums.MUSICS.SHOP:
				self._on_Shop_Music_finished()


func changeVolume(value:float) -> void:
	for world in self.get_children():
		for music in world.get_children():
			music.set_volume_db(value)


var dontRepeat:bool = false
func _stopAll() -> void:
	self.dontRepeat = true
	for world in self.get_children():
		for music in world.get_children():
			music.stop()


#func pauseOrResumeMusic(musicEnum:int, pause:bool) -> bool:
#	var node:Node = null
#	match musicEnum:
#		Enums.MUSICS.PRESSING: node = $Pressing
#		Enums.MUSICS.SHOP: node = $Shop
#
#	var wasPaused:bool = false
#	for music in node.get_children():
#		if music.stream_paused == true: wasPaused = true
#		music.stream_paused = pause
#
#	return wasPaused

var pressingMusicPlayed = []
func _on_Pressing_Music_finished() -> void:
	if self.dontRepeat: return
	
	randomize()
	var childCount = $Pressing.get_child_count()
	var randNumber = randi()%childCount

	if len(self.pressingMusicPlayed) == childCount: self.pressingMusicPlayed = []

	while randNumber in self.pressingMusicPlayed:
		randNumber = randi()%childCount

	self.pressingMusicPlayed.append(randNumber)
	$Pressing.get_child(randNumber).play()



func _on_Shop_Music_finished() -> void:
	if self.dontRepeat: return
	$Shop/Music1.play()
	pass
