extends Control
signal buttonPressed

var guitar:Weapon = null

var comboValue:float = 0
var comboMaxValue:float = 100

var normalSpeed:float = 500
var blueSpeed:float = 800
var greenSpeed:float = 1100
var redSpeed:float = 1350

var currentSpeed:float = normalSpeed

func _ready() -> void:
	#self._changeSpeedOfButtons(self.normalSpeed)
	pass

func init(guitar:Weapon) -> void:
	self.guitar = guitar
	pass

func _physics_process(_delta: float) -> void:
	$Label.text = String(self.currentSpeed)

#Spawn a button after timer's time
func _on_TimerSpawn_timeout() -> void:
	var button:GuitarInterfaceButton = load("res://Scenes/DefaultWorld/Weapons/Guitar/Interface/GuitarInterfaceButton/GuitarInterfaceButton.tscn").instance()
	button.init(self.currentSpeed, $DespawnPosition.global_position)
	button.connect("button_down",self,"_on_GuitarInterfaceButton_pressed")
	button.connect("buttonMissed",self,"_on_GuitarInterfaceButton_buttonMissed")
	
	randomize()
	match randi()%2:
		0: $Spawner1.add_child(button)
		1: $Spawner2.add_child(button)
	
	
	$GuitarComboJauge.updateGauge(self.comboValue, self.comboMaxValue)
	pass # Replace with function body.

#On button pressed
func _on_GuitarInterfaceButton_pressed():
	#Play music
	self.guitar.playMusic()
	
	#Reset
	self.buttonMissed = 0
	
	self.comboValue += 5
	if self.comboValue > self.comboMaxValue:
		self.comboValue = self.comboMaxValue
	$GuitarComboJauge.updateGauge(self.comboValue, self.comboMaxValue)
	emit_signal("buttonPressed")

var maxButtonMissed:int = 5
var buttonMissed:int = 0
#When button is missed
func _on_GuitarInterfaceButton_buttonMissed() -> void:
	#Fail sound
	self.guitar.playFailSound()
	
	if self.buttonMissed >= self.maxButtonMissed:
		self.guitar.stopMusic()
		self.buttonMissed = 0
	else:
		self.buttonMissed += 1
	
	self.comboValue -= 15
	if self.comboValue < 0:
		self.comboValue = 0
	pass


func _changeSpeedOfButtons(value:float) -> void:
	self.currentSpeed = value
	for button in $Spawner1.get_children():
		button.changeSpeed(value)
	for button in $Spawner2.get_children():
		button.changeSpeed(value)
	pass


func _on_GuitarComboJauge_blueBuffActivated() -> void:
	self._changeSpeedOfButtons(self.blueSpeed)
	self.guitar.activeBlueBuff()
	pass # Replace with function body.


func _on_GuitarComboJauge_greenBuffActivated() -> void:
	self._changeSpeedOfButtons(self.greenSpeed)
	self.guitar.activeGreenBuff()
	pass # Replace with function body.


func _on_GuitarComboJauge_redBuffActivated() -> void:
	self._changeSpeedOfButtons(self.redSpeed)
	self.guitar.activeRedBuff()
	pass # Replace with function body.


func _on_GuitarComboJauge_noBuffActivated() -> void:
	self._changeSpeedOfButtons(self.normalSpeed)
	self.guitar.disableBuff()
	pass # Replace with function body.


