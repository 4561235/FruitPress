extends Node
class_name AudioPlayer

var childNumberPlaying:int = 0

func _ready() -> void:
	for music in self.get_children():
		music.connect("finished",self,"_on_Music_finished")


func playMusic() -> void:
	self._on_Music_finished()


func changeVolume(value:float) -> void:
	for music in self.get_children():
		music.set_volume_db(value)


var musicPlayed = []
func _on_Music_finished() -> void:
	randomize()
	var childCount = self.get_child_count()
	var randNumber = randi()%childCount

	if len(self.musicPlayed) == childCount: self.musicPlayed = []

	while randNumber in self.musicPlayed:
		randNumber = randi()%childCount
	
	self.childNumberPlaying = randNumber
	
	self.musicPlayed.append(randNumber)
	self.get_child(randNumber).play()
	
	
