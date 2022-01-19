extends Weapon

signal smashed(weapon)

var buff:AttackBuff = AttackBuff.new()

func _init():
	self.weaponInterface = preload("res://Scenes/DefaultWorld/Weapons/Lyre/Interface/LyreInterface.tscn")
	self.weaponEnum = Enums.WEAPONS.LYRE


func init(target:Fruit):
	self.target = target


func _ready():
	$AnimationPlayer.play("Idle")
	pass


#FUNC FOR TESTING
func smash() -> void:
	randomize()
	match randi() % 3:
		0: self.smashWithBlueNote()
		1: self.smashWithGreenNote()
		2: self.smashWithRedNote()


#Connect to button
func smashWithBlueNote() -> void:
	self._smashWithNote(Enums.LYRE_NOTES.BLUE)
	$Sounds/BlueNoteSound.play()


#Connect to button
func smashWithGreenNote() -> void:
	self._smashWithNote(Enums.LYRE_NOTES.GREEN)
	$Sounds/GreenNoteSound.play()


#Connect to button
func smashWithRedNote() -> void:
	self._smashWithNote(Enums.LYRE_NOTES.RED)
	$Sounds/RedNoteSound.play()


func _smashWithNote(noteEnum:int) -> void:
	self._spawnNote(GameData.LYRE_NOTES_TEXTURES[noteEnum])
	

#Saving last target position to not interupt attacks when a fruit is despawned
var lastTargetPosition:Vector2
func _spawnNote(noteTexture:Texture) -> void:
	
	#Saving target position when target is valid
	if is_instance_valid(self.target): self.lastTargetPosition = self.target.global_position
	
	#Spawning note and giving a position to note to atack
	var note:MusicNote = load("res://Scenes/DefaultWorld/Weapons/Lyre/Note/MusicNote.tscn").instance()
	note.init(noteTexture, to_local(lastTargetPosition))
	note.connect("hit",self,"_on_MusicNote_hit")
	
	self.add_child(note)


func _on_MusicNote_hit():
	self.emit_signal("smashed",self, self.buff)


func playBlueNoteSound() -> void:
	$Sounds/BlueNoteSound.play()
	
	
func playGreenNoteSound() -> void:
	$Sounds/GreenNoteSound.play()
	
	
func playRedNoteSound() -> void:
	$Sounds/RedNoteSound.play()

func upgradeBuff() -> void:
	self.buff.buffInfo[Enums.BUFF_PROPERTY.ATTACK] += float(50)
	pass

func downgradeBuff() -> void:
	self.buff.buffInfo[Enums.BUFF_PROPERTY.ATTACK] = float(0)
	pass

#func _on_BuffIcon_buffEnded(lyreBuffEnum):
#	self.buffsActive[lyreBuffEnum][0] = false
#	self.buffsActive[lyreBuffEnum][1] = 0
