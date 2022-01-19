extends Control

var lyre:Weapon = null

var simonArray = []


func _ready():
	self._replaySimon()
	pass


func init(lyre:Weapon) -> void:
	self.lyre = lyre


func _replaySimon() -> void:
	var delay:float = 0.3
	
	self._enableOrDisableButtons(true)
	$WatchLabel.visible = true
	
	for i in self.simonArray:
		match i:
			0: 
				$HBoxContainer/LyreButtonBlue.shine()
				self.lyre.playBlueNoteSound()
			1:
				$HBoxContainer/LyreButtonGreen.shine()
				self.lyre.playGreenNoteSound()
			2:
				$HBoxContainer/LyreButtonRed.shine()
				self.lyre.playRedNoteSound()
		yield(get_tree().create_timer(delay),"timeout")
	
	yield(get_tree().create_timer(delay),"timeout")
	self._addNote()
	
	yield(get_tree().create_timer(0.5),"timeout")
	$WatchLabel.visible = false
	self._enableOrDisableButtons(false)


func _addNote() -> void:
	randomize()
	match randi()%3:
		0:
			self.simonArray.append(0)
			$HBoxContainer/LyreButtonBlue.shine()
			self.lyre.playBlueNoteSound()
		1:
			self.simonArray.append(1)
			$HBoxContainer/LyreButtonGreen.shine()
			self.lyre.playGreenNoteSound()
		2:
			self.simonArray.append(2)
			$HBoxContainer/LyreButtonRed.shine()
			self.lyre.playRedNoteSound()


func _on_LyreButtonBlue_button_down() -> void:
	self._userPress(0)


func _on_LyreButtonGreen_button_down() -> void:
	self._userPress(1)


func _on_LyreButtonRed_button_down() -> void:
	self._userPress(2)


var checkIndex:int = 0
func _userPress(number:int) -> void:
	if len(self.simonArray) == 0:
		self._replaySimon()
		return
	
	#The user was right
	if number == self.simonArray[self.checkIndex]:
		match number:
			0: self.lyre.smashWithBlueNote()
			1: self.lyre.smashWithGreenNote()
			2: self.lyre.smashWithRedNote()
		
		self.checkIndex += 1
		
		#Check if the user played all notes
		if len(self.simonArray) == self.checkIndex:
			#Upgrading buff
			self.lyre.upgradeBuff()
			
			#Displaying nice label
			$NiceLabel.visible = true
			$NiceLabel/NiceLabelTimer.start()
			
			self.checkIndex = 0
			
			#Disabling input and replaying simon after 2 seconds
			yield(get_tree().create_timer(0.15),"timeout")
			self._enableOrDisableButtons(true)
			yield(get_tree().create_timer(1.3),"timeout")
			self._replaySimon()
			
	#The user made a mistake
	else:
		#Reseting buff because of the mistake
		self.lyre.downgradeBuff()
		
		#Displaying the made error label
		$ErrorLabel.visible = true
		$ErrorLabel/ErrorLabelTimer.start()
		
		#Disabling input
		self._enableOrDisableButtons(true)
		yield(get_tree().create_timer(1),"timeout")
		
		#Replay simon at the beginning
		self.checkIndex = 0
		self.simonArray = []
		self._replaySimon()


func _on_NiceLabelTimer_timeout() -> void:
	$NiceLabel.visible = false


func _on_ErrorLabelTimer_timeout() -> void:
	$ErrorLabel.visible = false
	pass # Replace with function body.


func _enableOrDisableButtons(state:bool) -> void:
	for button in $HBoxContainer.get_children():
		button.disabled = state
