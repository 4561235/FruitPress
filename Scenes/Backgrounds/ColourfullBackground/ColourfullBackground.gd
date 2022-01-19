extends Node2D

signal ColorCycleCompleted

onready var Background = $Background
onready var BackgroundTween = $BackgroundTween
export var speed : float = 10

var faze:int = 0
var totalFaze:int = 5


func _ready():
	#Load faze data from temp data
	if TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.BACKGROUND_COLOR_FAZE] != null:
		self.faze = TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.BACKGROUND_COLOR_FAZE]
	
	startChangingColors()
	pass # Replace with function body.

func startChangingColors() -> void:
	self._goToFaze(self.faze)
	yield(BackgroundTween,"tween_all_completed")
	emit_signal("ColorCycleCompleted")
	pass

func _goToFaze(fazeNb:int):
	match fazeNb:
		0: BackgroundTween.interpolate_property(Background,"color",Color(1,0,0,1),Color(1,0,1,1),speed)
		1: BackgroundTween.interpolate_property(Background,"color",Color(1,0,1,1),Color(0,0,1,1),speed)
		2: BackgroundTween.interpolate_property(Background,"color",Color(0,0,1,1),Color(0,1,1,1),speed)
		3: BackgroundTween.interpolate_property(Background,"color",Color(0,1,1,1),Color(0,1,0,1),speed)
		4: BackgroundTween.interpolate_property(Background,"color",Color(0,1,0,1),Color(1,1,0,1),speed)
		5: BackgroundTween.interpolate_property(Background,"color",Color(1,1,0,1),Color(1,0,0,1),speed)
	BackgroundTween.start();
	pass


func _on_ColourfullBackground_ColorCycleCompleted():
	if self.faze >= self.totalFaze:
		self.faze = 0
	else:
		self.faze += 1
	startChangingColors()
	pass # Replace with function body.
